<?php
// показывать сообщения об ошибках 
error_reporting(E_ALL);
 
// установить часовой пояс по умолчанию 
date_default_timezone_set('Europe/Moscow');
 
// переменные, используемые для JWT 
$key = "your_secret_key";
$iss = "https://hackathon.bizness-pro.ru";
$aud = "https://hackathon.bizness-pro.ru";
$iat = 1356999524;
$nbf = 1357000000;
?>