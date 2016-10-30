Imports System.Net.Mail
Imports System.IO

Partial Class Account_return
    Inherits System.Web.UI.Page

    Protected Sub btnReturn_Click(sender As Object, e As EventArgs) Handles btnReturn.Click
        pnlConfirm.Visible = True
        btnReturn.Visible = False
    End Sub

    Protected Sub rblConfirm_SelectedIndexChanged(sender As Object, e As EventArgs) Handles rblConfirm.SelectedIndexChanged
        If rblConfirm.SelectedValue = "1" Then
            sql_UpdateItems.UpdateCommand = "UPDATE paft_Items SET Item_Status_Id = 4 WHERE (Item_Id IN (SELECT paft_Transactions.Item_Id FROM paft_Orders INNER JOIN paft_Transactions ON paft_Orders.Order_Id = paft_Transactions.Order__Id WHERE (paft_Orders.Order_Id = " & Session("Order_Id") & ")))"
            sql_UpdateItems.Update()
            sql_UpdateOrders.UpdateCommand = "UPDATE paft_Orders SET Status_Id = 5 WHERE (Order_Id = " & Session("Order_Id") & ")"
            sql_UpdateOrders.Update()
            lblThanks.Text = "Thank you for submitting a reqest of returning. We will schedule a pickup as soon as possible."
            SendMail()
            btnReturn.Visible = False
        Else
            btnReturn.Visible = True
        End If
        pnlConfirm.Visible = False
    End Sub

    Sub SendMail()
        Dim mail As New MailMessage
        Dim mystr As String = ""
        mail.Subject = gv_Email.Rows(0).Cells(2).Text & "'s Returning plan"
        mystr = "Dear " & gv_Email.Rows(0).Cells(2).Text & ",<br/> Thanks for planning a return for your order! We hope you have enjoyed our free furniture.<br/>"
        mystr += "Your best time for pickup is <span style='color:blue'>" & tbPickupDate.Text
        mystr += "</span><br/> Your donation information is <br/><span style='color:blue'>" & tbDonate.Text
        mystr += "</span><br/>And here is the order you are going to return:<br/>"
        mystr += GetGridviewData(gv_Email)
        mystr += "<br/>We are glad to help you. We will process your return as soon as possible!<br/><br/>Best Regards,<br/>Dan Stovall<br/>Perpetual Amity Furnishing and Travel, INC.<br/>Phone:815-761-3815<br/>Email:wsa.dbs@gmail.com<br/>"
        mail.Body = mystr
        mail.IsBodyHtml = True
        mail.To.Add(Trim(gv_Email.Rows(0).Cells(3).Text))
        mail.CC.Add("sycamore729@gmail.com")
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
End Class
