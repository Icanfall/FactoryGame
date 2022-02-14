extends RigidBody2D

var timer;
var res;
var first;
var obj_pos

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.autostart = true
	timer.set_wait_time(3)
	timer.connect("timeout", self, "gen_resource")
	timer.start()
	first = false
	res = null;
	obj_pos = position + Vector2(64*cos(rotation), 64*sin(rotation));
	pass

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == 2:
			queue_free()
	pass

func can_gen()->bool:
	var space = get_world_2d().direct_space_state;
	var result = space.intersect_point(obj_pos, 32, [], 4)
	return result.size() == 0

func gen_resource():
	print("Timeout")
	if res == null or not can_gen():
		return
	var obj = res.instance()
	print("Pop")
	obj.position = obj_pos
	get_tree().get_root().get_child(0).add_child(obj)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var col = get_colliding_bodies()
	if not first:
		for c in col:
			if c.owner.has_meta("type"):
				if c.owner.get_meta("type") == "Base_Resource":
					res = load("res://Scenes/"+c.owner.get_meta("resource")+".tscn");
			first = true;
