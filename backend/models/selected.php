<?php
class Selected{
    public $id;
    public $option;
    public $user;
    public $appointment;

    function __construct($id,$option,$user,$appointment){
        $this->id = $id;
        $this->option = $option;
        $this->user = $user;
        $this->appointment = $appointment;
    }
}
?>