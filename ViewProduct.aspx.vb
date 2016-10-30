
Partial Class ViewProduct
    Inherits System.Web.UI.Page

    Protected Sub GridView1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles GridView1.SelectedIndexChanged
        Label1.Visible = False
        Dim selectedItems As Array
        Dim currentItem As String = GridView1.SelectedValue.ToString
        Dim dupl As Boolean = False
        If Trim(GridView1.SelectedRow.Cells(5).Text) = "Available" Then
            'check duplication
            If Session("DataTable") <> "" Then
                selectedItems = Session("DataTable").ToString.Split(",")
                For i = 0 To selectedItems.Length - 1 Step 1
                    If selectedItems(i) = currentItem Then
                        dupl = True
                        Exit For
                    End If
                Next
                If dupl = False Then
                    Session("DataTable") = Session("DataTable") & "," & currentItem
                Else
                    Label1.Visible = True
                    Label1.Text = "Ah uhm, the item is aready in My Cart!"
                End If
            Else
                Session("DataTable") = currentItem
            End If
            Label2.Text = "Items in My Cart: " & Session("DataTable").ToString
        Else
            Label1.Visible = True
            Label1.Text = " Sorry, " & currentItem & " is not Available!"
        End If
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Session("DataTable").ToString.Length > 3 Then
            Label2.Text = "Items in My Cart: " & Session("DataTable").ToString
        End If
    End Sub
End Class
