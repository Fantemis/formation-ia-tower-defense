extends Area2D
class_name TileMapEntity

# Declare member variables here. Examples:
export (int) var width = 1
export (int) var height = 1
export (float) var hitpoints = 50
export (String) var tag

func _ready():
	var collision_shape = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	var tile_map = get_node("../TileMap")
	var pixel_width = width * tile_map.cell_size.x
	var pixel_height = height * tile_map.cell_size.y
	shape.extents = Vector2(pixel_width / 2, pixel_height / 2)
	collision_shape.set_shape(shape)
	add_child(collision_shape)
	collision_shape.position = Vector2(pixel_width / 2, pixel_height / 2)
	
func take_damage(amount):
	hitpoints -= amount
	$HealthDisplay.update_healthbar(hitpoints)
	if (hitpoints <= 0):
		get_node("..").remove_entity(self)
