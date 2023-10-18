class_name World
extends Node2D

@export var width = 12
@export var height = 12
@export var cell_size = 128

@onready var grid: Grid = get_node("Grid")
@onready var pathfinding: Pathfinding = get_node("Grid/Pathfinding")

# Called when the node enters the scene tree for the first time.
func _ready():
	grid.set_parameters(width, height, cell_size)
	grid.generate_grid()
	pathfinding.initialize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
