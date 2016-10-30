<%@ Page Title="Address" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Address.aspx.vb" Inherits="Account_Address" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <div style="text-align:center"><a href="Manage.aspx">My Account</a></div><br />
    <asp:Panel ID="pnlLogin" runat="server" Visible="False">
        <asp:Login ID="Login1" runat="server"></asp:Login>
    </asp:Panel>
    <asp:Panel ID="pnlAddress" runat="server">
        Select an Address:
        <asp:DropDownList ID="ddlAddress" runat="server" DataSourceID="sql_ddlAddress" DataTextField="Address" DataValueField="Address_Id" AutoPostBack="True"></asp:DropDownList>
        <asp:SqlDataSource ID="sql_ddlAddress" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT Address_Id, Address1 AS Address FROM paft_Address WHERE (User_Id = @User_Id)">
            <SelectParameters>
                <asp:SessionParameter Name="User_Id" SessionField="User_Id" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:FormView ID="fvAddress" runat="server" DataKeyNames="Address_Id" DataSourceID="sql_fvAddress">
            <EditItemTemplate>
                Address_Id:
                <asp:Label ID="Address_IdLabel1" runat="server" Text='<%# Eval("Address_Id") %>' />
                <br />
                Name:
                <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' />
                <br />
                Email:
                <asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>' />
                <br />
                Phone:
                <asp:TextBox ID="PhoneTextBox" runat="server" Text='<%# Bind("Phone") %>' />
                <br />
                Address1:
                <asp:TextBox ID="Address1TextBox" runat="server" Text='<%# Bind("Address1") %>' />
                <br />
                Address2:
                <asp:TextBox ID="Address2TextBox" runat="server" Text='<%# Bind("Address2") %>' />
                <br />
                City:
                <asp:TextBox ID="CityTextBox" runat="server" Text='<%# Bind("City") %>' />
                <br />
                State:
                <asp:TextBox ID="StateTextBox" runat="server" Text='<%# Bind("State") %>' />
                <br />
                Zipcode:
                <asp:TextBox ID="ZipcodeTextBox" runat="server" Text='<%# Bind("Zipcode") %>' />
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
&nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </EditItemTemplate>
            <InsertItemTemplate>
                Name:
                <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' />
                <br />
                Email:
                <asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>' />
                <br />
                Phone:
                <asp:TextBox ID="PhoneTextBox" runat="server" Text='<%# Bind("Phone") %>' />
                <br />
                Address1:
                <asp:TextBox ID="Address1TextBox" runat="server" Text='<%# Bind("Address1") %>' />
                <br />
                Address2:
                <asp:TextBox ID="Address2TextBox" runat="server" Text='<%# Bind("Address2") %>' />
                <br />
                City:
                <asp:TextBox ID="CityTextBox" runat="server" Text='<%# Bind("City") %>' />
                <br />
                State:
                <asp:TextBox ID="StateTextBox" runat="server" Text='<%# Bind("State") %>' />
                <br />
                Zipcode:
                <asp:TextBox ID="ZipcodeTextBox" runat="server" Text='<%# Bind("Zipcode") %>' />
                <br />
                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
&nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </InsertItemTemplate>
            <ItemTemplate>
                Address_Id:
                <asp:Label ID="Address_IdLabel" runat="server" Text='<%# Eval("Address_Id") %>' />
                <br />
                Name:
                <asp:Label ID="NameLabel" runat="server" Text='<%# Bind("Name") %>' />
                <br />
                Email:
                <asp:Label ID="EmailLabel" runat="server" Text='<%# Bind("Email") %>' />
                <br />
                Phone:
                <asp:Label ID="PhoneLabel" runat="server" Text='<%# Bind("Phone") %>' />
                <br />
                Address1:
                <asp:Label ID="Address1Label" runat="server" Text='<%# Bind("Address1") %>' />
                <br />
                Address2:
                <asp:Label ID="Address2Label" runat="server" Text='<%# Bind("Address2") %>' />
                <br />
                City:
                <asp:Label ID="CityLabel" runat="server" Text='<%# Bind("City") %>' />
                <br />
                State:
                <asp:Label ID="StateLabel" runat="server" Text='<%# Bind("State") %>' />
                <br />
                Zipcode:
                <asp:Label ID="ZipcodeLabel" runat="server" Text='<%# Bind("Zipcode") %>' />
                <br />
                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
&nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
&nbsp;
            </ItemTemplate>
        </asp:FormView>
        <asp:SqlDataSource ID="sql_fvAddress" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" DeleteCommand="DELETE FROM [paft_Address] WHERE [Address_Id] = @original_Address_Id"  OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [Address_Id], [Name], [Email], [Phone], [Address1], [Address2], [City], [State], [Zipcode] FROM [paft_Address] WHERE ([Address_Id] = @Address_Id) ORDER BY [Address_Id] DESC" UpdateCommand="UPDATE [paft_Address] SET [Name] = @Name, [Email] = @Email, [Phone] = @Phone, [Address1] = @Address1, [Address2] = @Address2, [City] = @City, [State] = @State, [Zipcode] = @Zipcode WHERE [Address_Id] = @original_Address_Id">
            <DeleteParameters>
                <asp:Parameter Name="original_Address_Id" Type="Int32" />
                <asp:Parameter Name="original_Name" Type="String" />
                <asp:Parameter Name="original_Email" Type="String" />
                <asp:Parameter Name="original_Phone" Type="String" />
                <asp:Parameter Name="original_Address1" Type="String" />
                <asp:Parameter Name="original_Address2" Type="String" />
                <asp:Parameter Name="original_City" Type="String" />
                <asp:Parameter Name="original_State" Type="String" />
                <asp:Parameter Name="original_Zipcode" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Name" Type="String" />
                <asp:Parameter Name="Email" Type="String" />
                <asp:Parameter Name="Phone" Type="String" />
                <asp:Parameter Name="Address1" Type="String" />
                <asp:Parameter Name="Address2" Type="String" />
                <asp:Parameter Name="City" Type="String" />
                <asp:Parameter Name="State" Type="String" />
                <asp:Parameter Name="Zipcode" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlAddress" Name="Address_Id" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Name" Type="String" />
                <asp:Parameter Name="Email" Type="String" />
                <asp:Parameter Name="Phone" Type="String" />
                <asp:Parameter Name="Address1" Type="String" />
                <asp:Parameter Name="Address2" Type="String" />
                <asp:Parameter Name="City" Type="String" />
                <asp:Parameter Name="State" Type="String" />
                <asp:Parameter Name="Zipcode" Type="String" />
                <asp:Parameter Name="original_Address_Id" Type="Int32" />
                <asp:Parameter Name="original_Name" Type="String" />
                <asp:Parameter Name="original_Email" Type="String" />
                <asp:Parameter Name="original_Phone" Type="String" />
                <asp:Parameter Name="original_Address1" Type="String" />
                <asp:Parameter Name="original_Address2" Type="String" />
                <asp:Parameter Name="original_City" Type="String" />
                <asp:Parameter Name="original_State" Type="String" />
                <asp:Parameter Name="original_Zipcode" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <div style="text-align:center;padding-right:20px"><asp:LinkButton ID="lbAddNewAddress" runat="server">Add a new address</asp:LinkButton></div>
        <asp:Panel ID="pnlAddAddress" runat="server" Visible="false">
            <style>
                .auto-style1 {
                    text-align: right;
                }
            </style>
            <table id="Address" style="width: 95%;">
                <tr>
                    <td class="auto-style1">Name</td>
                    <td><asp:TextBox ID="tbName" runat="server" Width="150px"></asp:TextBox>* (Please Enter Your Full Name: <strong>GivenName Surname</strong>)</td>
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
                    <td class="auto-style1">Address1</td>
                    <td>
                        <asp:TextBox ID="tbAddress1" runat="server" Width="180px"></asp:TextBox>*</td>
                </tr>
                <tr>
                    <td class="auto-style1">Address2</td>
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
                        <span><asp:Button ID="btnAddAddress" runat="server" Text="Add Address" />    <asp:Button ID="btnCancel" runat="server" Text="Cancel" /></span>
                        <asp:SqlDataSource ID="sql_AddAddress" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'></asp:SqlDataSource>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </asp:Panel>
    <style>
        label {
            display:inline;
        }
    </style>
</asp:Content>

