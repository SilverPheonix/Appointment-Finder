<?php
include("./models/person.php");
include("./models/book.php");
include("db.php");
class DataHandler
{

    public function getAllAppointments()
    {
        $query = "SELECT * FROM `appointment`";
        // Use prepared statements to prevent SQL injection
        $stmt = $mysqli->prepare($query);
        //$stmt->bind_param("s", $username);
        $stmt->execute();
        $result = $stmt->get_result();
        return $result;
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
