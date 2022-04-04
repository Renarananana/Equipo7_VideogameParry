extends KinematicBody2D

var SPEED = 200
var ACCELERATION = 100
var velocity = Vector2()
onready var animTree = $AnimationTree
onready var animPlayer = $AnimationPlayer
onready var playback = animTree.get("parameters/playback")


func _physics_process(delta):
	
	velocity = move_and_slide(velocity)
	
	var move_input_x = Input.get_axis("left", "right")
	var move_input_y = Input.get_axis("up", "down")
	
	velocity.x = move_toward(velocity.x, move_input_x * SPEED, ACCELERATION)
	velocity.y = move_toward(velocity.y, move_input_y * SPEED, ACCELERATION)
	
	if velocity.x > 10 and abs(velocity.y) <10:
		playback.travel("walk_right")
	elif velocity.x > 10 and velocity.y >10:
		playback.travel("walk_frontright")
	elif velocity.x < -10 and abs(velocity.y) <10:
		playback.travel("walk_left")
	elif velocity.x > 10 and velocity.y < -10:
		playback.travel("walk_backright")
	elif velocity.y < -10 and abs(velocity.x) <10:
		playback.travel("walk_back")
	elif velocity.x < -10 and velocity.y < -10:
		playback.travel("walk_backleft")
	elif velocity.y > 10 and abs(velocity.x) <10:
		playback.travel("walk_front")
	elif velocity.x < -10 and velocity.y > 10:
		playback.travel("walk_frontleft")
	else:
		playback.travel("Idle") 
	
