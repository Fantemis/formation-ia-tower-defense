extends Node2D

var bar_red = preload("res://sprites/bar_orange.png")
var bar_green = preload("res://sprites/bar_green.png")
var bar_yellow = preload("res://sprites/bar_yellow.png")

onready var healthbar = $HealthBar

func _ready():
	hide()
	if get_parent() and get_parent().get("max_health"):
		healthbar.max_value = get_parent().max_health
		update_healthbar(get_parent().max_health)
		print_debug("max heal recupere")
		print_debug("value : ", healthbar.max_value)
	
func _process(delta):
	global_rotation = 0
	
func update_healthbar(value):
	healthbar.texture_progress = bar_green
	if value < healthbar.max_value * 0.7:
		healthbar.texture_progress = bar_yellow
	if value < healthbar.max_value * 0.35:
		healthbar.texture_progress = bar_red
	if value < healthbar.max_value:
		show()
	healthbar.value = value
