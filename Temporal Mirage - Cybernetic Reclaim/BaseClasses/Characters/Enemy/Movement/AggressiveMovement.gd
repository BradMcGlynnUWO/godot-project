extends MovementStrategy
func move(enemy: Enemy, delta: float) -> void:
	# Implement aggressive movement towards the player
	if enemy.target:
		var direction = (enemy.target.global_position - enemy.global_position).normalized()
		enemy.velocity = direction * enemy.movement_speed
		enemy.move_and_slide()
