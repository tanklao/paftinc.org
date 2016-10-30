<%@ Page Title="Database Configuation" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="config.aspx.vb" Inherits="Admin_config" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <style>
        #config td {
            vertical-align: text-top;
            padding-bottom: 10px;
        }
        .auto-style1 {
            font-size: medium;
        }
    </style>
    <h3>Database Configuration</h3>
    <table id="config" style="width: 90%">
        <tr>
            <td>
                <strong>Product Category:</strong>
                <asp:DropDownList ID="ddl_Category" runat="server" DataSourceID="sql_ddl_Category" DataTextField="Category_Name" DataValueField="Category_Id" AutoPostBack="True"></asp:DropDownList>
                <asp:SqlDataSource runat="server" ID="sql_ddl_Category" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT [Category_Id], [Category_Name] FROM [paft_Category]"></asp:SqlDataSource>
                <asp:FormView ID="fv_Category" runat="server" DataKeyNames="Category_Id" DataSourceID="sql_fv_Category">
                    <EditItemTemplate>
                        Category_Id:
                        <asp:Label Text='<%# Eval("Category_Id") %>' runat="server" ID="Category_IdLabel1" /><br />
                        Category_Name:
                        <asp:TextBox Text='<%# Bind("Category_Name") %>' runat="server" ID="Category_NameTextBox" /><br />
                        <asp:LinkButton runat="server" Text="Update" CommandName="Update" ID="UpdateButton" CausesValidation="True" />&nbsp;<asp:LinkButton runat="server" Text="Cancel" CommandName="Cancel" ID="UpdateCancelButton" CausesValidation="False" />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        Category_Name:
                        <asp:TextBox Text='<%# Bind("Category_Name") %>' runat="server" ID="Category_NameTextBox" /><br />
                        <asp:LinkButton runat="server" Text="Insert" CommandName="Insert" ID="InsertButton" CausesValidation="True" />&nbsp;<asp:LinkButton runat="server" Text="Cancel" CommandName="Cancel" ID="InsertCancelButton" CausesValidation="False" />
                    </InsertItemTemplate>
                    <ItemTemplate>
                        Category_Id:
                        <asp:Label Text='<%# Eval("Category_Id") %>' runat="server" ID="Category_IdLabel" /><br />
                        Category_Name:
                        <asp:Label Text='<%# Bind("Category_Name") %>' runat="server" ID="Category_NameLabel" /><br />
                        <asp:LinkButton runat="server" Text="Edit" CommandName="Edit" ID="EditButton" CausesValidation="False" />&nbsp;<asp:LinkButton runat="server" Text="Delete" CommandName="Delete" ID="DeleteButton" CausesValidation="False" />&nbsp;<asp:LinkButton runat="server" Text="New" CommandName="New" ID="NewButton" CausesValidation="False" />
                    </ItemTemplate>
                </asp:FormView>
                <asp:SqlDataSource runat="server" ID="sql_fv_Category" ConflictDetection="CompareAllValues" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' DeleteCommand="DELETE FROM [paft_Category] WHERE [Category_Id] = @original_Category_Id AND [Category_Name] = @original_Category_Name" InsertCommand="INSERT INTO [paft_Category] ([Category_Name]) VALUES (@Category_Name)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [paft_Category] WHERE ([Category_Id] = @Category_Id)" UpdateCommand="UPDATE [paft_Category] SET [Category_Name] = @Category_Name WHERE [Category_Id] = @original_Category_Id AND [Category_Name] = @original_Category_Name">
                    <DeleteParameters>
                        <asp:Parameter Name="original_Category_Id" Type="Int32"></asp:Parameter>
                        <asp:Parameter Name="original_Category_Name" Type="String"></asp:Parameter>
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="Category_Name" Type="String"></asp:Parameter>
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddl_Category" PropertyName="SelectedValue" Name="Category_Id" Type="Int32"></asp:ControlParameter>
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Category_Name" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_Category_Id" Type="Int32"></asp:Parameter>
                        <asp:Parameter Name="original_Category_Name" Type="String"></asp:Parameter>
                    </UpdateParameters>
                </asp:SqlDataSource>
            </td>
            <td><strong>Products:</strong>
                <asp:DropDownList ID="ddl_Products" runat="server" DataSourceID="sql_ddl_Products" DataTextField="Name" DataValueField="Prod_Id" AutoPostBack="True"></asp:DropDownList>
                <asp:SqlDataSource runat="server" ID="sql_ddl_Products" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT [Name], [Prod_Id] FROM [paft_Products] ORDER BY [Name]"></asp:SqlDataSource>
                <asp:FormView ID="fv_Product" runat="server" DataKeyNames="Prod_Id" DataSourceID="sql_fv_Products">
                    <EditItemTemplate>
                        Prod_Id:
                <asp:Label Text='<%# Eval("Prod_Id") %>' runat="server" ID="Prod_IdLabel1" /><br />
                        SKU:
                <asp:TextBox Text='<%# Bind("SKU") %>' runat="server" ID="SKUTextBox" /><br />
                        Name:
                <asp:TextBox Text='<%# Bind("Name") %>' runat="server" ID="NameTextBox" /><br />
                        Description:
                <asp:TextBox Text='<%# Bind("Description") %>' runat="server" ID="DescriptionTextBox" /><br />
                        ImageURL:
                <asp:TextBox Text='<%# Bind("ImageURL") %>' runat="server" ID="ImageURLTextBox" ReadOnly="True" />
                        <br />
                        <asp:FileUpload ID="fuUpdateImage" runat="server" />
                        <asp:Button ID="btnUpdateImage" runat="server" OnClick="btnUpdateImage_Click" Text="Upload" />
                        <br />
                        Category_Id:
                        <asp:DropDownList ID="ddl_fv_ProductsEditCategory" runat="server" DataSourceID="sql_ddl_fv_ProductsEditCategory" DataTextField="Category_Name" DataValueField="Category_Id" SelectedValue='<%# Bind("Category_Id") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sql_ddl_fv_ProductsEditCategory" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [Category_Id], [Category_Name] FROM [paft_Category]"></asp:SqlDataSource>
                        <br />
                        Price:&nbsp;<asp:TextBox ID="PriceTextBox" runat="server" Text='<%# Bind("Price") %>'></asp:TextBox>
                        <br />
                        <asp:LinkButton runat="server" Text="Update" CommandName="Update" ID="UpdateButton" CausesValidation="True" />&nbsp;<asp:LinkButton runat="server" Text="Cancel" CommandName="Cancel" ID="UpdateCancelButton" CausesValidation="False" />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        SKU:
                <asp:TextBox Text='<%# Bind("SKU") %>' runat="server" ID="SKUTextBox" /><br />
                        Name:
                <asp:TextBox Text='<%# Bind("Name") %>' runat="server" ID="NameTextBox" /><br />
                        Description:
                <asp:TextBox Text='<%# Bind("Description") %>' runat="server" ID="DescriptionTextBox" /><br />
                        ImageURL: 
                        <asp:TextBox ID="lbl_ImageURL" runat="server" ReadOnly="True" Text='<%# Bind("ImageURL") %>'></asp:TextBox>
                        <br />
                        <asp:FileUpload ID="fu_ImageUpLoad" runat="server" />
                        <asp:Button ID="btn_Image" runat="server" OnClick="Button1_Click" Text="Upload" />
                        <br />
                        <br />
                        Category_Id:
                        <asp:DropDownList ID="ddl_fv_ProductNewCategory" runat="server" DataSourceID="sql_ddl_fv_ProductNewCategory" DataTextField="Category_Name" DataValueField="Category_Id" SelectedValue='<%# Bind("Category_Id") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sql_ddl_fv_ProductNewCategory" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [Category_Id], [Category_Name] FROM [paft_Category]"></asp:SqlDataSource>
                        <br />
                        Price:&nbsp;<asp:TextBox ID="PriceTextBoxNew" runat="server" Text='<%# Bind("Price") %>'></asp:TextBox>
                        <br />
                        <asp:LinkButton runat="server" Text="Insert" CommandName="Insert" ID="InsertButton" CausesValidation="True" />&nbsp;<asp:LinkButton runat="server" Text="Cancel" CommandName="Cancel" ID="InsertCancelButton" CausesValidation="False" />
                    </InsertItemTemplate>
                    <ItemTemplate>
                        Prod_Id:
                <asp:Label Text='<%# Eval("Prod_Id") %>' runat="server" ID="Prod_IdLabel" /><br />
                        SKU:
                <asp:Label Text='<%# Bind("SKU") %>' runat="server" ID="SKULabel" /><br />
                        Name:
                <asp:Label Text='<%# Bind("Name") %>' runat="server" ID="NameLabel" /><br />
                        Description:
                <asp:Label Text='<%# Bind("Description") %>' runat="server" ID="DescriptionLabel" /><br />
                        ImageURL:
                <asp:Label Text='<%# Bind("ImageURL") %>' runat="server" ID="ImageURLLabel" /><br />
                        Category_Id:
                <asp:Label Text='<%# Bind("Category_Id") %>' runat="server" ID="Category_IdLabel" />
                        &nbsp;(<asp:Label ID="lbl_fv_ProductVCategory" runat="server"></asp:Label>
                        )<asp:SqlDataSource ID="sql_lbl_fv_ProductViewCategory" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT [Category_Id], [Category_Name] FROM [paft_Category] WHERE ([Category_Id] = @Category_Id)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="Category_IdLabel" Name="Category_Id" PropertyName="Text" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        Price:&nbsp;<asp:Label ID="PriceLabel" runat="server" Text='<%# Bind("Price") %>'></asp:Label>
                        <br />
                        <%--&nbsp;&nbsp;<asp:LinkButton runat="server" Text="Edit" CommandName="Edit" ID="EditButton" CausesValidation="False" />&nbsp;<asp:LinkButton runat="server" Text="Delete" CommandName="Delete" ID="DeleteButton" CausesValidation="False" />&nbsp;<asp:LinkButton runat="server" Text="New" CommandName="New" ID="NewButton" CausesValidation="False" />
                    --%>
                        &nbsp;&nbsp;<asp:LinkButton ID="lbEditProduct" runat="server" PostBackUrl="~/Admin/manageProducts.aspx">Edit Products</asp:LinkButton>
                    </ItemTemplate>
                </asp:FormView>
                <asp:SqlDataSource runat="server" ID="sql_fv_Products" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT Prod_Id, SKU, Name, Description, ImageURL, Category_Id, Price FROM paft_Products WHERE ([Prod_Id] = @Prod_Id) ORDER BY [Name]" ConflictDetection="CompareAllValues" DeleteCommand="DELETE FROM [paft_Products] WHERE [Prod_Id] = @original_Prod_Id AND [SKU] = @original_SKU AND [Name] = @original_Name AND [Description] = @original_Description AND [ImageURL] = @original_ImageURL AND [Category_Id] = @original_Category_Id AND (([Price] = @original_Price) OR ([Price] IS NULL AND @original_Price IS NULL))" InsertCommand="INSERT INTO [paft_Products] ([SKU], [Name], [Description], [ImageURL], [Category_Id], [Price]) VALUES (@SKU, @Name, @Description, @ImageURL, @Category_Id, @Price)" OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE [paft_Products] SET [SKU] = @SKU, [Name] = @Name, [Description] = @Description, [ImageURL] = @ImageURL, [Category_Id] = @Category_Id, [Price] = @Price WHERE [Prod_Id] = @original_Prod_Id AND [SKU] = @original_SKU AND [Name] = @original_Name AND [Description] = @original_Description AND [ImageURL] = @original_ImageURL AND [Category_Id] = @original_Category_Id AND (([Price] = @original_Price) OR ([Price] IS NULL AND @original_Price IS NULL))">
                    <DeleteParameters>
                        <asp:Parameter Name="original_Prod_Id" Type="Int32"></asp:Parameter>
                        <asp:Parameter Name="original_SKU" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_Name" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_Description" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_ImageURL" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_Category_Id" Type="Int32"></asp:Parameter>
                        <asp:Parameter Name="original_Price" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="SKU" Type="String"></asp:Parameter>
                        <asp:Parameter Name="Name" Type="String"></asp:Parameter>
                        <asp:Parameter Name="Description" Type="String"></asp:Parameter>
                        <asp:Parameter Name="ImageURL" Type="String"></asp:Parameter>
                        <asp:Parameter Name="Category_Id" Type="Int32"></asp:Parameter>
                        <asp:Parameter Name="Price" Type="Int32" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddl_Products" PropertyName="SelectedValue" Name="Prod_Id" Type="Int32"></asp:ControlParameter>
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="SKU" Type="String"></asp:Parameter>
                        <asp:Parameter Name="Name" Type="String"></asp:Parameter>
                        <asp:Parameter Name="Description" Type="String"></asp:Parameter>
                        <asp:Parameter Name="ImageURL" Type="String"></asp:Parameter>
                        <asp:Parameter Name="Category_Id" Type="Int32"></asp:Parameter>
                        <asp:Parameter Name="Price" Type="Int32"></asp:Parameter>
                        <asp:Parameter Name="original_Prod_Id" Type="Int32"></asp:Parameter>
                        <asp:Parameter Name="original_SKU" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_Name" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_Description" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_ImageURL" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_Category_Id" Type="Int32" />
                        <asp:Parameter Name="original_Price" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <strong>Address:</strong>
                <asp:DropDownList ID="ddl_Item" runat="server" DataSourceID="sql_ddl_Items" DataTextField="Address" DataValueField="Address_Id" AutoPostBack="True">
                </asp:DropDownList>
                <asp:SqlDataSource runat="server" ID="sql_ddl_Items" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT Address_Id, Name + ': ' + Address1 AS Address FROM paft_Address">
                </asp:SqlDataSource>
                <asp:FormView ID="fv_Address" runat="server" DataKeyNames="Address_Id" DataSourceID="sql_fv_paftAddress">
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

                <asp:SqlDataSource ID="sql_fv_paftAddress" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" DeleteCommand="DELETE FROM [paft_Address] WHERE [Address_Id] = @original_Address_Id AND [Name] = @original_Name AND [Email] = @original_Email AND (([Phone] = @original_Phone) OR ([Phone] IS NULL AND @original_Phone IS NULL)) AND [Address1] = @original_Address1 AND (([Address2] = @original_Address2) OR ([Address2] IS NULL AND @original_Address2 IS NULL)) AND [City] = @original_City AND [State] = @original_State AND [Zipcode] = @original_Zipcode" InsertCommand="INSERT INTO [paft_Address] ([Name], [Email], [Phone], [Address1], [Address2], [City], [State], [Zipcode]) VALUES (@Name, @Email, @Phone, @Address1, @Address2, @City, @State, @Zipcode)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [Address_Id], [Name], [Email], [Phone], [Address1], [Address2], [City], [State], [Zipcode] FROM [paft_Address] WHERE ([Address_Id] = @Address_Id)" UpdateCommand="UPDATE [paft_Address] SET [Name] = @Name, [Email] = @Email, [Phone] = @Phone, [Address1] = @Address1, [Address2] = @Address2, [City] = @City, [State] = @State, [Zipcode] = @Zipcode WHERE [Address_Id] = @original_Address_Id AND [Name] = @original_Name AND [Email] = @original_Email AND (([Phone] = @original_Phone) OR ([Phone] IS NULL AND @original_Phone IS NULL)) AND [Address1] = @original_Address1 AND (([Address2] = @original_Address2) OR ([Address2] IS NULL AND @original_Address2 IS NULL)) AND [City] = @original_City AND [State] = @original_State AND [Zipcode] = @original_Zipcode">
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
                        <asp:ControlParameter ControlID="ddl_Item" Name="Address_Id" PropertyName="SelectedValue" Type="Int32" />
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

            </td>
        </tr>
        <tr>
            <td>
                <strong>Item Status:</strong><asp:DropDownList ID="ddl_ItemStatus" runat="server" DataSourceID="sql_ddl_ItemStatus" DataTextField="Status" DataValueField="Status_Id" AutoPostBack="True"></asp:DropDownList>
                <asp:SqlDataSource ID="sql_ddl_ItemStatus" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [Status_Id], [Status] FROM [paft_Item_Status]"></asp:SqlDataSource>
                <asp:FormView ID="fv_ItemStatus" runat="server" DataKeyNames="Status_Id" DataSourceID="sql_fv_ItemStatus">
                    <EditItemTemplate>
                        Status_Id:
                        <asp:Label Text='<%# Eval("Status_Id") %>' runat="server" ID="Status_IdLabel1" /><br />
                        Status:
                        <asp:TextBox Text='<%# Bind("Status") %>' runat="server" ID="StatusTextBox" /><br />
                        <asp:LinkButton runat="server" Text="Update" CommandName="Update" ID="UpdateButton" CausesValidation="True" />&nbsp;<asp:LinkButton runat="server" Text="Cancel" CommandName="Cancel" ID="UpdateCancelButton" CausesValidation="False" />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        Status:
                        <asp:TextBox Text='<%# Bind("Status") %>' runat="server" ID="StatusTextBox" /><br />
                        <asp:LinkButton runat="server" Text="Insert" CommandName="Insert" ID="InsertButton" CausesValidation="True" />&nbsp;<asp:LinkButton runat="server" Text="Cancel" CommandName="Cancel" ID="InsertCancelButton" CausesValidation="False" />
                    </InsertItemTemplate>
                    <ItemTemplate>
                        Status_Id:
                        <asp:Label Text='<%# Eval("Status_Id") %>' runat="server" ID="Status_IdLabel" /><br />
                        Status:
                        <asp:Label Text='<%# Bind("Status") %>' runat="server" ID="StatusLabel" /><br />
                        <asp:LinkButton runat="server" Text="Edit" CommandName="Edit" ID="EditButton" CausesValidation="False" />&nbsp;<asp:LinkButton runat="server" Text="Delete" CommandName="Delete" ID="DeleteButton" CausesValidation="False" />&nbsp;<asp:LinkButton runat="server" Text="New" CommandName="New" ID="NewButton" CausesValidation="False" />
                    </ItemTemplate>
                </asp:FormView>
                <asp:SqlDataSource runat="server" ID="sql_fv_ItemStatus" ConflictDetection="CompareAllValues" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' DeleteCommand="DELETE FROM [paft_Item_Status] WHERE [Status_Id] = @original_Status_Id AND [Status] = @original_Status" InsertCommand="INSERT INTO [paft_Item_Status] ([Status]) VALUES (@Status)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [paft_Item_Status] WHERE ([Status_Id] = @Status_Id)" UpdateCommand="UPDATE [paft_Item_Status] SET [Status] = @Status WHERE [Status_Id] = @original_Status_Id AND [Status] = @original_Status">
                    <DeleteParameters>
                        <asp:Parameter Name="original_Status_Id" Type="Int32"></asp:Parameter>
                        <asp:Parameter Name="original_Status" Type="String"></asp:Parameter>
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="Status" Type="String"></asp:Parameter>
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddl_ItemStatus" PropertyName="SelectedValue" Name="Status_Id" Type="Int32"></asp:ControlParameter>
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Status" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_Status_Id" Type="Int32"></asp:Parameter>
                        <asp:Parameter Name="original_Status" Type="String"></asp:Parameter>
                    </UpdateParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <strong>Order Status:</strong>
                <asp:DropDownList ID="ddl_OrderStatus" runat="server" DataSourceID="sql_ddl_OrderStatus" DataTextField="Order_Status" DataValueField="Status_Id" AutoPostBack="True"></asp:DropDownList>
                <asp:SqlDataSource runat="server" ID="sql_ddl_OrderStatus" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT [Status_Id], [Order_Status] FROM [paft_Order_Status]"></asp:SqlDataSource>
                <asp:FormView ID="fv_OrderStatus" runat="server" DataKeyNames="Status_Id" DataSourceID="sql_fv_OrderStatus">
                    <EditItemTemplate>
                        Status_Id:
                        <asp:Label Text='<%# Eval("Status_Id") %>' runat="server" ID="Status_IdLabel1" /><br />
                        Order_Status:
                        <asp:TextBox ID="Order_StatusTextBox" runat="server" Text='<%# Bind("Order_Status") %>' />
                        <br />
                        <asp:LinkButton runat="server" Text="Update" CommandName="Update" ID="UpdateButton" CausesValidation="True" />&nbsp;<asp:LinkButton runat="server" Text="Cancel" CommandName="Cancel" ID="UpdateCancelButton" CausesValidation="False" />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        Order_Status:
                        <asp:TextBox ID="Order_StatusTextBox" runat="server" Text='<%# Bind("Order_Status") %>' />
                        <br />
                        <asp:LinkButton runat="server" Text="Insert" CommandName="Insert" ID="InsertButton" CausesValidation="True" />&nbsp;<asp:LinkButton runat="server" Text="Cancel" CommandName="Cancel" ID="InsertCancelButton" CausesValidation="False" />
                    </InsertItemTemplate>
                    <ItemTemplate>
                        Status_Id:
                        <asp:Label Text='<%# Eval("Status_Id") %>' runat="server" ID="Status_IdLabel" /><br />
                        Order_Status:
                        <asp:Label ID="Order_StatusLabel" runat="server" Text='<%# Bind("Order_Status") %>' />
                        <br />
                    </ItemTemplate>
                </asp:FormView>
                <asp:SqlDataSource runat="server" ID="sql_fv_OrderStatus" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [paft_Order_Status] WHERE ([Status_Id] = @Status_Id)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddl_OrderStatus" Name="Status_Id" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <strong>Transaction Type:</strong>
                <asp:DropDownList ID="ddl_TransType" runat="server" DataSourceID="sql_ddl_TransType" DataTextField="Type" DataValueField="Type_Id" AutoPostBack="True"></asp:DropDownList>
                <asp:SqlDataSource runat="server" ID="sql_ddl_TransType" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT [Type_Id], [Type] FROM [paft_Transaction_Type]"></asp:SqlDataSource>
                <asp:FormView ID="fv_TransType" runat="server" DataKeyNames="Type_Id" DataSourceID="sql_fv_TransType">
                    <EditItemTemplate>
                        Type_Id:
                        <asp:Label Text='<%# Eval("Type_Id") %>' runat="server" ID="Type_IdLabel1" /><br />
                        Type:
                        <asp:TextBox Text='<%# Bind("Type") %>' runat="server" ID="TypeTextBox" /><br />
                        <asp:LinkButton runat="server" Text="Update" CommandName="Update" ID="UpdateButton" CausesValidation="True" />&nbsp;<asp:LinkButton runat="server" Text="Cancel" CommandName="Cancel" ID="UpdateCancelButton" CausesValidation="False" />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        Type:
                        <asp:TextBox Text='<%# Bind("Type") %>' runat="server" ID="TypeTextBox" /><br />
                        <asp:LinkButton runat="server" Text="Insert" CommandName="Insert" ID="InsertButton" CausesValidation="True" />&nbsp;<asp:LinkButton runat="server" Text="Cancel" CommandName="Cancel" ID="InsertCancelButton" CausesValidation="False" />
                    </InsertItemTemplate>
                    <ItemTemplate>
                        Type_Id:
                        <asp:Label Text='<%# Eval("Type_Id") %>' runat="server" ID="Type_IdLabel" /><br />
                        Type:
                        <asp:Label Text='<%# Bind("Type") %>' runat="server" ID="TypeLabel" /><br />
                        <asp:LinkButton runat="server" Text="Edit" CommandName="Edit" ID="EditButton" CausesValidation="False" />&nbsp;<asp:LinkButton runat="server" Text="Delete" CommandName="Delete" ID="DeleteButton" CausesValidation="False" />&nbsp;<asp:LinkButton runat="server" Text="New" CommandName="New" ID="NewButton" CausesValidation="False" />
                    </ItemTemplate>
                </asp:FormView>
                <asp:SqlDataSource runat="server" ID="sql_fv_TransType" ConflictDetection="CompareAllValues" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' DeleteCommand="DELETE FROM [paft_Transaction_Type] WHERE [Type_Id] = @original_Type_Id AND [Type] = @original_Type" InsertCommand="INSERT INTO [paft_Transaction_Type] ([Type]) VALUES (@Type)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [Type_Id], [Type] FROM [paft_Transaction_Type] WHERE ([Type_Id] = @Type_Id)" UpdateCommand="UPDATE [paft_Transaction_Type] SET [Type] = @Type WHERE [Type_Id] = @original_Type_Id AND [Type] = @original_Type">
                    <DeleteParameters>
                        <asp:Parameter Name="original_Type_Id" Type="Int32"></asp:Parameter>
                        <asp:Parameter Name="original_Type" Type="String"></asp:Parameter>
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="Type" Type="String"></asp:Parameter>
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddl_TransType" PropertyName="SelectedValue" Name="Type_Id" Type="Int32"></asp:ControlParameter>
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Type" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_Type_Id" Type="Int32"></asp:Parameter>
                        <asp:Parameter Name="original_Type" Type="String"></asp:Parameter>
                    </UpdateParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td colspan="3">
            <asp:LinkButton ID="LinkButton2" runat="server" PostBackUrl="~/Admin/manageProducts.aspx"><h5>Manage a batch of items of the same product</h5>
                </asp:LinkButton>
            </td>
        </tr>
        <tr style="display:none">
            <td colspan="3">
                <asp:LinkButton ID="LinkButton1" runat="server"><h5>Add a batch of items of the same product</h5>
                </asp:LinkButton><br />
                What product are you adding? 
                <asp:DropDownList ID="ddl_BatProduct" runat="server" DataSourceID="sql_ddl_BatProduct" DataTextField="Name" DataValueField="Prod_Id" AutoPostBack="True"></asp:DropDownList>
                <asp:SqlDataSource runat="server" ID="sql_ddl_BatProduct" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT [SKU], [Name], [Prod_Id] FROM [paft_Products]"></asp:SqlDataSource>
                &nbsp;<asp:SqlDataSource ID="sql_DB4SKU" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [Prod_Id], [SKU] FROM [paft_Products] WHERE ([Prod_Id] = @Prod_Id)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddl_BatProduct" Name="Prod_Id" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                &nbsp;&nbsp;
                How many items do you have?<asp:TextBox ID="tb_BatTotal" runat="server" Width="20px"></asp:TextBox>
                <br />
                What's is the first item number?
                <asp:TextBox ID="tb_BatItemFirstNo" runat="server" Width="40px" Text="101"></asp:TextBox><br />
                <center><asp:Button ID="btn_BatItem" runat="server" Text="Add Items" /></center>
                <asp:SqlDataSource ID="sql_AddItems" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"></asp:SqlDataSource>
                <asp:Label ID="Label1" runat="server" Text="Adding items failed. Duplicate Item Codes detected. Please check and add items again!" ForeColor="Red" Style="font-size: medium; font-weight: 700" Visible="False"></asp:Label>
                <br />
                <asp:Label ID="lbl_CheckInsert" runat="server" Text="Check your inserted items, please!" Style="font-size: large; font-weight: 700"></asp:Label>
                <br />
                <table>
                    <tr>
                        <td>
                            <asp:GridView ID="gv_Inserts" runat="server" AutoGenerateColumns="False" DataKeyNames="Item_Id" DataSourceID="sql_gv_Inserts" AllowPaging="True" AllowSorting="True" SelectedIndex="0">
                                <Columns>
                                    <asp:CommandField ShowSelectButton="True" />
                                    <asp:BoundField DataField="Item_Id" HeaderText="Item_Id" ReadOnly="True" InsertVisible="False" SortExpression="Item_Id"></asp:BoundField>
                                    <asp:BoundField DataField="Prod_Id" HeaderText="Prod_Id" SortExpression="Prod_Id"></asp:BoundField>
                                    <asp:BoundField DataField="Item_Code" HeaderText="Item_Code" SortExpression="Item_Code"></asp:BoundField>
                                    <asp:BoundField DataField="Item_Status_Id" HeaderText="Status_Id" SortExpression="Item_Status_Id"></asp:BoundField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource runat="server" ID="sql_gv_Inserts" ConflictDetection="CompareAllValues" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' DeleteCommand="DELETE FROM [paft_Items] WHERE [Item_Id] = @original_Item_Id AND [Prod_Id] = @original_Prod_Id AND [Item_Code] = @original_Item_Code AND [Item_Status_Id] = @original_Item_Status_Id" InsertCommand="INSERT INTO [paft_Items] ([Prod_Id], [Item_Code], [Item_Status_Id]) VALUES (@Prod_Id, @Item_Code, @Item_Status_Id)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [paft_Items] WHERE ([Prod_Id] = @Prod_Id)" UpdateCommand="UPDATE [paft_Items] SET [Prod_Id] = @Prod_Id, [Item_Code] = @Item_Code, [Item_Status_Id] = @Item_Status_Id WHERE [Item_Id] = @original_Item_Id AND [Prod_Id] = @original_Prod_Id AND [Item_Code] = @original_Item_Code AND [Item_Status_Id] = @original_Item_Status_Id">
                                <DeleteParameters>
                                    <asp:Parameter Name="original_Item_Id" Type="Int32"></asp:Parameter>
                                    <asp:Parameter Name="original_Prod_Id" Type="Int32"></asp:Parameter>
                                    <asp:Parameter Name="original_Item_Code" Type="String"></asp:Parameter>
                                    <asp:Parameter Name="original_Item_Status_Id" Type="Int32"></asp:Parameter>
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="Prod_Id" Type="Int32"></asp:Parameter>
                                    <asp:Parameter Name="Item_Code" Type="String"></asp:Parameter>
                                    <asp:Parameter Name="Item_Status_Id" Type="Int32"></asp:Parameter>
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="ddl_BatProduct" Name="Prod_Id" PropertyName="SelectedValue" Type="Int32" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="Prod_Id" Type="Int32"></asp:Parameter>
                                    <asp:Parameter Name="Item_Code" Type="String"></asp:Parameter>
                                    <asp:Parameter Name="Item_Status_Id" Type="Int32"></asp:Parameter>
                                    <asp:Parameter Name="original_Item_Id" Type="Int32"></asp:Parameter>
                                    <asp:Parameter Name="original_Prod_Id" Type="Int32"></asp:Parameter>
                                    <asp:Parameter Name="original_Item_Code" Type="String"></asp:Parameter>
                                    <asp:Parameter Name="original_Item_Status_Id" Type="Int32"></asp:Parameter>
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </td>
                        <td>
                            <strong><span class="auto-style1">Please select an item to edit.</span></strong><br />
                            <asp:FormView ID="fv_Items" runat="server" DataKeyNames="Item_Id" DataSourceID="sql_fv_Item">
                                <EditItemTemplate>
                                    Item_Id:
                          <asp:Label ID="Item_IdLabel1" runat="server" Text='<%# Eval("Item_Id") %>' />
                                    <br />
                                    Prod_Id:
                          <asp:DropDownList ID="ddlfvItemsEditProd" runat="server" DataSourceID="sql_ddlfvItemsEditProd" DataTextField="Name" DataValueField="Prod_Id" SelectedValue='<%# Bind("Prod_Id") %>'>
                          </asp:DropDownList>
                                    <asp:SqlDataSource ID="sql_ddlfvItemsEditProd" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [Prod_Id], [Name] FROM [paft_Products]"></asp:SqlDataSource>
                                    <br />
                                    Item_Code:
                          <asp:TextBox ID="Item_CodeTextBox" runat="server" Text='<%# Bind("Item_Code") %>' />
                                    <br />
                                    Item_Status_Id:
                          <asp:DropDownList ID="ddlfvItemsEditStatus" runat="server" DataSourceID="sql_ddlfvItemsEditStatus" DataTextField="Status" DataValueField="Status_Id" SelectedValue='<%# Bind("Item_Status_Id") %>'>
                          </asp:DropDownList>
                                    <asp:SqlDataSource ID="sql_ddlfvItemsEditStatus" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [Status_Id], [Status] FROM [paft_Item_Status]"></asp:SqlDataSource>
                                    <br />
                                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                                    &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    Prod_Id:
                          <asp:DropDownList ID="ddl_fvItemsEditProd" runat="server" DataSourceID="sql_ddl_fvItemsEditProd" DataTextField="Name" DataValueField="Prod_Id" SelectedValue='<%# Bind("Prod_Id") %>'>
                          </asp:DropDownList>
                                    <asp:SqlDataSource ID="sql_ddl_fvItemsEditProd" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [Prod_Id], [Name] FROM [paft_Products]"></asp:SqlDataSource>
                                    <br />
                                    Item_Code:
                          <asp:TextBox ID="Item_CodeTextBox" runat="server" Text='<%# Bind("Item_Code") %>' />
                                    <br />
                                    Item_Status_Id:
                          <asp:DropDownList ID="ddl_fvItemsEditStatus" runat="server" DataSourceID="sql_ddl_fvItemsEditStatus" DataTextField="Status" DataValueField="Status_Id" SelectedValue='<%# Bind("Item_Status_Id") %>'>
                          </asp:DropDownList>
                                    <asp:SqlDataSource ID="sql_ddl_fvItemsEditStatus" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [Status_Id], [Status] FROM [paft_Item_Status]"></asp:SqlDataSource>
                                    <br />
                                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                                    &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    Item_Id:
                          <asp:Label ID="Item_IdLabel" runat="server" Text='<%# Eval("Item_Id") %>' />
                                    <br />
                                    Prod_Id:
                          <asp:Label ID="Prod_IdLabel" runat="server" Text='<%# Bind("Prod_Id") %>' />
                                    &nbsp; (<asp:Label ID="lbl_fv_ItemVProd" runat="server" Text="Label"></asp:Label>)<br />
                                    <asp:SqlDataSource ID="sql_fv_ItemVProd" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT [Prod_Id], [Name] FROM [paft_Products] WHERE ([Prod_Id] = @Prod_Id)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="Prod_IdLabel" Name="Prod_Id" PropertyName="Text" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    Item_Code:
                          <asp:Label ID="Item_CodeLabel" runat="server" Text='<%# Bind("Item_Code") %>' />
                                    <br />
                                    Item_Status_Id:
                          <asp:Label ID="Item_Status_IdLabel" runat="server" Text='<%# Bind("Item_Status_Id") %>' />
                                    &nbsp;(<asp:Label ID="lbl_fv_ItemVStutas" runat="server" Text="Label"></asp:Label>)<br />
                                    <asp:SqlDataSource ID="sql_fv_ItemVStutas" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT [Status_Id], [Status] FROM [paft_Item_Status] WHERE ([Status_Id] = @Status_Id)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="Item_Status_IdLabel" PropertyName="Text" Name="Status_Id" Type="Int32"></asp:ControlParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                                    &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
                                    &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
                                </ItemTemplate>
                            </asp:FormView>
                            <asp:SqlDataSource runat="server" ID="sql_fv_Item" ConflictDetection="CompareAllValues" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' DeleteCommand="DELETE FROM [paft_Items] WHERE [Item_Id] = @original_Item_Id AND [Prod_Id] = @original_Prod_Id AND [Item_Code] = @original_Item_Code AND [Item_Status_Id] = @original_Item_Status_Id" InsertCommand="INSERT INTO [paft_Items] ([Prod_Id], [Item_Code], [Item_Status_Id]) VALUES (@Prod_Id, @Item_Code, @Item_Status_Id)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [paft_Items] WHERE ([Item_Id] = @Item_Id)" UpdateCommand="UPDATE [paft_Items] SET [Prod_Id] = @Prod_Id, [Item_Code] = @Item_Code, [Item_Status_Id] = @Item_Status_Id WHERE [Item_Id] = @original_Item_Id AND [Prod_Id] = @original_Prod_Id AND [Item_Code] = @original_Item_Code AND [Item_Status_Id] = @original_Item_Status_Id">
                                <DeleteParameters>
                                    <asp:Parameter Name="original_Item_Id" Type="Int32"></asp:Parameter>
                                    <asp:Parameter Name="original_Prod_Id" Type="Int32"></asp:Parameter>
                                    <asp:Parameter Name="original_Item_Code" Type="String"></asp:Parameter>
                                    <asp:Parameter Name="original_Item_Status_Id" Type="Int32"></asp:Parameter>
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="Prod_Id" Type="Int32"></asp:Parameter>
                                    <asp:Parameter Name="Item_Code" Type="String"></asp:Parameter>
                                    <asp:Parameter Name="Item_Status_Id" Type="Int32"></asp:Parameter>
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="gv_Inserts" PropertyName="SelectedValue" Name="Item_Id" Type="Int32"></asp:ControlParameter>
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="Prod_Id" Type="Int32"></asp:Parameter>
                                    <asp:Parameter Name="Item_Code" Type="String"></asp:Parameter>
                                    <asp:Parameter Name="Item_Status_Id" Type="Int32"></asp:Parameter>
                                    <asp:Parameter Name="original_Item_Id" Type="Int32"></asp:Parameter>
                                    <asp:Parameter Name="original_Prod_Id" Type="Int32"></asp:Parameter>
                                    <asp:Parameter Name="original_Item_Code" Type="String"></asp:Parameter>
                                    <asp:Parameter Name="original_Item_Status_Id" Type="Int32"></asp:Parameter>
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>

