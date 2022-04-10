extends KinematicBody2D

export var SPEED = 200
export var ACCELERATION = 100
var velocity = Vector2()
export var HEALTH = 100

onready var animTree = $AnimationTree
onready var animPlayer = $AnimationPlayer
onready var playback = animTree.get("parameters/playback")
onready var maletin = $Maletin

var direction = Vector2.DOWN

func _unhandled_input(event):
	if event.is_action_pressed("parry"):
		maletin.parry()
		
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

func take_damage(damage):
	print(damage)
	HEALTH -= damage
	is_dead()
	
func is_dead():
	if HEALTH <= 0:
		queue_free()
		

