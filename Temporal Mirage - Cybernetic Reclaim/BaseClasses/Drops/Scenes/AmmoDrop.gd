extends Area2D

# Define the amount of ammo this drop provides

func _on_body_entered(body):
	if body.is_in_group("player") and body.weapon_slot is Gun:
		body.refill_weapon()
		body.update_ammo_display()
		queue_free()
