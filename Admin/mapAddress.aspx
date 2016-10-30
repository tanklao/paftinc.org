<%@ Page Title="Map" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="mapAddress.aspx.vb" Inherits="Admin_mapAddress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <style>
        #map {
            width: 920px;
            height: 500px;
        }
    </style>
    <script src="http://maps.google.com/maps/api/js?sensor=false"></script>
    <%--    <script src="../Scripts/js/jquery-1.9.1.js"></script>--%>
    <script src="../Scripts/jquery.gomap-1.3.2.min.js"></script>
    Track our furniture by Google map :
    <asp:DropDownList ID="ddl_MapCenter" runat="server" DataSourceID="sql_ddl_MapCenter" DataTextField="Name" DataValueField="Address"></asp:DropDownList>
    <asp:SqlDataSource runat="server" ID="sql_ddl_MapCenter" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT Name, Address1 + ' ' + isnull(Address2,'') + ', ' + City + ',  ' + State + ' ' + Zipcode AS Address FROM paft_Address Order by Name"></asp:SqlDataSource>
    &nbsp;<span id="selecetedAddress"></span>
    <div id="map"></div>
    <div><span id="demo"></span>
        <input type="button" value="Show My Current Location" id="showme" /></div>
    <div style="display: none">
        <asp:Label ID="lblMarkers" runat="server" Text="" Visible="True"></asp:Label>
    </div>
    <asp:SqlDataSource ID="sql_Markers" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT Name, Address1 + ', ' + City + ', ' + State + ' ' + Zipcode AS Address FROM paft_Address ORDER BY Address_Id DESC"></asp:SqlDataSource>
    <br />
    <script>
        $(function () {
            $("#selecetedAddress").text($("#MainContent_ddl_MapCenter").val());
            var markerstr = $("#MainContent_lblMarkers").text();
            var markers = new Array();
            markers = markerstr.split(",`,");
            var address_i = markers[0];
            var name_i = markers[1];
            $("#map").goMap({
                address: address_i,
                zoom: 17
            });
            //add makers by address
            for (i = 0; i < markers.length; i += 2) {
                address_i = markers[i];
                name_i = markers[i + 1];
                $.goMap.createMarker({
                    address: address_i,
                    html: {
                        content: name_i,
                        popup: true}
                });
            }
            $.goMap.setMap({address: markers[0]});
            //center the map
            $("#MainContent_ddl_MapCenter").change(function () {
                $("#selecetedAddress").text($("#MainContent_ddl_MapCenter").val());
                $.goMap.setMap({ address: $("#MainContent_ddl_MapCenter").val() });
                //$.goMap.createMarker({ address: $("#MainContent_ddl_MapCenter").val() });
            });
            $("#showme").click(showMyPos);
        });

        function showMyPos() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(success, error);
            } else {
                $("#demo").text("Your browser does not allow geolocating.");
            }
        }
        function success(pos) {
            $("#demo").text("Latitude: " + pos.coords.latitude + " Longitude: " + pos.coords.longitude);
            $.goMap.setMap({
                latitude: pos.coords.latitude,
                longitude: pos.coords.longitude,
                zoom: 19
            });
            $.goMap.createMarker({
                latitude: pos.coords.latitude,
                longitude: pos.coords.longitude,
                draggable: true,
                icon: '../Images/apartment.png',
                html: {
                    content: 'I am HERE',
                    popup: true
                }
            });
        }
        function error(err) {
            alert('ERROR(' + err.code + '): ' + err.message);
        };
    </script>
    <style>
        #fgid_612394abfff25aacda4d091ff {
            display: block;
        }
    </style>
</asp:Content>

