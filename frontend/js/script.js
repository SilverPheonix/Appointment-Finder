$(document).ready(function () {
    getAllAppointments();
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