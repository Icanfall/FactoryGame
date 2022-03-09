extends CenterContainer

onready var itemTextureRect = $TextureRect
var invintory = preload("res://Items/Invintory.tres")

func display_item(item):
	if item is Item:
		itemTextureRect.texture = item.texture
	else:
		itemTextureRect.texture = load("res://Sprites/B_Rec.png")

func get_drag_data(_position):
	var item_index = get_index()
	var item = invintory.remove_item(item_index)
	if item is Item:
		var data = {}
		data.item = item
		data.item_index = item_index
		var dragPreview = TextureRect.new()
		dragPreview.texture = item.texture
		set_drag_preview(dragPreview)
		return data

func can_drop_data(_position, data):
	return data is Dictionary and data.has("item")

func drop_data(_position, data):
	var my_item_index = get_index()
	var my_item = invintory.items[my_item_index]
	invintory.swap_items(my_item_index, data.item_index)
	invintory.set_item(my_item_index, data.item)
