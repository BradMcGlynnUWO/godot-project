class_name Melee
extends Weapon

var knockback_force: float = 300.0

func _ready():
	range = 50.0 # Example value, adjust as needed.

func use_weapon(character: Node, target_position: Vector2) -> void:
	# Implement the logic to perform melee attacks.
	# For example, apply knockback to the target.
	pass
