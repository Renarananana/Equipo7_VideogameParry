extends Node2D

export var enemy_count = 4


func enemy_die():
	enemy_count -= 1
	if enemy_count <= 0 :
		$Area2D.start()

# Called when the node enters the scene tree for the first time.
func _ready():
	#camara.current = true
	$Area2D.next_scene = "boss_room"
	$Player.connect("update_health_player",$Control,"update_health")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

