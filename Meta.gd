extends Area3D

var contenido = []

signal winning

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	contenido = get_overlapping_bodies()
	if len(contenido) > 1:
		if contenido[1].name == 'jelly':
			winning.emit()
	pass
