Imports System.IO
Imports System.Net.Mail
Imports System.Data

Partial Class Account_Payment
    Inherits System.Web.UI.Page

    Protected Sub gvPayingOrder_DataBound(sender As Object, e As EventArgs) Handles gvPayingOrder.DataBound
        Dim total As Decimal = 0
        Dim price As String = ""
        For Each row As GridViewRow In gvPayingOrder.Rows
            price = row.Cells(6).Text
            total += CDec(price)
        Next
        lblTotalValue.Text = total
        lblTotalDeposit.Text = determineDeposite(CInt(total))
        lblTotal.Text = determineDeposite(CInt(total))
    End Sub

    Protected Sub gvPayingOrder_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvPayingOrder.RowCommand
        If (e.CommandName = "RemoveItem") Then
            ' Retrieve the row index stored in the CommandArgument property.
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            Dim dv As System.Data.DataView = CType(sql_gvPayingOrder.Select(DataSourceSelectArguments.Empty), System.Data.DataView)
            lblRemoveComfirm.Text = CStr(index)
        End If
    End Sub

    Protected Sub gvPayingOrder_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvPayingOrder.SelectedIndexChanged
        gvPayingOrder.SelectedRow.BackColor = Drawing.Color.Red
        gvPayingOrder.SelectedRow.ForeColor = Drawing.Color.White
        pnlConfirm.Visible = True
        rblConfirm.SelectedValue = "3"
    End Sub

    Protected Sub rblConfirm_SelectedIndexChanged(sender As Object, e As EventArgs) Handles rblConfirm.SelectedIndexChanged
        If rblConfirm.SelectedValue = "1" Then
            Dim str As String = gvPayingOrder.SelectedRow.Cells(7).Text
            sql_UpdateItems.UpdateCommand = "UPDATE paft_Items SET Item_Status_Id = 1 WHERE (Item_Id = " & str & ")"
            sql_UpdateItems.Update()
            sql_UpdateTransaction.Update()
            ddlItem.DataBind()
            gvPayingOrder.DataBind()
            gv_Email.DataBind()
        Else
            gvPayingOrder.SelectedRow.BackColor = Drawing.Color.Transparent
            gvPayingOrder.SelectedRow.ForeColor = Drawing.Color.Black
        End If
        pnlConfirm.Visible = False
    End Sub

    Public Function determineDeposite(ByVal totalValue As Integer) As Integer
        Dim retvalue As Integer = 0
        Select Case totalValue
            Case 0 To 4
                retvalue = 0
            Case 5 To 200
                retvalue = 100
            Case 201 To 500
                retvalue = 150
            Case Else
                retvalue = 200
        End Select
        Return retvalue
    End Function

    Protected Sub btnCheckPayment_Click(sender As Object, e As EventArgs) Handles btnCheckPayment.Click
        Dim mystr As String = ""
        If btnCheckPayment.Text = "Check My Payment Summary" Then
            lblCheckSummary.Visible = True
            mystr = "Dear " & gv_Email.Rows(0).Cells(2).Text & ",<br/> Thanks for planning a payment for your order! Here is the summary of your payment plan:<br/>"
            mystr += "<table><tr><td>Your total deposit for this order is</td><td>$" & lblTotal.Text & ".00</td></tr><tr><td>The delivery fee you are willing to donate is</td><td>$" & ddlDeliveryFee.SelectedValue & ".00</td></tr><tr><td>You are willing to make a donation of </td><td>$" & ddlDonation.SelectedValue & ".00</td></tr><tr><td>The total amount you are going to pay for this order is </td><td>$" & CStr(CInt(lblTotal.Text) + CInt(ddlDeliveryFee.SelectedValue) + CInt(ddlDonation.SelectedValue)) & ".00</td></tr></table><br/>Note: Your deposit is refundable when you return our furniture! We highly appreciate any of your donations. Your support is very important for us to help more people.<br/>"
            mystr += "<br/>Here is your order summary:<br/>"
            mystr += GetGridviewData(gv_Email)
            mystr += "<br/>We are glad to help you. We will process your order as soon as possible!<br/><br/>Best Regards,<br/>Dan Stovall<br/>Perpetual Amity Furnishing and Travel, INC.<br/>Phone:815-761-3815<br/>Email:wsa.dbs@gmail.com<br/>"
            lblCheckSummary.Text = mystr
            btnCheckPayment.Text = "Submit My Payment Plan"
        ElseIf btnCheckPayment.Text = "Submit My Payment Plan" Then
            sql_OrderStutus.UpdateCommand = "UPDATE paft_Orders SET Status_Id = 2 Where Order_Id=@Order_Id"
            sql_OrderStutus.Update()
            lblCheckSummary.Text = "Thank you very much for your plan of payment. <br/>We will contact you and process your order as soon as possible.<br/>Your deposit is refundable when you return your furniture.<br/><span style='color:red'> If you edit your order, please re-submite a plan of payment!</span> <br/> We have send you an email. Check your email, please."
            gv_Email.DataBind()
            SendMail()
            btnCheckPayment.Text = "Check My Payment Summary"
        Else
            lblCheckSummary.Text = "Error!"
        End If
    End Sub

    Sub SendMail()
        Dim mail As New MailMessage
        Dim mystr As String = ""
        mail.Subject = gv_Email.Rows(0).Cells(2).Text & "'s plan of payment"
        mystr = "Dear " & gv_Email.Rows(0).Cells(2).Text & ",<br/> Thanks for planning a payment for your order! Here is the summary of your payment plan:<br/>"
        mystr += "<table><tr><td>Your total deposit for this order is</td><td>$" & lblTotal.Text & ".00</td></tr><tr><td>The delivery fee you are willing to donate is</td><td>$" & ddlDeliveryFee.SelectedValue & ".00</td></tr><tr><td>You are willing make a donation of </td><td>$" & ddlDonation.SelectedValue & ".00</td></tr><tr><td>The total amount you are going to pay for this order is </td><td>$" & CStr(CInt(lblTotal.Text) + CInt(ddlDeliveryFee.SelectedValue) + CInt(ddlDonation.SelectedValue)) & ".00</td></tr></table><br/>Note: Your deposit is refundable when you return our furniture! We highly appreciate any of your donations. Your support is very important for us to help more people.<br/>"
        mystr += "<br/>Here is your order summary:<br/>"
        mystr += GetGridviewData(gv_Email)
        mystr += "<br/>We are glad to help you. We will process your order as soon as possible!<br/><br/>Best Regards,<br/>Dan Stovall<br/>Perpetual Amity Furnishing and Travel, INC.<br/>Phone:815-761-3815<br/>Email:wsa.dbs@gmail.com<br/>"
        mail.Body = mystr
        mail.IsBodyHtml = True
        mail.To.Add(Trim(gv_Email.Rows(0).Cells(3).Text))
        mail.CC.Add("wsa.dbs@gmail.com")
        Dim ms As New SmtpClient
        ms.EnableSsl = True
        ms.Send(mail)
    End Sub
    Public Function GetGridviewData(gv As GridView) As String
        Dim strBuilder As New StringBuilder()
        Dim strWriter As New StringWriter(strBuilder)
        Dim htw As New HtmlTextWriter(strWriter)
        gv.RenderControl(htw)
        Return strBuilder.ToString()
    End Function
    Public Overrides Sub VerifyRenderingInServerForm(control As Control)
        ' Verifies that the control is rendered
    End Sub

    Protected Sub addItem_Click(sender As Object, e As EventArgs) Handles addItem.Click
        Dim str As String = ddlItem.SelectedValue
        If gvPayingOrder.Rows.Count >= 1 Then
            sql_UpdateItems.UpdateCommand = "UPDATE paft_Items SET Item_Status_Id = 2 WHERE (Item_Id = " & str & ")"
            sql_UpdateItems.Update()
            sql_UpdateTransaction.InsertCommand = "INSERT INTO paft_Transactions(CreateDate, Item_Id, Type_Id, Order__Id, Status_Id, ReturnDate) VALUES (GETDATE(), " & ddlItem.SelectedValue & ", 1, " & Session("Order_Id") & ", 1, '" & gvPayingOrder.Rows(0).Cells(2).Text & "')"
            sql_UpdateTransaction.Insert()
            'Label1.Text = sql_UpdateTransaction.InsertCommand
            ddlItem.DataBind()
            gvPayingOrder.DataBind()
            gv_Email.DataBind()
        End If
    End Sub
End Class
