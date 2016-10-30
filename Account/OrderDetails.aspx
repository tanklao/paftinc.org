<%@ Page Title="Order Details" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="OrderDetails.aspx.vb" Inherits="Account_OrderDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <h2>Order Details</h2>
    <asp:GridView ID="gvOrderDetail" runat="server" DataSourceID="sql_gvOrderDetail" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="Order_NO" HeaderText="Order_NO" SortExpression="Order_NO" />
            <asp:BoundField DataField="Order_Date" DataFormatString="{0:d}" HeaderText="Order_Date" SortExpression="Order_Date" />
            <asp:BoundField DataField="Order_Status" HeaderText="Order_Status" SortExpression="Order_Status" />
            <asp:BoundField DataField="Barcode" HeaderText="Barcode" SortExpression="Barcode" />
            <asp:TemplateField HeaderText="Picture" SortExpression="ImageURL">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ImageURL") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" Height="100px" ImageUrl='<%# Bind("ImageURL", "../{0}") %>' Width="100px" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
            <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
            <asp:BoundField DataField="Item_Id" HeaderText="Item_Id" InsertVisible="False" ReadOnly="True" SortExpression="Item_Id" Visible="False" />
            <asp:BoundField DataField="Trans_Id" HeaderText="Trans_Id" InsertVisible="False" ReadOnly="True" SortExpression="Trans_Id" Visible="False" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource runat="server" ID="sql_gvOrderDetail" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT paft_Orders.Order_NO, paft_Orders.Order_Date, paft_Order_Status.Order_Status, paft_Items.Item_Code AS Barcode, paft_Products.Name, paft_Products.Description, paft_Products.Price, paft_Products.ImageURL, paft_Items.Item_Id, paft_Transactions.Trans_Id FROM paft_Orders INNER JOIN paft_Transactions ON paft_Orders.Order_Id = paft_Transactions.Order__Id INNER JOIN paft_Order_Status ON paft_Orders.Status_Id = paft_Order_Status.Status_Id INNER JOIN paft_Items ON paft_Transactions.Item_Id = paft_Items.Item_Id INNER JOIN paft_Products ON paft_Items.Prod_Id = paft_Products.Prod_Id WHERE paft_Orders.Order_Id=@Order_Id ORDER BY paft_Products.Name">
        <SelectParameters>
            <asp:SessionParameter SessionField="Order_Id" Name="Order_Id"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

