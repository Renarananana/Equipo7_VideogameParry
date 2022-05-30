extends KinematicBody2D

export var health = 100
var player = null
var move = Vector2.ZERO
var SPEED = 200
onready var bala = preload("res://scenes/Bala.tscn")
var look_vec = Vector2.ZERO
var look_vec2 = Vector2.ZERO
var look_vec3 = Vector2.ZERO
var random = RandomNumberGenerator.new()
var c = 0
onready var animTree = $AnimationTree
onready var animPlayer = $AnimationPlayer
onready var playback = animTree.get("parameters/playback")

func _ready():
	animTree.active=true
	
	random.randomize()

func _physics_process(delta):
	if player != null:
		move = position.direction_to(player.position ) * SPEED
	else:
		move = Vector2.ZERO
	if move.length() > 10 : 
		playback.travel("run")
		$Idle.visible = false
		$Walk.visible = true
	else: 
		playback.travel("idle")
		$Idle.visible = true
		$Walk.visible = false
		
	move = move.normalized()
	move_and_collide(move)
	
	

func take_damage(damage):
	health -= damage
	is_dead()
	
	
func fire():
	var Bala = bala.instance()
	look_vec = player.position - global_position
	look_vec = look_vec.normalized()
	Bala.position = get_global_position() + look_vec * 90
	Bala.rotation = look_vec.angle()
	Bala.player = player
	get_parent().add_child(Bala)
	$Timer.set_wait_time(1)
	
	
func fire_machinegun():
	var Bala = bala.instance()
	
	
	look_vec = player.position - global_position
	look_vec = look_vec.normalized()
	Bala.position = get_global_position() + look_vec * 90
	Bala.rotation = look_vec.angle() + random.randf_range(-PI/18 , PI/18)
	Bala.player = player
	get_parent().add_child(Bala)
	if c == 10:
		c = 0
		$Timer.set_wait_time(3)
	else:
		c += 1
		$Timer.set_wait_time(.1)
	
	

func fire_shotgun():
	var Bala1 = bala.instance()
	var Bala2 = bala.instance()
	var Bala3 = bala.instance()
	
	look_vec = player.position - global_position
	look_vec = look_vec.normalized()
	
	Bala1.position = get_global_position() + look_vec * 90
	Bala1.player = player
	Bala1.rotation = look_vec.angle()
	get_parent().add_child(Bala1)
	
	Bala2.position = get_global_position() + look_vec * 90
	Bala2.rotation = look_vec.angle() + PI/6
	Bala2.player = player
	
	get_parent().add_child(Bala2)
	
	Bala3.position = get_global_position() + look_vec * 90
	Bala3.player = player
	
	Bala3.rotation = look_vec.angle() - PI/6
	get_parent().add_child(Bala3)
	
	$Timer.set_wait_time(1)
	

func is_dead():
	if health <= 0:
		queue_free()

func _on_Area2D_body_entered(body):
	if body != self:
		player = body



func _on_Timer_timeout():
	if player != null:
		fire()
		
	


func _on_Area2D_body_exited(body):
	player = null
