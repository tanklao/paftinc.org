<%@ Page Title="My Cart" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Cart.aspx.vb" Inherits="Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <style type="text/css">
        .auto-style1 {
            width: 66px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <%-- Welcome label--%>
    <asp:Label ID="Label2" runat="server" Style="text-align: center; font-size: large; font-weight: 700"></asp:Label><br />
    <%--Item number in cart--%>
    <asp:Label ID="Label1" runat="server" Visible="true"></asp:Label>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Item_Id" DataSourceID="sql_CartItems">
        <Columns>
            <asp:CommandField ButtonType="Button" SelectText="Remove" ShowSelectButton="True" />
            <asp:BoundField DataField="Item_Id" HeaderText="Item_Id" ReadOnly="True" InsertVisible="False" SortExpression="Item_Id"></asp:BoundField>
            <asp:BoundField DataField="Barcode" HeaderText="Barcode" SortExpression="Barcode"></asp:BoundField>
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name"></asp:BoundField>
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description"></asp:BoundField>
            <asp:BoundField DataField="Deposit" HeaderText="Price" SortExpression="Deposit" />
            <asp:TemplateField HeaderText="Picture">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" Height="54px" ImageUrl='<%# Bind("ImageURL") %>' Width="86px" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource runat="server" ID="sql_CartItems" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' >
    </asp:SqlDataSource>
    <span style="padding-left:200px">The total value of your order is <strong><span class="auto-style3">$</span></strong></span><asp:Label ID="lblDeposit" runat="server" style="font-size:large;font-weight:bold"></asp:Label>.<br />
    This number of order value is only used to determine your deposit, not the amount of money you will pay. You will see the amount of deposit you need to pay in next page. Your deposit is refundable. <br />
    <asp:Button ID="Button1" runat="server" Text="Clear Cart" />
    <asp:Button ID="btnContinue" runat="server" Text="Check Out" />
    <span style="padding-left: 30px"><a href="products.aspx">Continue browsing</a></span><br />
    <asp:Label ID="lblConflict" runat="server" ForeColor="Red" style="font-size: large; font-weight: 700"></asp:Label>
    <asp:GridView ID="gvConflict" runat="server" AllowPaging="True" AllowSorting="True" DataSourceID="sql_ItemStatusCheck" AutoGenerateColumns="False" DataKeyNames="Item_Id" ShowHeader="False" Visible="False">
        <Columns>
            <asp:BoundField DataField="Item_Id" HeaderText="Item_Id" InsertVisible="False" ReadOnly="True" SortExpression="Item_Id" ShowHeader="False" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sql_ItemStatusCheck" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"></asp:SqlDataSource>
    <asp:Panel ID="pnlLogin" runat="server" Visible="False">
        <asp:Login ID="Login1" runat="server"></asp:Login><br />
        If you don't have an account, please register <a href="Account/Register.aspx">here</a>.
    </asp:Panel>
    <asp:Panel ID="pnlAddress" runat="server" Visible="false">
        <h6><span class="auto-style3"><strong>Please select a delivery address:</strong></span></h6><br />
        <asp:RadioButtonList ID="rblAddress" runat="server" DataSourceID="sql_Address" CssClass="RadioButtonList" DataTextField="Address" DataValueField="Address_Id" AutoPostBack="True"></asp:RadioButtonList>
        <asp:SqlDataSource ID="sql_Address" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT Address_Id, Name + ': ' + Address1 + ' ' + isnull(Address2,'') + ', ' + City + ', ' + State + ' ' + Zipcode + '  Email: ' + Email + ',   Phone: ' + isnull(Phone,'') AS Address FROM paft_Address where User_Id=@User_Id Order by Address_Id Desc">
            <SelectParameters>
                <asp:SessionParameter SessionField="User_Id" Name="User_Id"></asp:SessionParameter>
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <asp:Label ID="lblDeliveryAddressId" runat="server" Text="" Visible="false"></asp:Label>
        <span class="auto-style2">
            <asp:Label ID="lblNoSelectIndicator" runat="server" ForeColor="Red" Text="Please select an address"></asp:Label>
            <br />
        </span>
        <span style="padding-left: 20px"><span class="auto-style3">
            <asp:LinkButton ID="lbAddAddress" runat="server">Add a New Address</asp:LinkButton>
        </span><a href="Account/Address.aspx" target="_blank"><span class="auto-style3" style="padding-left: 30px">Edit My Addresses</span></a></span>
        <asp:Panel ID="pnlAddAddress" runat="server" Visible="false">
            <style>
                .auto-style1 {
                    text-align: right;
                }
            </style>
            <table id="Address" style="width: 95%;">
                <tr>
                    <td class="auto-style1">Name</td>
                    <td>
                        <asp:TextBox ID="tbName" runat="server" Width="150px"></asp:TextBox>*&nbsp; (Please enter your full name: <strong>GivenName Surname</strong>)</td>
                </tr>
                <tr>
                    <td class="auto-style1">Email</td>
                    <td>
                        <asp:TextBox ID="tbEmail" runat="server" Width="150px"></asp:TextBox>*</td>
                </tr>
                <tr>
                    <td class="auto-style1">Phone</td>
                    <td>
                        <asp:TextBox ID="tbPhone" runat="server" Width="150px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="auto-style1">Street1</td>
                    <td>
                        <asp:TextBox ID="tbAddress1" runat="server" Width="180px"></asp:TextBox>*</td>
                </tr>
                <tr>
                    <td class="auto-style1">Street2</td>
                    <td>
                        <asp:TextBox ID="tbAddress2" runat="server" Width="180px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="auto-style1">City/Town</td>
                    <td>
                        <asp:TextBox ID="tbCity" runat="server" Width="100px"></asp:TextBox>*</td>
                </tr>
                <tr>
                    <td class="auto-style1">State</td>
                    <td>
                        <asp:TextBox ID="tbState" runat="server" Width="100px"></asp:TextBox>*</td>
                </tr>
                <tr>
                    <td class="auto-style1">Zip Cpde</td>
                    <td>
                        <asp:TextBox ID="tbZip" runat="server" Width="100px"></asp:TextBox>*</td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center">
                        <asp:Label ID="lblAddressValid" runat="server" Text="" ForeColor="Red"></asp:Label><br />
                        <span>
                            <asp:Button ID="btnAddAddress" runat="server" Text="Add Address" />
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" /></span>
                        <asp:SqlDataSource ID="sql_AddAddress" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'></asp:SqlDataSource>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <br />
        <h3>
            <asp:Label ID="lblRetunDate" runat="server" Text="Please select a return date that is at least 30 days after today"></asp:Label></h3>
<%--        <asp:Calendar ID="cldReturn" DayNameFormat="Full" runat="server">
                <WeekendDayStyle BackColor="#fafad2" ForeColor="#ff0000" />
                <DayHeaderStyle ForeColor="#0000ff" />
                <TodayDayStyle BackColor="#00ff00" />
            </asp:Calendar>--%>
        <asp:TextBox ID="cldReturn" runat="server"></asp:TextBox>
            <ajaxToolkit:CalendarExtender ID="cldReturn_CalendarExtender" runat="server" Enabled="True" DefaultView="Months" TargetControlID="cldReturn">
        </ajaxToolkit:CalendarExtender>
            <br />
        <asp:Label ID="lblReturnReminder" runat="server" Visible="false" ForeColor="Red"></asp:Label>
            <asp:Panel ID="pnlPolicy" runat="server" Visible="false">
                <h3>&nbsp;Policies of Perpetual Amity Furnishing &amp; Travel, Inc</h3>
                <ul>
                    <li>Policy 1: The furniture received is on loan to the recipient and must be returned to Perpetual Amity Furnishings &amp; Travel, Inc in usable condition upon permanently leaving campus. </li>
                    <li>Policy 2: Furniture is only loaned to international students living in the address given on the furniture request form and is not to be shared or distributed to other students or apartments. </li>
                    <li>Policy 3: A $100-$200 deposit is required upon delivery and the deposit is refundable when all the furniture is returned in usable condition, otherwise the deposit is forfeited in whole or in part at the digression of Perpetual Amity Furnishings &amp; Travel, Inc. </li>
                    <li>Policy 4: The furnishings have been donated by individuals, families, or corporations and each recipient is ask to participate in the donor program by completing 10 hours of verified volunteer service within their community. Volunteer service verification must be submitted in writing to dan@perpetualamity.org detailing the service rendered, number of hours and date. Qualifying volunteers may have their deposit reduced.</li>
                </ul>
                <asp:CheckBox ID="cbAgree" runat="server" /> I agree all the above policies
            </asp:Panel>
            <div style="text-align: right; padding-left: 30px">
                <asp:Label ID="lblTest" runat="server" Text="test" Visible="false"></asp:Label><br />
           <asp:Button ID="btnContinue2" runat="server" Text=" Continue " />
        </div>
    </asp:Panel>
    <asp:SqlDataSource ID="sqlChangeItemStatus" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_CreateOrder" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_transactItems" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"></asp:SqlDataSource>
    <div style="display:none">
    <asp:GridView ID="gv_Email" runat="server" AutoGenerateColumns="False" DataKeyNames="UserId" DataSourceID="sqlEmail" >
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
    
    <style>
        .RadioButtonList input {
            width: 20px;
            background-color: transparent;
        }

        .RadioButtonList label {
            display: inline;
            padding-left: 10px;
        }

        .auto-style2 {
            font-size: large;
        }

        .auto-style3 {
            font-size: medium;
        }

        label {
            display: inline;
        }
    </style>
</asp:Content>

