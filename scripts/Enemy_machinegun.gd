extends "res://scripts/Enemy.gd"


func spawn_bullet():
	var Bala = bala.instance()
	look_vec = objective.position - global_position
	look_vec = look_vec.normalized()
	Bala.position = get_global_position() + look_vec * 90
	Bala.rotation = look_vec.angle() + random.randf_range(-PI/25 , PI/25)
	get_parent().add_child(Bala)
	

func _on_Timer_timeout():
	if player != null and not dead:
		$Timer.set_wait_time(5)
		objective = player
		playback.travel("AttackEnemy")
		
