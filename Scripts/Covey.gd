extends Area2D


func get_intersecting()->bool:
	print(get_overlapping_areas());
	return get_overlapping_areas().size() != 0;


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
