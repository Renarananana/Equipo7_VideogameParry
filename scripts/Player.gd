extends KinematicBody2D

export var SPEED = 200
export var ACCELERATION = 100
var velocity = Vector2()
export var HEALTH = 100
signal update_health_player


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
		velocity = velocity.move_toward(direction.normalized() * SPEED *2.5, ACCELERATION)
	else:	
		velocity = velocity.move_toward(move_input.normalized() * SPEED , ACCELERATION)
	if velocity.length() > 10:
		playback.travel("walk")
		animTree.set("parameters/walk/blend_position", move_input.normalized())
	else:
		playback.travel("Idle")
		animTree.set("parameters/Idle/blend_position", direction.normalized())
		

func update_health(valor):
	HEALTH += valor
	emit_signal("update_health_player", HEALTH)
	

func take_damage(damage):
	update_health(-damage)
	is_dead()

#Funcion para ganar vida
func gain_health(health):
	if HEALTH < 100:
		update_health(health)
	

func is_dead():
	if HEALTH <= 0:
		queue_free()
		get_tree().change_scene("res://scenes/MENU.tscn")
		

func _on_Timer_timeout():
	dash_ready = true


func _on_Timer2_timeout():
	dash = false
	$Timer.start()
