class_name AttackComponent
extends Node2D

@export var sender: Node2D = null
@export var projectile: PackedScene = null
@export var attack_damage: float = 10.0
@export var knockback_force: float = 10.0
@export var cooldown: float = 1.0

@onready var main: Node2D = get_tree().root.get_node("Main")
@onready var timer: Timer = get_node("Timer")
@onready var projectile_pool: Node2D = main.get_node("World/Grid/ProjectilePool")

var can_attack: bool = false

func _ready():
	timer.timeout.connect(_reset_cooldown)
	timer.start(cooldown)
	
func do_attack(from: Vector2, to: Vector2):
	if can_attack == false:
		return
	var attack: Attack = Attack.new()
	attack.sender = sender
	attack.attack_damage = attack_damage
	attack.knockback_force = knockback_force
	attack.attack_position = from
	
	timer.start(cooldown)
	can_attack = false
	send_projectile(attack, to)
	
func send_projectile(attack: Attack, to: Vector2):
	var instance = projectile.instantiate()
	instance.send_projectile(attack, to)
	projectile_pool.add_child(instance)
	
func _reset_cooldown():
	can_attack = true

