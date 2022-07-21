extends MarginContainer

onready var play=$Panel/VBoxContainer/play
onready var exit=$Panel/VBoxContainer/exit
onready var credits=$Panel/VBoxContainer/credits


# Called when the node enters the scene tree for the first time.
func _ready():
	play.connect("pressed",self,"_on_play_pressed")
	exit.connect("pressed",self,"_on_exit_pressed")
	

func _on_play_pressed():
	get_tree().change_scene("res://scenes/Main.tscn")
	

func _on_exit_pressed():  #esta func no recibe argumento 
	get_tree().quit()    #salida 
	
