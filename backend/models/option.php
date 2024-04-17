<?php
class Option{
    public $id;
    public $date;
    public $appointment;

    function __construct($id,$date,$appointment){
        $this->id = $id;
        $this->date = $date;
        $this->appointment = $appointment;
    }
}
?>