extends KinematicBody2D

export var health = 50
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
onready var health_bar = $ProgressBar

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
		$Attack.visible = false
	else: 
		playback.travel("idle")
		$Idle.visible = true
		$Walk.visible = false
		$Attack.visible = false
		
	move = move.normalized()
	move_and_collide(move)
	
	

func take_damage(damage):
	health -= damage
	health_bar.value = health * 100 / 50
	is_dead()
	
	
func fire():
	var Bala = bala.instance()
	#playback.travel("AttackEnemy")
	#$Idle.visible = false
	#$Attack.visible = true
	#$Walk.visible = false
	
	
	
	look_vec = player.position - global_position
	look_vec = look_vec.normalized()
	Bala.position = get_global_position() + look_vec * 90
	Bala.rotation = look_vec.angle()
	Bala.player = player
	get_parent().add_child(Bala)
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
