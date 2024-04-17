<?php
class Appointment{
    public $id;
    public $title;
    public $place;
    public $date;
    public $exdate;

    function __construct($id,$title,$place,$date,$exdate){
        $this->id = $id;
        $this->title = $title;
        $this->place = $place;
        $this->date = $date;
        $this->exdate = $exdate;
    }
}
?>