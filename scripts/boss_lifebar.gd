extends ProgressBar


var health_ini = 400

func _ready():
	value = 100

func update_health(health):
	print("health")
	value = health * 100 / health_ini 
