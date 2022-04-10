extends Node2D

onready var anim=$Area2D/AnimationPlayer

func attack():
	anim.play("parry")
