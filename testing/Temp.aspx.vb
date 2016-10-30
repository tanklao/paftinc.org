
Partial Class testing_Temp
    Inherits System.Web.UI.Page
    Protected Sub gvOrders_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvOrders.RowCommand
        If (e.CommandName = "MakePayment") Then
            ' Retrieve the row index stored in the CommandArgument property.
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            Session("Order_Id") = gvOrders.DataKeys(index).Value.ToString
            Response.Redirect("~/Account/Payment.aspx")
        End If
    End Sub
End Class
