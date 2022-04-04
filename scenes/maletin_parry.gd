extends RigidBody2D




func _physics_process(delta):
	position += SPEED * transform.x * delta
	
	
