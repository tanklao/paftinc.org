
Partial Class Admin_OrderManagement
    Inherits System.Web.UI.Page

    Protected Sub fvOrderStatus_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles fvOrderStatus.ItemUpdated
        gvOrderList.DataBind()
        gvOrderDetail.DataBind()
        ddl_OrderStatus.DataBind()
        Dim ddlOrderStatus As DropDownList = fvOrderStatus.FindControl("ddlfvOrderStatus")
        Label1.Text = ddlOrderStatus.SelectedValue
        Dim status_id As Integer = CInt(ddlOrderStatus.SelectedValue)
        Dim item_status_id As String
        Select Case status_id
            Case 1, 2, 3
                item_status_id = "2"
            Case 4
                item_status_id = "3"
            Case 5
                item_status_id = "4"
            Case 6, 7, 8
                item_status_id = "1"
            Case Else
                item_status_id = "6"
        End Select
        sql_UpdateItems.UpdateCommand = "UPDATE paft_Items SET Item_Status_Id =" & item_status_id & " WHERE (Item_Id IN (SELECT paft_Transactions.Item_Id FROM paft_Orders INNER JOIN paft_Transactions ON paft_Orders.Order_Id = paft_Transactions.Order__Id WHERE (paft_Orders.Order_Id = @Order_Id)))"
        sql_UpdateItems.Update()
    End Sub

End Class
