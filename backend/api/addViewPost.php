<?php
// required headers
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// файлы, необходимые для подключения к базе данных
include_once '../db.php';
include_once 'objects/post.php';
// создание объекта 'Post'
$post = new Post();
// получаем данные
$data = json_decode(file_get_contents("php://input"));


        $post->id = $data->id;
        if ($post->addView())
		{
    // устанавливаем код ответа 
			http_response_code(204);
		}
 
			//  
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
  
    

// показать сообщение об ошибке, если jwt пуст

?>