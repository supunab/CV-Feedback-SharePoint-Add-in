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
</asp:Content>

<%-- The markup in the following Content element will be placed in the TitleArea of the page --%>
<asp:Content ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server">
    Administator View
</asp:Content>

<asp:Content ContentPlaceHolderId="PlaceHolderMain" runat="server">
    <WebPartPages:WebPartZone runat="server" FrameType="TitleBarOnly" ID="full" Title="loc:full" />
    <div class="jumnotron text-center padding-bottom">
        <h1>Administator View</h1>
    </div>

    <div class="container">
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
                    <div class="col-md-3 col-md-offset-3"><h3>CV Count : </h3><h3 id="cvCount"></h3></div>
                    <div class="col-md-3"><h3>Completed Count : </h3><h3 id="feedbackCount"></h3></div>
                </div>
                <div class="row">
                    <div class="col-md-6 col-md-offset-3">
                        <div class="progress">
                            <div class="progress-bar progress-bar-success" style="width: 35%">
                                Feedback Given
                            </div>
                            <div class="progress-bar progress-bar-danger" style="width: 65%">
                                Not Reviewed
                            </div>
                        </div>
                    </div>
                </div>

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
                                        <td>Masters</td>
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
                <div style="text-align:right">
                    <input class="btn btn-info" type="button" value="Sort by Oldest Date" />

                </div>
              <table id="volunte" class="tablesorter table table-hover table-responsive" style="font-size:large;">
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Last Date</th>
                                        <th>Internship CVs Reviewed</th>
                                        <th>Career CVs Reviewed</th>
                                        <th>Masters CVs Reviewed</th>
                                        <th>Total</th>
                                    </tr>
                                </thead>
                                <tbody id="volunteer-table-body">
                                    <tr><td>Amarasinghe</td>
                                        <td>sdfdsf@uomcse.lk</td>
                                        <td>2015-01-02</td>
                                        <td>1</td>
                                        <td>1</td>
                                        <td>1</td>
                                        <td>3</td>
                                     </tr>
                                    <tr><td>Samanmali</td>
                                        <td>samanmali@uomcse.lk</td>
                                        <td>2016-01-02</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>1</td>
                                        <td>4</td>
                                     </tr>
                                    <tr><td>Abraham</td>
                                        <td>abraham@uomcse.lk</td>
                                        <td>_</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>0</td>
                                     </tr>
                                </tbody>
                            </table>


            </div>

            <div id="Batch" class="tab-pane">
               <br />
               <div class="row" style="font-size:large;">
                   &nbsp &nbsp Select Batch : &nbsp
                   <select style="width:100px">
                       <option value="13">2013</option>
                        <option value="14">2014</option>
                        <option value="15">2015</option>
                        <option value="16">2016</option>
                   </select>
               </div>
              <table id="batch" class="table table-hover table-responsive" style="font-size:large;">
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>CV Type</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                  </table>

            </div>
        </div>
    </div>
</asp:Content>
