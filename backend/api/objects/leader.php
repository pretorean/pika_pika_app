<?php
// объект 'leader' 
class Leader extends User {
 
  
    // свойства объекта 
    public $voices;
    // конструктор класса User 
    public function __construct() {
		$this->table_name = "users";
        $this->error=array();
    }

    // Создание нового пользователя 
		// обновить запись пользователя 

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
	$this->voices=$this->model->voices;
	$this->delegates = $this->getDelegates();
	return true;
    
}

public function getElectorat($limit,$offset) {
	if(!$limit){$limit=10;}
	if(!$offset){$offset=0;}
	if(!$this->model){$this->model=R::load($this->table_name,$this->id);}
	$this->delway = $this->model->delway;
	$delway=(trim($this->delway)=='') ? '/' : trim($this->delway); 
	//return 'SELECT u.id, u.firstname , u.lastname, u.delegate_id, d.firstname as delegatfirstname, d.lastname as delegatlastname, u.delway FROM '.$this->table_name.' as u LEFT JOIN users as d ON u.delegate_id=d.id WHERE u.delway LIKE "'.$this->delway.$this->id.'/%" ORDER BY u.delway LIMIT '.$limit;
	$res = R::getAll('SELECT u.id, u.firstname , u.lastname, u.delegate_id, d.firstname as delegatfirstname, d.lastname as delegatlastname, u.delway FROM '.$this->table_name.' as u LEFT JOIN users as d ON u.delegate_id=d.id WHERE u.delway LIKE "'.$delway.$this->id.'/%" ORDER BY u.delway LIMIT '.$limit);
	
	return $res;
}

public function setVoices() {
	$this->model=R::load($this->table_name,$this->id);
	$this->error[]=gettype ($this->model->delway);
	$this->error[]=trim($this->model->delway)=='';
	if(trim($this->model->delway)==''){$delway='/';$this->error[]='22';}else{$delway=$this->model->delway;}
	
	$res = R::getCell('SELECT Count(u.id) as voices FROM '.$this->table_name.' as u WHERE u.delway LIKE "'.$delway.$this->id.'/%" ');
	$this->voices=$res;
	
	
	$this->model->voices=$this->voices;
	if(R::store($this->model)){
		return true;
	}else{
		return false;
	}
}

public function setAllVoices($tdelway) {
	
	
	$ar = explode('/',$tdelway);
	$newar = array();
	foreach ($ar as $sid){
		if(trim($sid)==''){continue;}
		array_unshift($newar,(int)$sid);
	}
	foreach ($newar as $id){
		if($id==0){continue;}
		$nLeader=new Leader();
		$nLeader->id=$id;
		$nLeader->setVoices();
	}
	
	
}


public function getTop($limit) {
	if(!$limit){$limit=10;}
	//return 'SELECT u.id, u.firstname , u.lastname, u.voices, 0 as place FROM '.$this->table_name.' as u  ORDER BY u.voices desc LIMIT '.$limit; 
	$list = R::getAll('SELECT u.id, u.firstname , u.lastname, u.voices, 0 as place FROM '.$this->table_name.' as u WHERE u.voices>0 ORDER BY u.voices desc LIMIT '.$limit);
	$place=1;
	
	foreach($list as $id=>$body){
		$list[$id]['place'] = $place;
		$place=$place+1;
		 
	}
	return $list;
}




}