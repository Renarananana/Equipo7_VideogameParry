extends Area2D

export var SPEED=600
export var ang_speed = PI
export var DAMAGE = 20
onready var pivot = $Pivot
onready var timer = $Timer
var rotation_speed = PI
var direction = Vector2.ZERO
var velocity = Vector2.ZERO

func _ready():
	connect("body_entered", self, "_on_body_entered")
	timer.start()
	
	

	
func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(DAMAGE)
	queue_free()


func _physics_process(delta):

	position+=SPEED*transform.x*delta


func _on_Timer_timeout():
	modulate = Color(1, 1, 1, 1)
	set_collision_layer_bit(4,true)
	collision_mask = 32771
