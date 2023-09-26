extends Sprite2D


const SPEED = 200.0  # Adjust as needed

func _process(delta):
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed('ui_right'):
		direction.x += 1
	if Input.is_action_pressed('ui_left'):
		direction.x -= 1
	if Input.is_action_pressed('ui_down'):
		direction.y += 1
	if Input.is_action_pressed('ui_up'):
		direction.y -= 1
	
	if direction.length() > 0:
		direction = direction.normalized()
	
	position += direction * SPEED * delta
