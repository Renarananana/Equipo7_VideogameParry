extends KinematicBody2D

var SPEED = 200
var ACCELERATION = 100
var velocity = Vector2()
onready var animTree = $AnimationTree
onready var animPlayer = $AnimationPlayer
onready var playback = animTree.get("parameters/playback")

var direction = Vector2.DOWN


func _physics_process(delta):
	
	velocity = move_and_slide(velocity)
	
	var move_input = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	
	if move_input.length() != 0:
		direction = move_input
	
	velocity = velocity.move_toward(move_input * SPEED, ACCELERATION)
	
	if velocity.length() > 10:
		playback.travel("walk")
	else:
		playback.travel("Idle")
	
	animTree.set("parameters/walk/blend_position", direction)

