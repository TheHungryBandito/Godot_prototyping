class_name ItemDatabase
extends Node2D

@export var item_data_array: Array[ItemData] = []

func get_item_from_name(item_name) -> ItemData:
	for item in item_data_array:
		if item.name == item_name:
			return item
	return null
