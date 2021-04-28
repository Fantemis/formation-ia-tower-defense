extends TileMapEntity
class_name Tower

var menu_index
export (int) var max_health = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	collision_layer = 0b10
	collision_mask = 0
