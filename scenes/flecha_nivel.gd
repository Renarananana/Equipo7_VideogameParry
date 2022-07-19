extends Area2D
var lista = false


func start():
	$AnimatedSprite.playing = true
	modulate = Color(0.1,0.9,0.25,1.0)
	lista = true


func _ready():
	connect("body_entered", self, "_on_body_entered")
	
	
func _on_body_entered(body):
	if lista:	
		get_tree().change_scene("res://scenes/boss_room.tscn")
