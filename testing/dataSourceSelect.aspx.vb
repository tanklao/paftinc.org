
Partial Class testing_dataSourceSelect
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim dv As System.Data.DataView
        dv = CType(SqlDataSource1.Select(DataSourceSelectArguments.Empty), System.Data.DataView)
        Label1.Text = CType(dv.Table.Rows(0)(1), String)
    End Sub
End Class
