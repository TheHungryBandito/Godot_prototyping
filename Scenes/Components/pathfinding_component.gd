class_name PathfindingComponent
extends Node2D

@export var unit : Unit = null
@onready var main = get_tree().root.get_node("Main")
@onready var grid: Grid = main.get_node("World/Grid")
@onready var pathfinding: Pathfinding = grid.get_node("Pathfinding")

var path: Array[Vector2]

func get_pathfinding_path(start: Vector2, target: Vector2):
	# If we have a path then we will start our pathing from where we will be.
	if has_path():
		path = pathfinding.get_point_path(
			grid.world_to_grid(path[0]),
			target
		)
	else:
		path = pathfinding.get_point_path(start, target)
		

func get_next_destination() -> Vector2:
	if has_path():
		return path[0]
	else:
		return unit.pos

func get_end_destination() -> Vector2:
	if has_path():
		return path[len(path)-1]
	else:
		return unit.pos

func clear_path() -> void:
	path.clear()
	

func has_path() -> bool:
	return path.size() > 0
	

func update_path() -> void:
	if has_path():
		if unit.position.distance_to(path[0]) < 5:
			unit.pos = grid.world_to_grid(path[0])
			unit.position = path[0]
			path.pop_front()
		else:
			unit.pos = grid.world_to_grid(unit.position)
			
