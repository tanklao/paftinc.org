<%@ Page Title="Product Details" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="ViewProduct.aspx.vb" Inherits="ViewProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:DetailsView ID="dvProduct" runat="server" Height="50px" Width="125px" AutoGenerateRows="False" DataKeyNames="Prod_Id" DataSourceID="sql_dvProduct">
        <Fields>
            <asp:BoundField DataField="Name" HeaderText="Product" SortExpression="Name"></asp:BoundField>
            <asp:BoundField DataField="SKU" HeaderText="SKU" SortExpression="SKU"></asp:BoundField>
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description"></asp:BoundField>
            <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category"></asp:BoundField>
            <asp:TemplateField HeaderText="Picture" SortExpression="ImageURL">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ImageURL") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ImageURL") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("ImageURL", "~/{0}") %>'>
                        <asp:Image ID="Image1" runat="server" Height="324px" ImageUrl='<%# Bind("ImageURL") %>' Width="576px" />
                    </asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="AailNum" HeaderText="Quantity Available" SortExpression="AailNum" ReadOnly="True"></asp:BoundField>
            <asp:BoundField DataField="Price" HeaderText="Market Price" DataFormatString="${0:f2}" />
        </Fields>
    </asp:DetailsView>
    <asp:SqlDataSource runat="server" ID="sql_dvProduct" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="Select top 1 Prod_Id, SKU, AailNum, Name, Description, Category, ImageURL, Price from (
SELECT paft_Products.Prod_Id, paft_Products.SKU, COUNT(paft_Items.Item_Id) AS AailNum, 

paft_Products.Name, paft_Products.Description, paft_Category.Category_Name AS Category, 

paft_Products.ImageURL, paft_Products.Price FROM paft_Items INNER JOIN paft_Products ON 

paft_Items.Prod_Id = paft_Products.Prod_Id INNER JOIN paft_Category ON 

paft_Products.Category_Id = paft_Category.Category_Id WHERE (paft_Items.Item_Status_Id 

= '1') AND (paft_Products.Prod_Id = @Prod_Id) GROUP BY paft_Items.Prod_Id, 

paft_Products.Name, paft_Products.Description, paft_Products.ImageURL, 

paft_Products.Price, paft_Products.SKU, paft_Category.Category_Name, 

paft_Products.Prod_Id
Union
SELECT Distinct p.Prod_Id, p.SKU, 0 AS AailNum, p.Name, p.Description, g.Category_Name AS Category, p.ImageURL, p.Price FROM paft_Items as i INNER JOIN paft_Products as p ON 

i.Prod_Id = p.Prod_Id INNER JOIN paft_Category as g ON p.Category_Id = g.Category_Id 

WHERE (i.Item_Status_Id &lt;&gt; '1') AND (p.Prod_Id = @Prod_Id)
) as tempTable order by AailNum desc">
        <SelectParameters>
            <asp:SessionParameter SessionField="Prod_Id" Name="Prod_Id" Type="Int32"></asp:SessionParameter>

        </SelectParameters>
    </asp:SqlDataSource>Note: Items in your cart are still available to others until you place the order. We are not holding any items for you if you don&#39;t check them out. Please shop items that are <strong>Available</strong>.<br />
    <asp:Label ID="Label2" runat="server" Text="" Visible="true" style="font-size:large"></asp:Label>
    <asp:Label ID="Label1" runat="server" Text="Ah uhm, the item is aready in My Cart!" style="font-size: large; font-weight: 700; text-align: center;" Visible="False" ForeColor="Red"></asp:Label>
    <br />
    <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Item_Id">
        <Columns>
            <asp:CommandField ShowSelectButton="True" ButtonType="Button" SelectText="Add to My Cart" />
            <asp:BoundField DataField="Item_Id" HeaderText="Item_Id" ReadOnly="True" InsertVisible="False" SortExpression="Item_Id"></asp:BoundField>
            <asp:BoundField DataField="Item_Code" HeaderText="Bar Code" SortExpression="Item_Code"></asp:BoundField>
            <asp:BoundField DataField="Product" HeaderText="Product" SortExpression="Product"></asp:BoundField>
            <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category"></asp:BoundField>
            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status"></asp:BoundField>

        </Columns>
    </asp:GridView>
    <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT paft_Items.Item_Id, paft_Items.Item_Code, paft_Products.Name AS Product, paft_Category.Category_Name AS Category, paft_Item_Status.Status, paft_Products.Prod_Id FROM (SELECT Item_Id, Prod_Id, Item_Code, Item_Status_Id FROM paft_Items AS paft_Items_1 WHERE (Item_Status_Id = 1) or (Item_Status_Id = 2) or (Item_Status_Id = 3) or (Item_Status_Id = 4)) AS paft_Items INNER JOIN paft_Item_Status ON paft_Items.Item_Status_Id = paft_Item_Status.Status_Id INNER JOIN paft_Products ON paft_Items.Prod_Id = paft_Products.Prod_Id INNER JOIN paft_Category ON paft_Products.Category_Id = paft_Category.Category_Id WHERE (paft_Products.Prod_Id = @Prod_Id) order by paft_Items.Item_Status_Id, paft_Items.Item_Id">
        <SelectParameters>
            <asp:SessionParameter SessionField="Prod_Id" Name="Prod_Id"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <div style="margin:auto;padding-left:50px"><a href="Cart.aspx">Go to My Cart</a> <span style="padding-left:50px"><a href="products.aspx">Back to browsing</a></span></div>
    <asp:SqlDataSource ID="sqlTemp" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT Item_Id, Prod_Id, Item_Code, Item_Status_Id FROM paft_Items WHERE (Item_Status_Id = 1)"></asp:SqlDataSource>
    <script>
        //$("#MainContent_GridView1 tr").click(function () {
        //    $(this).toggleClass("highlight");
        //});
    </script>
    <style>
        .highlight { background-color: red; }
    </style>
</asp:Content>

