extends KinematicBody2D

export var health = 100
var player = null
var move = Vector2.ZERO
export var SPEED = 100
onready var bala = preload("res://scenes/Bala.tscn")
var look_vec = Vector2.ZERO


func _physics_process(delta):
	move = Vector2.ZERO
	
	if player != null:
		move = position.direction_to(player.position ) * SPEED
	
	move = move.normalized()
	move = move_and_collide(move)

func take_damage(damage):
	print(damage)
	health -= damage
	is_dead()
	
	
func fire():
	var Bala = bala.instance()
	look_vec = player.position - global_position
	look_vec = look_vec.normalized()
	Bala.position = get_global_position() + look_vec * 50
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
