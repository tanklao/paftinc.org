<%@ Page Title="Payment" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Payment.aspx.vb" Inherits="Account_Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <style type="text/css">
        .auto-style1 {
            text-align: center;
        }

        .auto-style2 {
            text-align: left;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <h1 style="text-align: center">Make A Payment</h1>
    You are paying the following order:
    <table>
        <tr>
            <td>
                <asp:GridView ID="gvPayingOrder" runat="server" AutoGenerateColumns="False" DataSourceID="sql_gvPayingOrder" DataKeyNames="Trans_Id">
                    <Columns>
                        <asp:BoundField DataField="Order_NO" HeaderText="Order_NO" SortExpression="Order_NO" />
                        <asp:BoundField DataField="Order_Status" HeaderText="Order_Status" SortExpression="Order_Status"></asp:BoundField>
                        <asp:BoundField DataField="ReturnDate" HeaderText="ReturnDate" SortExpression="ReturnDate"></asp:BoundField>
                        <asp:BoundField DataField="Item_Code" HeaderText="Item_Code" SortExpression="Item_Code"></asp:BoundField>
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name"></asp:BoundField>
                        <asp:TemplateField HeaderText="ImageURL" SortExpression="ImageURL">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ImageURL") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Image ID="Image1" runat="server" Height="54px" ImageUrl='<%# Bind("ImageURL","~/{0}") %>' Width="86px" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
                        <asp:BoundField DataField="Item_Id" HeaderText="Item_Id" InsertVisible="False" ReadOnly="True" SortExpression="Item_Id" />
                        <asp:BoundField DataField="Order__Id" HeaderText="Order__Id" SortExpression="Order__Id" Visible="False" />
                        <asp:BoundField DataField="Trans_Id" HeaderText="Trans_Id" InsertVisible="False" ReadOnly="True" SortExpression="Trans_Id" Visible="False" />
                        <asp:CommandField ShowSelectButton="True" ButtonType="Button" SelectText="Remove" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource runat="server" ID="sql_gvPayingOrder" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT paft_Orders.Order_NO, paft_Order_Status.Order_Status, paft_Transactions.ReturnDate, paft_Items.Item_Code, paft_Products.Name, paft_Products.ImageURL, paft_Products.Price, paft_Transactions.Order__Id, paft_Transactions.Trans_Id, paft_Items.Item_Id FROM paft_Orders INNER JOIN paft_Transactions ON paft_Orders.Order_Id = paft_Transactions.Order__Id INNER JOIN paft_Items ON paft_Transactions.Item_Id = paft_Items.Item_Id INNER JOIN paft_Products ON paft_Items.Prod_Id = paft_Products.Prod_Id INNER JOIN paft_Order_Status ON paft_Orders.Status_Id = paft_Order_Status.Status_Id WHERE (paft_Orders.Order_Id = @Order_Id) AND (paft_Orders.User_Id = @User_Id)">
                    <SelectParameters>
                        <asp:SessionParameter Name="Order_Id" SessionField="Order_Id" />
                        <asp:SessionParameter Name="User_Id" SessionField="User_Id" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sql_UpdateTransaction" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" UpdateCommand="UPDATE paft_Transactions SET Order__Id = 21, ReturnDate = GETDATE() WHERE (Trans_Id = @Trans_Id)">
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="gvPayingOrder" Name="Trans_Id" PropertyName="SelectedValue" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sql_UpdateItems" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand=""></asp:SqlDataSource>
                Add an item: select a product <asp:DropDownList ID="ddlProduct" runat="server" AutoPostBack="True" DataSourceID="sql_ddlProducts" DataTextField="Name" DataValueField="Prod_Id"></asp:DropDownList> 
                <asp:SqlDataSource ID="sql_ddlProducts" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [Prod_Id], [Name] FROM [paft_Products] ORDER BY [Name]"></asp:SqlDataSource>
                &nbsp;select an item: <asp:DropDownList ID="ddlItem" runat="server" AutoPostBack="True" DataSourceID="sql_ddlItems" DataTextField="Item_Code" DataValueField="Item_Id"></asp:DropDownList>
                <asp:SqlDataSource ID="sql_ddlItems" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT Item_Id, Item_Code FROM paft_Items WHERE (Prod_Id = @Prod_Id) AND (Item_Status_Id = 1)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlProduct" Name="Prod_Id" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                &nbsp;<asp:Button ID="addItem" runat="server" Text="Add This Item" />
                <br />
                <asp:Label ID="lblNote" runat="server" style="font-weight: 700" Text="After you edit your order, please submint or re-submit your plan of payment. Thank you!"></asp:Label>
                <br />
                <br />
                The total value of your order is <strong>$<asp:Label ID="lblTotalValue" runat="server" Text=""></asp:Label></strong><br />
                The total deposit you will pay is <strong>$<asp:Label ID="lblTotalDeposit" runat="server" Text=""></asp:Label>.00</strong><br />
                <asp:Panel ID="pnlConfirm" Visible="false" runat="server">
                    <center>
                    <h3 style="color:red"><asp:Label ID="lblRemoveComfirm" runat="server" Text="Are you sure you want to remove the item?"></asp:Label></h3><br />
                    <asp:RadioButtonList ID="rblConfirm" runat="server" RepeatDirection="Horizontal" AutoPostBack="True">
                        <asp:ListItem Value="1">Yes</asp:ListItem>
                        <asp:ListItem Value="0">No</asp:ListItem>
                        <asp:ListItem Value="3">Select</asp:ListItem>
                    </asp:RadioButtonList><br />
                    </center>
                </asp:Panel>
                <br />
            </td>
        </tr>
        <tr>
            <td style="padding-right: 55px;" class="auto-style2">
                <strong>Deposit is refundable when you return your furniture.
                Your total deposit is</strong> <strong>$<asp:Label ID="lblTotal" runat="server" Text=""></asp:Label>.00
                </strong>
            </td>
        </tr>
    </table>
    <br />
    <strong>We appreciate you pay certain amount of delivery fee to cover part of our expense. Delivery fee $<asp:DropDownList ID="ddlDeliveryFee" runat="server">
        <asp:ListItem>0</asp:ListItem>
        <asp:ListItem>5</asp:ListItem>
        <asp:ListItem>10</asp:ListItem>
        <asp:ListItem>15</asp:ListItem>
        <asp:ListItem>20</asp:ListItem>
        <asp:ListItem>25</asp:ListItem>
        <asp:ListItem>30</asp:ListItem>
        <asp:ListItem>40</asp:ListItem>
        <asp:ListItem>50</asp:ListItem>
        <asp:ListItem>60</asp:ListItem>
        <asp:ListItem>70</asp:ListItem>
        <asp:ListItem>80</asp:ListItem>
        <asp:ListItem>90</asp:ListItem>
        <asp:ListItem>100</asp:ListItem>
    </asp:DropDownList>
    </strong>&nbsp;<br />
    <br />
    <strong>We also appreciate your donation. Your support is important for us to survive. Make a donation of $<asp:DropDownList ID="ddlDonation" runat="server">
        <asp:ListItem>0</asp:ListItem>
        <asp:ListItem>5</asp:ListItem>
        <asp:ListItem>10</asp:ListItem>
        <asp:ListItem>15</asp:ListItem>
        <asp:ListItem>20</asp:ListItem>
        <asp:ListItem>25</asp:ListItem>
        <asp:ListItem>30</asp:ListItem>
        <asp:ListItem>40</asp:ListItem>
        <asp:ListItem>50</asp:ListItem>
        <asp:ListItem>60</asp:ListItem>
        <asp:ListItem>70</asp:ListItem>
        <asp:ListItem>80</asp:ListItem>
        <asp:ListItem>90</asp:ListItem>
        <asp:ListItem>100</asp:ListItem>
    </asp:DropDownList>
    </strong>&nbsp;<br />
    <br />
    <div style="border: double">
        <asp:Label ID="lblCheckSummary" runat="server" BorderColor="Blue" ForeColor="#0033CC" Style="font-weight: 700"></asp:Label>
    </div>
    <br />
    <asp:Button ID="btnCheckPayment" runat="server" Text="Check My Payment Summary" />
    <br />
    <asp:Panel ID="pnlEmail" runat="server">
        <div style="display: none">
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
                    <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sqlEmail" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT Users.UserId, Users.UserName, paft_Address.Name, paft_Address.Email, paft_Address.Phone, paft_Address.Address1, paft_Address.Address2, paft_Address.City, paft_Address.State, paft_Address.Zipcode, paft_Orders.Order_NO, paft_Orders.Order_Date, paft_Order_Status.Order_Status, paft_Transactions.ReturnDate, paft_Items.Item_Code, paft_Products.SKU, paft_Products.Name AS Product, paft_Products.Price FROM paft_Orders INNER JOIN paft_Order_Status ON paft_Orders.Status_Id = paft_Order_Status.Status_Id INNER JOIN Users ON paft_Orders.User_Id = Users.UserId INNER JOIN paft_Transactions ON paft_Orders.Order_Id = paft_Transactions.Order__Id INNER JOIN paft_Items ON paft_Transactions.Item_Id = paft_Items.Item_Id INNER JOIN paft_Address ON paft_Orders.Address_Id = paft_Address.Address_Id INNER JOIN paft_Products ON paft_Items.Prod_Id = paft_Products.Prod_Id WHERE (paft_Orders.Order_Id=@Order_Id) ORDER BY paft_Orders.Order_Date DESC">
                <SelectParameters>
                    <asp:SessionParameter Name="Order_Id" SessionField="Order_Id" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Label ID="lblEmail" runat="server" Text=""></asp:Label>
        </div>
    </asp:Panel>
    <br />
    <div style="font-size: medium">
        <p>Currently, we only accept cash or checks. Please pay your indicated amount using cash or checks to:</p>
        <p class="auto-style1"><strong style="text-align: center">Perpetual Amity Furnishing & Travel, INC</strong> or</p>
        <p class="auto-style1">
            <strong>Dan Stovall<br />
                729 West State St,
                <br />
                Sycarmore, IL 60178</strong>
        </p>
    </div>
    <div style="text-align: center">
        <asp:SqlDataSource ID="sql_OrderStutus" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' UpdateCommand="">
            <UpdateParameters>
                <asp:SessionParameter SessionField="Order_Id" Name="Order_Id"></asp:SessionParameter>
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
        <br />
        <asp:LinkButton ID="lb" runat="server" PostBackUrl="~/Account/Manage.aspx">Go to My Account Page</asp:LinkButton>
        <br />
    </div>
</asp:Content>

