<?php
// required headers
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// файлы, необходимые для подключения к базе данных
include_once '../db.php';
include_once 'objects/user.php';
include_once 'objects/leader.php';
// создание объекта 'User'
$leader = new Leader();
// получаем данные
$data = json_decode(file_get_contents("php://input"));
// получаем jwt

        $leader->id = $data->id;
        // создание пользователя
        if ($leader->get()) {
            		
            // код ответа
            http_response_code(200);
            // ответ в формате JSON
			unset($leader->password);
			unset($leader->delegate->password); 	
			unset($leader->model);
			unset($leader->table_name);			
            echo json_encode(array("message" => $leader));
        }
       
        else {
            // код ответа
            http_response_code(400);
            // показать сообщение об ошибке
            echo json_encode(array("message" => "User not find", "error"=>"db error"));
        }
    
   
   

?>