extends KinematicBody2D


export var health = 50
var player = null
var move = Vector2.ZERO
var SPEED = 200
onready var bala = preload("res://scenes/wizard_bullet.tscn")
onready var corazon = preload("res://scenes/PowerUpVida.tscn")
var look_vec = Vector2.ZERO
var look_vec2 = Vector2.ZERO
var look_vec3 = Vector2.ZERO
var random = RandomNumberGenerator.new()
var dead = false
export var attacking = false
var objective = null
onready var animTree = $AnimationTree
onready var animPlayer = $AnimationPlayer
onready var playback = animTree.get("parameters/playback")
onready var health_bar = $ProgressBar
signal enemy_die

func _ready():
	animTree.active=true
	$Timer.start()
	
	random.randomize()



func _physics_process(delta):
	if player != null and not dead and not attacking:
		move = position.direction_to(player.position ) * SPEED
	else:
		move = Vector2.ZERO
	if move.x < 0:
		$pivot.rotation = PI
		$AnimatedSprite.flip_h = true
	elif move.x > 0:
		$pivot.rotation = 0
		$AnimatedSprite.flip_h = false
	
	if not dead and not attacking:
		if move.length() > 10: 
			playback.travel("walk")
		else: 
			playback.travel("Idle")
		
	move = move.normalized()
	move_and_collide(move)
	
func drop_heart():
	if random.randf_range(0 , 1) < .5:
		var Corazon = corazon.instance()
		Corazon.position = position
		get_parent().add_child(Corazon)
	

func take_damage(damage):
	health -= damage
	health_bar.value = health * 100 / 50
	if health <= 0:
		dead = true
		get_parent().enemy_die()
		playback.travel("Death")
	


func fire():
	var Bala = bala.instance()
	
	look_vec = objective.position - global_position
	look_vec = look_vec.normalized()
	Bala.position = get_node("pivot/spawn").get_global_position()
	Bala.rotation = look_vec.angle()
	get_parent().add_child(Bala)
	
	
	

func _on_Area2D_body_entered(body):
	if body != self:
		player = body



func _on_Timer_timeout():
	if player != null and not dead:
		$Timer.start()
		objective = player
		attacking = true
		playback.travel("ataque1")
		
	


func _on_Area2D_body_exited(_body):
	player = null
