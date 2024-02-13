extends Node3D

var level_data
var obstucalos = preload('res://obstucalos.tscn')
var obstucalo_dimension = 2.5
var cam_def = Vector3(0, 13, 3)
var cam_pos_values = [Vector3(0, 14, 4), Vector3(0, 15, 5), Vector3(0, 16, 6)]
var player_initial_position = Vector3(0, 0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	level_data = load_file('res://level0.txt')
	player_initial_position = process_level_data(level_data)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_file(file_name):
	var file = FileAccess.open(file_name, FileAccess.READ)
	var content = []
	while !file.eof_reached():
		content.append(file.get_line())
	content.pop_back()
	return content

func process_level_data(level_data):
	var height = len(level_data)
	var width = len(level_data[0])
	var index = Vector2(0, 0)
	var jelly_pos
	for line in level_data:
		for cell in line:
			if cell == '1':
				var instance = obstucalos.instantiate()
				instance.position = grid_to_real(index, width, height)
				add_child(instance)
			elif cell == '0':
				$Meta.position = grid_to_real(index, width, height)
			elif cell == '2':
				jelly_pos = grid_to_real(index, width, height)
				$jelly.position = jelly_pos
			elif cell == ' ':
				pass
			else:
				print('non valid data found. skipping')
			index.x += 1
		index.y += 1
		index.x = 0
	return jelly_pos

func grid_to_real(index, width, height):
	var offsetx = width / 2
	var offsetz = height / 2
	var offsety = obstucalo_dimension * 0.5
	var virtualx = index.x + 0.5 - offsetx
	var virtualz = index.y + 0.5 - offsetx
	var realx = virtualx * obstucalo_dimension
	var realz = virtualz * obstucalo_dimension
	var real_pos = Vector3(realx, offsety, realz)
	return real_pos

func _on_reiniciar_pressed():
	$jelly.position = player_initial_position
	$Interfaz/Juego/Controles/Stack.clear_stack()
	$Interfaz/Juego/Controles/Stack.enable_buttons()
	$Interfaz/Ending/AnimationPlayer.play("fade out")
	$Interfaz/Ending.reset_disabled = true
	$Interfaz/Juego/Controles/Acciones/Left/Run.set_disabled(false)
