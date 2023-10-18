class_name Pathfinding
extends Node

const DIRECTIONS = [
	Vector2(0, 1),
	Vector2(0, -1),
	Vector2(-1, 0),
	Vector2(1, 0),
	Vector2(1, 1),
	Vector2(-1, 1),
	Vector2(1, -1),
	Vector2(-1, -1),
]

var aStar = AStar2D.new()

@onready var main = get_tree().root.get_node("Main")
@onready var grid: Grid = main.get_node("World/Grid")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func initialize():
	add_points()
	connect_all_points()
	

func get_point_path(point_a: Vector2, point_b: Vector2):
	var a_id = get_point_id(point_a)
	var b_id = get_point_id(point_b)
	var point_path = aStar.get_point_path(a_id, b_id)
	return _unpack_vector2_array(point_path)
	
	
func connect_point(point: Vector2):
	var point_id = get_point_id(point)
	for direction in DIRECTIONS:
		var neighbor = point + direction
		var neighbor_id = get_point_id(neighbor)
		
		if !grid.grid.has(neighbor):
			continue
		if grid.grid[neighbor].navigable != true:
			continue
		if grid.grid[point].navigable != true:
			continue
			
		aStar.connect_points(point_id, neighbor_id)

# TODO: Connections are still made between navigable to non-navigable but not
# non-navigable to non-navigable, make them both not have connections.
func disconnect_point(point: Vector2):
	var point_id = get_point_id(point)
	for direction in DIRECTIONS:
		var neighbor = point + direction
		var neighbor_id = get_point_id(neighbor)
		aStar.disconnect_points(point_id, neighbor_id)
		
		
func reconnect_point(point: Vector2):
	disconnect_point(point)
	connect_point(point)
	
func connect_all_points():
	for point in grid.grid:
		connect_point(point)
		grid.grid[point].nav_changed.connect(reconnect_point)
		grid.grid[point].cell_changed.connect(reconnect_point)
		

func add_points():
	var cur_id = 0
	for point in grid.grid:
		aStar.add_point(cur_id, grid.grid_to_world(point))
		cur_id += 1
		
func get_point_id(grid_point: Vector2) -> int:
	return aStar.get_closest_point(grid.grid_to_world(grid_point))
	

func get_world_id(world_point: Vector2) -> int:
	return aStar.get_closest_point(world_point)
	

func get_id_world_pos(_id: int) -> Vector2:
	return aStar.get_point_position(_id)
	

func get_id_grid_pos(_id: int) -> Vector2:
	var world_pos = get_id_world_pos(_id)
	return grid.world_to_grid(world_pos)
	
func _unpack_vector2_array(packed_array: PackedVector2Array) -> Array[Vector2]:
	var vector2_array: Array[Vector2] = []
	for vector in packed_array:
		vector2_array.append(vector as Vector2)
	
	return vector2_array
	
	

