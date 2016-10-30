<%@ Page Title="Manage Account" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Manage.aspx.vb" Inherits="Account_Manage" %>
<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content ContentPlaceHolderID="MainContent" Runat="Server">
    <hgroup class="title">
        <h1>My Account</h1>
    </hgroup>
    <asp:Panel ID="pnlMenu" runat="server">
        <style>
            #menu-list li {
                display: inline;
                padding-left:30px;
            }
        </style>
        <ul id="menu-list">
            <li><asp:LinkButton ID="lbOrder" runat="server">Order Information</asp:LinkButton></li>
            <li><a href="Address.aspx">Address Management</a></li>
            <li><asp:LinkButton ID="lbAccount" runat="server">Account Management</asp:LinkButton></li>
        </ul>
    </asp:Panel>
    <asp:Panel ID="pnlOrder" runat="server" Visible="true">
    <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="False" DataSourceID="sql_gvOrders" DataKeyNames="Order_Id" AllowPaging="True" AllowSorting="True" Width="579px">
            <Columns>
                <asp:BoundField DataField="Order_NO" HeaderText="Order_NO" SortExpression="Order_NO" />
                <asp:BoundField DataField="Order_Date" HeaderText="Order_Date" SortExpression="Order_Date" DataFormatString="{0:yyyy/MM/dd}" />
                <asp:BoundField DataField="Order_Status" HeaderText="Order_Status" SortExpression="Order_Status" />
                <asp:BoundField DataField="Order_Id" HeaderText="Order_Id" SortExpression="Order_Id" ReadOnly="True" InsertVisible="False" Visible="False" />
                <asp:BoundField DataField="Deposit" HeaderText="Deposit" SortExpression="Deposit" ReadOnly="True" Visible="False" />
                <asp:ButtonField Text="Make A Deposite" ButtonType="Button" CommandName="MakePayment" HeaderText="Payment" />
                <asp:ButtonField ButtonType="Button" HeaderText="Return" Text="Return" CommandName="OrderReturn" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sql_gvOrders" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT paft_Orders.Order_NO, paft_Orders.Order_Date, paft_Order_Status.Order_Status, paft_Orders.Order_Id, SUM(paft_Products.Price) AS Deposit FROM paft_Orders INNER JOIN paft_Address ON paft_Orders.Address_Id = paft_Address.Address_Id INNER JOIN paft_Order_Status ON paft_Orders.Status_Id = paft_Order_Status.Status_Id INNER JOIN paft_Transactions ON paft_Orders.Order_Id = paft_Transactions.Order__Id INNER JOIN paft_Items ON paft_Transactions.Item_Id = paft_Items.Item_Id INNER JOIN paft_Products ON paft_Items.Prod_Id = paft_Products.Prod_Id WHERE paft_Orders.User_Id=@User_Id GROUP BY paft_Orders.Order_NO, paft_Orders.Order_Date, paft_Order_Status.Order_Status, paft_Orders.Order_Id, paft_Orders.User_Id ORDER BY paft_Orders.Order_Date DESC, paft_Orders.Order_NO DESC">
            <SelectParameters>
                <asp:SessionParameter Name="User_Id" SessionField="User_Id" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sql_TestOrderStatus" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="">
            <SelectParameters>
                <asp:SessionParameter SessionField="Order_Id" Name="Order_Id"></asp:SessionParameter>
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
    </asp:Panel>
    <asp:Panel ID="pnlAccount" runat="server" Visible="false">
    <section id="passwordForm">
        <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
            <p class="message-success"><%: SuccessMessageText %></p>
        </asp:PlaceHolder>

        <p>You're logged in as <strong><%: User.Identity.Name %></strong>.</p>

        <asp:PlaceHolder runat="server" ID="setPassword" Visible="false">
            <p>
                You do not have a local password for this site. Add a local
                password so you can log in without an external login.
            </p>
            <fieldset>
                <legend>Set password form</legend>
                <ol>
                    <li>
                        <asp:Label runat="server" AssociatedControlID="password">Password</asp:Label>
                        <asp:TextBox runat="server" ID="password" TextMode="Password" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="password"
                            CssClass="field-validation-error" ErrorMessage="The password field is required."
                            Display="Dynamic" ValidationGroup="SetPassword" />
                        
                        <asp:ModelErrorMessage runat="server" ModelStateKey="NewPassword" AssociatedControlID="password"
                            CssClass="field-validation-error" SetFocusOnError="true" />
                        
                    </li>
                    <li>
                        <asp:Label runat="server" AssociatedControlID="confirmPassword">Confirm password</asp:Label>
                        <asp:TextBox runat="server" ID="confirmPassword" TextMode="Password" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="confirmPassword"
                            CssClass="field-validation-error" Display="Dynamic" ErrorMessage="The confirm password field is required."
                            ValidationGroup="SetPassword" />
                        <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="confirmPassword"
                            CssClass="field-validation-error" Display="Dynamic" ErrorMessage="The password and confirmation password do not match."
                            ValidationGroup="SetPassword" />
                    </li>
                </ol>
                <asp:Button runat="server" Text="Set Password" ValidationGroup="SetPassword" OnClick="setPassword_Click" />
            </fieldset>
        </asp:PlaceHolder>

        <asp:PlaceHolder runat="server" ID="changePassword" Visible="false">
            <h3>Change password</h3>
            <asp:ChangePassword runat="server" CancelDestinationPageUrl="~/" ViewStateMode="Disabled" RenderOuterTable="false" SuccessPageUrl="Manage.aspx?m=ChangePwdSuccess">
                <ChangePasswordTemplate>
                    <p class="validation-summary-errors">
                        <asp:Literal runat="server" ID="FailureText" />
                    </p>
                    <fieldset class="changePassword">
                        <legend>Change password details</legend>
                        <ol>
                            <li>
                                <asp:Label runat="server" ID="CurrentPasswordLabel" AssociatedControlID="CurrentPassword">Current password</asp:Label>
                                <asp:TextBox runat="server" ID="CurrentPassword" CssClass="passwordEntry" TextMode="Password" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="CurrentPassword"
                                    CssClass="field-validation-error" ErrorMessage="The current password field is required."
                                    ValidationGroup="ChangePassword" />
                            </li>
                            <li>
                                <asp:Label runat="server" ID="NewPasswordLabel" AssociatedControlID="NewPassword">New password</asp:Label>
                                <asp:TextBox runat="server" ID="NewPassword" CssClass="passwordEntry" TextMode="Password" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="NewPassword"
                                    CssClass="field-validation-error" ErrorMessage="The new password is required."
                                    ValidationGroup="ChangePassword" />
                            </li>
                            <li>
                                <asp:Label runat="server" ID="ConfirmNewPasswordLabel" AssociatedControlID="ConfirmNewPassword">Confirm new password</asp:Label>
                                <asp:TextBox runat="server" ID="ConfirmNewPassword" CssClass="passwordEntry" TextMode="Password" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmNewPassword"
                                    CssClass="field-validation-error" Display="Dynamic" ErrorMessage="Confirm new password is required."
                                    ValidationGroup="ChangePassword" />
                                <asp:CompareValidator runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword"
                                    CssClass="field-validation-error" Display="Dynamic" ErrorMessage="The new password and confirmation password do not match."
                                    ValidationGroup="ChangePassword" />
                            </li>
                        </ol>
                        <asp:Button runat="server" CommandName="ChangePassword" Text="Change password" ValidationGroup="ChangePassword" />
                    </fieldset>
                </ChangePasswordTemplate>
            </asp:ChangePassword>
        </asp:PlaceHolder>
    </section>

    <section id="externalLoginsForm">
        
        <asp:ListView runat="server"
            ItemType="Microsoft.AspNet.Membership.OpenAuth.OpenAuthAccountData"
            SelectMethod="GetExternalLogins" DeleteMethod="RemoveExternalLogin" DataKeyNames="ProviderName,ProviderUserId">
        
            <LayoutTemplate>
                <h3>Registered external logins</h3>
                <table>
                    <thead><tr><th>Service</th><th>User Name</th><th>Last Used</th><th>&nbsp;</th></tr></thead>
                    <tbody>
                        <tr runat="server" id="itemPlaceholder"></tr>
                    </tbody>
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    
                    <td><%#: Item.ProviderDisplayName %></td>
                    <td><%#: Item.ProviderUserName %></td>
                    <td><%#: ConvertToDisplayDateTime(Item.LastUsedUtc) %></td>
                    <td>
                        <asp:Button runat="server" Text="Remove" CommandName="Delete" CausesValidation="false" 
                            ToolTip='<%#: "Remove this " & Item.ProviderDisplayName & " login from your account" %>'
                            Visible="<%# CanRemoveExternalLogins %>" />
                    </td>
                    
                </tr>
            </ItemTemplate>
        </asp:ListView>

        <h3>Add an external login</h3>
        <uc:OpenAuthProviders runat="server" ReturnUrl="~/Account/Manage.aspx" />
    </section>
    </asp:Panel>
<%--   <script>
            $("#MainContent_gvOrders tr").click(function () {
                $(this).toggleClass("highlight");
            });
    </script>
    <style>
        .highlight { background-color: red; }
    </style>--%>
    <style>
        #fgid_612394abfff25aacda4d091ff {
            display: none;
        }
    </style>
</asp:Content>
