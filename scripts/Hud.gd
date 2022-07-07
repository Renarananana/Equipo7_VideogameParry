extends Control

onready var vida = $ProgressBar
var health_ini = 100
var vida_player = 0


func _physics_process(delta):
	if get_tree().root.get_node("Main").get_node("KinematicBody2D") != null:
		vida_player = get_tree().root.get_node("Main").get_node("KinematicBody2D").HEALTH
		vida.value = vida_player * 100 / health_ini 
