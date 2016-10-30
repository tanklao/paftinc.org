<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="oboutTest.aspx.vb" Inherits="testing_oboutTest" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:Button ID="Button1" runat="server" Text="Button" />
    <ajax:ConfirmButtonExtender ID="Button1_ConfirmButtonExtender" runat="server" ConfirmText="Really?" Enabled="True" TargetControlID="Button1">
</ajax:ConfirmButtonExtender>
    <br />
    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    <ajax:CalendarExtender ID="TextBox1_CalendarExtender" runat="server" DefaultView="Months" Enabled="True" TargetControlID="TextBox1">
    </ajax:CalendarExtender>
    <br />
    <br />
    <br />
<br />
</asp:Content>

