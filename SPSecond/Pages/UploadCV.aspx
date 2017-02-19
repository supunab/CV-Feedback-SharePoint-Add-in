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
    <link rel="Stylesheet" type="text/css" href="../Content/uploadCV.css" />

    <!--JS-->
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!--Importing order is important since we are calling functinos of the above script from the lower one-->
    <script type="text/javascript" src="../Scripts/uploadCV.js"></script>
    <script type="text/javascript" src="../Scripts/uploadCVView.js"></script>

</asp:Content>

<asp:Content ContentPlaceHolderId="PlaceHolderMain" runat="server">
    
    <div class="jumnotron text-center padding-bottom">
        <h1>Upload Your CV</h1>
    </div>
    
    <div class="container">
        <div class="row">
            <div class="col-md-3 col-md-offset-3">
                <p>Last Upload Date</p>
            </div>
            <div class="col-md-3">
                <input id="lastUploadDate" class="form-control" type="text" value="Not Available" disabled/><br />
            </div>
        </div>

        <div class="row">
            <div class="col-md-3 col-md-offset-3">
                <p>Uploads Remaining&nbsp<a href="#" data-toggle="tooltip" title="This value shows the number of times you can re-submit and recieve feedbacks. But if you re-submit before getting a feedback, your previous CV will be replaced." aria-hidden="true"><span style="color:#337ab7;" class="glyphicon glyphicon-question-sign"></span></a></p>
            </div>
            <div class="col-md-3">
                <input id="uploadsRemaining" class="form-control" type="text" value="Not Available" disabled/><br />
            </div>
        </div>

        <div class="row">
            <div class="col-md-3 col-md-offset-3">
                <p>Upload your CV here</p>
            </div>
            <div class="col-md-3">
                <input class="form-control" id="getFile" type="file" accept=".pdf"/><br />
            </div>
            <div class="col-md-3">
                <div class="alert alert-danger" style="display:none;padding:1.5%;padding-left:2%;width:70%" id="fileTypeAlert">
                    <strong>Only PDFs are allowed!</strong>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-3 col-md-offset-3">
                <p>Enter your name</p>
            </div>
            <div class="col-md-3">
                <input class="form-control" id="studentName" type="text" value="" /><br />
            </div>
        </div>

        <div class="row">
            <div class="col-md-3 col-md-offset-3">
                <p>Select CV Type</p>
            </div>
            <div class="col-md-3">
                <select class="form-control select-bottom-margin" id="cvType">
                    <option value="career">Career</option>
                    <option value="internship">Internship</option>
                    <option value="masters">Masters</option>
                </select>
            </div>
        </div>

        <div class="row">
            <div class="col-md-3 col-md-offset-3">
                <p>Select Your Batch</p>
            </div>
            <div class="col-md-3">
                <select class="form-control select-bottom-margin" id ="batch">
                </select>
            </div>
        </div>


        <div class="row">
            <div class="col-md-5 col-md-offset-4">
                <p id="validationMsg" class="text-danger">Please fill all the fields.</p>
                <img src="../Images/loading.gif" alt="Uploading" id="loadingPic" style="display:block; margin-left:25%"/>
            </div>
        </div>

        <div class="row">
            <div class="col-md-2 col-md-offset-4">
                <button id="btnSubmit" type="button" class="btn btn-primary">Submit</button>
            </div>
            <div class="col-md-2">
                <a id="homeBtn" type="button" class="btn btn-danger">&nbsp&nbsp Back&nbsp&nbsp&nbsp</a>
            </div>
        </div>


    </div>


    <!-- Modals for showing alerts-->
    <div class="modal fade" id="alertModal" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="modalTitle">Modal Header</h4>
                </div>

                <div class="modal-body">
                    <p id="modalText"></p>
                </div>

                <div class="modal-footer">
                    <button id="modalBtn" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for showing maximum upload limit-->
    <div class="modal fade" id="uploadLimitModal" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Feedback Upload Limit Exceeded</h4>
                </div>

                <div class="modal-body">
                    <p>You have uploaded your CV and got feedback. You cannot upload further.</p>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" onclick="loadHome()">Home</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
