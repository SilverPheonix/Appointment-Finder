<?php
class Comment{
    public $id;
    public $content;
    public $user;
    public $appointment;

    function __construct($id,$content,$user,$appointment){
        $this->id = $id;
        $this->content = $content;
        $this->user = $user;
        $this->appointment = $appointment;
    }
}
?>