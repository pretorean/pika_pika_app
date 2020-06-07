<?php
// required headers
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
// требуется для кодирования веб-токена JSON
include_once 'config/core.php';
include_once '../libs/php-jwt-master/src/BeforeValidException.php';
include_once '../libs/php-jwt-master/src/ExpiredException.php';
include_once '../libs/php-jwt-master/src/SignatureInvalidException.php';
include_once '../libs/php-jwt-master/src/JWT.php';
use \Firebase\JWT\JWT;
// файлы, необходимые для подключения к базе данных
include_once '../db.php';
include_once 'objects/post.php';
// создание объекта 'Post'
$post = new Post();
// получаем данные
$data = json_decode(file_get_contents("php://input"));

// получаем jwt
$jwt = isset($_SERVER["HTTP_AUTHORIZATION"]) ? $_SERVER["HTTP_AUTHORIZATION"] : "";
// если JWT не пуст
if ($jwt) {
    // если декодирование выполнено успешно, показать данные пользователя
    try {
        // декодирование jwt
        $decoded = JWT::decode($jwt, $key, array('HS256'));
        // Нам нужно установить отправленные данные (через форму HTML) в свойствах объекта пользователя
        $post->user = $decoded->data->id;
        $post->body = $data->body;
		$post->title = $data->title;
		$post->type = $data->type;
		
        if ($post->add())
 {
    // устанавливаем код ответа 
    http_response_code(204);
 
    // 
    echo json_encode(array("message" => "Post add"));
}
 
// сообщение, если не удаётся создать пост 
else {
 
    // устанавливаем код ответа 
    http_response_code(400);
 
    //
	$error='';
	foreach($post->error as $terror){
		$error=$error.$terror.', ';
	}
	echo json_encode(array("message" =>"Post not add" , "error" => "Empty ".$error));
}
    }
    // если декодирование не удалось, это означает, что JWT является недействительным
    catch(Exception $e) {
        // код ответа
        http_response_code(401);
        // сообщение об ошибке
        echo json_encode(array("message" => "Access denied.", "error" => $e->getMessage()));
    }
}
// показать сообщение об ошибке, если jwt пуст
else {
    // код ответа
    http_response_code(401);
    // сообщить пользователю что доступ запрещен
    echo json_encode(array("message" => "Access denied."));
}
?>