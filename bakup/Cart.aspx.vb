Imports System.Data

Partial Class Cart
    Inherits System.Web.UI.Page

    Protected Sub Page_PreLoad(sender As Object, e As EventArgs) Handles Me.PreLoad
        Try
            If Trim(Session("DataTable")) <> "" Then
                Session("DataTable") = System.Text.RegularExpressions.Regex.Replace(Trim(Session("DataTable").ToString), ",$", "")
                Dim selectedItems As Array = Session("DataTable").ToString.Split(",")
                Dim selectStr As String = "SELECT paft_Items.Item_Id, paft_Items.Item_Code AS Barcode, paft_Products.Name, paft_Products.Description, paft_Products.Price AS Deposit, paft_Products.ImageURL FROM paft_Items INNER JOIN paft_Products ON paft_Items.Prod_Id = paft_Products.Prod_Id WHERE ("
                For i = 0 To selectedItems.Length - 1 Step 1
                    selectStr = selectStr & " paft_Items.Item_Id = '" & selectedItems(i) & "' OR"
                Next
                Label1.Text = "You have following item(s) in your Cart."
                sql_CartItems.SelectCommand = selectStr.Remove(selectStr.Length - 3) & ")"
            Else
                sql_CartItems.SelectCommand = ""
                Label1.Text = "You have nothing in your Cart!"
            End If
        Catch ex As Exception
            Label1.Text = "You have nothing in your Cart!"
        End Try
        Try
            Label2.Text = "Welcome to <span style='font-weight:bold;font-family:sans-serif;background-color: white;border-radius:8px;'><span style='color:limegreen;'>P</span><span style='color:blue;'>e</span><span style='color:goldenrod;'>r</span><span style='color:limegreen;'>p</span><span style='color:blue;'>e</span><span style='color:goldenrod;'>t</span><span style='color:limegreen;'>u</span><span style='color:blue;'>a</span><span style='color:goldenrod;'>l</span><span style='color:limegreen;'> </span><span style='color:blue;'>A</span><span style='color:goldenrod;'>m</span><span style='color:limegreen;'>i</span><span style='color:blue;'>t</span><span style='color:goldenrod;'>y</span><span style='color:limegreen;'> </span><span style='color:blue;'>F</span><span style='color:goldenrod;'>u</span><span style='color:limegreen;'>r</span><span style='color:blue;'>n</span><span style='color:goldenrod;'>i</span><span style='color:limegreen;'>s</span><span style='color:blue;'>h</span><span style='color:goldenrod;'>i</span><span style='color:limegreen;'>n</span><span style='color:blue;'>g</span><span style='color:goldenrod;'> </span><span style='color:limegreen;'>&</span><span style='color:blue;'> </span><span style='color:goldenrod;'>T</span><span style='color:limegreen;'>r</span><span style='color:blue;'>a</span><span style='color:goldenrod;'>v</span><span style='color:limegreen;'>e</span><span style='color:blue;'>l</span>&trade;</span>, <span style='color:darkgreen;font-family:fantasy;font-size:larger'>" & Membership.GetUser.UserName & "</span>!"
        Catch ex As Exception
            Label2.Text = "Please log in to check out! <span style='color:red'>We do not accept anonymous checkout</span>."
        End Try
    End Sub

    Protected Sub GridView1_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GridView1.RowDataBound
        Dim totalDeposit As Integer = 0
        For i = 0 To GridView1.Rows.Count - 1 Step 1
            totalDeposit = totalDeposit + CInt(GridView1.Rows(i).Cells(5).Text)
        Next
        lblDeposit.Text = totalDeposit & ".00"
    End Sub

    Protected Sub GridView1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles GridView1.SelectedIndexChanged
        Dim sdtString As String = Session("DataTable").ToString
        Session("DataTable") = System.Text.RegularExpressions.Regex.Replace(sdtString, GridView1.SelectedValue & ",?", "")
        Response.Redirect(Request.RawUrl)
    End Sub

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Session("DataTable") = ""
        Response.Redirect(Request.RawUrl)
    End Sub

    Protected Sub btnContinue_Click(sender As Object, e As EventArgs) Handles btnContinue.Click
        checkingout()
    End Sub

    Sub checkingout()
        lblConflict.Visible = False
        pnlLogin.Visible = False
        pnlAddress.Visible = False
        pnlAddAddress.Visible = False
        lblNoSelectIndicator.Visible = False
        Dim userID As String = ""
        Dim addressID As String = ""
        Dim returnDate As Date = cldReturn.SelectedDate
        Dim loginStatus As Boolean = pleaseLogin(pnlLogin)
        If loginStatus Then
            btnContinue.Visible = False
            pnlAddress.Visible = True
            userID = Membership.GetUser.ProviderUserKey.ToString
            addressID = lblDeliveryAddressId.Text
            If addressID <> "" Then
                If returnDate > Date.Now.Date.AddDays(30) Then
                    pnlPolicy.Visible = True
                    btnContinue2.Text = "Place Order"
                    If cbAgree.Checked Then
                        checkout(userID, addressID, returnDate)
                    End If
                End If
            End If
        End If
    End Sub

    Function pleaseLogin(ByRef pnlLogin As Panel) As Boolean
        Dim userID As String = ""
        Dim loginStatus As Boolean = False
        Try
            userID = Membership.GetUser.ProviderUserKey.ToString
            If userID <> "" Then
                loginStatus = True
            Else
                pnlLogin.Visible = True
            End If
        Catch ex As Exception
            pnlLogin.Visible = True
        End Try
        Return loginStatus
    End Function
    Sub checkout(ByVal userID As String, ByVal addressID As String, ByVal returnDate As Date)
        If Trim(Session("DataTable")).Length >= 4 Then
            checkConflict()
            If gvConflict.Rows.Count = 0 Then 'If no conflict then recreate order
                changeItemStatus()
                Dim orderID = createOrder(userID, addressID)
                transactItems(orderID, returnDate)
                Session("DataTable") = ""
                Response.Redirect("~/Account/Manage.aspx")
            Else 'else remove conflict items
                removeConflict()
            End If
        Else
            lblConflict.Visible = True
            lblConflict.Text = "You have nothing in your cart!"
        End If
    End Sub


    Sub checkConflict()
        Dim selectedItems As Array = Session("DataTable").ToString.Split(",")
        'SELECT Item_Id, Item_Status_Id FROM (SELECT Item_Id, Item_Status_Id FROM paft_Items WHERE (Item_Id = 1807) OR (Item_Id = 1808) OR (Item_Id = 1809) OR (Item_Id = 1810) OR (Item_Id = 1811)) AS dr_paft_Items WHERE (Item_Status_Id <> 1)
        Dim selectStr As String = "SELECT Item_Id, Item_Status_Id FROM (SELECT Item_Id, Item_Status_Id FROM paft_Items WHERE ("
        For i = 0 To selectedItems.Length - 1 Step 1
            selectStr = selectStr & "Item_Id = '" & selectedItems(i) & "' OR "
        Next
        selectStr = selectStr.Remove(selectStr.Length - 4) & ")) AS dr_paft_Items WHERE (Item_Status_Id != 1)"
        sql_ItemStatusCheck.SelectCommand = selectStr
        sql_ItemStatusCheck.Select(DataSourceSelectArguments.Empty)
        gvConflict.DataBind()
    End Sub

    Sub removeConflict()
        Dim sdt As String = Trim(Session("DataTable"))
        Dim itemsConflict As String = "("
        For i As Integer = 0 To gvConflict.Rows.Count - 1 Step 1
            sdt = System.Text.RegularExpressions.Regex.Replace(sdt, CType(gvConflict.Rows(i).Cells(0).Text, String) & ",?", "")
            itemsConflict = itemsConflict & CType(gvConflict.Rows(i).Cells(0).Text, String) & ", "
        Next
        itemsConflict = System.Text.RegularExpressions.Regex.Replace(itemsConflict, ",\s$", "") & ")"
        lblConflict.Visible = True
        lblConflict.Text = "The items " & itemsConflict & " are not available now, and has been removed."
        Session("DataTable") = Trim(sdt)
        refreshGridView1()
    End Sub

    Sub refreshGridView1()
        If Trim(Session("DataTable")) <> "" Then
            Session("DataTable") = System.Text.RegularExpressions.Regex.Replace(Trim(Session("DataTable").ToString), ",$", "")
            Dim selectedItems As Array = Session("DataTable").ToString.Split(",")
            Dim selectStr As String = "SELECT paft_Items.Item_Id, paft_Items.Item_Code AS Barcode, paft_Products.Name, paft_Products.Description, paft_Products.Price AS Deposit, paft_Products.ImageURL FROM paft_Items INNER JOIN paft_Products ON paft_Items.Prod_Id = paft_Products.Prod_Id WHERE ("
            For i = 0 To selectedItems.Length - 1 Step 1
                selectStr = selectStr & " paft_Items.Item_Id = '" & selectedItems(i) & "' OR"
            Next
            Label1.Text = "You have following item(s) in your Cart."
            sql_CartItems.SelectCommand = selectStr.Remove(selectStr.Length - 3) & ")"
        Else
            sql_CartItems.SelectCommand = ""
            Label1.Text = "You have nothing in your Cart!"
        End If
        sql_CartItems.Select(DataSourceSelectArguments.Empty)
        GridView1.DataBind()
    End Sub

    Sub changeItemStatus()
        sqlChangeItemStatus.UpdateCommand = "UPDATE paft_Items SET Item_Status_Id = 2 WHERE Item_Id IN (" & Trim(Session("DataTable")) & ")"
        sqlChangeItemStatus.Update()
    End Sub

    Function createOrder(ByVal userID As String, ByVal addressID As String) As String
        Dim orderID As String = ""
        Dim orderNo As String = Format(Now, "yyyyMMddHHmmssff").ToString
        sql_CreateOrder.InsertCommand = "INSERT INTO paft_Orders(Order_NO, Order_Date, Status_Id, User_Id, Address_Id) VALUES ('" & _
                                             String.Join("','", {orderNo, Format(Now.Date, "yyyy/MM/dd").ToString, 1, userID, addressID}) & "')"
        sql_CreateOrder.Insert()
        sql_CreateOrder.SelectCommand = "SELECT Order_Id FROM paft_Orders Where (Order_NO = '" & orderNo & "')"
        orderID = CType(sql_CreateOrder.Select(DataSourceSelectArguments.Empty), DataView).Table.Rows(0)(0).ToString
        Return orderID
    End Function

    Sub transactItems(ByVal orderID As String, ByVal returnDate As Date)
        'INSERT INTO paft_Transactions(CreateDate, Item_Id, Type_Id, Order__Id, Status_Id, ReturnDate) VALUES (,,,,,)
        Dim insertStr As String = ""
        Dim createDate = Date.Now.ToString
        Dim itemArr As Array = Trim(Session("DataTable")).ToString.Split(",")
        For i = 0 To itemArr.Length - 1 Step 1
            insertStr = insertStr & "('" & String.Join("','", {createDate, Trim(itemArr(i)), 1, orderID, 1, returnDate.ToShortDateString}) & "'),"
        Next
        insertStr = System.Text.RegularExpressions.Regex.Replace(insertStr, ",$", "")
        sql_transactItems.InsertCommand = "INSERT INTO paft_Transactions (CreateDate, Item_Id, Type_Id, Order__Id, Status_Id, ReturnDate) VALUES " & insertStr
        sql_transactItems.Insert()
    End Sub


    Protected Sub btnAddAddress_Click(sender As Object, e As EventArgs) Handles btnAddAddress.Click
        'INSERT INTO paft_Address(User_Id, Name, Email, Phone, Address1, Address2, City, State, Zipcode) VALUES (,,,,,,,,)
        Dim User_Id As String = Membership.GetUser.ProviderUserKey.ToString
        Dim Name As String = Trim(tbName.Text)
        Dim Email As String = Trim(tbEmail.Text)
        Dim Phone As String = Trim(tbPhone.Text)
        Dim Address1 As String = Trim(tbAddress1.Text)
        Dim Address2 As String = Trim(tbAddress2.Text)
        Dim City As String = Trim(tbCity.Text)
        Dim State As String = Trim(tbState.Text)
        Dim Zipcode As String = Trim(tbZip.Text)
        If Name <> "" And Email <> "" And Address1 <> "" And City <> "" And State <> "" And Zipcode <> "" Then
            If Name.Length <= 50 And Email.Length <= 50 And Phone.Length <= 20 And Address1.Length <= 60 And Address2.Length <= 40 And City.Length <= 30 And State.Length <= 30 And Zipcode.Length <= 10 Then
                sql_AddAddress.InsertCommand = "INSERT INTO paft_Address(User_Id, Name, Email, Phone, Address1, Address2, City, State, Zipcode) VALUES ('" & _
                                String.Join("','", {User_Id, Name, Email, Phone, Address1, Address2, City, State, Zipcode}) & "')"
                sql_AddAddress.Insert()
                rblAddress.DataBind()
                pnlAddAddress.Visible = False
            Else
                lblAddressValid.Text = "The fields should meet following reqirements: Name.Length <= 50 And Email.Length <= 50 And Address1.Length <= 60 And City.Length <= 30 And State.Length <= 30 And Zipcode.Length <= 10"
            End If
        Else
            lblAddressValid.Visible = True
            lblAddressValid.Text = "Name, Email, Address1, City, State and Zip Codes are required"
        End If
    End Sub

    Protected Sub lbAddAddress_Click(sender As Object, e As EventArgs) Handles lbAddAddress.Click
        pnlAddAddress.Visible = True
    End Sub

    Protected Sub btnContinue2_Click(sender As Object, e As EventArgs) Handles btnContinue2.Click
        checkingout()
    End Sub

    Protected Sub rblAddress_SelectedIndexChanged(sender As Object, e As EventArgs) Handles rblAddress.SelectedIndexChanged
        lblDeliveryAddressId.Text = rblAddress.SelectedItem.Value
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        pnlAddAddress.Visible = False
    End Sub

    Protected Sub cldReturn_SelectionChanged(sender As Object, e As EventArgs) Handles cldReturn.SelectionChanged
        If cldReturn.SelectedDate < Date.Now.Date.AddDays(30) Then
            lblRetunDate.ForeColor = Drawing.Color.Red
        Else
            lblRetunDate.ForeColor = Drawing.Color.Black
        End If
    End Sub
End Class
