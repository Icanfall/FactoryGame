extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_inputs():
	var vel = Vector2(0,0)
	if Input.is_action_pressed("Up"):
		vel.y -= 1
	if Input.is_action_pressed("Down"):
		vel.y += 1
	if Input.is_action_pressed("Left"):
		vel.x -= 1
	if Input.is_action_pressed("Right"):
		vel.x += 1
	return 100*vel.normalized()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var vel = get_inputs()
	if vel != Vector2(0,0):
		get_parent()._generate_world()
# warning-ignore:return_value_discarded
	move_and_slide(vel)
