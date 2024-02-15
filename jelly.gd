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

var ouch1: AudioStream = preload("res://ouch1.wav")
var ouch2: AudioStream = preload("res://ouch2.wav")
var ouch3: AudioStream = preload("res://ouch3.wav")
var yay: AudioStream = preload("res://yay.wav")
var yeah: AudioStream = preload("res://yeah.wav")
var yippie: AudioStream = preload("res://yippie.wav")

var ouchies = [ouch1, ouch2, ouch3]
var yays = [yay, yeah, yippie]

var random = RandomNumberGenerator.new()

var hoverStrengthX = 0.2
var hoverStrengthY = 0.3
var lemniscateTimeCounter = 0
var lemniscateTimeCounterRate = 0.04
var hoverVector = Vector2()

var finalDirection = Vector3()

func _ready():
	randomize()
	pass

func _physics_process(delta):
	# rotation handling
	curOrientation = get_global_rotation_degrees()
	tarOrientation = curOrientation.lerp(dirToRot[directionString], rotation_speed)
	set_global_rotation_degrees(tarOrientation)
	
	# hover in place
	lemniscateTimeCounter = lemniscateTimeCounter + lemniscateTimeCounterRate
	hoverVector = Vector2((cos(lemniscateTimeCounter)*hoverStrengthX), (sin(2*lemniscateTimeCounter)/2)*hoverStrengthY)
	$Armature/Skeleton3D.position = Vector3(hoverVector.x, hoverVector.y, 0.0)
	# calculate direction using hover
	#if direction == Vector3(0, 0, 0):		# idle
		#finalDirection = (direction + Vector3(hoverVector.x, hoverVector.y, 0)) * SPEED
	#elif direction == Vector3(0, 0, -1):	# up
		#finalDirection = (direction + Vector3(hoverVector.x, hoverVector.y, 0)) * SPEED
	#elif direction == Vector3(0, 0, 1):		# down
		#finalDirection = (direction + Vector3(-hoverVector.x, hoverVector.y, 0)) * SPEED
	#elif direction == Vector3(1, 0, 0):		# right
		#finalDirection = (direction + Vector3(0, hoverVector.y, hoverVector.x)) * SPEED
	#elif direction == Vector3(-1, 0, 0):	# left
		#finalDirection = (direction + Vector3(0, hoverVector.y, -hoverVector.x)) * SPEED
	
	# apply translation
	set_velocity(direction * SPEED)
	move_and_slide()
	
	# collision validation
	if is_on_wall():
		if get_wall_normal() + direction == Vector3(0,0,0):
			$Boca.set_stream(ouchies[random.randi_range(0,2)])
			$Boca.play()
			$Label3D.text = 'bonk'
			$Timer.start()
			direction = Vector3(0, 0, 0)
			wall_hit.emit()

func _on_stack_move_in_direction(direct):
	direction = dirToVec[direct]
	directionString = direct

func _on_timer_timeout():
	$Label3D.text = ''

func _on_meta_winning():
	$Boca.set_stream(yays[random.randi_range(0,2)])
	$Boca.play()
	$Label3D.text = 'yay'
