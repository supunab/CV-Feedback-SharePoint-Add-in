'use strict';

var dataArray = [];
var batchArray = []; // Use custom hash function to map years to indeces; TODO -> use start year and map it to zero, then linear hashing

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

    clientContext.executeQueryAsync(function () {
        var enumerator = cvItems.getEnumerator();
        var current, batch, type, status;

        while (enumerator.moveNext()) {
            current = enumerator.get_current();
            batch = current.get_item("Batch");
            type = current.get_item("CV_x0020_Type");
            status = current.get_item("Status");

            switch (type + " " + status) {
                case "Internship Feedback Given":
                    dataArray[0][0]++;
                    break;

                case "Internship In Process":
                    dataArray[0][1]++;
                    break;

                case "Career Feedback Given":
                    dataArray[1][0]++;
                    break;

                case "Career In Process":
                    dataArray[1][1]++;
                    break;

                case "Masters Feedback Given":
                    dataArray[2][0]++;
                    break;

                case "Masters In Process":
                    dataArray[2][1]++;
                    break;

                default:
                    alert("There is a problem in the switch statement!! : " + type + " " + status);
                    break;
            }

            // TODO Update according to batch
        }

        updateTableView();
    }
    , onError);
});

function initDataArray() {
    // 2d array
    // 0 - Internship, 1-Career, 2-Masters
    // 2nd: 0 - Feedback Given; 1 = Not Given
    for (var i = 0 ; i < 3; i++) {
        dataArray.push([0, 0]);
    }
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
    var enumerator = cvItems.getEnumerator();
    var current, batch, type, status;

    while (enumerator.moveNext()) {
        current = enumerator.get_current();
        batch = current.get_item("Batch");
        type = current.get_item("CV_x0020_Type");
        status = current.get_item("Status");

        switch (type+" "+status) {
            case "Internship Feedback Given":
                dataArray[0][0]++;
                break;
            
            case "Internship In Progress":
                dataArray[0][1]++;
                break;

            case "Career Feedback Given":
                dataArray[1][0]++;
                break;

            case "Career In Progress":
                dataArray[1][1]++;
                break;

            case "Masters Feedback Given":
                dataArray[2][0]++;
                break;

            case "Masters In Progress":
                dataArray[2][1]++;
                break;

            default:
                alert("There is a problem in the switch statement!!");
                break;
        }

        // TODO Update according to batch
    }

    updateTableView();
}


function updateTableView() {
    $("#internship-nr").html(String(dataArray[0][0]));
    $("#internship-nl").html(String(dataArray[0][1]));
    $("#internship-t").html(String(dataArray[0][1] + dataArray[0][0]));
    $("#internship-p").html(String(
        (100 * dataArray[0][0] / (dataArray[0][1] + dataArray[0][0])).toFixed(2)
        ));

    $("#career-nr").html(String(dataArray[1][0]));
    $("#career-nl").html(String(dataArray[1][1]));
    $("#career-t").html(String(dataArray[1][1] + dataArray[1][0]));
    $("#career-p").html(String(
        (100 * dataArray[1][0] / (dataArray[1][1] + dataArray[1][0])).toFixed(2)
        ));

    $("#masters-nr").html(String(dataArray[1][0]));
    $("#masters-nl").html(String(dataArray[1][1]));
    $("#masters-t").html(String(dataArray[1][1] + dataArray[1][0]));
    $("#masters-p").html(String(
        (100 * dataArray[1][0] / (dataArray[1][1] + dataArray[1][0])).toFixed(2)
        ));
}