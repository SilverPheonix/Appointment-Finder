<?php

class DataHandler
{

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
            $appointment[$i] = $row;
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

        $stmt = $mysqli->prepare($query1);
        $stmt->bind_param("s", $id);
        $stmt->execute();
        $result = $stmt->get_result();
        $count = $result->num_rows;
        $options = array();
        for($i= 0;$row = $result->fetch_object();$i++) {
            $options[$i] = $row;
        }
        $stmt->close();

        $stmt = $mysqli->prepare($query2);
        $stmt->bind_param("s", $id);
        $stmt->execute();
        $result = $stmt->get_result();
        $count = $result->num_rows;
        $selected = array();
        for($i= 0;$row = $result->fetch_object();$i++) {
            $selected[$i] = $row;
        }
        $stmt->close();

        $stmt = $mysqli->prepare($query3);
        $stmt->bind_param("s", $id);
        $stmt->execute();
        $result = $stmt->get_result();
        $count = $result->num_rows;
        $comments = array();
        for($i= 0;$row = $result->fetch_object();$i++) {
            $comments[$i] = $row;
        }
        $stmt->close();

        $mysqli->close();
        
        $appointment = [$options,$selected,$comments];
        return $appointment;
    }
    /*
    public function getAppointment($id)
    {
        $result = array();
        foreach ($this->queryBooks() as $val) {
            if ($val[0]->author == $author) {
                array_push($result, $val);
            }
        }
        return $result;
    }
    public function postAppointment($appointment)
    {
        return 0;
    }
    public function postSelected($selected)
    {
        return 0;
    }

    public function postComment($comment)
    {
       return 0;
    }

    private static function getDemoData()
    {
        $demodata = [[
            [new Person(1, "Jane", "Doe", "jane.doe@fhtw.at", 1234567, "Central IT")],
            [new Person(2, "John", "Doe", "john.doe@fhtw.at", 34345654, "Help Desk")],
            [new Person(3, "baby", "Doe", "baby.doe@fhtw.at", 54545455, "Management")],
            [new Person(4, "Mike", "Smith", "mike.smith@fhtw.at", 343477778, "Faculty")],
        ],
        [
            [new Book(1,"Mord im Orient-Express", "Agatha Christie")],
            [new Book(2, "The Book Thief", "Markus Zusak")],
            [new Book(3, "Paper Towns", "John Green")],
            [new Book(4, "The Fault in Our Stars", "John Green")],
            [new Book(5, "1984", "George Orwell")],
        ]
    ];
        return $demodata;
    }*/
}
