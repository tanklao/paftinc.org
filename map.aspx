<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="map.aspx.vb" Inherits="map" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <script src="http://maps.google.com/maps/api/js?sensor=false"></script>
    <script src="Scripts/js/jquery-1.9.1.js"></script>
    <script src="Scripts/jquery.gomap-1.3.2.min.js"></script>
    <style>
        #map {
            width:800px;
            height:640px;
        }
    </style>
    <div id="map"></div>
    <script>
        $(function () {
            $("#map").goMap();
        })
    </script>
</asp:Content>

