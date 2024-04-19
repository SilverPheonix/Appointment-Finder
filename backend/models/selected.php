<?php
class Selected{
    public $id;
    public $option;
    public $user;
    public $userid;
    public $appointment;
    public $value;

    function __construct($id,$option,$user, $userid, $appointment,$value){
        $this->id = $id;
        $this->option = $option;
        $this->user = $user;
        $this->userid = $userid;
        $this->appointment = $appointment;
        $this->value = $value;
    }
}
?>