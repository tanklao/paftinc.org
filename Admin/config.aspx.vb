Imports System.Data

Partial Class Admin_config
    Inherits System.Web.UI.Page

    Function FileUploader(ByRef FileUpload1 As FileUpload, ByVal path As String, ByVal fileExents As Array) As String
        If IsPostBack Then
            Dim filePath As String = Server.MapPath("~/" & path)
            Dim fileOK As Boolean = False
            If FileUpload1.HasFile Then
                Dim fileExtension As String
                fileExtension = System.IO.Path.GetExtension(FileUpload1.FileName).ToLower()
                Dim allowedExtensions As String() = fileExents
                For i As Integer = 0 To allowedExtensions.Length - 1
                    If fileExtension = allowedExtensions(i).ToLower Then
                        fileOK = True
                    End If
                Next
                If fileOK Then
                    Try
                        FileUpload1.SaveAs(filePath & FileUpload1.FileName)
                        Return path & FileUpload1.FileName
                    Catch ex As Exception
                        Return "File could not be uploaded. " & ex.Message
                    End Try
                Else
                    Return "Cannot accept files of this type."
                End If
            End If
        Else
            Return Nothing
        End If
    End Function

    Protected Sub Button1_Click(sender As Object, e As EventArgs)
        Dim lblImage As TextBox = CType(fv_Product.FindControl("lbl_ImageURL"), TextBox)
        Dim upImage As FileUpload = CType(fv_Product.FindControl("fu_ImageUpLoad"), FileUpload)
        lblImage.Text = FileUploader(upImage, "img/", {".jpg", ".png", ".gif", ".bmp", ".jpeg"})
    End Sub

    Protected Sub btnUpdateImage_Click(sender As Object, e As EventArgs)
        Dim tbUpImage As TextBox = CType(fv_Product.FindControl("ImageURLTextBox"), TextBox)
        Dim fuUpImage As FileUpload = CType(fv_Product.FindControl("fuUpdateImage"), FileUpload)
        tbUpImage.Text = FileUploader(fuUpImage, "img/", {".jpg", ".png", ".gif", ".bmp", ".jpeg"})
    End Sub

    Protected Sub fv_Product_ItemDeleted(sender As Object, e As FormViewDeletedEventArgs) Handles fv_Product.ItemDeleted
        Response.Redirect(Request.RawUrl)
    End Sub

    Protected Sub fv_Product_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles fv_Product.ItemUpdated
        Response.Redirect(Request.RawUrl)
    End Sub



    Protected Sub fv_Product_PreRender(sender As Object, e As EventArgs) Handles fv_Product.PreRender
        Dim dv As DataView
        Dim lbl As Label = CType(fv_Product.FindControl("lbl_fv_ProductVCategory"), Label)
        Dim sds As SqlDataSource = CType(fv_Product.FindControl("sql_lbl_fv_ProductViewCategory"), SqlDataSource)
        If Not IsNothing(sds) Then
            dv = CType(sds.Select(DataSourceSelectArguments.Empty), DataView)
            lbl.Text = dv.Table.Rows(0)(1)
        End If
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
                Label1.Visible = False
                For i As Integer = firstNo To firstNo + number - 1 Step 1
                    '               INSERT INTO [paft_Items]         ([Prod_Id], [Item_Code], [Item_Status_Id])
                    insertString = insertString & String.Join(",", {"(" & ddl_BatProduct.SelectedValue.ToString, "'" & sku & i.ToString & "'", "1)"}) & ","
                Next
                sql_AddItems.InsertCommand = insertString.Remove(insertString.Length - 1)
                sql_AddItems.Insert()
                Response.Redirect("config.aspx")
            Catch ex As Exception
                Label1.Visible = True
                Label1.Text = ex.Message
            End Try
        Else
            Label1.Visible = True
        End If
    End Sub

End Class
