<?php
// заголовки 

header("Access-Control-Allow-Origin: https://hackathon.bizness-pro.ru/");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
 
// файлы необходимые для соединения с БД 
include_once '../db.php';
include_once 'objects/user.php'; 
 

 
 
// создание объекта 'User' 
$user = new User();
 
// получаем данные 
$data = json_decode(file_get_contents("php://input"));
 
// устанавливаем значения 
$user->phone = $data->phone;
$phone_exists = $user->phoneExists();
 
// подключение файлов jwt 
include_once 'config/core.php';
include_once '../libs/php-jwt-master/src/BeforeValidException.php';
include_once '../libs/php-jwt-master/src/ExpiredException.php';
include_once '../libs/php-jwt-master/src/SignatureInvalidException.php';
include_once '../libs/php-jwt-master/src/JWT.php';
use \Firebase\JWT\JWT;

// существует ли телефон и соответствует ли пароль тому, что находится в базе данных 
if ( $phone_exists && password_verify($data->password, $user->password) ) {
 
    $token = array(
       "iss" => $iss,
       "aud" => $aud,
       "iat" => $iat,
       "nbf" => $nbf,
       "data" => array(
           "id" => $user->id,
           //"firstname" => $user->firstname,
           //"lastname" => $user->lastname,
           "phone" => $user->phone
       )
    );
 
    // код ответа 
    http_response_code(200);
 
    // создание jwt 
    $jwt = JWT::encode($token, $key);
    echo json_encode(
        array(
            "message" => "Access allowed",
            "jwt" => $jwt
        )
    );
 
}
 
// Если электронная почта не существует или пароль не совпадает, 
// сообщим пользователю, что он не может войти в систему 
else {
 
  // код ответа 
  http_response_code(401);

  // сказать пользователю что войти не удалось 
  echo json_encode(array("message" => "Access error"));
}
?>