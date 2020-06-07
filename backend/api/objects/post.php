<?php
// объект 'post' 
class Post {
 
    // подключение к БД таблице "users" 
    private $model;
    private $table_name = "posts";
 
    // свойства объекта 
    public $id;
    public $user;
    public $body;
	public $title;
	public $views;
    public $likes;
	public $isliked;
	public $type;
	public $lastname;
	public $firstname;
	public $createdate;
	public $modifydate;
	public $error;
     
    // конструктор класса User 
    public function __construct() {
       $this->error=array(); 
    }

    // Создание нового лайка 
function add() {
          // подготовка модели 
        $this->model = R::dispense($this->table_name);
    
        // инъекция 
        $stuser=htmlspecialchars(strip_tags($this->user));
        $this->body=htmlspecialchars(strip_tags($this->body));
        $this->likes=0;
        $this->views=0;
		
		$user = R::load('users',$stuser);
		
		
		
		if ($user->id==0){ $this->error[]='User not found';} 
		if (empty($this->body)){ $this->error[]='body is empty';} 
		if (empty($this->title)){ $this->error[]='title is empty';} 
		
    
        if(empty($this->error)){
		// привязываем значения 
        $this->model->user=$user;
		$this->model->body=$this->body;
		$this->model->createdate=date("Y-m-d H:i:s");
		$this->model->modifydate=date("Y-m-d H:i:s");
		$this->model->likes= $this->likes;
		$this->model->title= $this->title;
		$this->model->type= $this->type;
		$this->model->views= $this->views;
		//$this->model->post=$post;
       
		}  else {
		
			return false;
		}  
        
        // Выполняем запрос 
        // Если выполнение успешно, то лайк поставлен в базе
        if(R::store($this->model)) {
			$this->user=$user;
			$this->createdate=$this->model->createdate;
			$this->modifydate=$this->model->modifydate;
            return true;
        }
		$this->error[]=$user;
		$this->error[]=$text;
		$this->error[]='1';
        return false;
    }

public function addView(){
	$this->model=R::load($this->table_name,$this->id);
	if($this->model->id==0){
		$this->error[]='Post with id '.$this->id.'not found';
		return false;
	} else {
		$this->model->views=(int)$this->model->views+1;
		if (R::store($this->model)){
		return true;
		}else{
			$this->error[]='error in db for id'.$this->id;
			return false;
		}
	}
}	
 
 
		// убрать пост 
public function delete(){
 
 
 
	if($this->id){
		$post = R::load($this->table_name,$this->id);
		R::trash($post);
	}
		
  return true;
 
}

//{filter - массив {	"users"=>массив пользователей,
//					"lcmin"=>условие по количеству лайков, 
//					"lcmax"=>условие по количеству лайков, 
//                  "vmin"=>условие по количеству просмотров, 
//					"vmax"=>условие по количеству просмотров, 
//					"ids"= массив ид постов
//					"limit" = количество записей
//					"offset" = смещение
// все условия по и

public function getList($filters,$sort){
	
	
	$t=' WHERE '; 
	
	if (isset($filters['users'])){$t=$t.' t.user_id IN ('.$this->prepareParam($filters['users']).') AND';}
		if (isset($filters['lcmin'])){$t=$t.' t.likes>=  '.$this->prepareParam($filters['lcmin']).' AND';}
		if (isset($filters['lcmax'])){$t=$t.' t.likes<=  '.$this->prepareParam($filters['lcmax']).' AND';}
		if (isset($filters['vmin'])){$t=$t.' t.views>=  '.$this->prepareParam($filters['vmin']).' AND';}
		if (isset($filters['vmax'])){$t=$t.' t.views<=  '.$this->prepareParam($filters['vmax']).' AND';}
		if (isset($filters['ids'])){$t=$t.' t.id IN ('.$this->prepareParam($filters['ids']).') AND';}
		if (isset($filters['types'])){$t=$t.' t.type IN ('.$this->prepareParam($filters['types']).') AND';}
		$limitoffset='';
		if (isset($filters['limit'])) {$limitoffset=$limitoffset.' LIMIT '.(int)$filters['limit'].' ';} else {$limitoffset=$limitoffset.' LIMIT 100 ';};
		if (isset($filters['offset'])) {$limitoffset=$limitoffset.'OFFSET '.(int)$filters['offset'].' ';} else {$limitoffset=$limitoffset.'';};
		$fields=array('type','id','likes','title','firstname','lastname','user_id');
		$tsort=' ORDER BY ';
		$newsort=array();
		
		if (is_array($sort)){
			foreach($sort as $el){
				$arEl=(array) $el;
				
				foreach($arEl as $key=>$value)
				
				if(in_array($key,$fields)){
					$direct = (strtolower($value)=='desc')? ' DESC ' : ' ASC ';
					$newsort[]=' '.$key.' '.$direct;
				}
			}
		}
		
		if (count($newsort)==0){
			$tsort='';
		} else {
			$tsort = $tsort.$this->prepareParam($newsort);
		}
		if(!$this->user){
		$tuserid=0;}
		else{
		$tuserid=$this->user;	
		}
		//return 'SELECT  t.id, t.body, t.title, t.user_id, u.firstname , u.lastname , t.likes, t.views, t.type, DATE_FORMAT(t.createdate, "%d.%m.%Y") as createdate, DATE_FORMAT(t.modifydate, "%d.%m.%Y") as modifydate, CASE When IFNULL(l.id,false)=false then false else true END as isliked FROM  '.$this->table_name.' as t LEFT JOIN users as u on t.user_id=u.id LEFT JOIN likes as l ON t.id=l.post_id and l.user_id='.$this->user.' '.$t.' true '.$tsort.$limitoffset; 
		$subsCollection = R::getAll('SELECT  t.id, t.body, t.title, t.user_id, u.firstname , u.lastname , t.likes, t.views, t.type, DATE_FORMAT(t.createdate, "%d.%m.%Y") as createdate, DATE_FORMAT(t.modifydate, "%d.%m.%Y") as modifydate, CASE When IFNULL(l.id,false)=false then false else true END as isliked FROM  '.$this->table_name.' as t LEFT JOIN users as u on t.user_id=u.id LEFT JOIN likes as l ON t.id=l.post_id and l.user_id='.$tuserid.' '.$t.' true '.$tsort.$limitoffset);
		
		$count=0;
		
		$result =array('result'=>$subsCollection, 
		
	'count'=>count($subsCollection));
	return $result;
	
 
 
	
 
}

public function get(){
	$this->model=R::load($this->table_name,$this->id);
	if ($this->model->id==0){
		$this->error[]='Post with id '.$this->id.' not found ';
		return false;
	} else {
		if(!$this->user){
		$tuserid=0;}
		else{
		$tuserid=$this->user;	
		}
		$this->title=$this->model->title;
		$this->body=$this->model->body;
		$this->user=$this->model->user_id;
		$user = $this->model->fetchAs('users')->user->export();
		$this->lastname=$user['lastname'];
		$this->firstname=$user['firstname'];
		$this->views=$this->model->views;
		$this->likes=$this->model->likes;
		$this->type=$this->model->type;
		$this->createdate=date("d.m.Y", strtotime($this->model->createdate));
		$this->modifydate=date("d.m.Y", strtotime($this->model->modifydate)); 
		$res=R::getCell( 'SELECT COUNT(*) FROM likes WHERE post_id='.htmlspecialchars(strip_tags($this->id)).' AND user_id='.$tuserid);
		$this->isliked=$res;
		$this->error[]=$tuserid;
		
		return true;
	}
}

public function getMyList(){
	
	return $this->getList(array('users'=>array($this->user)));
} 

public function countLikes(){
	$res=R::getCell( 'SELECT COUNT(*) FROM likes WHERE post_id='.htmlspecialchars(strip_tags($this->id)) );
	
	
		$this->model=R::load($this->table_name,$this->id);
		if($this->model){
			$this->model->likes=$res;
			R::store($this->model);
			return true;
		}
	
	return false;
}

public function update(){
	if(!$this->body){
		$this->error[]='Post with id '.$this->id.' not update. Body is empty ';
		return false;
	}
	$model = R::load($this->table_name,$this->id);
	
	if ($this->model->id==0){
		$this->error[]='Post with id '.$this->id.' not found ';
	return false;}
	elseif ($this->model->user_id!=$this->user){
		$this->error[]='User not owner Post';
		return false;
		
	} else {
		$this->model->body=$this->body;
		$this->model->modifydate=date("Y-m-d H:i:s");
		if(R::store($this->model))
		{
		return true;
		}
		return false;
	}
}

private function prepareParam($array){
	if (!is_array($array)){
		return htmlspecialchars($array);
	}else { 
	return htmlspecialchars(implode(",", $array));
	}
}


}