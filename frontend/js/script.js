$(document).ready(function () {
    getAllAppointments();
    getAppointmentDetail(1);
    postVote();
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
                appointments += "<button type='button' class='btn selectappointment btn-primary' id='selectappointment'>Select Appointment</button>";
                appointments += "</div>";
                appointments += "</div>";
            }
            $("#appointments").html(appointments);
        }
    });
};

//gets all options, selections and comments for an appointment
function getAppointmentDetail($a_id){
    $.ajax({
        type: "POST",
        url: "../backend/serviceHandler.php",
        cache: false,
        data: {method: 'getAppointmentDetail', param: $a_id},
        dataType: "json",
        success: function (response) {
            console.log(response);
        }
    });
};

//$vote[0] = appointment, $vote[1] = user, $vote[2] = selections als array, $vote[3]= comment
function postVote(){
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