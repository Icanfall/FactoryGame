extends CenterContainer

onready var itemTextureRect = $TextureRect

func display_item(item):
	if item is Item:
		itemTextureRect.texture = item.texture
	else:
		itemTextureRect.texture = load("res://Sprites/B_Rec.png")
