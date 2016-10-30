
Partial Class testing_fileUpload
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Function UploadFileParameters(ByRef FileUpload1 As FileUpload, ByVal path As String, ByVal fileExents As Array) As String
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
                        FileUpload1.PostedFile.SaveAs(filePath & FileUpload1.FileName)
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

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Image1.ImageUrl = "~/" & UploadFileParameters(FileUpload1, "img/", {".jpg", ".png", ".gif", ".bmp", ".jpeg"})
        Label1.Text = "~/" & UploadFileParameters(FileUpload1, "img/", {".jpg", ".png", ".gif", ".bmp", ".jpeg"})
    End Sub
End Class
