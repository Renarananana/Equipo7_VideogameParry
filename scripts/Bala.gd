extends Area2D

var SPEED=-300
export var DAMAGE = 100

func _ready():
	connect("body_entered", self, "_on_body_entered")

func devolver():
	SPEED = -SPEED
	
func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(DAMAGE)
		queue_free()
	
func _physics_process(delta):
	position+=SPEED*transform.x*delta
	
