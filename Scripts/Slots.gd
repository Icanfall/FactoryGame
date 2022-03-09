extends Panel

var invintory = preload("res://Items/Invintory.tres")

func display_item(item):
	var tRec = TextureRect.new()
	if not get_child_count() == 0:
		for child in get_children():
			child.queue_free()
	if item is Item:
		tRec.texture = item.texture
		add_child(tRec)
	else:
		tRec.texture = load("res://Sprites/B_Rec.png")
		add_child(tRec)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
