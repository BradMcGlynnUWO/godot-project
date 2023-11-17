extends Area2D

# Define the amount of health this drop provides
var health_amount: int = 50

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.health += health_amount
		if body.health > body.max_health:
			body.health = body.max_health
		body.update_health_display()
		queue_free()

