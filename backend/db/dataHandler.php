<?php
include("./models/appointment.php");
include("./models/comment.php");
include("./models/option.php");
include("./models/selected.php");

class DataHandler
{
    //Liste alle Appointments
    public function getAllAppointments()
    {
        include("db.php");

        $query = "SELECT * FROM appointment";
        $stmt = $mysqli->prepare($query);
        $stmt->execute();
        $result = $stmt->get_result();
        $count = $result->num_rows;
        $appointment = array();

        for($i= 0;$row = $result->fetch_object();$i++) {
            $a = new Appointment($row->a_id, $row->a_title,$row->a_place,$row->a_exdate);
            $appointment[$i] = $a;
        }
        
        $stmt->close();
        $mysqli->close();

        return $appointment;
    }

    public function getAppointmentDetail($id)
    {
        include("db.php");

        $query1 = "SELECT * FROM `option` WHERE o_appointment = ?";
        $query2 = "SELECT * FROM `selected` WHERE s_appointment = ?";
        $query3 = "SELECT * FROM `comment` WHERE c_appointment = ?";

        //Options eines Appointments aus der Datenbank 
        $stmt = $mysqli->prepare($query1);
        $stmt->bind_param("s", $id);
        $stmt->execute();
        $result = $stmt->get_result();
        $count = $result->num_rows;
        $options = array();
        for($i= 0;$row = $result->fetch_object();$i++) {
            $o = new Option($row->o_id, $row->o_date,$row->o_to,$row->o_from,$row->o_appointment);
            $options[$i] = $o;
        }
        $stmt->close();

        //Selections eines Appointments aus der Datenbank 
        $stmt = $mysqli->prepare($query2);
        $stmt->bind_param("s", $id);
        $stmt->execute();
        $result = $stmt->get_result();
        $count = $result->num_rows;
        $selected = array();
        for($i= 0;$row = $result->fetch_object();$i++) {
            $s = new Selected($row->s_id,$row->s_option, $row->s_user,$row->s_appointment, $row->s_value);
            $selected[$i] = $s;
        }
        $stmt->close();

        //Comments eines Appointments aus der Datenbank 
        $stmt = $mysqli->prepare($query3);
        $stmt->bind_param("s", $id);
        $stmt->execute();
        $result = $stmt->get_result();
        $count = $result->num_rows;
        $comments = array();
        for($i= 0;$row = $result->fetch_object();$i++) {
            $c = new Comment($row->c_id, $row->c_content,$row->c_user,$row->c_appointment);
            $comments[$i] = $c;
        }
        $stmt->close();

        $mysqli->close();

        //Alle drei Array als Array zurückgeben
        $appointment = [$options,$selected,$comments];
        return $appointment;
    }
    #
    public function postVote($vote)
    {
        include("db.php");
        
        
        //Selection in die Datenbank einfügen
        //$vote[0] = appointment, $vote[1] = user, $vote[2] = selections als array, $vote[3]= comment
        foreach($vote[2] as $v){
            $query1 = "INSERT INTO `selected`(`s_appointment`,`s_option`,`s_user`, `s_value`) VALUES (?,?,?,?) ";

            $stmt = $mysqli->prepare($query1);
            //$vote[0] = appointment, $vote[1] = user, $vote[2] = selections als array, $vote[3]= comment
            $stmt->bind_param("ssss", $vote[0],$v[0],$vote[1],$v[1]);
            $stmt->execute();
            $stmt->close();
        }

        //Überprüfen ob comment da ist, wenn ja => Comment in die Datenbank
        if($vote[3]!= null){
            $query2 = "INSERT INTO `comment`(`c_content`,`c_appointment`,`c_user`) VALUES (?,?,?)";

            $stmt = $mysqli->prepare($query2);
            //$vote[0] = appointment, $vote[1] = user, $vote[2] = selections als array, $vote[3]= comment
            $stmt->bind_param("sss", $vote[3],$vote[0],$vote[1]);
            $stmt->execute();
            $stmt->close();
        }

        $mysqli->close();
        return "Your vote was successfully inserted into the DB!";
        
    }
    
}
