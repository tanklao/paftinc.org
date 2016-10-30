<%@ Page Title="Contact" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Contact.aspx.vb" Inherits="Contact" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <hgroup class="title">
        <h1><%: Title %></h1>
    </hgroup>

    <section class="contact">
        <header>
            <h3>Phone: (815)761-3815</h3>
        </header>
    </section>

    <section class="contact">
        <header>
            <h3>Email:</h3>
        </header>
        <p>
            <span class="label">General Infomation:</span>
            <span><a href="mailto:info@perpetualamity.org">info@perpetualamity.org</a></span>
        </p>
        <p>
            <span class="label">Technical Support</span>
            <span><a href="#">tliu (a-t) niu (dot) edu</a></span>
        </p>
    </section>

    <section class="contact">
        <header>
            <h3>Orgination Address:</h3>
        </header>
        <p>
            200 Southpointe Drive <br />
            DeKalb, IL 60115
        </p>
        <header>
            <h3>Mail Address:</h3>
        </header>
        <p>
            729 West State St <br />
            Sycarmore, IL 60178
        </p>
    </section>
</asp:Content>