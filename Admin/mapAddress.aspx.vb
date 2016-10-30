Imports System.Data

Partial Class Admin_mapAddress
    Inherits System.Web.UI.Page

    Protected Sub Page_PreLoad(sender As Object, e As EventArgs) Handles Me.PreLoad
        Dim dv As DataView = CType(sql_Markers.Select(DataSourceSelectArguments.Empty), DataView)
        Dim str As String = ""
        Dim dr As DataRow
        For i = 0 To dv.Table.Rows.Count - 1 Step 1
            dr = dv.Table.Rows(i)
            str = str & dr(1).ToString & ",`," & dr(0).ToString & ",`, "
        Next
        str = str.Remove(str.Length - 4)
        lblMarkers.Text = str
    End Sub
End Class
