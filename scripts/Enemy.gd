extends KinematicBody2D

export var health = 100

func take_damage(damage):
	print(damage)
	health -= damage
	is_dead()
	
	

func is_dead():
	if health <= 0:
		queue_free()
		

