extends ColorRect

var reset_disabled = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$GridContainer/Reiniciar.set_disabled(reset_disabled)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_meta_winning():
	play_fade_in()
	$GridContainer/Mensaje.set_text('¡Has hecho la ganación!')

func _on_meta_lost():
	play_fade_in()
	$GridContainer/Mensaje.set_text('¡Has hecho la perdición!')

func play_fade_in():
	var mod = get_modulate()
	if mod.a == 0:
		$AnimationPlayer.play("fade in")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == 'fade in':
		reset_disabled = false
		$GridContainer/Reiniciar.set_disabled(reset_disabled)
	elif anim_name == 'fade out':
		reset_disabled = true
		$GridContainer/Reiniciar.set_disabled(reset_disabled)
