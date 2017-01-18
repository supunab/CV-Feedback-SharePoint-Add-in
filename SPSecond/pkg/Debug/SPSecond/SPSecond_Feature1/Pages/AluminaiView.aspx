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
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

    <!-- Add your JavaScript to the following file -->
    <script type="text/javascript" src="../Scripts/AluminaiView.js"></script>
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <%--<script type="text/javascript">
        function doPreview(ele) {
            var id = ele.id;
            var idNum = parseInt(id.substring(id.length - 1));
           
            if (pdf[idNum - 1] !== '') {
                var t = $('#myModal').height() * 0.88;
                console.log(t);
                $('#modalBody').height(t);
                $('#infoDivName').text($('#divName' + idNum).text());
                $('#infoDivBatch').text('Batch : ' + $('#divBatch' + idNum).text());
                $('#infoDivAim').text('Aim : ' + $('#divName' + idNum).text());
                $('#number').text(''+idNum);
                $('#feedbackTxt').val('');

                $('#pdfModal').html('<div style="background: transparent url(load.gif) no-repeat;width: 100%; height: '+t+';background-position:center;"><object type="application/pdf" width="100%" height="400px"  data="' + pdf[idNum - 1] + '?#scrollbar=0&navpanes=0" style="overflow:hidden; width: 100%; height:' + t + 'px;"></object>');
                
                $('#feedbackTxt').focus();
                $('#myModal').modal('show');
            } else {
                $('#myModal').modal('hide');
            }
        }
        function validateFeedback() {
            var feedback = $('#feedbackTxt').val().trim();
            var num = $('#number').text().trim();
            console.log('Text area :' + feedback+"  "+num)
            if (~isNaN(feedback) && feedback !== '') {
                saveFeedBack(num,feedback);
            } else {
                alert("You must enter valid feedback to save !!");
            }

        }
    </script>--%>
</asp:Content>

<asp:Content ContentPlaceHolderId="PlaceHolderMain" runat="server">
    <div>
        <div style="width: 30%; float: left;"><span style="font-size: 25pt"><strong>Give CV Feedback</strong></span></></div>

        <div style="text-align: left; width: 50%; margin-top: 2px;">
            <span style="font-size: 13pt">&nbsp &nbsp CV Aim &nbsp &nbsp</span>
            <select id="cvAim" style="width: 200px; font-size: 13pt; margin-top: 5px" class="selectpicker btn-default">
                <option value="all" selected="selected">All</option>
                <option value="internship">Internship</option>
                <option value="career">Career</option>
                <option value="master">Master</option>
            </select>
            <select id="selectType" style="200px; margin-top: 5px; overflow: hidden; font-size: 13pt">
                <option value="random" selected="selected">Random</option>
                <option value="resubmition">Re-Submision from Feedback given</option>
            </select>
            <input type="button" class="btn btn-info btn-lg" value="Next Set" style="margin-left: 20px; margin-top: 5px; width: 75px;" onclick="doFilter(true);" />
        </div>
    </div>

    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" id="modalCont" style="overflow: hidden">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;Close</button>
                    <h3 class="modal-title" id="myModalLabel">Feedback Form</h3>
                </div>
                <div class="modal-body row" id="modalBody">
                    <div id="pdfModal" class="col-md-8">
                    </div>
                    <div id="feedBackForm" class="col-md-4">
                        <div id="infoDiv">
                            <div id="infoDivName" style="font-size: 15pt; font-weight: 500;">&nbsp</div>
                            <div id="infoDivBatch"></div>
                            <div id="infoDivAim"></div>
                            <div id="number" style="display:none"></div>
                        </div>
                        <br />
                        <span style="font-weight: 300;">Enter Feedback : </span>
                        <div id="feedbackDiv" style="height: 60%;">
                            <textarea id="feedbackTxt" rows="15" style="height: 100%; width: 100%">

                                </textarea>
                        </div>
                        <div style="text-align: right; padding-top: 10px;">
                            <input type="button" runat="server" value="Save Feedback" onclick="return validateFeedback()" class="btn btn-info" />
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <div id="divMain" class="row" style="margin-top: 30px">
        <div style="border: 2px solid black; height: 464px; overflow: hidden; width: 24%; float: left;">

            <div id="divDetail1" style="text-align: left; float: left; height: 450px; width: 100%">

                <div id="divName1" style="font-size: 17pt; text-align: center; width: 100%; height: 7%; background-color: cornflowerblue; color: white;">Not Available</div>
                <div class="col-md-12" id="divBatch1" style="font-size: 13pt; height: 5%">Batch : _</div>
                <div class="col-md-8" id="divAim1" style="font-size: 13pt; height: 5%;">Aim : _</div>
                <div class="col-md-4" style="text-align: right; padding: 0px; height: 5%; padding-right: 10px;">
                    <input id="preview1" type="button" class="btn btn-default" onclick="doPreview(this)" value="Feedback" />
                </div>
                <div id="pdf1"></div>
            </div>
        </div>
        <div style="width: 1.3%; float: left;">&nbsp</div>
        <div style="border: 2px solid black; height: 464px; overflow: hidden; width: 24%; float: left;">

            <div id="divDetail2" style="text-align: left; float: left; height: 450px; width: 100%;">

                <div id="divName2" style="font-size: 17pt; text-align: center; width: 100%; height: 7%; background-color: cornflowerblue; color: white;">Not Available</div>
                <div class="col-md-12" id="divBatch2" style="font-size: 13pt; height: 5%">Batch : _</div>
                <div class="col-md-8" id="divAim2" style="font-size: 13pt; height: 5%;">Aim : _</div>
                <div class="col-md-4" style="text-align: right; padding: 0px; height: 5%; padding-right: 10px;">
                    <input id="preview2" type="button" class="btn btn-default" onclick="doPreview(this)" value="Feedback" />
                </div>
                <div id="pdf2"></div>
            </div>
        </div>
        <div style="width: 1.3%; float: left;">&nbsp</div>
        <div style="border: 2px solid black; height: 464px; overflow: hidden; width: 24%; float: left;">

            <div id="divDetail3" style="text-align: left; float: left; height: 450px; width: 100%;">

                <div id="divName3" style="font-size: 17pt; text-align: center; width: 100%; height: 7%; background-color: cornflowerblue; color: white;">Not Available</div>
                <div class="col-md-12" id="divBatch3" style="font-size: 13pt; height: 5%">Batch : _</div>
                <div class="col-md-8" id="divAim3" style="font-size: 13pt; height: 5%;">Aim : _</div>
                <div class="col-md-4" style="text-align: right; padding: 0px; height: 5%; padding-right: 10px;">
                    <input id="preview3" type="button" class="btn btn-default" onclick="doPreview(this)" value="Feedback" />
                </div>
                <div id="pdf3"></div>
            </div>

        </div>
        <div style="width: 1.3%; float: left;">&nbsp</div>
        <div style="border: 2px solid black; height: 464px; overflow: hidden; width: 24%; float: left;">

            <div id="divDetail4" style="text-align: left; float: left; height: 450px; width: 100%;">

                <div id="divName4" style="font-size: 17pt; text-align: center; width: 100%; height: 7%; background-color: cornflowerblue; color: white;">Not Available</div>
                <div class="col-md-12" id="divBatch4" style="font-size: 13pt; height: 5%">Batch : _</div>
                <div class="col-md-8" id="divAim4" style="font-size: 13pt; height: 5%;">Aim : _</div>
                <div class="col-md-4" style="text-align: right; padding: 0px; height: 5%; padding-right: 10px;">
                    <input id="preview4" type="button" class="btn btn-default" onclick="doPreview(this)" value="Feedback" />
                </div>
                <div id="pdf4"></div>
            </div>
        </div>
    </div>


</asp:Content>
