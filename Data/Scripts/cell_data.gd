class_name CellData
extends Object

signal cell_changed(pos: Vector2)
signal nav_changed(pos: Vector2)

@export var name: String
@export var texture: Texture

var pos: Vector2

var floor_data: FloorData :
	set(value):
		floor_data = value
		emit_signal("cell_changed", pos)
	get:
		return floor_data

var occupier = null :
	set(value):
		occupier = value
		emit_signal("cell_changed", pos)
	get:
		return occupier

var navigable: bool = true :
	set(value):
		navigable = value
		emit_signal("nav_changed", pos)
	get:
		return navigable
		

func _init(_pos: Vector2):
	pos = _pos
