<?php
class Appointment{
    public $id;
    public $title;
    public $place;
    public $exdate;

    function __construct($id,$title,$place,$exdate){
        $this->id = $id;
        $this->title = $title;
        $this->place = $place;
        $this->exdate = $exdate;
    }
}
?>