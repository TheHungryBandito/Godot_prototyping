class_name Unit
extends Node2D

@onready var main = get_tree().root.get_node("Main")
@onready var grid: Grid = main.get_node("World/Grid")
@onready var pathfinding: Pathfinding = grid.get_node("Pathfinding")
@onready var pathfinding_component: PathfindingComponent = get_node("PathfindingComponent")
@onready var movement_component: MovementComponent = get_node("MovementComponent")
@onready var health_component: HealthComponent = get_node("HealthComponent")
@onready var selectable_component: SelectableComponent = get_node("SelectableComponent")
@onready var attack_component: AttackComponent = get_node("AttackComponent")
@onready var inventory_component: InventoryComponent = get_node("InventoryComponent")
@onready var popup_component: PopupComponent = get_node("PopupComponent")
@onready var fire_point: Node2D = get_node("FirePoint")

var data: UnitData = UnitData.new()

var pos: Vector2 :
	get:
		return pos
	set(value):
		if value != pos:
			grid.set_cell_occupier(pos, null)
			grid.set_cell_navigable(pos, true)
		pos = value
		if grid.get_cell_occupier(pos) != self:
			grid.set_cell_occupier(pos, self)
			grid.set_cell_navigable(pos, false)


# Called when the node enters the scene tree for the first time.
func _ready():
	pos = grid.world_to_grid(position)
	data.name = "George"
	data.description = "Old Fool"
	data.stats = "Super Buff"
	
	inventory_component.on_item_added.connect(_on_item_added)
	inventory_component.on_item_removed.connect(_on_item_removed)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move(delta)
	
func _on_item_added(transaction: InventoryTransaction):
	popup_component.popout_text("".join(["+", str(transaction.amount)]), Color.DARK_SEA_GREEN)

func _on_item_removed(transaction: InventoryTransaction):
	popup_component.popout_text("".join(["-", str(transaction.amount)]), Color.FIREBRICK)
	
func move(delta):
	if pathfinding_component.has_path():
		pathfinding_component.update_path()
		var destination : Vector2 = pathfinding_component.get_next_destination()
#		print_debug("Grid Pos: ", pos)
#		print_debug("World Pos: ", position)
#		print_debug("Destination: ", destination)
		movement_component.move(
			delta, 
			data.speed, 
			destination,
		)

func _input(event):
	if event.is_action_pressed("middle_click"):
		if !selectable_component.is_selected:
			return
		
		attack_component.do_attack(fire_point.global_position, get_global_mouse_position())
		
	if event.is_action_pressed("left_click"):
		if !selectable_component.is_selected:
			return
			
		get_pathfinding_path(pos, grid.world_to_grid(get_global_mouse_position()))


func get_pathfinding_path(start: Vector2, target: Vector2):
	var previous_target = pathfinding_component.get_end_destination()
	if previous_target != pos:
		grid.set_cell_occupier(previous_target, null)
		grid.set_cell_navigable(pos, true)
		
	pathfinding_component.get_pathfinding_path(start, target)
	grid.set_cell_occupier(target, self)
	grid.set_cell_navigable(pos, false)
	

func get_object_type():
	return "Unit"
