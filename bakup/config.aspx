<%@ Page Title="Database Configuation" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="config.aspx.vb" Inherits="Admin_config" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <link href="../css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet" />
    <script>
    $(function () {$("#dbAccordion").accordion();});
    </script>
    <h3>Select Following Tables To Configure</h3>
    <div id="dbAccordion">
	    <h6><a href="#">Products</a></h6>
	    <div>
		    #<br />
            #<br />
		    #<br />
            #<br />
		    #<br />
            #<br />
	    </div>
	    <h6><a href="#">Items</a></h6>
	    <div>
		    #<br />
            #<br />
		    #<br />
            #<br />
		    #<br />
            #<br />
	    </div>
	    <h6><a href="#">Transations</a></h6>
	    <div>
		    #<br />
            #<br />
		    #<br />
            #<br />
		    #<br />
            #<br />
	    </div>
</div>
</asp:Content>

