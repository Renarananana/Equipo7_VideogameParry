extends Control

onready var vida = $ProgressBar
var health_ini = 100



func update_health(health):
	vida.value = health * 100 / health_ini 
