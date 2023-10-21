class_name Projectile
extends Entity

@onready var movement_component: MovementComponent = get_node("MovementComponent")
@onready var health_component: HealthComponent = get_node("HealthComponent")
@onready var hitbox_component: HitboxComponent = get_node("HitboxComponent")

var attack: Attack = null
var destination: Vector2 = Vector2.ZERO
var speed: float = 100
var is_enabled = false

func _ready():
	hitbox_component.on_hitbox_entered.connect(collide_projectile)
	health_component.on_die.connect(_on_die)
	
func _process(delta):
	if !is_enabled:
		return
	movement_component.move(delta, speed, destination)
	self.look_at(destination)
	
	if position.distance_to(destination) < 5:
		health_component.die()
		
func _on_die():
	queue_free()
	
func damage(attack: Attack):
	health_component.damage(attack)
	
func send_projectile(attack: Attack, to: Vector2):
	self.attack = attack
	position = attack.attack_position
	destination = to
	is_enabled = true
	

func collide_projectile(area):
	if !is_enabled:
		return
	if attack == null:
		return
	if not is_collision_target(area):
		return
	area.owner.damage(attack)
	health_component.die()

func is_collision_target(area) -> bool:
	if area.owner == attack.sender:
		return false
	if !area.owner.has_method("damage"):
		return false
	return true

func get_object_type():
	return "Projectile"



