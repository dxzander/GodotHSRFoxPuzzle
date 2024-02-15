extends Node3D

var maxRotation = 0.5
var rotationTimer = 0.0
var rotationTimerRate = 0.2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	rotation.z = sin(rotationTimer) * maxRotation
	rotationTimer += rotationTimerRate
