class_name HarvestableComponent
extends Node2D

@export var inventory_component: InventoryComponent = null

func initialize(items: Dictionary):
	for item in items:
		print(item)
		var transaction: InventoryTransaction = inventory_component.create_transaction()
		transaction.sender = get_parent()
		transaction.target = get_parent()
		transaction.item = item
		transaction.amount = items[item]
		inventory_component.add_item(transaction)
	
func harvest(transaction):
	if not inventory_component.remove_item(transaction):
		return false
	return transaction
