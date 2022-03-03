extends GridContainer

var invintory = preload("res://Items/Invintory.tres")


# Called when the node enters the scene tree for the first time.
func _ready():
	invintory.connect("items_changed", self, "_on_items_changed")
	update_invintory_display()
	pass # Replace with function body.

func update_invintory_display():
	for item_index in invintory.items.size():
		update_invintory_slot_display(item_index)

func update_invintory_slot_display(item_index):
	var invintory_slot_display = get_child(item_index)
	var item = invintory.items[item_index]
	invintory_slot_display.display_item(item)

func _on_items_changed(indexes):
	for item_index in indexes:
		update_invintory_slot_display(item_index)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
