extends Area2D

var item_vel;
var col_bodies;

func _ready():
	item_vel = Vector2(10*cos(rotation), 10*sin(rotation));
	col_bodies = [];
	# warning-ignore:return_value_discarded
	connect("body_entered", self, "body_enter")
	# warning-ignore:return_value_discarded
	connect("body_exited", self, "body_exit")

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == 2:
			queue_free()
	pass
	
func body_enter(body):
	if body.get_collision_layer_bit(2):
		col_bodies.append(body)
	pass

func body_exit(body):
	if body in col_bodies:
		col_bodies.remove(col_bodies.find(body))
	pass 
	
func _process(_delta):
	for b in col_bodies:
		b.move_and_slide(item_vel);
