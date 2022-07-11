extends "res://scripts/Enemy.gd"


func fire_machinegun():
	var Bala = bala.instance()
	
	playback.travel("AttackEnemy")
	
	
	look_vec = player.position - global_position
	look_vec = look_vec.normalized()
	Bala.position = get_global_position() + look_vec * 90
	Bala.rotation = look_vec.angle() + random.randf_range(-PI/25 , PI/25)
	Bala.player = player
	get_parent().add_child(Bala)
	if c == 5:
		c = 0
		$Timer.set_wait_time(5)
	else:
		c += 1
		$Timer.set_wait_time(0.1)

func _on_Timer_timeout():
	if player != null:
		fire_machinegun()
