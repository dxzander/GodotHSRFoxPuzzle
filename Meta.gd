extends Area3D

signal winning
signal lost

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if len(get_overlapping_bodies()) > 0:
		if has_jelly_arrived():
			winning.emit()

func _on_stack_ran_out_of_stack():
	if !has_jelly_arrived():
		lost.emit()

func has_jelly_arrived():
	var contenido = get_overlapping_bodies()
	var names = []
	for n in contenido:
		names.append(n.name)
	var is_jelly = true if 'jelly' in names else false
	return is_jelly
