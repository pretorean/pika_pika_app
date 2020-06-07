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
// создание объекта 'Post'
$leader = new Leader();
// получаем данные
$data = json_decode(file_get_contents("php://input"));




		
		$res = $leader->getTop($data->limit);	
        if ($res)
 {
    // устанавливаем код ответа 
    http_response_code(200);
 
    // 
    echo json_encode(array("message" => $res));
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
	echo json_encode(array("message" =>"Top empty" , "error" => $error));
}
   

?>