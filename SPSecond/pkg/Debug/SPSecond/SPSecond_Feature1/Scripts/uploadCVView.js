$(document).ready(function () {
    // Hide validation fail message
    $("#validationMsg").hide();

    // Set batch years
    $("#batch").html(generateBatches());

    //Validate on click
    $("#btnSubmit").click(validateInputs);

    //On modal button click go to the home page, with params as well
    $("#modalBtn").click(function () {
        window.location.href = "Default.aspx?" + document.URL.split("?")[1];
    });


});


function generateBatches() {
    var markup = "";
    var year = new Date().getFullYear();

    // The select will have values starting from startYear to current year
    var startYear = 2010;

    for (startYear; startYear <= year ; startYear++) {
        markup += String.format("<option value='{0}'>{0}</option>", startYear);
    }
    
    return markup;
}

function validateInputs() {
    if ($("#studentName").val().trim() == "") {
        $("#validationMsg").show();
        return
    }

    if ($("#getFile").get(0).files.length == 0) {
        $("#validationMsg").show();
        return
    }

    // Since there are no errors upload the file
    uploadFile();

}