
Partial Class products
    Inherits System.Web.UI.Page

    Protected Sub gvProductList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvProductList.SelectedIndexChanged
        Session("Prod_Id") = gvProductList.SelectedValue.ToString
        Response.Redirect("~/ViewProduct.aspx")
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Try
            If IsNothing(Session("DataTable")) Then
                Session("DataTable") = ""
            End If
        Catch ex As Exception
            Session("DataTable") = ""
        End Try
    End Sub
End Class
