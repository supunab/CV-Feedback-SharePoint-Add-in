$(document).ready(function () {
    // According to the user group page will be redirected
    var clientContext = SP.ClientContext.get_current();
    var user = clientContext.get_web().get_currentUser();
    var groups = user.get_groups();

    clientContext.load(groups);

    clientContext.executeQueryAsync(function () {
        var enumerator = groups.getEnumerator();

        var redirected = false;

        while (enumerator.moveNext()) {
            var group = enumerator.get_current().get_title();

            if (group === "Admin") {
                // Admin person
                window.location.replace("AdminView.aspx?" + document.URL.split("?")[1]);
                redirected = true;
                break;
            }

            else if (group === "Alumni") {
                // An Aluminai person
                window.location.replace("AluminaiView.aspx?" + document.URL.split("?")[1]);
                redirected = true;
                break;
            }

        }

        if (!redirected) {
            // Default case is student
            window.location.replace("StudentView.aspx?" + document.URL.split("?")[1]);
        }

    }, function () {
        alert("There's been some issue with getting data from the server. Try refreshing the page.");
    });


});