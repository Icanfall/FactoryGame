extends Area2D

var timer;
var res;
var first;
var obj_pos;
var t_map = null;

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
# warning-ignore:return_value_discarded
	connect("body_entered", self, "body_enter")
	pass

func body_enter(body):
	print("POG: "+str(body))
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
	if res == null or not can_gen():
		return
	var obj = res.instance()
	obj.position = obj_pos
	get_tree().get_root().get_child(0).add_child(obj)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not first:
		var Sibs = get_parent().get_children()
		for n in Sibs:
			if n is TileMap:
				t_map = n;
				break;
		if t_map != null:
			var index = t_map.get_cellv(position/t_map.cell_size);
			if index != -1:
				res = load("res://Scenes/" + t_map.Resources[index] + ".tscn")
	first = true;
