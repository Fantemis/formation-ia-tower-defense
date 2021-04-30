extends Node2D
class_name Spawner

export var waves = []
export (float) var interval = 5
var wave_index = 0
var spawn_index = 0
var wave_timer: Timer
var spawn_timer: Timer
var world: Node
var played = 0

func _ready():
	if !waves.size():
		print_debug("Spawner has no waves!")
		return
	wave_timer = Timer.new()
	wave_timer.one_shot = true
	wave_timer.connect("timeout", self, "_on_wave_timer")
	add_child(wave_timer)
	spawn_timer = Timer.new()
	spawn_timer.connect("timeout", self, "_on_spawn_timer")
	add_child(spawn_timer)
	_start_wave()
	world = get_node("..")
	world.spawners.append(self)
	get_node("/root/Main").connect("state_change", self, "_on_game_state")
	
func _start_wave():
	spawn_timer.stop()
	if wave_index >= waves.size():
		print_debug("All waves sent")
		return
	wave_timer.start(waves[wave_index].wait)
	print_debug("Wave %s starting in %s seconds" % [wave_index + 1, waves[wave_index].wait])
	
func _on_wave_timer():
	spawn_timer.start(interval)
	print_debug("Wave %s!" % (wave_index + 1))
	
func playSound():
	$"BossSound".stop()
	
func _on_spawn_timer():
	var enemy = waves[wave_index].enemies[spawn_index].instance()
	if enemy.hitpoints == 666:
		$"BossSound".play()
		var timer = Timer.new()
		timer.one_shot = true
		timer.connect("timeout", self, "playSound")
		timer.start(5)
	world.add_enemy(enemy)
	enemy.position = position
	enemy.z_index = position.y
	spawn_index += 1
	if spawn_index >= waves[wave_index].enemies.size():
		spawn_index = 0
		wave_index += 1
		_start_wave()
		
func _on_game_state(state):
	if state != "playing":
		wave_timer.stop()
		spawn_timer.stop()
	

