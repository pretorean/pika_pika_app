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


$jwt = isset($_SERVER["HTTP_AUTHORIZATION"]) ? $_SERVER["HTTP_AUTHORIZATION"] : "";
$currentUserID=0;
// если JWT не пуст
if ($jwt) {
    // если декодирование выполнено успешно, показать данные пользователя
    try {
        // декодирование jwt
        $decoded = JWT::decode($jwt, $key, array('HS256'));
        // Нам нужно установить отправленные данные (через форму HTML) в свойствах объекта пользователя
	$currentUserID = $decoded->data->id;}
	catch (Exception $e) {
		$currentUserID=0;
	}
}





// файлы, необходимые для подключения к базе данных
include_once '../db.php';
include_once 'objects/post.php';
// создание объекта 'Post'
$post = new Post();
// получаем данные
$data = json_decode(file_get_contents("php://input"));




		$post->id = $data->id;
	$post->user=$currentUserID;	
        if ($post->get())
 {
    // устанавливаем код ответа 
    http_response_code(200);
 
    // 
    echo json_encode(array("message" => $post));
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
	echo json_encode(array("message" =>"Post not find" , "error" => "Empty ".$error));
}
   

?>