$(document).ready(function () {
    getAllAppointments();
    $("miau").show();
    $("#appointmentForm").hide();
    getAppointmentDetail(1);
    generateCheckboxes(1);
});


function getAllAppointments(){
    $.ajax({
        type: "POST",
        url: "../backend/serviceHandler.php",
        cache: false,
        data: {method: 'getAllAppointments'},
        dataType: "json",
        success: function (response) {
            var appointments = "";
            console.log(response);
            for (var i = 0; i < response.length; i++) {
                var appointment = response[i];
                appointments += "<div class='appointment-card'>";
                appointments += "<h3>" + appointment.title + "</h3>";
                appointments += "<p>Vote until: " + appointment.exdate + "</p>";
                appointments += "<p>Location: " + appointment.place + "</p>";
                appointments += "<div class='select-container'>";
                appointments += "<button type='button' class='btn selectappointment appointment' data-appointment-id='" + appointment.id + "'>Select Appointment</button>";
                appointments += "</div>";
                appointments += "</div>";
            }
            $("#appointments").html(appointments);
        }
    });
};

function getAppointmentDetail(appointmentId){
    $.ajax({
        type: "POST",
        url: "../backend/serviceHandler.php",
        cache: false,
        data: {method: 'getAppointmentDetail', param: appointmentId},
        dataType: "json",
        success: function (response) {
            var details = "";
            console.log(response);
            var appointmentArray = response[0];
            for (var i = 0; i < appointmentArray.length; i++) {
                var detail = appointmentArray[i];
                details += "<th>";
                details += "<p>" + detail.date + "</p>";
                details += "<p>from: " + detail.from + "</p>";
                details += "<p>to: " + detail.to + "</p>";
                details += "</th>";
            }
            $("#details").html(details);
            console.log(details);
            $("#submitVote").data('appointment-id', appointmentId);

        }
    });
};

function generateCheckboxes(appointmentId) {
    console.log('generateCheckboxes called with appointmentId:', appointmentId);
    $.ajax({
        type: "POST",
        url: "../backend/serviceHandler.php",
        cache: false,
        data: { method: 'generateCheckboxes', param: appointmentId },
        dataType: "json",
        success: function (response) {
            var row = "";
            var checkboxesarray = response.filter(item => item.appointment === appointmentId);

            // Create an array of unique users
            var uniqueUsers = [...new Set(checkboxesarray.map(item => item.user))];

            uniqueUsers.forEach(user => {
                var userData = checkboxesarray.filter(item => item.user === user);
                row += "<tr><td class='fix others'>" + user + "</td>";
                userData.forEach(data => {
                    row += "<td><input class='checkbox' type='checkbox' id='otherselections' disabled" + (data.value == 1 ? " checked" : "") + "></td>";
                });
                row += "</tr>";
            });
            var uniqueOptions = [...new Set(checkboxesarray.map(item => item.option))];

            // Add the last row
            row += "<tr><td class='fix userinput'><input type='text' class='form-control' id='nameInput' placeholder='Name'></td>";
            uniqueOptions.forEach(option => {
                row += "<td class='userinput'><input class='checkbox' type='checkbox' id='option" + option + "'></td>";
            });
            row += "</tr>";

            $("#checkboxes").html(row);
            console.log(row);

            // Re-select the appointment after generating checkboxes
            $(".selectappointment[data-appointment-id='" + appointmentId + "']").addClass("selected");
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("AJAX error: " + textStatus + ' : ' + errorThrown);
        }
    });
}


$(document).on('click', '.selectappointment', function() {
    var appointmentId = $(this).data('appointment-id');
    getAppointmentDetail(appointmentId);
    $("#miau").hide();
    $("#appointmentForm").show();
    generateCheckboxes(appointmentId);
    displayComments(appointmentId);
});

$(document).on('click', '#submitVote', function() {
    var appointmentId = $(this).data('appointment-id');
    var user = $("#nameInput").val();
    var selected = [];
    $('.checkbox').each(function() {
        if ($(this).is(':checked') && !$(this).attr('id').startsWith('otherselections')) {
            selected.push([$(this).attr('id').replace('option', ''), 1]);
        } else if (!$(this).attr('id').startsWith('otherselections')){
            selected.push([$(this).attr('id').replace('option', ''), 0]);
        }
    });
    var comment = $("#commentInput").val();
    var vote = [appointmentId, user, selected, comment];
    console.log(vote);
    $.ajax({
        type: "POST",
        url: "../backend/serviceHandler.php",
        cache: false,
        data: {method: 'postVote', param: vote},
        dataType: "json",
        success: function (response) {
            console.log(response);
            //refresh the form
            $("#nameInput").val("");
            $("#commentInput").val("");
            generateCheckboxes(appointmentId);
            displayComments(appointmentId);

        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("AJAX error: " + textStatus + ' : ' + errorThrown);
        }
    });
});

function displayComments(appointmentId) {
    $.ajax({
        type: "POST",
        url: "../backend/serviceHandler.php",
        cache: false,
        data: { method: 'displayComments', param: appointmentId },
        dataType: "json",
        success: function (response) {
            console.log(response); // Check if comments are received
            var comments = "";
            for (var i = 0; i < response.length; i++) {
                var comment = response[i]; // Use the loop variable i to access each comment
                comments += "<div class='comment-card'>";
                comments += "<p style='font-weight:bold;'>" + comment.user + "</p>"; // Add missing semicolon after 'font-weight:bold'
                comments += "<p>" + comment.content + "</p>";
                comments += "</div>";
            }
            $("#comments").html(comments);
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.log("AJAX error: " + textStatus + ' : ' + errorThrown);
        }
    });
}



//$vote[0] = appointment, $vote[1] = user, $vote[2] = selections als array, $vote[3]= comment
/*function postVote(){
    $appointment = 1;
    $user = "user1";
    $comment = "lol lol";
    //[option_id, value]
    $selected = [[1,1],[2,1],[3,0],[4,1]];
    $vote = [$appointment,$user,$selected,$comment];
    $.ajax({
        type: "POST",
        url: "../backend/serviceHandler.php",
        cache: false,
        data: {method: 'postVote', param: $vote},
        dataType: "json",
        success: function (response) {
            console.log(response);
        }
    });
};


function getAppointmentDetail(appointmentId){
    $.ajax({
        type: "POST",
        url: "../backend/serviceHandler.php",
        cache: false,
        data: {method: 'getAppointmentDetail', param: appointmentId},
        dataType: "json",
        success: function (response) {
            var details = "";
            console.log(response);
            // Assuming you want to target the second array in the response
            var appointmentArray = response[1];
            for (var i = 0; i < appointmentArray.length; i++) {
                var detail = appointmentArray[i];
                // Assuming you want to display the content property from each object
                details += "<div>";
                details += "<p>" + detail.content + "</p>"; // Accessing content property
                details += "<p>User: " + detail.user + "</p>"; // Accessing user property
                details += "</div>";
            }
            $("#details").html(details);
            console.log(details);
        }
    });
};

*/