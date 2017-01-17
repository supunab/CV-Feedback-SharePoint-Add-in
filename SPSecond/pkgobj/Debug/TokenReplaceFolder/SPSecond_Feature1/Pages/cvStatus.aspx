<%@ Page language="C#" MasterPageFile="~masterurl/default.master" Inherits="Microsoft.SharePoint.WebPartPages.WebPartPage, Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<asp:Content ContentPlaceHolderId="PlaceHolderAdditionalPageHead" runat="server">
    <SharePoint:ScriptLink name="sp.js" runat="server" OnDemand="true" LoadAfterUI="true" Localizable="false" />
    <script type="text/javascript" src="../Scripts/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="/_layouts/15/sp.runtime.js"></script>
    <script type="text/javascript" src="/_layouts/15/sp.js"></script>

    <!--CSS-->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="Stylesheet" type="text/css" href="../Content/cvStatus.css" />

    <!--JS-->
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="../Scripts/cvStatus.js"></script>
</asp:Content>

<asp:Content ContentPlaceHolderId="PlaceHolderMain" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-4"></div>
            <div class="col-md-2"><h3>CV Status</h3></div>
            <div class="col-md-2">
                <img src="../Images/loading.gif" id="loadingPic"/>
                <h3 id="notUploaded"><span class="label label-danger">Not Uploaded</span></h3>
                <h3 id="notReviewed"><span class="label label-default">Not Reviewed</span></h3>
                <h3 id="reviewed"><span class="label label-success">Feedback Given</span></h3>
            </div>
            <div class="col-md-4"></div>
        </div>

        <div class="row" id="feedbackpanel">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <div class="panel panel-default">
                  <div class="panel-heading">
                    <h3 class="panel-title">Received Feedback</h3>
                  </div>
                  <div class="panel-body">
                    <p id="feedbackbody">This will show the feedback.</p>
                  </div>
                </div>
            </div>
            <div class="col-md-3"></div>
        </div>

        <div></div>
    </div>
</asp:Content>
