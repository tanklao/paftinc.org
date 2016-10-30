Imports System.Net
Imports System.IO

Partial Class testing_Default
    Inherits System.Web.UI.Page

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim f As String = Upload(FileUpload1.FileBytes, FileUpload1.FileName, "niunt\z1733222", "niuPP!(*$0819", "ftp://omisapps.niu.edu//Tank/paft/img")
        Label1.Text = f
    End Sub

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
End Class
