extends Area2D

export var SPEED=600
export var ang_speed = PI
export var DAMAGE = 30
onready var pivot = $Pivot
onready var timer = $Timer
var rotation_speed = PI
var objective = null
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
	if objective == null:
		return
	var objective_pos = objective.get_global_position()
	pivot.rotation += rotation_speed * delta
	direction = objective_pos - get_global_position()
	direction = direction.normalized()
	var angle = transform.x.cross(direction)
	rotation += ang_speed * angle * delta
	position+=SPEED*transform.x*delta


func _on_Timer_timeout():
	modulate = Color(0.52, 0.12, 0.18, 1)
	set_collision_layer_bit(4,true)
	collision_mask = 32771
