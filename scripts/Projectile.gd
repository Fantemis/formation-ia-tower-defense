extends Area2D

export (float) var damage = 10
export (float) var heal = 10
export (float) var speed = 10
export (float) var duration = 4
var timer
var velocity

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.connect("timeout", self, "_on_timer")
	timer.start(duration)
	connect("area_entered", self, "_on_hit")
	
func _on_timer():
	queue_free()
	
func _on_hit(other):
	if other.has_method("take_heal"): 
		other.take_heal(heal)
		queue_free()
	if other.has_method("take_damage"):
		other.take_damage(damage)
		queue_free()

func _process(delta):
	if get_node("/root/Main").state != "playing": return
	z_index = position.y
	if velocity:
		position += velocity * delta
		
func fire(direction):
	velocity = direction * speed
