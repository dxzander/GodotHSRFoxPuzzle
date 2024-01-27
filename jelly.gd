extends CharacterBody3D


const SPEED = 3.0
var direction = Vector3(0, 0, 0)
var directionString = 'up'
var curOrientation = Vector3(0, 0, 0)
var tarOrientation = Vector3(0, 0, 0)
var rotation_speed = 0.1
var inclination = Vector3(-30, 0, 0)
var dirToVec = {
				'up' = Vector3(0, 0, -1), #y = 0
				'down' = Vector3(0, 0, 1), #y = 180
				'right' = Vector3(1, 0, 0), #y = 270
				'left' = Vector3(-1, 0, 0) #y = 90
				}
var dirToRot = {
				'up' = Vector3(-50, 0, 0), #y = 0
				'down' = Vector3(50, 180, 0), #y = 180
				'right' = Vector3(-40, -90, 50), #y = 270
				'left' = Vector3(-40, 90, -50) #y = 90
				}

signal wall_hit

func _physics_process(delta):
	velocity = direction * SPEED
	move_and_slide()
	curOrientation = get_global_rotation_degrees()
	tarOrientation = curOrientation.lerp(dirToRot[directionString], rotation_speed)
	set_global_rotation_degrees(tarOrientation)
	if is_on_wall():
		if get_wall_normal() + direction == Vector3(0,0,0):
			$Label3D.text = 'bonk'
			$Timer.start()
			direction = Vector3(0, 0, 0)
			wall_hit.emit()

func _on_stack_move_in_direction(direct):
	direction = dirToVec[direct]
	directionString = direct
	pass # Replace with function body.


func _on_timer_timeout():
	$Label3D.text = ''
	pass # Replace with function body.


func _on_meta_winning():
	$Label3D.text = 'yay'
	pass # Replace with function body.
