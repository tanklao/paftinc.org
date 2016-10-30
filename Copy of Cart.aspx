<%@ Page Title="My Cart" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Copy of Cart.aspx.vb" Inherits="Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
   <%-- Welcome label--%>
    <asp:Label ID="Label2" runat="server" style="text-align: center; font-size: large; font-weight: 700"></asp:Label><br />
    <%--Item number in cart--%>
    <asp:Label ID="Label1" runat="server" Visible="true"></asp:Label>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Item_Id" DataSourceID="sql_CartItems" AllowPaging="True" AllowSorting="True" Visible="True">
        <Columns>
            <asp:CommandField ShowSelectButton="True" ButtonType="Button" SelectText="Remove"></asp:CommandField>
            <asp:BoundField DataField="Item_Id" HeaderText="Item_Id" ReadOnly="True" InsertVisible="False" SortExpression="Item_Id"></asp:BoundField>
            <asp:BoundField DataField="Item_Code" HeaderText="Item_Code" SortExpression="Item_Code"></asp:BoundField>
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name"></asp:BoundField>
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description"></asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource runat="server" ID="sql_CartItems" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT paft_Items.Item_Id, paft_Items.Item_Code, paft_Products.Name, paft_Products.Description FROM paft_Items INNER JOIN paft_Products ON paft_Items.Prod_Id = paft_Products.Prod_Id"></asp:SqlDataSource>
    <asp:Button ID="Button1" runat="server" Text="Clear Cart" />
    <asp:Button ID="btnContinue" runat="server" Text="Check Out" />
    <span style="padding-left:30px"><a href="products.aspx">Continue browsing</a></span><br />
    <asp:Label ID="lblConflict" runat="server" ForeColor="Red"></asp:Label>
    <asp:GridView ID="gvConflict" runat="server" AllowPaging="True" AllowSorting="True" DataSourceID="sql_ItemStatusCheck" AutoGenerateColumns="False" DataKeyNames="Item_Id" ShowHeader="False" Visible="False">
        <Columns>
            <asp:BoundField DataField="Item_Id" HeaderText="Item_Id" InsertVisible="False" ReadOnly="True" SortExpression="Item_Id" ShowHeader="False" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sql_ItemStatusCheck" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" ></asp:SqlDataSource>
    <asp:Label ID="lblTest" runat="server" Text="Label"></asp:Label>
</asp:Content>

