extends "res://scripts/Enemy.gd"

	

func fire():
	var Bala1 = bala.instance()
	var Bala2 = bala.instance()
	var Bala3 = bala.instance()
	
	
	look_vec = objective.position - global_position
	look_vec = look_vec.normalized()
	
	Bala1.position = get_global_position() + look_vec * 90
	Bala1.player = objective
	Bala1.rotation = look_vec.angle()
	get_parent().add_child(Bala1)
	
	Bala2.position = get_global_position() + look_vec * 90
	Bala2.rotation = look_vec.angle() + PI/6
	Bala2.player = objective
	
	get_parent().add_child(Bala2)
	
	Bala3.position = get_global_position() + look_vec * 90
	Bala3.player = objective
	
	Bala3.rotation = look_vec.angle() - PI/6
	get_parent().add_child(Bala3)
	
	


func _on_Timer_timeout():
	if player != null and not dead:
		objective = player
		playback.travel("AttackEnemy")
		$Timer.set_wait_time(3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
