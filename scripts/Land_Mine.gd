extends Area2D

var timer
export (int) var duration = 2
var menu_index
export (int) var max_health = 500
var already_explosed = false


# Called when the node enters the scene tree for the first time.
func _ready():
	collision_layer = 0b10
	collision_mask = 0
	connect("area_entered", self, "_on_hit")
	$"Init".play()

	
func endAnimation():
	queue_free()
	
func endSound():
	print_debug("stop sound")
	$"Sound".playing = false	
	

func _on_hit(other):
	if other.has_method("take_damage"):
		if !already_explosed:
			$"ExplosionShape".set_deferred("disabled", false)
			already_explosed = true
			$"Sprite2".hide()
			$"CollisionShape2D".set_deferred("disabled", true)
			
			$"Sound".play()
			#$"Sound".connect("finished", self, "endSound")
			
			$"AnimatedSprite".show()
			$"AnimatedSprite".play()
			$"AnimatedSprite".connect("animation_finished", self, "endAnimation")
			other.take_damage(500)	
		else:
			other.take_damage(500)		

			
