<?php
// объект 'user' 
class User {
 
    // подключение к БД таблице "users" 
    private $model;
    private $table_name = "users";
 
    // свойства объекта 
    public $id;
    public $firstname;
    public $lastname;
	public $delegate;
    public $phone;
	public $delway;
    public $password;
	public $delegates;
	public $error;
    // конструктор класса User 
    public function __construct() {
        $this->error=array();
    }

    // Создание нового пользователя 
function add() {
    
       if ($this->phoneExists()){
		   $this->error[]='phone exist';
		   return false;
	   }
	   
	   
        // подготовка модели 
        $this->model = R::dispense($this->table_name);
    
        // инъекция 
        $this->firstname=htmlspecialchars(strip_tags($this->firstname));
        $this->lastname=htmlspecialchars(strip_tags($this->lastname));
        //$this->phone=htmlspecialchars(strip_tags($this->phone));
        $this->password=htmlspecialchars(strip_tags($this->password));
    
        // привязываем значения 
        $this->model->firstname=$this->firstname;
		$this->model->lastname=$this->lastname;
		$this->model->phone=$this->phone;
		$this->model->active = false;
		//$this->model->delegate = new User();
		$this->model->delway = ''; //полный путь до верхнего суверена 
        // для защиты пароля 
        // хешируем пароль перед сохранением в базу данных 
        $password_hash = password_hash($this->password, PASSWORD_BCRYPT);
        $this->model->password=$password_hash;
    
        // Выполняем запрос 
        // Если выполнение успешно, то информация о пользователе будет сохранена в базе данных 
        if(R::store($this->model)) {
            return true;
        }
    
        return false;
    }

    // Проверка, существует ли телефон в нашей базе данных 
function phoneExists(){
 
    // инъекция 
    $this->phone=htmlspecialchars(strip_tags($this->phone));
 
	$this->model=R::findOne($this->table_name, ' phone = ? ', array($this->phone));
 
 // если электронная почта существует, 
    // присвоим значения свойствам объекта для легкого доступа и использования для php сессий 
    if($this->model) {
 
        
        // присвоим значения свойствам объекта 
        $this->id = $this->model->id;
        $this->firstname = $this->model->firstname;
        $this->lastname = $this->model->lastname;
        $this->password = $this->model->password;
		
 
        // вернём 'true', потому что в базе данных существует электронная почта 
        return true;
    }
 
    // вернём 'false', если адрес электронной почты не существует в базе данных 
    return false;
}
		// обновить запись пользователя 
public function update(){
 
 
	 $this->model=R::load($this->table_name, $this->id);
 
    // Если нет информации о пользователе будет возвращ false 
    if(!$this->model) {
        return false;
    }
 
	
    // Если в HTML-форме был введен пароль (необходимо обновить пароль) 
    $password_set=!empty($this->password);
	
    // инъекция (очистка) 
    $this->firstname=htmlspecialchars(strip_tags($this->firstname));
    $this->lastname=htmlspecialchars(strip_tags($this->lastname));
    //$this->phone=htmlspecialchars(strip_tags($this->phone));
 
    // привязываем значения с HTML формы 
    $this->model->firstname=$this->firstname;
    $this->model->lastname=$this->lastname;
    //$this->model->phone=$this->phone;
 
    // метод password_hash () для защиты пароля пользователя в базе данных 
    if($password_set){
        $this->password=htmlspecialchars(strip_tags($this->password));
        $password_hash = password_hash($this->password, PASSWORD_BCRYPT);
        $this->model->password=$password_hash;
    }
  
    // Если выполнение успешно, то информация о пользователе будет сохранена в базе данных 
    if(R::store($this->model)) {
		//пароль не отправляем
		$this->password=null;
		$this->phone=$this->model->phone;
        return true;
    }
 
    return false;
}

public function get(){
 
 
	 $this->model=R::load($this->table_name, $this->id);
 
    // Если нет информации о пользователе будет возвращ false 
    if($this->model->id==0) {
        return false;
    }
 
    // привязываем значения с HTML формы 
    $this->firstname=$this->model->firstname;
    $this->lastname=$this->model->lastname;
    $this->phone=$this->model->phone;
	$this->delegate=$this->model->fetchAs('users')->delegate; 
	$this->delway=$this->model->delway;
    $this->password=$this->model->password;
	$this->delegates = $this->getDelegates(); 
	return true;
    
}

public function getDelegates() {
	
	
	$ar = explode('/',$this->delway);
	$newar = array();
	$res=array();
	foreach ($ar as $sid){
		if(trim($sid)==''){continue;}
		array_unshift($newar,(int)$sid);
	}
	$lvl=1;
	foreach ($newar as $id){
		if($id==0){continue;}
		$nDelegate=R::load($this->table_name,$id);
		if($nDelegate->id==0){continue;}
		$res[]=array("id"=>$nDelegate->id,"firstname"=>$nDelegate->firstname,"lastname"=>$nDelegate->lastname,"level"=>$lvl);
		$lvl=$lvl+1;
	}
	
	return $res;
}


public function delegateVoice(){
	$this->model=R::load($this->table_name, $this->id);
	if($this->id==$this->delegate){
		$this->error[]='Not delegate to self';
		return false;
	}
	$tdelegate=R::load($this->table_name,$this->delegate);
		if ($tdelegate->id!=0){
			
			if ($this->canDelegateVoice($tdelegate->delway)){
			  
			  
				  $newway=$tdelegate->delway;
				  $this->error[]=$newway;
				  if ($newway==''){$newway='/';}
				  $newway=$newway.$tdelegate->id.'/';
				  $oldway=$this->model->delway;
				  if ($oldway==''){$oldway='/';}
				  $oldway=$oldway.$this->id.'/';
				  $this->model->delegate=$tdelegate;
				  $this->model->delway=$newway;
				  $this->error[]=$oldway;
				  
				  $referals=R::getCol('SELECT id FROM '.$this->table_name.' WHERE delway LIKE "'.$oldway.'%"');
					$newway=$newway.$this->id.'/';
					$this->error[]=$newway;
					
				 	 
						foreach( $referals as $ref)  {
							$referal=R::load('users', $ref);
							$referal->delway=str_replace($oldway,'',$referal->delway);
							$referal->delway=$newway.$referal->delway;
							R::store($referal);
							}
						
						R::store($this->model);
						 $this->delway= $this->model->delway;
						return true;
					
					
			  }else{
				  $this->error[]='Delegate not found with id '.$this->delegate;
				  return false;
			  }
		
		
		}
}

public function unDelegateVoice(){
	$this->model=R::load($this->table_name, $this->id);
	
		
				  $newway='';
				  
				
				  $oldway=$this->model->delway;
				  $this->error[]=$oldway;
				  if ($oldway==''){$oldway='/';}
				  $oldway=$oldway.$this->id.'/';
				  $this->error[]=$oldway;
				  $this->model->delegate=NULL;
				  $this->model->delway=$newway;
				  $referals=R::getCol('SELECT id FROM '.$this->table_name.' WHERE delway LIKE "'.$oldway.'%"');
					$newway='/'.$this->id.'/';
					$this->error[]=implode(",",$referals);
					
					
						foreach( $referals as $refid ) {
							$referal = R::load('users', $refid);
							$this->error[]=$refid;
							if($referal->id==0){
								$this->error[]='хрень'.$refid.' -! '; 
								continue;
							}	
							$referal->delway=str_replace($oldway,'',$referal->delway);
							$referal->delway=$newway.$referal->delway;
							$this->error[]=$referal->delway.' - ';
							$this->error[]=R::store($referal);
							}
						
						R::store($this->model);
						 $this->delway= $this->model->delway;
						return true;
								  
		

}


private function canDelegateVoice($way){
	$this->error[]=$way;
     if ($way==''){return true;}
	if(strpos('/'.$this->id.'/',$way)===false){
		return true;
	} 
	$this->error[]='cilcle ref';
	return false;

}


}