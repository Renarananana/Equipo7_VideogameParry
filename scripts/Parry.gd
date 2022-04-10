extends Node2D

onready var anim=$AnimationPlayer
onready var coll= $CollisionShape2D

func _ready():
	connect("area_entered", self, "_on_Maletin_area_entered")
	coll.disabled = true
	
	
func parry():
	anim.play("Parry")


func _on_Maletin_area_entered(area):
	if area.has_method("devolver"):
		area.devolver()
