extends Area2D

export var SPEED=600
export var ang_speed = PI
export var DAMAGE = 30
var objective = null
var direction = Vector2.ZERO
var velocity = Vector2.ZERO
var shooter = null

func _ready():
	connect("body_entered", self, "_on_body_entered")
	

func devolver():
	objective = shooter
	rotation = (objective.get_global_position() - get_global_position()).angle()
	set_collision_mask(2)
	
func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(DAMAGE)
	queue_free()


func _physics_process(delta):
	if objective == null:
		return
	direction = objective.get_global_position() - get_global_position()
	direction = direction.normalized()
	var angle = transform.x.cross(direction)
	rotation += ang_speed * angle * delta
	position+=SPEED*transform.x*delta
