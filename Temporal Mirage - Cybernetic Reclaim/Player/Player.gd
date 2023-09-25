extends CharacterBody2D

const SPEED = 200.0  # Adjust as needed

@onready var anim = get_node("AnimationPlayer")
@onready var sprite = get_node("AnimatedSprite2D")  # Assuming the node name is AnimatedSprite2D, adjust if needed

func _physics_process(delta):
	var direction = Vector2.ZERO  # Initialize a zero vector for direction
	
	# Handle the input for both horizontal and vertical directions
	if Input.is_action_pressed('ui_right'):
		direction.x += 1
		sprite.flip_h = false  # Face right
	if Input.is_action_pressed('ui_left'):
		direction.x -= 1
		sprite.flip_h = true  # Face left
	if Input.is_action_pressed('ui_down'):
		direction.y += 1
	if Input.is_action_pressed('ui_up'):
		direction.y -= 1
	
	# Normalize the direction vector to avoid faster diagonal movement
	if direction.length() > 0:
		direction = direction.normalized()
		anim.play("Run")  # Play run animation when moving
	else:
		anim.play("Idle")  # Play idle animation when not moving
	
	# Move the character in the direction input by the user
	velocity = direction * SPEED
	move_and_slide()
	
	# Handle other game logic like changing scenes or player death
	if Game.playerHP <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://main.tscn")
	
	if Input.is_action_just_pressed("ui_cancel"):
		queue_free()
		get_tree().change_scene_to_file("res://main.tscn")
