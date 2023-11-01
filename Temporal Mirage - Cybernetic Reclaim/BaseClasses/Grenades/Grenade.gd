class_name Grenade
extends Area2D
const AmmoType = preload("res://BaseClasses/Damage/AmmoType.gd").AmmoType
var ammo_type: AmmoType = AmmoType.EXPLOSIVE


var explosion_radius: float = 100.0
var knockback_force: float = 500.0
var damage: int = 20
var max_distance: float = 300.0
var speed: float = 300.0 # Speed of the grenade

var direction: Vector2 = Vector2.ZERO # Direction in which the grenade is moving
var initial_position: Vector2
var timer: Timer
var timer_started: bool = false

func _ready():
	initial_position = global_position
	initial_position = global_position
	timer = Timer.new()
	timer.wait_time = 5.0
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "explode"))
	add_child(timer)
	timer.start()

func _process(delta):
	global_position += direction * speed * delta
	if global_position.distance_to(initial_position) >= max_distance and not timer_started:
		direction = Vector2.ZERO # Stop the grenade's movement
		timer.start() # Start the timer if it hasn't started yet
		timer_started = true



func setup(dir: Vector2, spd: float, dmg: int, max_distance: float, ammo_type: AmmoType) -> void:
	self.direction = dir
	self.speed = spd
	self.damage = dmg
	self.max_distance = max_distance
	self.ammo_type = ammo_type


func explode():
	# Get all bodies in the "enemies" and "player" groups
	var all_bodies = get_tree().get_nodes_in_group("enemies") + get_tree().get_nodes_in_group("player")

	for body in all_bodies:
		var distance_to_body = global_position.distance_to(body.global_position)
		
		# Check if the body is within the explosion radius
		if distance_to_body <= explosion_radius:
			# Calculate knockback direction and magnitude
			var knockback_direction = (body.global_position - global_position).normalized()
			var knockback_magnitude = knockback_force * (1 - distance_to_body / explosion_radius)
			
			# Apply knockback and damage if the body is of type BaseCharacter
			if body is BaseCharacter:
				body.apply_knockback(knockback_direction, knockback_magnitude)
				body.take_damage(damage, ammo_type)

	# Destroy the grenade after explosion
	queue_free()



func _on_body_entered(hitbox):
	print("Bullet collided with character")
	if hitbox.is_in_group("enemies") or hitbox.is_in_group("player"):
		if hitbox.get_is_shield_active():
			reset_grenade()
		else:
			hitbox.take_damage(damage)

func reset_grenade():
	direction = -1 * direction
	timer.stop()
	get_tree().create_timer(1.0).connect("timeout", Callable(self, "_resume_timer"))

func _resume_timer():
	timer.start()
