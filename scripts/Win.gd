extends MarginContainer


onready var retrywin = $PanelContainer/VBoxContainer/Retrywin  
onready var main_menu3 = $PanelContainer/VBoxContainer/main_menu3

func _ready():
	retrywin.connect("pressed",self, "_on_retrywin_pressed")
	main_menu3.connect("pressed",self, "_on_main_menu3_pressed")



func _on_retry_pressed():
	get_tree().change_scene("res://scenes/Main.tscn")
	visible=false 


func  _on_main_menu3_pressed(): 
	get_tree().change_scene("res://scenes/Menu.tscn")
	visible=false
