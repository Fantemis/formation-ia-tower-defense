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
	
	#collision_layer = 0b10
	#collision_mask = 0
	
	print_debug("ok heal")
	parent = get_node("..")
	var collision_shape = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	shape.radius = radius
	collision_shape.set_shape(shape)
	add_child(collision_shape)
	
	
	var timer = Timer.new()
	add_child(timer)
	timer.start(1 / attack_speed)
	timer.connect("timeout", self, "heal")
	#pass # Replace with function body.

func isHealer():
	return

func heal():
	#print_debug("heal1")
	if get_node("/root/Main").state != "playing": return
	if target && !overlaps_area(target):
		#print_debug("heal2")
		target = null
	if !target:
		#print_debug("heal3")
		var overlapping = get_overlapping_areas()
		var less_life = 999999999
		var ennemi_to_heal
		for obj in overlapping:
			#print_debug("list")
			#print_debug(obj)
			#print_debug(obj.get_node("Shooter"))
			if obj == parent:
			#if obj.get_node("Shooter").has_method("isHealer"):
				continue
			else:
				if obj.hitpoints < less_life:
					less_life = obj.hitpoints
					ennemi_to_heal = obj
				#print_debug("heal")
				#print_debug(obj)
				#target = obj
				#break
		target = ennemi_to_heal
	if target:
		#print_debug("heal4")
		var bullet = projectile.instance()
		parent.get_node("..").add_child(bullet)
		bullet.collision_layer = 0
		bullet.collision_mask = collision_mask
		bullet.position = parent.position
		bullet.fire((target.position - parent.position).normalized())


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
