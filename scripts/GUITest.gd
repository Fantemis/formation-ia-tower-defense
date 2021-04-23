extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var number_label = $Bars/LifeBar/Count/Background/Number
onready var bar = $Bars/LifeBar/TextureProgress
onready var tween = $Tween

var animated_health = 0

# Called when the node enters the scene tree for the first time.
func _ready():
		var player_max_health = $"../Enemies/Test".max_health
	ar.max_value = player_max_health
	update_health(player_max_health)

func _on_Player_health_changed(player_health):
	update_health(player_health)


func update_health(new_value):
	tween.interpolate_property(self, "animated_health", animated_health, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()


func _process(delta):
	var round_value = round(animated_health)
	number_label.text = str(round_value)
	bar.value = round_value

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
