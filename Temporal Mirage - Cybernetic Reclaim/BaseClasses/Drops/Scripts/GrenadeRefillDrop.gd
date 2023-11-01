extends Area2D

# Define the amount of ammo this drop provides

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.grenades = body.max_grenades
		body.update_grenade_display()
		queue_free()
