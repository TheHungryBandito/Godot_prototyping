class_name HealthComponent
extends Node2D

signal on_damaged(attack)
signal on_health_changed(health)
signal on_max_health_changed(max_health)

@export var max_health : float = 100
@export var health : float = 100

func _ready():
	health = max_health 

func damage(attack: Attack):
	health -= attack.attack_damage
	print_debug("Health Remaining: ", health)
	on_damaged.emit(attack)
	on_health_changed.emit(health)
	
	if health <= 0:
		die()

func die():
	get_parent().queue_free()
