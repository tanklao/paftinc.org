Imports System.Data

Partial Class Cart
    Inherits System.Web.UI.Page

    Protected Sub Page_PreLoad(sender As Object, e As EventArgs) Handles Me.PreLoad
        Try
            If Trim(Session("DataTable")) <> "" Then
                Session("DataTable") = System.Text.RegularExpressions.Regex.Replace(Trim(Session("DataTable").ToString), ",$", "")
                Dim selectedItems As Array = Session("DataTable").ToString.Split(",")
                Dim selectStr As String = "SELECT paft_Items.Item_Id, paft_Items.Item_Code, paft_Products.Name, paft_Products.Description FROM paft_Items INNER JOIN paft_Products ON paft_Items.Prod_Id = paft_Products.Prod_Id WHERE ("
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

    Protected Sub GridView1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles GridView1.SelectedIndexChanged
        Dim sdtString As String = Session("DataTable").ToString
        Session("DataTable") = System.Text.RegularExpressions.Regex.Replace(sdtString, GridView1.SelectedValue & ",?", "")
        Response.Redirect("~/Cart.aspx")
    End Sub

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Session("DataTable") = ""
        Response.Redirect("~/Cart.aspx")
    End Sub

    Protected Sub btnContinue_Click(sender As Object, e As EventArgs) Handles btnContinue.Click
        lblConflict.Visible = False
        If Trim(Session("DataTable")).Length >= 4 Then
            checkConflict()
            'If no conflict then recreate order
            If gvConflict.Rows.Count = 0 Then
                createOrder()
                'else remove conflict items
            Else
                removeConflict()
            End If
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
            Dim selectStr As String = "SELECT paft_Items.Item_Id, paft_Items.Item_Code, paft_Products.Name, paft_Products.Description FROM paft_Items INNER JOIN paft_Products ON paft_Items.Prod_Id = paft_Products.Prod_Id WHERE ("
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
    Sub createOrder()
        Dim orderNo As String
        orderNo = System.Text.RegularExpressions.Regex.Replace(Date.Now.ToString, "\D", "") & Int(Rnd() * 10).ToString
        lblTest.Text = orderNo
    End Sub
End Class
