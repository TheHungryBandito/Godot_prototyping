class_name InventoryComponent
extends Node2D

signal on_item_added(inventory_transaction: InventoryTransaction)
signal on_item_removed(inventory_transaction: InventoryTransaction)

@onready var main = get_tree().root.get_node("Main")
@onready var item_database = main.get_node("ItemDatabase") as ItemDatabase

@export var MAX_SIZE: int = 30


var inventory: Dictionary = {}

func add_item(inventory_transaction: InventoryTransaction) -> bool:
	if not inventory.has(inventory_transaction.item.name):
		if inventory.size() >= MAX_SIZE:
			return false
		inventory[inventory_transaction.item.name] = 0
	inventory[inventory_transaction.item.name] += inventory_transaction.amount
	print_debug("Item added to inventory: ", inventory_transaction.item.name, " - ", inventory_transaction.amount)
	print_debug("Total: ", inventory_transaction.item.name, " - ", inventory[inventory_transaction.item.name])
	on_item_added.emit(inventory_transaction)
	return true

func remove_item(inventory_transaction: InventoryTransaction) -> bool:
	if not inventory.has(inventory_transaction.item.name):
		return false
	var result: int = inventory[inventory_transaction.item.name] - inventory_transaction.amount
	if result < 0:
		return false
	inventory[inventory_transaction.item.name] = result
	print_debug("Item removed to inventory: ", inventory_transaction.item.name, " - ", inventory_transaction.amount)
	print_debug("Total: ", inventory_transaction.item.name, " - ", inventory[inventory_transaction.item.name])
	on_item_removed.emit(inventory_transaction)
	return true
	
func get_item_count(item: ItemData):
	return inventory[item]
	
func get_first_item():
	for item_name in inventory:
		if inventory[item_name] > 0:
			return item_database.get_item_from_name(item_name)
	
func get_item_least():
	var least: int = 0
	var target_item_name: String = ""
	for item_name in inventory:
		if inventory[item_name] < least:
			least = inventory[item_name]
			target_item_name = item_name
	return item_database.get_item_from_name(target_item_name)

func get_item_most():
	var most: int = 0
	var target_item_name: String = ""
	for item_name in inventory:
		if inventory[item_name] > most:
			most = inventory[item_name]
			target_item_name = item_name
	return item_database.get_item_from_name(target_item_name)
	
func create_transaction():
	return InventoryTransaction.new()

