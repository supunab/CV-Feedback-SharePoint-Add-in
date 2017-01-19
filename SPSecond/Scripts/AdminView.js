'use strict';

var dataArray = [];

$(document).ready(function () {
    initDataArray();
    // load the table with values
    // Overview table
    var appWebUrl = decodeURIComponent(getQueryStringParameter("SPAppWebUrl"));
    var hostWebUrl = decodeURIComponent(getQueryStringParameter("SPHostUrl"));

    var clientContext = SP.ClientContext.get_current();
    var hostContext = new SP.AppContextSite(clientContext, hostWebUrl);
    
    var cvList = hostContext.get_web().get_lists().getByTitle("CV List");
    var camlQuerry = new SP.CamlQuery();
    var cvItems = cvList.getItems(camlQuerry);

    clientContext.load(
        cvItems,
        'Include(Batch, CV_x0020_Type,Status)'
        );

    clientContext.executeQueryAsync(Function.createDelegate(this, this.calculateValues), Function.createDelegate(this, this.onError));
});

function initDataArray() {
    // 2d array
    // 0 - Internship, 1-Career, 2-Masters
    // 2nd: 0 - Feedback Given; 1 = Not Given

}

// Get parameters from the query string.
function getQueryStringParameter(paramToRetrieve) {
    var params = document.URL.split("?")[1].split("&");
    for (var i = 0; i < params.length; i = i + 1) {
        var singleParam = params[i].split("=");
        if (singleParam[0] == paramToRetrieve) return singleParam[1];
    }
}

function onError() {
    alert("Operation Failed!");
}

function calculateValues() {

}