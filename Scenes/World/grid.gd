class_name Grid
extends TileMap

signal on_grid_generated

@export var show_debug: bool = false
@export var _floor_datas: Array[Resource] = []
@export var _thresholds: Array[float] = []

var _width: int = 12
var _height: int = 12
var _cell_size: int = 128

var grid: Dictionary = {}
var grid_label_debug: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func set_parameters(width, height, cell_size) -> void:
	_width = width
	_height = height
	_cell_size = cell_size
# TODO: Generate grid cells based on something 
func generate_grid() -> void:
	var noise : FastNoiseLite = FastNoiseLite.new()
	for x in _width:
		for y in _height:
			# Initaite CellData
			grid[Vector2(x, y)] = CellData.new(Vector2(x,y))
			grid[Vector2(x, y)].cell_changed.connect(_update_debug)
			grid[Vector2(x, y)].floor_data = generate_cells(noise.get_noise_2d(x, y), _thresholds, _floor_datas)
				
			refresh_tile(Vector2(x, y))
			
			if show_debug:
				grid[Vector2(x, y)].cell_changed.connect(_notify_cell_change)
				grid[Vector2(x, y)].nav_changed.connect(_notify_nav_change)
				var rect = ReferenceRect.new()
				rect.position = grid_to_world(Vector2(x,y))
				rect.size = Vector2(_cell_size, _cell_size)
				rect.editor_only = false
				get_node("Debug").add_child(rect)
				var label = Label.new()
				label.position = grid_to_world(Vector2(x,y))
				label.text = str(Vector2(x,y)) + " : " + str(grid[Vector2(x, y)].occupier)
				get_node("Debug").add_child(label)
				grid_label_debug[Vector2(x,y)] = label
				
	on_grid_generated.emit()

func generate_cells(noise_value: float, thresholds: Array[float], cells: Array):
	var i: int = 0
	for threshold in thresholds:
		if noise_value < threshold:
			return cells[i]
		i+=1
	return cells[-1]
	
func _update_debug(grid_pos):
	if not grid_label_debug.has(grid_pos):
		return
	grid_label_debug[grid_pos].text = str(grid_pos) + " : " + str(grid[grid_pos].occupier)
	
func _notify_cell_change(pos):
	print_debug("Cell Changed: ", pos)

func _notify_nav_change(pos):
	print_debug("Nav Changed: ", pos)
	
func refresh_tile(grid_pos: Vector2) -> void:
	var data = grid[grid_pos]
	set_cell(0, grid_pos, data.floor_data.id, data.floor_data.coords)
	set_cell(1, grid_pos)

func grid_to_world(grid_pos: Vector2) -> Vector2:
	return grid_pos * _cell_size

func world_to_grid(world_pos: Vector2) -> Vector2:
	return floor(world_pos / _cell_size)
	
func world_to_nearest_grid(world_pos: Vector2) -> Vector2:
	return round(world_pos / _cell_size)
	
func get_cell_center_offset() -> Vector2:
	return Vector2(_cell_size/2, _cell_size/2)
	
func get_cell_data(grid_pos: Vector2) -> CellData:
	if not grid.has(grid_pos):
		return
	return grid[grid_pos]
	
func set_cell_occupier(grid_pos: Vector2, occupier):
	if not grid.has(grid_pos):
		return
	grid[grid_pos].occupier = occupier

func get_cell_occupier(grid_pos: Vector2):
	if not grid.has(grid_pos):
		return
	return grid[grid_pos].occupier
	
func set_cell_navigable(grid_pos: Vector2, navigable: bool):
	if not grid.has(grid_pos):
		return
	grid[grid_pos].navigable = navigable

func get_cell_navigable(grid_pos: Vector2):
	if not grid.has(grid_pos):
		return null
	return grid[grid_pos].navigable

