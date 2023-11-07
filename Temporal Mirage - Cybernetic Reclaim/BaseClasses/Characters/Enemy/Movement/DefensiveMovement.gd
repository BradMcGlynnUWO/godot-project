extends MovementStrategy
func move(enemy: Enemy, delta: float) -> void:
	# Implement defensive movement, e.g., moving away from the player
	if enemy.target:
		var direction = (enemy.global_position - enemy.target.global_position).normalized()
		enemy.velocity = direction * enemy.movement_speed
		enemy.move_and_slide()
