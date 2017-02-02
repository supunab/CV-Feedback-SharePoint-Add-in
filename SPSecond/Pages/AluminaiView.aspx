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

    <!-- Add your CSS styles to the following file -->
    <link rel="Stylesheet" type="text/css" href="../Content/AluminaiView.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />

    <!-- Add your JavaScript to the following file -->
    <script type="text/javascript" src="../Scripts/AluminaiView.js"></script>
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


</asp:Content>

<asp:Content ContentPlaceHolderId="PlaceHolderMain" runat="server">
    <div class="jumnotron text-center">
        <h1>Provide Feedback</h1>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <hr />
            </div>
        </div>

        <div class="row">
            <div class="col-md-3 col-md-offset-3">
                <h3>Feedback Count <span class="label label-default" id="feedbackCount">0</span></h3>
                <br />
            </div>
            <div class="col-md-4">
                <h3>Last Date <span class="label label-info" id="lastDate">No CVs Reviewed</span></h3>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <hr />
            </div>
        </div>
        <div class="row">
            <div class="col-md-1 col-md-offset-2">
                <h5>CV Type</h5>
            </div>
            <div class="col-md-3">
                <select id="cvAim" class="selectpicker btn-default form-control">
                    <option value="all" selected="selected">All</option>
                    <option value="internship">Internship</option>
                    <option value="career">Career</option>
                    <option value="master">Master</option>
                </select>
            </div>
            <div class="col-md-3">
                <select id="selectType" class="form-control">
                    <option value="random" selected="selected">Random</option>
                    <option value="resubmition">Re-Submision from Feedback given</option>
                </select>
            </div>
            <div class="col-md-2">
                <input type="button" class="btn btn-info btn-lg" value="Next Set" onclick="doFilter(true);" />
            </div>
        </div>
        
        <div class="row" id="emptyMessage">
            <div class="col-md-8 col-md-offset-2">
                <br />
                <h4 class="text-danger text-center">No CVs found to review</h4>
            </div>
        </div>
        <div id="divMain" class="row" style="margin-top: 30px">
            <div class="col-md-3" id="div1">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <div style="text-align: center;"><h4 id="divName1">Not Available</h4></div>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-12"><h5 id="divBatch1">Batch : _</h5></div>
                        </div>
                        <div class="row">
                            <div class="col-md-7"><h5 id="divAim1">Type : _</h5></div>
                            <div class="col-md-4">
                                <input id="preview1" type="button" class="btn btn-default" onclick="doPreview(this)" value="Feedback" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12" id="pdf1"></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-3" id="div2">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <div style="text-align: center;"><h4 id="divName2">Not Available</h4></div>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-12"><h5 id="divBatch2">Batch : _</h5></div>
                        </div>
                        <div class="row">
                            <div class="col-md-7"><h5 id="divAim2">Type : _</h5></div>
                            <div class="col-md-4">
                                <input id="preview2" type="button" class="btn btn-default" onclick="doPreview(this)" value="Feedback" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12" id="pdf2"></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-3" id="div3">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <div style="text-align: center;"><h4 id="divName3">Not Available</h4></div>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-12"><h5 id="divBatch3">Batch : _</h5></div>
                        </div>
                        <div class="row">
                            <div class="col-md-7"><h5 id="divAim3">Type : _</h5></div>
                            <div class="col-md-4">
                                <input id="preview3" type="button" class="btn btn-default" onclick="doPreview(this)" value="Feedback" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12" id="pdf3"></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-3" id="div4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <div style="text-align: center;"><h4 id="divName4">Not Available</h4></div>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-12"><h5 id="divBatch4">Batch : _</h5></div>
                        </div>
                        <div class="row">
                            <div class="col-md-7"><h5 id="divAim4">Type : _</h5></div>
                            <div class="col-md-4">
                                <input id="preview4" type="button" class="btn btn-default" onclick="doPreview(this)" value="Feedback" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12" id="pdf4"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" id="modalCont" style="overflow: hidden">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;Close</button>
                    <h3 class="modal-title" id="myModalLabel">Feedback Form</h3>
                </div>
                <div class="modal-body" id="modalBody">
                    <div class="containter">
                        <div class="row">
                            <div id="pdfModal" class="col-md-8"></div>
                            <div id="feedBackForm" class="col-md-4">
                                <div class="row">
                                    <h4 id="infoDivName">&nbsp</h4>
                                </div>
                                <div class="row">
                                    <p id="infoDivBatch"></p>
                                </div>
                                <div class="row">
                                    <p id="infoDivAim"></p>
                                </div>
                                <div class="row">
                                    <div id="number" style="display:none"></div>
                                </div>
                                <div class="row">
                                    <h4><b>Enter Feedback : </b></h4>
                                </div>
                                
                                <div class="row">
                                    <textarea id="feedbackTxt" rows="18" style="width:95%; height:100%;"></textarea>
                                </div>

                                <hr />
                                <div class="row">
                                    <div class="col-md-3 col-md-offset-7">
                                        <input type="button" runat="server" value="Save Feedback" onclick="return validateFeedback()" class="btn btn-info" />
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- Modal pop up -->
    <div id="popupModal" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title" id="popupTitle">Modal Header</h4>
        </div>
        <div class="modal-body">
            <p id="popupBody">Some text in the modal.</p>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
    </div>

    <!-- Modal to show while proccessing -->
    <div id="loadingModal" class="modal fade" role="dialog">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="loadingTitle">Feedback Submiting..</h4>
        </div>
        <div class="modal-body">
            <img style="text-align:center" src="../images/loading.gif" alt="Loading.. Please wait whicle the operation completes." />
        </div>
    </div>
  </div>
</div>
</asp:Content>
