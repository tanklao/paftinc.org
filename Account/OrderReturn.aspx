<%@ Page Title="Return" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="OrderReturn.aspx.vb" Inherits="Account_return" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <h2>The following items will be returned:</h2>
    <asp:GridView ID="gvOrderDetail" runat="server" DataSourceID="sql_gvOrderDetail" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="Item_Id" HeaderText="Item_Id" InsertVisible="False" ReadOnly="True" SortExpression="Item_Id" />
            <asp:BoundField DataField="Order_NO" HeaderText="Order_NO" SortExpression="Order_NO" />
            <asp:BoundField DataField="Order_Date" HeaderText="Order_Date" SortExpression="Order_Date" />
            <asp:BoundField DataField="Order_Status" HeaderText="Order_Status" SortExpression="Order_Status" />
            <asp:BoundField DataField="ReturnDate" HeaderText="ReturnDate" SortExpression="ReturnDate" />
            <asp:BoundField DataField="Barcode" HeaderText="Barcode" SortExpression="Barcode" />
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
            <asp:TemplateField HeaderText="ImageURL" SortExpression="ImageURL">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ImageURL") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" Height="54px" ImageUrl='<%# Bind("ImageURL", "~/{0}") %>' Width="86px" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" Visible="False" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource runat="server" ID="sql_gvOrderDetail" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT paft_Orders.Order_NO, paft_Orders.Order_Date, paft_Order_Status.Order_Status, paft_Transactions.ReturnDate, paft_Items.Item_Code AS Barcode, paft_Products.Name, paft_Products.Description, paft_Products.Price, paft_Products.ImageURL, paft_Items.Item_Id, paft_Transactions.Trans_Id FROM paft_Orders INNER JOIN paft_Transactions ON paft_Orders.Order_Id = paft_Transactions.Order__Id INNER JOIN paft_Order_Status ON paft_Orders.Status_Id = paft_Order_Status.Status_Id INNER JOIN paft_Items ON paft_Transactions.Item_Id = paft_Items.Item_Id INNER JOIN paft_Products ON paft_Items.Prod_Id = paft_Products.Prod_Id where paft_Orders.User_Id=@User_Id and paft_Orders.Order_Id=@Order_Id">
        <SelectParameters>
            <asp:SessionParameter SessionField="User_Id" Name="User_Id"></asp:SessionParameter>
            <asp:SessionParameter Name="Order_Id" SessionField="Order_Id" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_UpdateItems" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="">
        <UpdateParameters>
            <asp:SessionParameter Name="Order_Id" SessionField="Order_Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_UpdateOrders" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="">
        <UpdateParameters>
            <asp:SessionParameter Name="Order_Id" SessionField="Order_Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    When is the best time for us to pickup your furniture?<br />
    <asp:TextBox ID="tbPickupDate" runat="server" Width="342px"></asp:TextBox>
    <br />
    Do you have some pieces of furniture to donate, please? If yes, what are they and how many, please? <br />
    <asp:TextBox ID="tbDonate" runat="server" TextMode="MultiLine" Height="110px" Width="340px"></asp:TextBox>
    <br />
    <asp:Panel ID="pnlConfirm" runat="server" Visible="false">
    <center>
                    <h3 style="color:red"><asp:Label ID="lblRemoveComfirm" runat="server" Text="Are you sure you want to return these items?"></asp:Label></h3><br />
                    <asp:RadioButtonList ID="rblConfirm" runat="server" RepeatDirection="Horizontal" AutoPostBack="True">
                        <asp:ListItem Value="1">Yes</asp:ListItem>
                        <asp:ListItem Value="0">No</asp:ListItem>
                    </asp:RadioButtonList><br />
     </center>
    </asp:Panel>
    <asp:Panel ID="pnlEmail" runat="server">
    <br />
    <asp:Button ID="btnReturn" runat="server" Text="Request a Return" />
    <asp:Label ID="lblThanks" runat="server" Text=""></asp:Label>
    <div style="display:none">
    <asp:GridView ID="gv_Email" runat="server" AutoGenerateColumns="False" DataKeyNames="UserId" DataSourceID="sqlEmail">
        <Columns>
            <asp:BoundField DataField="UserId" HeaderText="UserId" ReadOnly="True" SortExpression="UserId" Visible="False" />
            <asp:BoundField DataField="UserName" HeaderText="UserName" SortExpression="UserName" />
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
            <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
            <asp:BoundField DataField="Address1" HeaderText="Address1" SortExpression="Address1" />
            <asp:BoundField DataField="Address2" HeaderText="Address2" SortExpression="Address2" />
            <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
            <asp:BoundField DataField="State" HeaderText="State" SortExpression="State" />
            <asp:BoundField DataField="Zipcode" HeaderText="Zipcode" SortExpression="Zipcode" />
            <asp:BoundField DataField="Order_NO" HeaderText="Order_NO" SortExpression="Order_NO" />
            <asp:BoundField DataField="Order_Date" HeaderText="Order_Date" SortExpression="Order_Date" />
            <asp:BoundField DataField="Order_Status" HeaderText="Order_Status" SortExpression="Order_Status" />
            <asp:BoundField DataField="ReturnDate" HeaderText="ReturnDate" SortExpression="ReturnDate" />
            <asp:BoundField DataField="Item_Code" HeaderText="Barcode" SortExpression="Item_Code" />
            <asp:BoundField DataField="SKU" HeaderText="SKU" SortExpression="SKU" />
            <asp:BoundField DataField="Product" HeaderText="Product" SortExpression="Product" />
            <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" Visible="False" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sqlEmail" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT Users.UserId, Users.UserName, paft_Address.Name, paft_Address.Email, paft_Address.Phone, paft_Address.Address1, paft_Address.Address2, paft_Address.City, paft_Address.State, paft_Address.Zipcode, paft_Orders.Order_NO, paft_Orders.Order_Date, paft_Order_Status.Order_Status, paft_Transactions.ReturnDate, paft_Items.Item_Code, paft_Products.SKU, paft_Products.Name AS Product, paft_Products.Price FROM paft_Orders INNER JOIN paft_Order_Status ON paft_Orders.Status_Id = paft_Order_Status.Status_Id INNER JOIN Users ON paft_Orders.User_Id = Users.UserId INNER JOIN paft_Transactions ON paft_Orders.Order_Id = paft_Transactions.Order__Id INNER JOIN paft_Items ON paft_Transactions.Item_Id = paft_Items.Item_Id INNER JOIN paft_Address ON paft_Orders.Address_Id = paft_Address.Address_Id INNER JOIN paft_Products ON paft_Items.Prod_Id = paft_Products.Prod_Id WHERE (paft_Orders.Order_Id=@Order_Id) ORDER BY paft_Orders.Order_Date DESC">
        <SelectParameters>
            <asp:SessionParameter Name="Order_Id" SessionField="Order_Id" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblEmail" runat="server" Text=""></asp:Label>
    </div>
        <br />
    </asp:Panel>
    <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl="~/Account/Manage.aspx">Go back to Order Management Page</asp:LinkButton>
</asp:Content>

