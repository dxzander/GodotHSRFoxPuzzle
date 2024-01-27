extends GridContainer

var stack = []
var stackMaxSize = 3
var buttons_enabled = true
var directToFiles = {'up' = 'res://arrow_up_press.png',
					'down' = 'res://arrow_down_press.png',
					'left' = 'res://arrow_left_press.png',
					'right' = 'res://arrow_right_press.png',
					'idle' = 'res://idle.png'
					}

signal move_in_direction(direct)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_to_stack(direct):
	if stack.size() < stackMaxSize:
		stack.push_back(direct)
		var lastPos = stack.size()-1
		match lastPos:
			0:
				$First.texture = load(directToFiles[direct])
			1:
				$Second.texture = load(directToFiles[direct])
			2:
				$Third.texture = load(directToFiles[direct])
	pass

func _on_up_pressed():
	if buttons_enabled:
		add_to_stack("up")
	pass # Replace with function body.

func _on_down_pressed():
	if buttons_enabled:
		add_to_stack("down")
	pass # Replace with function body.

func _on_left_pressed():
	if buttons_enabled:
		add_to_stack("left")
	pass # Replace with function body.

func _on_right_pressed():
	if buttons_enabled:
		add_to_stack("right")
	pass # Replace with function body.

func _on_clear_pressed():
	if buttons_enabled:
		stack = []
		$First.texture = load(directToFiles['idle'])
		$Second.texture = load(directToFiles['idle'])
		$Third.texture = load(directToFiles['idle'])
	pass # Replace with function body.

func _on_run_pressed():
	buttons_enabled = false
	execute()
	pass # Replace with function body.

func _on_jelly_wall_hit():
	execute()
	pass # Replace with function body.

func execute():
	if stack:
		move_in_direction.emit(stack[0])
		stack.pop_front()
	pass
