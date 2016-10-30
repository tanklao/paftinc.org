<%@ Page Title="Order Manangement" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="OrderManagement.aspx.vb" Inherits="Admin_OrderManagement" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    Please select an order status: <asp:DropDownList ID="ddl_OrderStatus" runat="server" DataSourceID="sql_ddl_OrderStatus" DataTextField="Order_Status" DataValueField="Status_Id" AutoPostBack="True"></asp:DropDownList>
    <asp:SqlDataSource ID="sql_ddl_OrderStatus" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT distinct paft_Orders.Status_Id, paft_Order_Status.Order_Status FROM paft_Orders INNER JOIN paft_Order_Status ON paft_Orders.Status_Id = paft_Order_Status.Status_Id Order By paft_Orders.Status_Id"></asp:SqlDataSource>
    <asp:GridView ID="gvOrderList" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Order_Id" DataSourceID="sql_gvOrderList" SelectedIndex="0">
        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="Order_NO" HeaderText="Order_NO" SortExpression="Order_NO" />
            <asp:BoundField DataField="Order_Date" HeaderText="Order_Date" SortExpression="Order_Date" />
            <asp:BoundField DataField="Order_Status" HeaderText="Order_Status" SortExpression="Order_Status" />
            <asp:BoundField DataField="UserName" HeaderText="UserName" SortExpression="UserName" />
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
            <asp:BoundField DataField="Address" HeaderText="Address" ReadOnly="True" SortExpression="Address" />
            <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
            <asp:BoundField DataField="Order_Id" HeaderText="Order_Id" InsertVisible="False" ReadOnly="True" SortExpression="Order_Id" Visible="False" />
            <asp:BoundField DataField="Status_Id" HeaderText="Status_Id" SortExpression="Status_Id" Visible="False" />
            <asp:BoundField DataField="Deposit" HeaderText="Value" ReadOnly="True" SortExpression="Deposit" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sql_gvOrderList" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT paft_Orders.Order_NO, paft_Orders.Order_Date, paft_Order_Status.Order_Status, Users.UserName, paft_Address.Name, paft_Address.Email, paft_Address.Address1 + ' ' + isnull(paft_Address.Address2,'') + ', ' + paft_Address.City + ', ' + paft_Address.State + ' ' + paft_Address.Zipcode AS Address, paft_Address.Phone, paft_Orders.Order_Id, paft_Orders.Status_Id, depositTable.Deposit FROM paft_Orders INNER JOIN paft_Order_Status ON paft_Orders.Status_Id = paft_Order_Status.Status_Id INNER JOIN paft_Address ON paft_Orders.Address_Id = paft_Address.Address_Id INNER JOIN Users ON paft_Address.User_Id = Users.UserId INNER JOIN (SELECT paft_Orders_1.Order_Id AS Deposit_Id, SUM(paft_Products.Price) AS Deposit FROM paft_Orders AS paft_Orders_1 INNER JOIN paft_Transactions ON paft_Orders_1.Order_Id = paft_Transactions.Order__Id INNER JOIN paft_Items ON paft_Transactions.Item_Id = paft_Items.Item_Id INNER JOIN paft_Products ON paft_Items.Prod_Id = paft_Products.Prod_Id GROUP BY paft_Orders_1.Order_Id) AS depositTable ON paft_Orders.Order_Id = depositTable.Deposit_Id WHERE (paft_Orders.Status_Id = @Status_Id) ORDER BY paft_Orders.Order_Date DESC, paft_Orders.Order_NO DESC">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddl_OrderStatus" Name="Status_Id" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <table>
        <tr>
            <td>
    <asp:FormView ID="fvOrderStatus" runat="server" DataKeyNames="Order_Id" DataSourceID="sql_fvOrderStatus">
        <EditItemTemplate>
            Order_Id:
            <asp:Label Text='<%# Eval("Order_Id") %>' runat="server" ID="Order_IdLabel1" /><br />
            Order_NO:
            <asp:TextBox Text='<%# Bind("Order_NO") %>' runat="server" ID="Order_NOTextBox" ReadOnly="True" /><br />
            Status_Id:
            <asp:DropDownList ID="ddlfvOrderStatus" runat="server" DataSourceID="sql_ddlfvOrderStatus" DataTextField="Order_Status" DataValueField="Status_Id" SelectedValue='<%# Bind("Status_Id") %>'>
            </asp:DropDownList>
            <asp:SqlDataSource ID="sql_ddlfvOrderStatus" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [Status_Id], [Order_Status] FROM [paft_Order_Status]"></asp:SqlDataSource>
            <br />
            <asp:LinkButton runat="server" Text="Update" CommandName="Update" ID="UpdateButton" CausesValidation="True" />&nbsp;<asp:LinkButton runat="server" Text="Cancel" CommandName="Cancel" ID="UpdateCancelButton" CausesValidation="False" />
        </EditItemTemplate>
        <InsertItemTemplate>
            Order_NO:
            <asp:TextBox Text='<%# Bind("Order_NO") %>' runat="server" ID="Order_NOTextBox" /><br />
            Status_Id:
            <asp:TextBox Text='<%# Bind("Status_Id") %>' runat="server" ID="Status_IdTextBox" /><br />
            <asp:LinkButton runat="server" Text="Insert" CommandName="Insert" ID="InsertButton" CausesValidation="True" />&nbsp;<asp:LinkButton runat="server" Text="Cancel" CommandName="Cancel" ID="InsertCancelButton" CausesValidation="False" />
        </InsertItemTemplate>
        <ItemTemplate>
            Order_Id:
            <asp:Label Text='<%# Eval("Order_Id") %>' runat="server" ID="Order_IdLabel" /><br />
            Order_NO:
            <asp:Label Text='<%# Bind("Order_NO") %>' runat="server" ID="Order_NOLabel" /><br />
            Status_Id:
            <asp:Label Text='<%# Bind("Status_Id") %>' runat="server" ID="Status_IdLabel" /><br />
            <asp:LinkButton ID="EditButton" runat="server" BackColor="#66CCFF" BorderColor="#66CCFF" CausesValidation="False" CommandName="Edit" ForeColor="Black" Text="Update Status" />
            &nbsp;

        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource runat="server" ID="sql_fvOrderStatus" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT [Order_Id], [Order_NO], [Status_Id] FROM [paft_Orders] WHERE ([Order_Id] = @Order_Id)" ConflictDetection="CompareAllValues" DeleteCommand="DELETE FROM [paft_Orders] WHERE [Order_Id] = @original_Order_Id AND [Order_NO] = @original_Order_NO AND [Status_Id] = @original_Status_Id" InsertCommand="INSERT INTO [paft_Orders] ([Order_NO], [Status_Id]) VALUES (@Order_NO, @Status_Id)" OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE [paft_Orders] SET [Order_NO] = @Order_NO, [Status_Id] = @Status_Id WHERE [Order_Id] = @original_Order_Id AND [Order_NO] = @original_Order_NO AND [Status_Id] = @original_Status_Id">
        <DeleteParameters>
            <asp:Parameter Name="original_Order_Id" Type="Int32" />
            <asp:Parameter Name="original_Order_NO" Type="String" />
            <asp:Parameter Name="original_Status_Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Order_NO" Type="String" />
            <asp:Parameter Name="Status_Id" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="gvOrderList" Name="Order_Id" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Order_NO" Type="String" />
            <asp:Parameter Name="Status_Id" Type="Int32" />
            <asp:Parameter Name="original_Order_Id" Type="Int32" />
            <asp:Parameter Name="original_Order_NO" Type="String" />
            <asp:Parameter Name="original_Status_Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
            </td>
        </tr>
    </table>
    <asp:Label ID="Label1" runat="server" Visible="False"></asp:Label>
    <asp:SqlDataSource ID="sql_UpdateItems" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [Order_Id] FROM [paft_Orders] WHERE ([Order_Id] = @Order_Id)">
        <UpdateParameters>
            <asp:ControlParameter ControlID="fvOrderStatus" Name="Order_Id" PropertyName="SelectedValue" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <h2>Order Details</h2>
    <asp:GridView ID="gvOrderDetail" runat="server" DataSourceID="sql_gvOrderDetail" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="Order_NO" HeaderText="Order_NO" SortExpression="Order_NO" />
            <asp:BoundField DataField="ReturnDate" HeaderText="ReturnDate" SortExpression="ReturnDate" />
            <asp:BoundField DataField="Order_Status" HeaderText="Order_Status" SortExpression="Order_Status" />
            <asp:BoundField DataField="Item_Code" HeaderText="Item_Code" SortExpression="Item_Code" />
            <asp:BoundField DataField="Name" HeaderText="ProductName" SortExpression="Name" />
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
            <asp:TemplateField HeaderText="ImageURL" SortExpression="ImageURL">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ImageURL") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" Height="54px" ImageUrl='<%# Bind("ImageURL", "~/{0}") %>' Width="86px" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource runat="server" ID="sql_gvOrderDetail" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT paft_Orders.Order_NO, paft_Orders.Order_Date, paft_Transactions.ReturnDate, paft_Order_Status.Order_Status, paft_Items.Item_Code, paft_Products.Name, paft_Products.Description, paft_Products.Price, paft_Products.ImageURL, paft_Items.Item_Id, paft_Transactions.Trans_Id FROM paft_Orders INNER JOIN paft_Transactions ON paft_Orders.Order_Id = paft_Transactions.Order__Id INNER JOIN paft_Order_Status ON paft_Orders.Status_Id = paft_Order_Status.Status_Id INNER JOIN paft_Items ON paft_Transactions.Item_Id = paft_Items.Item_Id INNER JOIN paft_Products ON paft_Items.Prod_Id = paft_Products.Prod_Id WHERE (paft_Orders.Order_Id = @Order_Id) ORDER BY paft_Products.Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvOrderList" Name="Order_Id" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

