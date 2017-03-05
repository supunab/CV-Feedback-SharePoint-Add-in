<%@ Page language="C#" MasterPageFile="~masterurl/default.master" Inherits="Microsoft.SharePoint.WebPartPages.WebPartPage, Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<asp:Content ContentPlaceHolderId="PlaceHolderAdditionalPageHead" runat="server">
    <SharePoint:ScriptLink name="sp.js" runat="server" OnDemand="true" LoadAfterUI="true" Localizable="false" />
    <script type="text/javascript" src="../Scripts/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="/_layouts/15/sp.runtime.js"></script>
    <script type="text/javascript" src="/_layouts/15/sp.js"></script>

    <meta name="WebPartPageExpansion" content="full" />

    <link rel="Stylesheet" type="text/css" href="../Content/AdminView.css" />

    <script type="text/javascript" src="../Scripts/AdminView.js"></script>

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

    <%-- For Datatables --%>
    <script src="https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.13/js/dataTables.bootstrap.min.js"></script>
    <link href="https://cdn.datatables.net/1.10.13/css/dataTables.bootstrap.min.css" rel="stylesheet" />

    <script type="text/javascript" src="../Scripts/progressbar.js"></script>
</asp:Content>

<%-- The markup in the following Content element will be placed in the TitleArea of the page --%>
<asp:Content ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server">
    Administator View
</asp:Content>

<asp:Content ContentPlaceHolderId="PlaceHolderMain" runat="server">
    <WebPartPages:WebPartZone runat="server" FrameType="TitleBarOnly" ID="full" Title="loc:full" />
    <div class="jumnotron text-center padding-bottom">
        <h1>Admin Panel</h1>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-md-3">
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#settingsModal"><span class="glyphicon glyphicon-wrench"></span>&nbspSettings</button>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-md-12">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#Overview" data-toggle="tab">Overview</a></li>
                    <li><a href="#Volunteer" data-toggle="tab">Volunteer Detail</a></li>
                    <li><a href="#Batch" data-toggle="tab">Batch wise</a></li>
                </ul>
            </div>
        </div>
    
        <div class="tab-content">
            <div id="Overview" class="tab-pane active">
                <div class="row">
                    <hr />
                    <div class="col-md-2">
                        <div id="progress" style="margin-top:3%;margin-bottom:1.5%;"></div>
                    </div>
                    <div class="col-md-3">
                        <h4 style="margin-top:20%;">CV Count : &nbsp<span id="cvCount"></span></h4>
                        <h4>Completed Count : &nbsp<span id="feedbackCount"></span></h4>
                    </div>
                </div>
                <hr />
                <div class="row">
                    <div class="col-md-12">
                            <table class="table table-hover table-responsive">
                                <thead>
                                    <tr>
                                        <th>CV Type</th>
                                        <th>Number Reviewed</th>
                                        <th>Number Left</th>
                                        <th>Total</th>
                                        <th>% Complete</th>
                                    </tr>
                                </thead>
                                <tbody id="cv-table-body">
                                    <tr>
                                        <td>Internship</td>
                                        <td id="internship-nr"></td>
                                        <td id="internship-nl"></td>
                                        <td id="internship-t"></td>
                                        <td id="internship-p"></td>
                                    </tr>
                                    <tr>
                                        <td>Career</td>
                                        <td id="career-nr"></td>
                                        <td id="career-nl"></td>
                                        <td id="career-t"></td>
                                        <td id="career-p"></td>
                                    </tr>
                                    <tr>
                                        <td>CS 3953</td>
                                        <td id="masters-nr"></td>
                                        <td id="masters-nl"></td>
                                        <td id="masters-t"></td>
                                        <td id="masters-p"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
            </div>

            <div id="Volunteer" class="tab-pane">
                <br />
                <div class="row">
                    <div class="col-md-12">
                        <table id="volunteerTable" class="table table-responsive" style="width:100%">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Last Date</th>
                                    <th>CVs Reviewed</th>
                                </tr>
                            </thead>
                            <tbody id="volunteer-table-body">
                            </tbody>
                        </table>
                    </div>
                </div>
              


            </div>

            <div id="Batch" class="tab-pane">
               <br />
                <div class="row form-group form-inline">
                    <div class="col-md-3">
                        <label class="col-form-label" for="batchSelect">Select Batch&nbsp&nbsp</label>
                        <select id="batchSelect" class="form-control"></select>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <hr />
                    </div>
                </div>
              <table id="batchTable" class="table table-responsive">
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>CV Type</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                  </table>

            </div>
        </div>
    </div>

    <!-- Modal for settings changes-->
    <div class="modal fade" id="settingsModal" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Change Settings</h4>
                </div>

                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-4">
                            <h5>Student CV upload limit</h5>
                        </div>
                        <div class="col-md-1">
                            <input type="number" id="uploadLimit" name="name" value="3" />
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="settingsConfirm">Confirm</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for Successful settings change-->
    <div class="modal fade" id="successModal" role="dialog">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Settings Update Success</h4>
                </div>

                <div class="modal-body">
                    <p>Settings you have entered have been successfully updated.</p>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
