<?php
class Option{
    public $id;
    public $date;
    public $from;
    public $to;
    public $appointment;

    function __construct($id,$date,$to,$from,$appointment){
        $this->id = $id;
        $this->date = $date;
        $this->from = $from;
        $this->to = $to;
        $this->appointment = $appointment;
    }
}
?>