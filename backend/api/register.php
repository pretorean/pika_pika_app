<?php
// требуемые заголовки 
header("Access-Control-Allow-Origin: https://hackathon.bizness-pro.ru/");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
 
// подключение к БД 
// файлы, необходимые для подключения к базе данных 
include_once '../db.php';
include_once 'objects/user.php';
 
// получаем соединение с базой данных 

 
// создание объекта 'User' 
$user =  new User();
$data = json_decode(file_get_contents("php://input"));
 
// устанавливаем значения 
$user->firstname = $data->firstname;
$user->lastname = $data->lastname;
$user->phone = $data->phone;
$user->password = $data->password;
if (
    !empty($user->phone) &&
    !empty($user->password) &&
    $user->add()
) {
    // устанавливаем код ответа 
    http_response_code(204);
 
    // покажем сообщение о том, что пользователь был создан 
    echo json_encode(array("message" => "User add."));
}
 
// сообщение, если не удаётся создать пользователя 
else {
 
    // устанавливаем код ответа 
    http_response_code(400);
 $error='';
	foreach($user->error as $terror){
		$error=$error.$terror.', ';
	}
    // покажем сообщение о том, что создать пользователя не удалось 
    echo json_encode(array("message" => "User not add", "error"=>$error));
}
?>