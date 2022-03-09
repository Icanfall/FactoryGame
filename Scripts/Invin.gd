extends ColorRect

var invintory = preload("res://Items/Invintory.tres")

func can_drop_data(_position, data):
	return data is Dictionary and data.has("item")

func drop_data(_position, data):
	invintory.set_item(data.item_index, data.item)

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_focus_next"):
		visible = !visible
