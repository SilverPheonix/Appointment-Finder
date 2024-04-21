$(document).ready(function () {
    getAllAppointments();
    $("miau").show();
    $("#appointmentForm").hide();
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


            // Sort the appointments by date
            response.sort(function(a, b) {
                return new Date(a.exdate) - new Date(b.exdate);
            });

            for (var i = 0; i < response.length; i++) {
                var appointment = response[i];
                var currentDate = new Date();
                var expirationDate = new Date(appointment.exdate);

                if (expirationDate < currentDate) {
                    // Use expired layout
                    appointments += "<div class='appointment-card expired'>";
                    appointments += "<h3>" + appointment.title + "</h3>";
                    appointments += "<p>Expired at: " + appointment.exdate + "</p>";
                    appointments += "<p>Location: " + appointment.place + "</p>";
                    appointments += "<div class='select-container expired'>";
                    appointments += "<button type='button' class='btn selectbutton expired appointment' data-appointment-id='" + appointment.id + "'>See Votes</button>";
                    appointments += "</div>";
                    appointments += "</div>";
                } else {
                    // Use regular layout
                    appointments += "<div class='appointment-card'>";
                    appointments += "<h3>" + appointment.title + "</h3>";
                    appointments += "<p>Vote until: " + appointment.exdate + "</p>";
                    appointments += "<p>Location: " + appointment.place + "</p>";
                    appointments += "<div class='select-container'>";
                    appointments += "<button type='button' class='btn selectbutton appointment' data-appointment-id='" + appointment.id + "'>Select Appointment</button>";
                    appointments += "</div>";
                    appointments += "</div>";
                }
            }
            /*
                add a new appointment?
                appointments += "<div class='appointment-card'>";
                appointments += "<h3> Add a new </h3>";
                appointments += "<h3>Appointment </h3>";
                appointments += "<div class='select-container'><button type='button' class='btn selectbutton appointment' data-appointment-id='" + appointment.id + "'>New Appointment</button></div>";
                appointments += "</div>";
            */

            $("#appointments").html(appointments);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("AJAX error: " + textStatus + ' : ' + errorThrown);
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


            //Options ausgeben
            //details += "<th><p> Add a new </p><p> Timeslot </p><p> + </p></th>";
            var appointmentArray = response[0];
            var currentDate = new Date();
            var expirationDate = new Date(appointmentArray[0].date);

            for (var i = 0; i < appointmentArray.length; i++) {
                var detail = appointmentArray[i];
                details += "<th>";
                details += "<p>" + detail.date + "</p>";
                details += "<p>from: " + detail.from + "</p>";
                details += "<p>to: " + detail.to + "</p>";
                details += "</th>";
            }
            $("#details").html(details);

            //Selections ausgeben (Votes der vorherigen User)
            var selectedArray = response[1];
            var row = "";


            // Create an array of unique users
            var uniqueUsers = [...new Set(selectedArray.map(item => item.userid))];        

            uniqueUsers.forEach(userid => {
                var userData = selectedArray.filter(item => item.userid === userid);
                row += "<tr><td class='fix others'>" +userData[0].user + "</td>";
                userData.forEach(data => {
                    row += "<td><input class='checkbox' type='checkbox' id='otherselections' disabled" + (data.value == 1 ? " checked" : "") + "></td>";
                });
                row += "</tr>";
            });
            var uniqueOptions = [...new Set(selectedArray.map(item => item.option))];

            // Add the last row depending on the expiration date and hide or show the form
            if (expirationDate < currentDate) {
                $('.fix').addClass('expired');
                $('.bg-blue').removeClass('bg-blue').addClass('bg-grey');
                $("#CommentAndSubmit").hide();
                row += "<tr><td class='fix userinput expired'><input type='text' class='form-control' id='nameInput' disabled  placeholder='Name'></td>";
                uniqueOptions.forEach(option => {
                    row += "<td class='userinput expired'><input class='checkbox' type='checkbox' disabled id='option" + option + "'></td>";
             })} else {
                $('.fix').removeClass('expired');
                $('.bg-grey').removeClass('bg-grey').addClass('bg-blue');
                $("#CommentAndSubmit").show();
                row += "<tr><td class='fix userinput'><input type='text' class='form-control' id='nameInput' placeholder='Name'></td>";
                uniqueOptions.forEach(option => {
                    row += "<td class='userinput'><input class='checkbox' type='checkbox' id='option" + option + "'></td>";
            })};
            row += "</tr>";


            $("#checkboxes").html(row);            
            
            //Comments ausgeben
            var comments = "";
            var commentlist = response[2];
            for (var i = 0; i < commentlist.length; i++) {
                var comment = commentlist[i]; // Use the loop variable i to access each comment
                if (expirationDate < currentDate) {
                    comments += "<div class='comment-card expired'>";
                } else {
                comments += "<div class='comment-card'>";}
                comments += "<p style='font-weight:bold;'>" + comment.user + "</p>"; // Add missing semicolon after 'font-weight:bold'
                comments += "<p>" + comment.content + "</p>";
                comments += "</div>";
            }
            $("#comments").html(comments);

            
            $("#submitVote").data('appointment-id', appointmentId);

        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("AJAX error: " + textStatus + ' : ' + errorThrown);
        }
    });
};

$(document).on('click', '.selectbutton', function() {
    var appointmentId = $(this).data('appointment-id');
    var title = $(this).closest('.appointment-card').find('h3').text();
    getAppointmentDetail(appointmentId);
    $("#miau").hide();
    $("#Title").html('<h2>' + title +'</h2>');
    $("#appointmentForm").show();
    
    // Remove "selected" class from all other buttons
    $(".selectbutton").removeClass("selected");
    
    // Add "selected" class to the clicked button
    $(this).addClass("selected");
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
            getAppointmentDetail(appointmentId);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("AJAX error: " + textStatus + ' : ' + errorThrown);
        }
    });
});