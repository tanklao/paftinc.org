<%@ Page Language="VB" AutoEventWireup="false" CodeFile="dataSourceSelect.aspx.vb" Inherits="testing_dataSourceSelect" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT [Category_Id], [Category_Name] FROM [paft_Category] WHERE ([Category_Id] = @Category_Id)">
            <SelectParameters>
                <asp:Parameter DefaultValue="1" Name="Category_Id" Type="Int32"></asp:Parameter>
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
