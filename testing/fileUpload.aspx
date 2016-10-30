<%@ Page Language="VB" AutoEventWireup="false" CodeFile="fileUpload.aspx.vb" Inherits="testing_fileUpload" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:FileUpload ID="FileUpload1" runat="server" />
        <br />
        <asp:Button ID="Button1" runat="server" Text="Button" />
        <br />
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        <br />
        <asp:Image ID="Image1" runat="server" />
        <br />
    </div>
    </form>
</body>
</html>
