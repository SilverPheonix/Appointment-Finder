<?php
include("db/dataHandler.php");

class SimpleLogic
{
    private $dh;
    function __construct()
    {
        $this->dh = new DataHandler();
    }

    function handleRequest($method, $param)
    {
        switch ($method) {
            case "getAllAppointments":
                $res = $this->dh->getAllAppointments();
                break;
            case "getAppointmentDetail":
                $res = $this->dh->getAppointmentDetail($param);
                break;
            case "generateCheckboxes":
                $res = $this->dh->generateCheckboxes($param);
                break;
            case "postVote":
                $res = $this->dh->postVote($param);
                break;
            default:
                $res = null;
                break;
        }
        return $res;
    }
}
