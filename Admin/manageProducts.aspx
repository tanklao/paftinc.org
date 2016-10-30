<%@ Page Language="VB" AutoEventWireup="false" CodeFile="manageProducts.aspx.vb" Inherits="Admin_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Product Management</title>
    <style type="text/css">


h5, h6 {
    font-size: 1em;
}

    h1, h2, h3,
h4, h5, h6 {
    color: #000;
    margin-bottom: 0;
    padding-bottom: 0;
}

    input {
        width: 90%;
    }

    
    
    input, textarea {
        border: 1px solid #e2e2e2;
        background: #fff;
        color: #333;
        font-size: 1.2em;
        margin: 5px 0 6px 0;
        padding: 5px;
        }

    td input[type="submit"],
    td input[type="button"],
    td button {
        font-size: 1em;
        padding: 4px;
        margin-right: 4px;
    }

    input[type="submit"],
    input[type="button"],
    button {
        background-color: #d3dce0;
        border: 1px solid #787878;
        cursor: pointer;
        font-size: 1.2em;
        font-weight: 600;
        padding: 7px;
        margin-right: 8px;
        width: auto;
    }

        .auto-style1 {
            font-size: medium;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        Please select category: <asp:DropDownList ID="ddlCategory" runat="server" DataSourceID="sql_ddlCategory" DataTextField="Category_Name" DataValueField="Category_Id" AutoPostBack="True"></asp:DropDownList>. 
        Please select a status: <asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="True">
            <asp:ListItem Value="%">All</asp:ListItem>
            <asp:ListItem Value="1">Available</asp:ListItem>
            <asp:ListItem Value="2">Borrowing</asp:ListItem>
            <asp:ListItem Value="3">Borrowed</asp:ListItem>
            <asp:ListItem Value="4">Returning</asp:ListItem>
            <asp:ListItem Value="5">Retruned</asp:ListItem>
            <asp:ListItem Value="6">Testing</asp:ListItem>
        </asp:DropDownList>
        &nbsp;
        <asp:SqlDataSource ID="sql_ddlCategory" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [Category_Id], [Category_Name] FROM [paft_Category] ORDER BY [Category_Name]"></asp:SqlDataSource>
        <br/>And select a product: <br />
        <asp:GridView ID="gvProduct" runat="server" AutoGenerateColumns="False" DataKeyNames="Prod_Id" DataSourceID="sql_gvProduct" SelectedIndex="0" AllowSorting="True">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="Prod_Id" HeaderText="Prod_Id" SortExpression="Prod_Id" ReadOnly="True" />
                <asp:BoundField DataField="SKU" HeaderText="SKU" SortExpression="SKU" ReadOnly="True" />
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" ReadOnly="True" />
                <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" ReadOnly="True" />
                <asp:TemplateField HeaderText="ImageURL" SortExpression="ImageURL">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ImageURL") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                         <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("ImageURL", "~/{0}") %>'>
                            <asp:Image ID="Image1" runat="server" AlternateText='<%# Eval("ImageURL") %>' Height="54px" ImageUrl='<%# Bind("ImageURL", "~/{0}") %>' Width="85px" />
                        </asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Category_Name" HeaderText="Category_Name" SortExpression="Category_Name" Visible="False" ReadOnly="True" />
                <asp:BoundField DataField="Number" HeaderText="Qty" SortExpression="Number" ReadOnly="True" />
                <asp:BoundField DataField="Price" HeaderText="Price" ReadOnly="True" SortExpression="Price" DataFormatString="${0}" />
                <asp:BoundField DataField="Category_Id" HeaderText="Category_Id" ReadOnly="True" SortExpression="Category_Id" Visible="False" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sql_gvProduct" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT   p.Prod_Id, COUNT(i.Item_Id) AS Number, p.SKU, p.Name, p.Description, p.ImageURL, g.Category_Name, p.Price, 
                g.Category_Id
FROM      paft_Products AS p INNER JOIN
                paft_Category AS g ON p.Category_Id = g.Category_Id INNER JOIN
                paft_Items AS i ON p.Prod_Id = i.Prod_Id
WHERE   (p.Category_Id = @Category_Id and i.Item_Status_Id like @Status_Id)
GROUP BY p.Prod_Id, p.SKU, p.Name, p.Description, p.ImageURL, g.Category_Name, p.Price, g.Category_Id
UNION
SELECT   pr.Prod_Id, 0 AS Expr1, pr.SKU, pr.Name, pr.Description, pr.ImageURL, gr.Category_Name, pr.Price, 
                gr.Category_Id
FROM      paft_Products AS pr INNER JOIN
                paft_Category AS gr ON pr.Category_Id = gr.Category_Id
WHERE  (pr.Category_Id = @Category_Id) and (pr.Prod_Id NOT IN
                    (SELECT   Prod_Id
                     FROM      paft_Items AS it))">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlCategory" Name="Category_Id" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddlStatus" Name="Status_Id" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <asp:DetailsView ID="dvProduct" runat="server" Height="50px" Width="300px" AllowPaging="True" AutoGenerateRows="False" DataKeyNames="Prod_Id" DataSourceID="sql_dvProduct">
            <Fields>
                <asp:BoundField DataField="Prod_Id" HeaderText="Prod_Id" InsertVisible="False" ReadOnly="True" SortExpression="Prod_Id" />
                <asp:BoundField DataField="SKU" HeaderText="SKU" SortExpression="SKU" />
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                <asp:TemplateField HeaderText="ImageURL" SortExpression="ImageURL">
                    <EditItemTemplate>
                        <asp:TextBox ID="tbInsertImageURL" runat="server" Text='<%# Bind("ImageURL") %>' ReadOnly="True"></asp:TextBox>
                        <br />
                        <asp:FileUpload ID="fuInsertImage" runat="server" />
                        <asp:Button ID="btnInsertImage" runat="server" Text="Upload" OnClick="btnInsertImage_Click" />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="tbInsertImageURL" runat="server" Text='<%# Bind("ImageURL") %>' ReadOnly="True"></asp:TextBox>
                        <br />
                        <asp:FileUpload ID="fuInsertImage" runat="server" />
                        <asp:Button ID="btnInsertImage" runat="server" Text="Upload" OnClick="btnInsertImage_Click" />
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Image ID="Image2" runat="server" Height="108px" ImageUrl='<%# Bind("ImageURL","~/{0}") %>' Width="192px" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Category_Id" SortExpression="Category_Id">
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddldvCategory" runat="server" DataSourceID="sql_ddldvCategory" DataTextField="Category_Name" DataValueField="Category_Id" SelectedValue='<%# Bind("Category_Id") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sql_ddldvCategory" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [Category_Id], [Category_Name] FROM [paft_Category] ORDER BY [Category_Name]"></asp:SqlDataSource>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:DropDownList ID="ddldvCategory" runat="server" DataSourceID="sql_ddldvCategory" DataTextField="Category_Name" DataValueField="Category_Id" SelectedValue='<%# Bind("Category_Id") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sql_ddldvCategory" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [Category_Id], [Category_Name] FROM [paft_Category] ORDER BY [Category_Name]"></asp:SqlDataSource>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Category_Id") %>'></asp:Label>
                        &nbsp;(<asp:Label ID="dvlblCategory" runat="server" Text="Category"></asp:Label>)
                        <asp:SqlDataSource ID="sql_dvlblCategory" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [Category_Id], [Category_Name] FROM [paft_Category] WHERE ([Category_Id] = @Category_Id) ORDER BY [Category_Name]">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="Label1" Name="Category_Id" PropertyName="Text" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowInsertButton="True" />
            </Fields>
        </asp:DetailsView>
        <asp:SqlDataSource ID="sql_dvProduct" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" DeleteCommand="DELETE FROM [paft_Products] WHERE [Prod_Id] = @original_Prod_Id" InsertCommand="INSERT INTO [paft_Products] ([SKU], [Name], [Description], [ImageURL], [Category_Id], [Price]) VALUES (@SKU, @Name, @Description, @ImageURL, @Category_Id, @Price)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [paft_Products] WHERE ([Prod_Id] = @Prod_Id) ORDER BY [Name]" UpdateCommand="UPDATE [paft_Products] SET [SKU] = @SKU, [Name] = @Name, [Description] = @Description, [ImageURL] = @ImageURL, [Category_Id] = @Category_Id, [Price] = @Price WHERE [Prod_Id] = @original_Prod_Id AND [SKU] = @original_SKU AND [Name] = @original_Name AND [Description] = @original_Description AND [ImageURL] = @original_ImageURL AND [Category_Id] = @original_Category_Id AND [Price] = @original_Price">
            <DeleteParameters>
                <asp:Parameter Name="original_Prod_Id" Type="Int32" />
                <asp:Parameter Name="original_SKU" Type="String" />
                <asp:Parameter Name="original_Name" Type="String" />
                <asp:Parameter Name="original_Description" Type="String" />
                <asp:Parameter Name="original_ImageURL" Type="String" />
                <asp:Parameter Name="original_Category_Id" Type="Int32" />
                <asp:Parameter Name="original_Price" Type="Decimal" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="SKU" Type="String" />
                <asp:Parameter Name="Name" Type="String" />
                <asp:Parameter Name="Description" Type="String" />
                <asp:Parameter Name="ImageURL" Type="String" />
                <asp:Parameter Name="Category_Id" Type="Int32" />
                <asp:Parameter Name="Price" Type="Decimal" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="gvProduct" Name="Prod_Id" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="SKU" Type="String" />
                <asp:Parameter Name="Name" Type="String" />
                <asp:Parameter Name="Description" Type="String" />
                <asp:Parameter Name="ImageURL" Type="String" />
                <asp:Parameter Name="Category_Id" Type="Int32" />
                <asp:Parameter Name="Price" Type="Decimal" />
                <asp:Parameter Name="original_Prod_Id" Type="Int32" />
                <asp:Parameter Name="original_SKU" Type="String" />
                <asp:Parameter Name="original_Name" Type="String" />
                <asp:Parameter Name="original_Description" Type="String" />
                <asp:Parameter Name="original_ImageURL" Type="String" />
                <asp:Parameter Name="original_Category_Id" Type="Int32" />
                <asp:Parameter Name="original_Price" Type="Decimal" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
    <table id="config" style="width: 90%">
        <tr>
            <td>
                <h5>Add a batch of items of the same product</h5>
                <br />
                Please select a product on the table above!  
                <asp:DropDownList ID="ddl_BatProduct" runat="server" DataSourceID="sql_ddl_BatProduct" DataTextField="Name" DataValueField="Prod_Id" AutoPostBack="True" Visible="False"></asp:DropDownList>
                <asp:SqlDataSource runat="server" ID="sql_ddl_BatProduct" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT [SKU], [Name], [Prod_Id] FROM [paft_Products] WHERE ([Category_Id] = @Category_Id) ORDER BY [Name]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlCategory" Name="Category_Id" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                (You can change product category on the page top.)&nbsp;<asp:SqlDataSource ID="sql_DB4SKU" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [Prod_Id], [SKU] FROM [paft_Products] WHERE ([Prod_Id] = @Prod_Id)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="gvProduct" Name="Prod_Id" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource><br />
                How many items do you have?&nbsp; <asp:TextBox ID="tb_BatTotal" runat="server" Width="54px" BorderColor="#3333CC"></asp:TextBox>
                <br />
                What's is the first item number?
                <asp:TextBox ID="tb_BatItemFirstNo" runat="server" Width="40px" Text="101"></asp:TextBox><br />
                <center><asp:Button ID="btn_BatItem" runat="server" Text="Add Items" /></center>
                <asp:SqlDataSource ID="sql_AddItems" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"></asp:SqlDataSource>
                <asp:Label ID="Label2" runat="server" Text="Adding items failed. Duplicated Item Codes detected. Please check and add items again!" ForeColor="Red" Style="font-size: medium; font-weight: 700" Visible="False"></asp:Label>
                &nbsp; 
                <br />
                <asp:Label ID="lbl_CheckInsert" runat="server" Text="Check your inserted items, please!" Style="font-size: large; font-weight: 700" Visible="False"></asp:Label>
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
                                    <asp:ControlParameter ControlID="gvProduct" Name="Prod_Id" PropertyName="SelectedValue" Type="Int32" />
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
                          <asp:TextBox ID="Item_CodeTextBox0" runat="server" Text='<%# Bind("Item_Code") %>' />
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
                                    &nbsp; (<asp:Label ID="lbl_fv_ItemVProd" runat="server"></asp:Label>)<br />
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
                                    &nbsp;(<asp:Label ID="lbl_fv_ItemVStutas" runat="server"></asp:Label>)<br />
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
    <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl="~/Default.aspx">Go to Home Page</asp:LinkButton>
    </div>
    </form>
</body>
</html>
