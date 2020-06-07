<?php
// объект 'city' 
class City {
 
    // подключение к БД таблице "users" 
    private $model;
    private $table_name = "cities";
 
    // свойства объекта 
    public $id;
    public $name;
	public $region;
    public $error;
     
    // конструктор класса User 
    public function __construct() {
       $this->error=array(); 
    }

    // Создание нового города 
function add() {
          // подготовка модели 
        $this->model = R::dispense($this->table_name);
    
        // инъекция 
        $this->name=htmlspecialchars(strip_tags($this->name));
        
        
		
		$user = R::load('users',$stuser);
		
		
		
		if (!$user){ $this->error[]='User not found';} 
		if (!$this->body){ $this->error[]='Text not found';} 
		
    
        if($user&&$this->body){
		// привязываем значения 
        $this->model->name=$this->name;
		$this->model->body=$this->body;
		$this->model->region=$region;
		
		//$this->model->post=$post;
       
		}  else {
		
			return false;
		}  
        
        // Выполняем запрос 
        // Если выполнение успешно, то лайк поставлен в базе
        if(R::store($this->model)) {
			
            return true;
        }
		
		$this->error[]='error db';
        return false;
    }

   
		// убрать пост 
public function delete(){
 
 
 
	if($this->id){
		$post = R::load($this->table_name,$this->id);
		R::trash($post);
	}
		
  return true;
 
}

//filter - массив {	"users"=>массив пользователей,
//					"lcmin"=>условие по количеству лайков, 
//					"lcmax"=>условие по количеству лайков, 
//					"ids"= массив ид постов
//					"limit" = количество записей
//					"offset" = смещение
// все условия по и



private function prepareParam($array){
	if (!is_array($array)){
		return htmlspecialchars($array);
	}else { 
	return htmlspecialchars(implode(",", $array));
	}
}


}