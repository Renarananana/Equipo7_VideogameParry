extends Area2D

var HEALTH = 20

func _ready():
	connect("body_entered", self, "_on_body_entered")
	
	
func _on_body_entered(body):
	if body.has_method("gain_health"):
		body.gain_health(HEALTH)
		queue_free()
