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
            /*case "getAppointment":
                $res = $this->dh->getAppointment($param);
                break;
            case "postAppointment":
                $res = $this->dh->postAppointment($param);
                break;
            case "postSelected":
                $res = $this->dh->postSelected($param);
                break;
            case  "postComment":
                $res = $this->dh->postComment($param);
                break;*/
            default:
                $res = null;
                break;
        }
        return $res;
    }
}
