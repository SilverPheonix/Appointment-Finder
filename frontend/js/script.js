$(document).ready(function () {
    getAllAppointments();
    getAppointmentDetail(1);
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
                // outputfromserver[i] can be used to get each value
                console.log(response[i].title);
                appointments += "<li>"+ response[i].a_id + " - "+response[i].a_title +" at "+response[i].a_place +"</li>";
            }
            $("#appointments").html(appointments);
        }
    });
}
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
}