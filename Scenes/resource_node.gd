class_name ResourceNode
extends Entity

@export var items: Array[ItemData] = []

@onready var main = get_tree().root.get_node("Main")
@onready var grid: Grid = main.get_node("World/Grid")
@onready var health_component: HealthComponent = get_node("HealthComponent")
@onready var hitbox_component: HitboxComponent = get_node("HitboxComponent")
@onready var harvestable_component: HarvestableComponent = get_node("HarvestableComponent")
@onready var inventory_component: InventoryComponent = get_node("InventoryComponent")
@onready var popup_component: PopupComponent = get_node("PopupComponent")

var data: ResourceData = ResourceData.new()

var pos: Vector2 :
	get:
		return pos
	set(value):
		if grid.get_cell_occupier(pos) == self and value != pos:
			grid.set_cell_occupier(pos, null)
		pos = value
		if grid.get_cell_occupier(pos) == null:
			grid.set_cell_occupier(pos, self)
			
# Called when the node enters the scene tree for the first time.
func _ready():
	grid.on_grid_generated.connect(_on_grid_generated)
	data.name = "Rock"
	data.description = "Old Fool"
	data.stored_resources = {}
	
	for item in items:
		data.stored_resources[item] = 100
	
	harvestable_component.initialize(data.stored_resources)
	health_component.on_damaged.connect(harvest)
	health_component.on_die.connect(_on_die)
	inventory_component.on_item_added.connect(_on_item_added)
	inventory_component.on_item_removed.connect(_on_item_removed)

func _on_grid_generated():
	pos = grid.world_to_grid(position)
	
func _on_item_added(transaction: InventoryTransaction):
	popup_component.popout_text("".join(["+", str(transaction.amount)]), Color.DARK_SEA_GREEN)

func _on_item_removed(transaction: InventoryTransaction):
	popup_component.popout_text("".join(["-", str(transaction.amount)]), Color.FIREBRICK)

func _on_die():
	queue_free()
	
func harvest(attack: Attack):
	if not attack:
		return
	if not attack.sender:
		return
	if not attack.sender.inventory_component:
		return
	var transaction: InventoryTransaction = inventory_component.create_transaction()
	transaction.sender = self
	transaction.target = attack.sender
	transaction.amount = attack.attack_damage
	transaction.item = inventory_component.get_item_most()
	if not transaction.item:
		return
	var harvested = harvestable_component.harvest(transaction)
	if not harvested:
		return
	attack.sender.inventory_component.add_item(harvested)
	
func get_object_type():
	return "Resource"
	
func _to_string():
	return data.name
