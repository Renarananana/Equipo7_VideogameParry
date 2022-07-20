extends KinematicBody2D

onready var animTree = $AnimationTree
onready var animPlayer = $AnimationPlayer
onready var playback = animTree.get("parameters/playback")
onready var spawn = $spawn
onready var timer_attack1 = $consecutive_attacks
export var attacking = false
export var speed = 100
export var health = 400
var objective = Vector2()
var direction = Vector2()
var velocity = Vector2()
var acceleration = 100
var second_fase = false
signal update_health_boss

var player = null
var look_vec = Vector2()
onready var bala1 = preload("res://scenes/boss_bullet.tscn")
onready var bala2 = preload("res://scenes/boss_bullet2.tscn")

var c = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	animTree.active = true


func go(delta,aim):
	if player == null:
		return
	objective = player.get_global_position() + aim
	direction = objective - get_global_position()
	velocity = velocity.move_toward(direction.normalized() * speed, acceleration)
	
	
func _physics_process(delta):
	velocity = move_and_slide(velocity)
	if not attacking:
		if c == 0:
			go(delta, Vector2(0, -500))
		elif c == 1:
			go(delta, Vector2(500, 0))
		else:
			go(delta, Vector2(-500, 0))
	else:
		velocity = Vector2.ZERO
		
		
func _process(delta):
	if not attacking:
		if health < 200 and not second_fase:
			attacking = true
			playback.travel("change_fase")
			second_fase = true
		else:
			playback.travel("Idle")
	
		


func _on_Area2D_body_entered(body):
	player = body
	
func attack():
	print(c)
	c += 1
	if c == 3:
		c = 0
	attacking = true
	playback.travel("Attack")
	timer_attack1.start()
	
func spawn_fire():
	var Bala = null
	if second_fase:
		Bala = bala2.instance()
	else:
		Bala = bala1.instance()
		Bala.shooter = self
	
	look_vec = player.get_global_position()  - spawn.get_global_position()
	look_vec = look_vec.normalized()

	Bala.position = spawn.get_global_position()
	Bala.rotation = look_vec.angle()
	Bala.objective = player
	
	get_parent().add_child(Bala)
	

	
	
func take_damage(damage):
	health -= damage
	if health <= 0:
		attacking = true
		get_parent().enemy_die()
		playback.travel("die")
		emit_signal("update_health_boss", health)
		return
	else:
		playback.travel("take_damage")
		emit_signal("update_health_boss", health)


func _on_Timer_timeout():
	if player == null or attacking == true:
		return
	attack()
	

