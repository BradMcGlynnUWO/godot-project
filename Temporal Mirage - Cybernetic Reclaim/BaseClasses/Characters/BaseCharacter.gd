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

func move(direction: Vector2, delta: float) -> void:
	global_position += direction.normalized() * movement_speed * delta
