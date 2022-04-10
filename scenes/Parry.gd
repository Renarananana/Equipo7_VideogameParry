extends Node2D

onready var anim=$Area2D/AnimationPlayer


func parry():
	anim.play("parry")

func _on_body_entered(body: Node):
	queue_free()
	if body.has_method("devolver"):
		body.devolver(self)
	pass
