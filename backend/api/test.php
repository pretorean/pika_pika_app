<?
include_once '../db.php';
$array=5;
//echo htmlspecialchars(implode(",", $array));
//$res=R::getCell( 'SELECT COUNT(*) FROM likes WHERE post_id=-1' );
//echo $res;

include_once 'objects/user.php';
include_once 'objects/leader.php';
// создание объекта 'Post'
$user = new user();
$leader = new Leader();
//$user->id=11;
//$user->delegate=10;

//$user->delegateVoice();
$leader->id = 8;
$res = $leader->getElectorat(10);
//echo print_r($user->getTop(10));
 //$res=R::getCell( 'SELECT COUNT(*) FROM likes WHERE post_id=6 AND user_id=5');
 /*$oldway='/5/24/';
 $referals=R::getCol('SELECT id FROM users WHERE delway LIKE "'.$oldway.'%"');
 print_r($referals);
 while( $item = $referals->getNextItem() ) {
							$referal=R::load('users', $item->id);
							$user->error[]=$item->id;
							
							}
						$referals->close();
//echo $res;*/
 echo print_r($res );
?>