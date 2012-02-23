<?php
  $soap = new SoapServer(
    'RandomNumberService.wsdl', 
    array('uri' => 'http://javascript.phrasebook.org/')
  );
  $soap->setClass('ServiceClass');
  $soap->handle();
  
  class ServiceClass {
    function randomNumber($lower, $upper) {
      return rand($lower, $upper);
    }
  }
?>