extends TileMap

var showing = false;
var belt = load("res://Scenes/Covey.tscn")
var belt_phys = load("res://Scenes/Convey_Phys.tscn")
var act_obj = null
var sz = get_cell_size()

var Resources = {
	0:"Red_Rec",
	1:"NULL",
	2:"B_Rec",
	3:"Yellow_Rec"
};

func grid_lock(pos):
	pos.x = floor(pos.x/sz.x)*sz.x+sz.x/2
	pos.y = floor(pos.y/sz.y)*sz.y+sz.y/2
	return pos
	
func check_empty(pos)->bool:
	return not act_obj.get_intersecting();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("Object_Interact"):
		showing = !showing
		if(is_instance_valid(act_obj)):
			act_obj.queue_free()
	if Input.is_action_just_pressed("rotate"):
		if(is_instance_valid(act_obj)):
			act_obj.rotation_degrees += 90
	if(showing):
		var pos = get_viewport().get_mouse_position() + $"../Camera_Holder".position
		pos = grid_lock(pos)
		if(!is_instance_valid(act_obj)):
			act_obj = belt.instance()
			act_obj.modulate.a = 0.5
			add_child(act_obj)
		act_obj.position = pos
	if Input.is_action_just_pressed("Mouse_Left") and showing:
		var pos = get_viewport().get_mouse_position() + $"../Camera_Holder".position
		if check_empty(pos):
			var fin = belt_phys.instance()
			fin.position = pos
			fin.rotation = act_obj.rotation
			get_parent().add_child(fin)
	
