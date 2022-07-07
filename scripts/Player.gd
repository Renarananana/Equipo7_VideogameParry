extends KinematicBody2D

export var SPEED = 200
export var ACCELERATION = 100
var velocity = Vector2()
export var HEALTH = 100


onready var animTree = $AnimationTree
onready var animPlayer = $AnimationPlayer
onready var playback = animTree.get("parameters/playback")
onready var maletin = $Maletin
onready var tiempo_dash = $ProgressBar

var direction = Vector2.DOWN
var dash = false
var dash_ready = true

func _unhandled_input(event):
	if event.is_action_pressed("parry"):
		maletin.parry()
		
		
		
func _physics_process(delta):
	
	
	velocity = move_and_slide(velocity)
	
	var move_input = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	var corriendo = Input.is_action_pressed("dashCorrer")
	
	if Input.is_action_just_pressed("dashCorrer"):
		SPEED = 300
		if dash_ready:
			dash = true
			dash_ready = false
			$Timer2.start()
			tiempo_dash.value = 0
	tiempo_dash.value = $Timer.wait_time - $Timer.time_left
		
		
	if Input.is_action_just_released("dashCorrer"):
		SPEED = 200
	
	
	if move_input.length() != 0:
		direction = move_input
		
		if direction.x == 1 and direction.y == -1:
			maletin.rotation_degrees = -45
		elif direction.x == 0 and direction.y == -1:
			maletin.rotation_degrees = -90
	
		elif direction.x == -1 and direction.y == -1:
			maletin.rotation_degrees = -135
		elif direction.x == -1 and direction.y == 0:
			maletin.rotation_degrees = -180
	
		elif direction.x == -1 and direction.y == 1:
			maletin.rotation_degrees = -225
		elif direction.x == 0 and direction.y == 1:
			maletin.rotation_degrees = -270
		
		elif direction.x == 1 and direction.y == 1:
			maletin.rotation_degrees = -315
		elif direction.x == 1 and direction.y == 0:
			maletin.rotation_degrees = 0
	
	if dash:
		velocity = velocity.move_toward(move_input.normalized() * SPEED *2.5, ACCELERATION)
	else:	
		velocity = velocity.move_toward(move_input.normalized() * SPEED , ACCELERATION)
	if velocity.length() > 10:
		playback.travel("walk")
		animTree.set("parameters/Idle/blend_position", direction)
		animTree.set("parameters/walk/blend_position", direction)
	else:
		playback.travel("Idle")
		

func take_damage(damage):
	print(damage)
	HEALTH -= damage
	is_dead()

#Funcion para ganar vida
func gain_health(health):
	print("vida anterior:",HEALTH)
	HEALTH+=health
	print("vida nueva:", HEALTH)
	

func is_dead():
	if HEALTH <= 0:
		queue_free()
		

func _on_Timer_timeout():
	print("ready")
	dash_ready = true


func _on_Timer2_timeout():
	dash = false
	$Timer.start()
