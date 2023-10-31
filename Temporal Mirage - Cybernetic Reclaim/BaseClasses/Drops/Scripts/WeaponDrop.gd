extends Area2D

# The weapon class that this drop represents
@export var weapon_class: Script = null

func _on_body_entered(body: Node):
	if body is BaseCharacter and body.is_in_group("player"):
		body.swap_weapon(weapon_class)
		body.update_ammo_display()
		queue_free()  # Remove the weapon drop from the scene
