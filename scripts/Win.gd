extends MarginContainer


onready var credits = $PanelContainer/VBoxContainer/credits
onready var main_menu3 = $PanelContainer/VBoxContainer/main_menu3

func _ready():
	credits.connect("pressed",self, "_on_credits_pressed")
	main_menu3.connect("pressed",self, "_on_main_menu3_pressed")



func _on_credits_pressed():
	get_tree().change_scene("res://scenes/Credits.tscn")
	visible=false 


func  _on_main_menu3_pressed(): 
	get_tree().change_scene("res://scenes/Menu.tscn")
	visible=false
