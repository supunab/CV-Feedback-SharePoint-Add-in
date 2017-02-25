// Sharepoint JSOM
var clientContext = SP.ClientContext.get_current();
var web = clientContext.get_web();
var user;

// Current userinfo
var userEmail;
var userGroups;

// For SharePoint REST calls
var appWebUrl;
var hostWebUrl;

// Wait till user details are loaded before uploading. (Due to async execution)
var userLoaded = false;

// User's update count and current feedback status
var count = 0;
var feedbackStatus = "";

// Maximum limit of uploads. Default is 3.
var feedbackLimit = 3;

$(document).ready(function () {
    // Check for FileReader API for Reading files
    if (!window.FileReader) {
        //alert('This browser does not support the FileReader API.');
        $("#modalTitle").html("Browser Not Supported");
        $("#modalText").html('This browser does not support the FileReader API.');
        $("#alertModal").modal();
    }

    // Tooltip
    $('[data-toggle="tooltip"]').tooltip();

    // Get the add-in web and host web URLs.
    appWebUrl = decodeURIComponent(getQueryStringParameter("SPAppWebUrl"));
    hostWebUrl = decodeURIComponent(getQueryStringParameter("SPHostUrl"));

    // Load user details
    user = clientContext.get_web().get_currentUser();
    clientContext.load(user);

    clientContext.executeQueryAsync(function () {
        userEmail = user.get_email();
        userGroups = user.get_groups();
        // User details loading completed
        userLoaded = true;
        updateLastDate();
    });
});

function loadHome() {
    window.location.replace(decodeURIComponent(getQueryStringParameter("SPAppWebUrl")));
}

// Get parameters from the query string.
function getQueryStringParameter(paramToRetrieve) {
    var params = document.URL.split("?")[1].split("&");
    for (var i = 0; i < params.length; i = i + 1) {
        var singleParam = params[i].split("=");
        if (singleParam[0] == paramToRetrieve) return singleParam[1];
    }
}

// Update last upload date on the view
function updateLastDate() {
    var hostClientContext = new SP.AppContextSite(clientContext, hostWebUrl);
    cvList = hostClientContext.get_web().get_lists().getByTitle("CV List");

    var camlQuery = new SP.CamlQuery();
    camlQuery.set_viewXml("<View><Query><Where><Eq><FieldRef Name='Email' /><Value Type='Text'>" + userEmail + "</Value></Eq></Where></Query></View>");
    cvItems = cvList.getItems(camlQuery);

    clientContext.load(cvItems);
    clientContext.executeQueryAsync(function () {
        var enumerator = cvItems.getEnumerator();

        // Can only exist one record per email
        if (enumerator.moveNext()) {
            var date = enumerator.get_current().get_item("Created");
            count = parseInt(enumerator.get_current().get_item("Count"));
            feedbackStatus = enumerator.get_current().get_item("Status");

            date = new Date(date);
            date = date.toISOString();
            $("#lastUploadDate").val(date.slice(0, 10) + " " + date.slice(11, 19));
        }

        // Get max upload count
        var appConstants = clientContext.get_web().get_lists().getByTitle("AppConstants");
        var conItems = appConstants.getItems(new SP.CamlQuery());
        clientContext.load(conItems);

        clientContext.executeQueryAsync(function () {
            var enumerator = conItems.getEnumerator();

            while (enumerator.moveNext()) {
                if (enumerator.get_current().get_item("Title") === "UploadLimit") {
                    feedbackLimit = parseInt(enumerator.get_current().get_item("Count"));
                    break;
                }
            }

            limitPassed();
        },
        onFailed);
    }
    , onFailed);
};

function limitPassed() {
    // Check upload count
    if (feedbackStatus === "Feedback Given") {
        $("#uploadsRemaining").val(feedbackLimit - count);
        if (count >= feedbackLimit) {
            $("#uploadLimitModal").modal({
                backdrop: 'static',
                keyboard: false
            });
        }
    } else {
        $("#uploadsRemaining").val(Math.min(feedbackLimit,feedbackLimit - count + 1));
    }
}


function uploadFile() {
    // Check and remove currently uploaded files. (File will get uploaded inside the below fun)

    // Check whether upload limit exceeded
    if (feedbackStatus === "Feedback Given") {
        if (count >= feedbackLimit) {
            $("#uploadLimitModal").modal({
                backdrop: 'static',
                keyboard: false
            });
            // exit without uploading the file
            return;
        }
    }

    checkAndDeleteFile();
}

// Display error messages.
function onError(error) {
    //alert(error.responseText);
    $("#modalTitle").html("Error");
    $("#modalText").html("An error occured during the process. This might be because of an internet connection problem. Please perform the task again. <br />" + error.responseText);
    $("#alertModal").modal();
}

function onFailed(sender, args) {
    //alert(args.get_message());
    $("#modalTitle").html("Error");
    $("#modalText").html("An Error Occured. This might be due to a error in your internet connection.");
    $("#alertModal").modal();
}


function checkAndDeleteFile() {
    var hostClientContext = new SP.AppContextSite(clientContext, hostWebUrl);
    cvList = hostClientContext.get_web().get_lists().getByTitle("CV List");

    while (!userLoaded) {
        // Wait till user details are loaded
    };

    var camlQuery = new SP.CamlQuery();
    camlQuery.set_viewXml("<View><Query><Where><Eq><FieldRef Name='Email' /><Value Type='Text'>" + userEmail + "</Value></Eq></Where></Query></View>");
    cvItems = cvList.getItems(camlQuery);

    clientContext.load(cvItems);
    clientContext.executeQueryAsync(Function.createDelegate(this, checkAndDeleteSuccess), onFailed);
}

function checkAndDeleteSuccess() {
    var enumerator = cvItems.getEnumerator();

    while (enumerator.moveNext()) {
        if (enumerator.get_current().get_item("Email") == userEmail) {
            enumerator.get_current().deleteObject();
            clientContext.executeQueryAsync(uploadFileSuccess, onFailed);
            return
        }

    }

    // File not currently uploaded
    uploadFileSuccess();

}

function uploadFileSuccess() {
    // Define the folder path
    var serverRelativeUrlToFolder = 'CV List';

    // Get test values from the file input and text input page controls.
    // The display name must be unique every time you run the example.
    var fileInput = $('#getFile');
    var newName = userEmail.split(".")[0] + userEmail.split(".")[1].split("@")[0];

    // Initiate method calls using jQuery promises.
    // Get the local file as an array buffer.
    var getFile = getFileBuffer();
    getFile.done(function (arrayBuffer) {

        // Add the file to the SharePoint folder.
        var addFile = addFileToFolder(arrayBuffer);
        addFile.done(function (file, status, xhr) {

            // Get the list item that corresponds to the uploaded file.
            var getItem = getListItem(file.d.ListItemAllFields.__deferred.uri);
            getItem.done(function (listItem, status, xhr) {

                // Change the display name and title of the list item.
                var changeItem = updateListItem(listItem.d.__metadata);
                changeItem.done(function (data, status, xhr) {
                    //alert('file uploaded and updated');
                    $("#loadingPic").hide();
                    $("#modalTitle").html("CV Uploaded Successfully");
                    $("#modalText").html('Your CV has been submitted successfully and you will get feedback soon from a email.');
                    $("#alertModal").modal();
                });
                changeItem.fail(onError);
            });
            getItem.fail(onError);
        });
        addFile.fail(onError);
    });
    getFile.fail(onError);

    // Get the local file as an array buffer.
    function getFileBuffer() {
        var deferred = $.Deferred();
        var reader = new FileReader();
        reader.onloadend = function (e) {
            deferred.resolve(e.target.result);
        }
        reader.onerror = function (e) {
            deferred.reject(e.target.error);
        }
        reader.readAsArrayBuffer(fileInput[0].files[0]);
        return deferred.promise();
    }

    // Add the file to the file collection in the Shared Documents folder.
    function addFileToFolder(arrayBuffer) {

        // Get the file name from the file input control on the page.
        var parts = fileInput[0].value.split('\\');
        var fileName = parts[parts.length - 1];

        // Construct the endpoint.
        var fileCollectionEndpoint = String.format(
            "{0}/_api/sp.appcontextsite(@target)/web/getfolderbyserverrelativeurl('{1}')/files" +
            "/add(overwrite=true, url='{2}')?@target='{3}'",
            appWebUrl, serverRelativeUrlToFolder, fileName, hostWebUrl);

        // Send the request and return the response.
        // This call returns the SharePoint file.
        return $.ajax({
            url: fileCollectionEndpoint,
            type: "POST",
            data: arrayBuffer,
            processData: false,
            headers: {
                "accept": "application/json;odata=verbose",
                "X-RequestDigest": $("#__REQUESTDIGEST").val(),
                //"content-length": arrayBuffer.byteLength
            }
        });
    }

    // Get the list item that corresponds to the file by calling the file's ListItemAllFields property.
    function getListItem(fileListItemUri) {

        // Construct the endpoint.
        // The list item URI uses the host web, but the cross-domain call is sent to the
        // add-in web and specifies the host web as the context site.
        fileListItemUri = fileListItemUri.replace(hostWebUrl, '{0}');
        fileListItemUri = fileListItemUri.replace('_api/Web', '_api/sp.appcontextsite(@target)/web');

        var listItemAllFieldsEndpoint = String.format(fileListItemUri + "?@target='{1}'",
            appWebUrl, hostWebUrl);

        // Send the request and return the response.
        return $.ajax({
            url: listItemAllFieldsEndpoint,
            type: "GET",
            headers: { "accept": "application/json;odata=verbose" }
        });
    }

    // Change the display name and title of the list item.
    function updateListItem(itemMetadata) {

        // Construct the endpoint.
        // Specify the host web as the context site.
        var listItemUri = itemMetadata.uri.replace('_api/Web', '_api/sp.appcontextsite(@target)/web');
        var listItemEndpoint = String.format(listItemUri + "?@target='{0}'", hostWebUrl);

        // Define the list item changes. Use the FileLeafRef property to change the display name.
        // For simplicity, also use the name as the title.
        // The example gets the list item type from the item's metadata, but you can also get it from the
        // ListItemEntityTypeFullName property of the list.

        if (feedbackStatus == "Feedback Given") {
            count++;
        }

        var body = String.format("{{'__metadata':{{'type':'{0}'}},'FileLeafRef':'{1}','Title':'{2}','Email':'{3}','CV_x0020_Type':'{4}','Batch':'{5}','Student_x0020_Name':'{6}','Count':'{7}'}}",
            itemMetadata.type, newName, newName, userEmail, $("#cvType").find(":selected").text(), $("#batch").find(":selected").text(), $("#studentName").val(), count);

        // Send the request and return the promise.
        // This call does not return response content from the server.
        return $.ajax({
            url: listItemEndpoint,
            type: "POST",
            data: body,
            headers: {
                "X-RequestDigest": $("#__REQUESTDIGEST").val(),
                "content-type": "application/json;odata=verbose",
                //"content-length": body.length,
                "IF-MATCH": itemMetadata.etag,
                "X-HTTP-Method": "MERGE",
                "If-Match": "*"
            }
        });
    }
}