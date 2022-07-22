extends Node2D

export var enemy_count = 1

onready var player = $Player
onready var boss = $KinematicBody2D
# Called when the node enters the scene tree for the first time.

func enemy_die():
	enemy_count -= 1
	if enemy_count <= 0 :
		$Area2D.start()

func _ready():
	$Area2D.next_scene = "Credits"
	player.connect("update_health_player",$Control,"update_health")
	boss.connect("update_health_boss",$ProgressBar,"update_health")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
