extends "res://scripts/Enemy.gd"


func _on_Timer_timeout():
	if player != null:
		fire_shotgun()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
