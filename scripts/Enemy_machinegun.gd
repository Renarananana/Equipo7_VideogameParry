extends "res://scripts/Enemy.gd"



func _on_Timer_timeout():
	if player != null:
		fire_machinegun()
