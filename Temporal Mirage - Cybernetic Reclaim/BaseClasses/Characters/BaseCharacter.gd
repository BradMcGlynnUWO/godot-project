class_name BaseCharacter
extends CharacterBody2D

var health: int = 100
var movement_speed: float = 200.0
var weapon_slot = null # You can assign a weapon class instance here.

func _ready():
	pass

func take_damage(amount: int) -> void:
	health -= amount
	print(health)
	if health <= 0:
		die()

func die() -> void:
	queue_free() # Override this method to perform specific actions upon death.
	
func get_is_shield_active() -> bool:
	return false

func apply_knockback(direction: Vector2, magnitude: float):
	global_position += direction * magnitude

