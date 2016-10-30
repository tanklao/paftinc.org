Imports System.Data
Imports System.Net
Imports System.IO

Partial Class Admin_Default
    Inherits System.Web.UI.Page
    Public Function Upload(FileByte() As Byte, FileName As String, ftpUserID As String, ftpPassword As String, ftpURL As String) As String
        Dim retValue As String = ""
        Try
            Dim ftpFullPath As String = ftpURL + "/" + FileName
            Dim ftp As FtpWebRequest = FtpWebRequest.Create(New Uri(ftpFullPath))
            ftp.Credentials = New NetworkCredential(ftpUserID, ftpPassword)
            ftp.KeepAlive = True
            ftp.UseBinary = True
            ftp.Method = WebRequestMethods.Ftp.UploadFile
            Dim ftpStream As Stream = ftp.GetRequestStream()
            ftpStream.Write(FileByte, 0, FileByte.Length)
            ftpStream.Close()
            ftpStream.Dispose()
            retValue = "img/" & FileName
        Catch ex As Exception
            retValue = ex.ToString
        End Try
        Return retValue
    End Function

    Protected Sub fv_Items_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles fv_Items.ItemUpdated
        gv_Inserts.DataBind()
    End Sub

    Protected Sub fv_Items_PreRender(sender As Object, e As EventArgs) Handles fv_Items.PreRender
        Dim dvProd, dvStatus As DataView
        Dim lblProd, lblStatus As Label
        Dim sdsProd, sdsStatus As SqlDataSource
        lblProd = CType(fv_Items.FindControl("lbl_fv_ItemVProd"), Label)
        sdsProd = CType(fv_Items.FindControl("sql_fv_ItemVProd"), SqlDataSource)
        lblStatus = CType(fv_Items.FindControl("lbl_fv_ItemVStutas"), Label)
        sdsStatus = CType(fv_Items.FindControl("sql_fv_ItemVStutas"), SqlDataSource)
        If Not (IsNothing(sdsProd) And IsNothing(sdsStatus)) Then
            dvProd = CType(sdsProd.Select(DataSourceSelectArguments.Empty), DataView)
            lblProd.Text = dvProd.Table.Rows(0)(1)
            dvStatus = CType(sdsStatus.Select(DataSourceSelectArguments.Empty), DataView)
            lblStatus.Text = dvStatus.Table.Rows(0)(1)
        End If
    End Sub

    Protected Sub btnInsertImage_Click(sender As Object, e As EventArgs)
        Dim tbInsertImageURL As TextBox = CType(dvProduct.FindControl("tbInsertImageURL"), TextBox)
        Dim upImage As FileUpload = CType(dvProduct.FindControl("fuInsertImage"), FileUpload)
        tbInsertImageURL.Text = Upload(upImage.FileBytes, upImage.FileName, "niunt\z1733222", "niuPP!(*$0819", "ftp://omisapps.niu.edu//Tank/paft/img")
    End Sub

    Protected Sub dvProduct_ItemInserted(sender As Object, e As DetailsViewInsertedEventArgs) Handles dvProduct.ItemInserted
        gvProduct.DataBind()
    End Sub

    Protected Sub dvProduct_ItemUpdated(sender As Object, e As DetailsViewUpdatedEventArgs) Handles dvProduct.ItemUpdated
        gvProduct.DataBind()
    End Sub

    Protected Sub dvProduct_PreRender(sender As Object, e As EventArgs) Handles dvProduct.PreRender
        Dim lblCategory As Label = CType(dvProduct.FindControl("dvlblCategory"), Label)
        Dim sqldvlblCategory = CType(dvProduct.FindControl("sql_dvlblCategory"), SqlDataSource)
        If Not IsNothing(sqldvlblCategory) Then
            Dim dv As DataView = CType(sqldvlblCategory.Select(DataSourceSelectArguments.Empty), DataView)
            lblCategory.Text = CType(dv.Table.Rows(0)(1), String)
        End If
    End Sub

    Protected Sub btn_BatItem_Click(sender As Object, e As EventArgs) Handles btn_BatItem.Click
        Dim insertString As String = "INSERT INTO [paft_Items] ([Prod_Id], [Item_Code], [Item_Status_Id]) VALUES "
        Dim selectString As String = "SELECT [Item_Code] From [paft_Items] Where "
        Dim dv As DataView = CType(sql_DB4SKU.Select(DataSourceSelectArguments.Empty), DataView)
        Dim sku As String = CType(dv.Table.Rows(0)(1), String)
        Dim number As Integer = CInt(tb_BatTotal.Text)
        Dim firstNo As Integer = CInt(tb_BatItemFirstNo.Text)
        'Avoid duplicate insert
        For i As Integer = firstNo To firstNo + number - 1 Step 1
            selectString = selectString & "[Item_Code] = '" & sku & i.ToString & "' Or "
        Next
        sql_AddItems.SelectCommand = selectString.Remove(selectString.Length - 3)
        Dim dvSelect As DataView = CType(sql_AddItems.Select(DataSourceSelectArguments.Empty), DataView)
        If (dvSelect.Count = 0) Then
            Try
                'Inserting recordes
                Label2.Visible = False
                For i As Integer = firstNo To firstNo + number - 1 Step 1
                    '               INSERT INTO [paft_Items]         ([Prod_Id], [Item_Code], [Item_Status_Id])
                    insertString = insertString & String.Join(",", {"(" & gvProduct.SelectedValue.ToString, "'" & sku & i.ToString & "'", "1)"}) & ","
                Next
                sql_AddItems.InsertCommand = insertString.Remove(insertString.Length - 1)
                sql_AddItems.Insert()
                Response.Redirect(Request.RawUrl)
            Catch ex As Exception
                Label2.Visible = True
                Label2.Text = ex.Message
            End Try
        Else
            Label2.Visible = True
        End If
    End Sub

End Class
