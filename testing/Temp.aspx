<%@ Page Title="Temp" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Temp.aspx.vb" Inherits="testing_Temp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="False" DataSourceID="sql_gvOrders" DataKeyNames="Order_Id" AllowPaging="True" AllowSorting="True" Width="579px">
            <Columns>
                <asp:BoundField DataField="Order_NO" HeaderText="Order_NO" SortExpression="Order_NO" />
                <asp:BoundField DataField="Order_Date" HeaderText="Order_Date" SortExpression="Order_Date" DataFormatString="{0:yyyy/MM/dd}" />
                <asp:BoundField DataField="Order_Status" HeaderText="Order_Status" SortExpression="Order_Status" />
                <asp:BoundField DataField="Order_Id" HeaderText="Order_Id" SortExpression="Order_Id" ReadOnly="True" InsertVisible="False" Visible="False" />
                <asp:BoundField DataField="Deposit" HeaderText="Deposit" SortExpression="Deposit" ReadOnly="True" />
                <asp:ButtonField Text="Make A Payment" ButtonType="Button" CommandName="MakePayment" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sql_gvOrders" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT paft_Orders.Order_NO, paft_Orders.Order_Date, paft_Order_Status.Order_Status, paft_Orders.Order_Id, SUM(paft_Products.Price) AS Deposit FROM paft_Orders INNER JOIN paft_Address ON paft_Orders.Address_Id = paft_Address.Address_Id INNER JOIN paft_Order_Status ON paft_Orders.Status_Id = paft_Order_Status.Status_Id INNER JOIN paft_Transactions ON paft_Orders.Order_Id = paft_Transactions.Order__Id INNER JOIN paft_Items ON paft_Transactions.Item_Id = paft_Items.Item_Id INNER JOIN paft_Products ON paft_Items.Prod_Id = paft_Products.Prod_Id WHERE paft_Orders.User_Id=@User_Id GROUP BY paft_Orders.Order_NO, paft_Orders.Order_Date, paft_Order_Status.Order_Status, paft_Orders.Order_Id, paft_Orders.User_Id ORDER BY paft_Orders.Order_Date DESC, paft_Orders.Order_NO">
            <SelectParameters>
                <asp:SessionParameter Name="User_Id" SessionField="User_Id" />
            </SelectParameters>
        </asp:SqlDataSource>
    <asp:Label ID="lblTest" runat="server" Text="test"></asp:Label>
</asp:Content>

