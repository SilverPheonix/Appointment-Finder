<?php
class Selected{
    public $id;
    public $option;
    public $user;
    public $appointment;
    public $value;

    function __construct($id,$option,$user,$appointment,$value){
        $this->id = $id;
        $this->option = $option;
        $this->user = $user;
        $this->appointment = $appointment;
        $this->value = $value;
    }
}
?>