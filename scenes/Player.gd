extends KinematicBody2D

var SPEED = 200
var ACCELERATION = 100
var velocity = Vector2()


func _physics_process(delta):
	
	velocity = move_and_slide(velocity)
	
	var move_input_x = Input.get_axis("left", "right")
	var move_input_y = Input.get_axis("up", "down")
	
	velocity.x = move_toward(velocity.x, move_input_x * SPEED, ACCELERATION)
	velocity.y = move_toward(velocity.y, move_input_y * SPEED, ACCELERATION) 
	
