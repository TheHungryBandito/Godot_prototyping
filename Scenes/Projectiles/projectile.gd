class_name Projectile
extends Node2D

@onready var movement_component: MovementComponent = get_node("MovementComponent")
@onready var health_component: HealthComponent = get_node("HealthComponent")
@onready var hitbox_component: HitboxComponent = get_node("HitboxComponent")

var attack: Attack = null
var destination: Vector2 = Vector2.ZERO
var speed: float = 100
var is_enabled = false

func _ready():
	hitbox_component.on_hitbox_entered.connect(collide_projectile)
	
func _process(delta):
	if !is_enabled:
		return
	movement_component.move(delta, speed, destination)
	
	if position.distance_to(destination) < 5:
		health_component.die()
	
	
func send_projectile(attack: Attack, to: Vector2):
	self.attack = attack
	self.look_at(to)
	position = attack.attack_position
	destination = to
	is_enabled = true
	

func collide_projectile(area):
	if !is_enabled:
		return
	if attack == null:
		return
	if area.get_parent() == attack.sender:
		return
	if !area.has_method("damage"):
		return
	area.damage(attack)
	health_component.die()



