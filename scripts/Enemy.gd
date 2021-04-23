extends Area2D
class_name Enemy

export (float) var speed = 1
export (int) var max_health = 100
export (float) var hitpoints = 20
export (String) var dijkstra
export (int) var reward = 30
var destination
var world

func _process(delta):
	if !dijkstra:
		print_debug("no dijkstra map assigned!")
		return
	z_index = position.y
	if get_node("/root/Main").state != "playing": return
	if world.dijkstra.has(dijkstra):
		var distance = 0
		if destination:
			distance = position.distance_to(destination)
		var tile_map = world.tile_map
		var tile_pos = tile_map.world_to_map(position)
		var move_amount = delta * speed / world.get_cost(tile_pos)
		if (distance < move_amount):
			destination = tile_map.map_to_world(world.dijkstra[dijkstra].get_next(tile_pos))
		position = position.move_toward(destination, move_amount)
		
func take_damage(amount):
	print("damage amount : ")
	print(amount)
	print("pv avant : ")
	print(hitpoints)
	hitpoints -= amount
	print(" ... pv après :")
	print(hitpoints)
	$HealthDisplay.update_healthbar(hitpoints)
	if (hitpoints <= 0):
		queue_free()
		var main = get_node("/root/Main")
		# on donne la récompense au joueur pour avoir tué un ennemi
		main.money += reward		
		
func take_heal(amount):
	print("heal aumount : ")
	print(amount)
	print("pv avant : ")
	print(hitpoints)
	print(" ... pv après :")
	print(hitpoints + amount)
	if (amount + hitpoints) > 100:
		print_debug("déjà full life")
	else:
		hitpoints = hitpoints + amount
		$HealthDisplay.update_healthbar(hitpoints)
		
func _exit_tree():
	world.remove_enemy(self)
