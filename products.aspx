<%@ Page Title="Products" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="products.aspx.vb" Inherits="products" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <div style="margin-left:30px; margin-right:30px">
        Select a Category:
        <asp:DropDownList ID="ddlCategory" runat="server" DataSourceID="sql_ddlCategory" DataTextField="Category_Name" DataValueField="Category_Id" AutoPostBack="True">
        </asp:DropDownList>
        <asp:SqlDataSource runat="server" ID="sql_ddlCategory" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT DISTINCT paft_Products.Category_Id, paft_Category.Category_Name FROM paft_Products INNER JOIN paft_Category ON paft_Products.Category_Id = paft_Category.Category_Id ORDER BY paft_Category.Category_Name"></asp:SqlDataSource>
        &nbsp;<asp:CheckBox ID="cbAllProducts" runat="server" Text="Browse All Products" Visible="False" />
        <asp:GridView ID="gvProductList" runat="server" AutoGenerateColumns="False" DataKeyNames="Prod_Id" DataSourceID="sql_gvProductList" AllowSorting="True">
            <Columns>
                <asp:CommandField SelectText="Find out More" ShowSelectButton="True" />
                <asp:BoundField DataField="SKU" HeaderText="SKU" SortExpression="SKU"></asp:BoundField>
                <asp:BoundField DataField="Name" HeaderText="Product Name" SortExpression="Name"></asp:BoundField>
                <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description"></asp:BoundField>
                <asp:TemplateField HeaderText="Picture" SortExpression="ImageURL">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ImageURL") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Image ID="Image1" runat="server" Height="108px" ImageUrl='<%# Bind("ImageURL") %>' Width="192px" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource runat="server" ID="sql_gvProductList" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT DISTINCT * FROM [paft_Products] WHERE ([Category_Id] = @Category_Id) ORDER BY [Prod_Id]">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlCategory" PropertyName="SelectedValue" Name="Category_Id" Type="Int32"></asp:ControlParameter>
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>

