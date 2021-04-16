extends Area2D
class_name Healer

export (int) var radius = 200
export (int) var heal = 10
export (float) var attack_speed = 1
export (PackedScene) var projectile

var target
var parent

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print_debug("ok heal")
	var shape = CircleShape2D.new()
	shape.radius = radius
	parent = get_node("..")
	var timer = Timer.new()
	add_child(timer)
	timer.start(1 / attack_speed)
	timer.connect("timeout", self, "heal")
	#pass # Replace with function body.

func isHealer():
	return

func heal():
	print_debug("heal1")
	if get_node("/root/Main").state != "playing": return
	if target && !overlaps_area(target):
		print_debug("heal2")
		target = null
	if !target:
		print_debug("heal3")
		var overlapping = get_overlapping_areas()
		for obj in overlapping:
			print_debug("list")
			print_debug(obj)
			if obj.has_method("isHealer"): 
				continue
			else:
				print_debug("heal")
				print_debug(obj)
				target = obj
				break
	if target:
		print_debug("heal4")
		var bullet = projectile.instance()
		parent.get_node("..").add_child(bullet)
		bullet.collision_layer = 0
		bullet.collision_mask = collision_mask
		bullet.position = parent.position
		bullet.fire((target.position - parent.position).normalized())


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
