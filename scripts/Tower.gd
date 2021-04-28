extends TileMapEntity
class_name Tower

var timer
export (int) var duration = 2
var menu_index
export (int) var max_health = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	collision_layer = 0b10
	collision_mask = 0
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	#timer.connect("timeout", self, "_on_timer")
	#timer.start(duration)
	connect("area_entered", self, "_on_hit")
	
func _on_timer():
	queue_free()
	
func _on_hit(other):
	print_debug("boum ?")
	if other.has_method("take_damage"):
		$"AnimatedSprite".show()
		$"AnimatedSprite".play()
		other.take_damage(500)
		$"Sprite2".hide()
		timer.connect("timeout", self, "_on_timer")
		timer.start(duration)


