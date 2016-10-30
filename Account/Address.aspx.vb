
Partial Class Account_Address
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If pleaseLogin(pnlLogin) Then
            pnlAddress.Visible = True
            lblAddressValid.Visible = True
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

    Protected Sub fvbtnGetUserId_Click(sender As Object, e As EventArgs)
        Dim userIdLabel As Label = CType(fvAddress.FindControl("User_IDLabelNew"), Label)
        userIdLabel.Text = Session("User_Id")
    End Sub

    Protected Sub lbAddNewAddress_Click(sender As Object, e As EventArgs) Handles lbAddNewAddress.Click
        pnlAddAddress.Visible = True
        lbAddNewAddress.Visible = False
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
        If Name.IndexOf(" ") >= 1 Then
            If Name <> "" And Email <> "" And Address1 <> "" And City <> "" And State <> "" And Zipcode <> "" Then
                If Name.Length <= 50 And Email.Length <= 50 And Phone.Length <= 20 And Address1.Length <= 60 And Address2.Length <= 40 And City.Length <= 30 And State.Length <= 30 And Zipcode.Length <= 10 Then
                    sql_AddAddress.InsertCommand = "INSERT INTO paft_Address(User_Id, Name, Email, Phone, Address1, Address2, City, State, Zipcode) VALUES ('" & _
                                    String.Join("','", {User_Id, Name, Email, Phone, Address1, Address2, City, State, Zipcode}) & "')"
                    sql_AddAddress.Insert()
                    Response.Redirect(Request.RawUrl)
                    pnlAddAddress.Visible = False
                Else
                    lblAddressValid.Text = "The fields should meet following reqirements: Name.Length <= 50 And Email.Length <= 50 And Address1.Length <= 60 And City.Length <= 30 And State.Length <= 30 And Zipcode.Length <= 10"
                End If
            Else
                lblAddressValid.Visible = True
                lblAddressValid.Text = "Name, Email, Address1, City, State and Zip Codes are required"
            End If
        Else
            lblAddressValid.Text = "You should enter your full name like <strong>Bill Clinton</strong>"
        End If
    End Sub

    Protected Sub fvAddress_ItemDeleted(sender As Object, e As FormViewDeletedEventArgs) Handles fvAddress.ItemDeleted
        Response.Redirect(Request.RawUrl)
    End Sub

    Protected Sub fvAddress_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles fvAddress.ItemUpdated
        Response.Redirect(Request.RawUrl)
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        Response.Redirect(Request.RawUrl)
    End Sub
End Class
