extends MarginContainer


onready var retry = $PanelContainer/VBoxContainer/Retry  
onready var main_menu2 = $PanelContainer/VBoxContainer/main_menu2
var current = ""

func _ready():
	retry.connect("pressed",self, "_on_retry_pressed")
	main_menu2.connect("pressed",self, "_on_main_menu2_pressed")
	current = GlobalVariables.current_level



func _on_retry_pressed():
	get_tree().change_scene("res://scenes/"+ current +".tscn")
	visible=false 


func  _on_main_menu2_pressed(): 
	get_tree().change_scene("res://scenes/Menu.tscn")
	visible=false
