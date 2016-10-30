
Partial Class testing_membership
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Try
            Label1.Text = Session("User_Id")
        Catch ex As Exception
            Label1.Text = "Please log in! " & ex.Message
        End Try
    End Sub
End Class
