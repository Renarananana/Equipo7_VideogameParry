extends Control

onready var menu=$VBoxContainer/menu


func _ready():
	menu.connect("pressed",self,"_on_menu_pressed")
	
func _on_menu_pressed():
	get_tree().change_scene("res://scenes/MENU.tscn")

