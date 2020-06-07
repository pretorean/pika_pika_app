<?php
// объект 'like' 
class Like {
 
    // подключение к БД таблице "users" 
    private $model;
    private $table_name = "likes";
 
    // свойства объекта 
    public $id;
    public $user;
    public $leader;
    public $error;
	public $post;
     
    // конструктор класса User 
    public function __construct() {
       $this->error=array(); 
    }

    // Создание нового лайка 
public function add() {
			
		if ($this->likeExist()){
			$this->error[]='Like exist';
			return false;
		}	
       
        // подготовка модели 
        $this->model = R::dispense($this->table_name);
    
        // инъекция 
        $stuser=htmlspecialchars(strip_tags($this->user));
        $stleader=htmlspecialchars(strip_tags($this->leader));
        $stpost=htmlspecialchars(strip_tags($this->post));
        
		
		$user = R::load('users',$stuser);
		$this->error=array();
		/*if ($stleader){
		$leader = R::load('users',$stleader);
		if ($leader->id==0){ $this->error[]='Leader not found';}else {
		$this->model->leader=$leader;}
		}else{
			$leader = new User();
		}*/
		if ($stpost){
		$post = R::load('posts',$stpost);
		if ($post->id==0){ $this->error[]='Post not found';} else {
		$this->model->post=$post;}
		} else{ 
			$post = 0;
		}
		
		if ($user->id==0){ $this->error[]='User not found';} 
		 
		
    
        if(empty($this->error)){
		// привязываем значения 
        $this->model->user=$user;
		
		
       
		}  else {
			return false;
		}  
        
        // Выполняем запрос 
        // Если выполнение успешно, то лайк поставлен в базе
        if(R::store($this->model)) {
           
			return true;
        }
    
        return false;
    }

   
		// убрать лайк
public function delete(){
 
 
 
	if(!$this->id){
		$stuser=htmlspecialchars(strip_tags($this->user));
        $stleader=htmlspecialchars(strip_tags($this->leader));
        $stpost=htmlspecialchars(strip_tags($this->post));
		if (!$stleader){$stleader=0;}
		if (!$stpost){$stpost=0;}
		//$res = R::findOne( $this->table_name, 'leader_id = :leader AND user_id = :user  AND post_id = :post',
		$like = R::findOne( $this->table_name, 'user_id = :user  AND post_id = :post',
		//array('leader'=>$stleader,'user'=>$stuser,'post'=>$stpost)
		array('user'=>$stuser,'post'=>$stpost)
		); 
		$this->error[]='2';
		$this->error[]=is_null($like);
		$this->error[]=$stuser;
		$this->error[]=$stpost;
		if($like !=NULL){
		R::trash($like);
		}
	} else {
		$like = R::load($this->table_name,$this->id);
		R::trash($like);
		$this->error[]='21';
	}
		
  return true;
 
}

public function likeExist(){
	if(!$this->id){
		$stuser=htmlspecialchars(strip_tags($this->user));
        $stleader=htmlspecialchars(strip_tags($this->leader));
        $stpost=htmlspecialchars(strip_tags($this->post));
		if (!$stleader){$stleader=0;}
		if (!$stpost){$stpost=0;}
		//$res = R::findOne( $this->table_name, 'leader_id = :leader AND user_id = :user  AND post_id = :post',
		$res = R::findOne( $this->table_name, 'user_id = :user  AND post_id = :post',
		//array('leader'=>$stleader,'user'=>$stuser,'post'=>$stpost)
		array('user'=>$stuser,'post'=>$stpost)
		); 
		$this->error[]=$res;
		$this->error[]=$stuser;
		$this->error[]=$stleader;
		$this->error[]=$stpost;
		return ($res===NULL) ? false : true;
	} else {
		$res = R::load($this->table_name,$this->id);
		return ($res) ? true : false;
	}
}

}