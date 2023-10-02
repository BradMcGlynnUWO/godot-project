extends BaseCharacter

var can_shoot: bool = true

@onready var anim = get_node("AnimationPlayer")

func _ready():
	health = 100 # Example health value
	movement_speed = 200.0 # Example movement speed value
	weapon_slot = MachineGun.new() # Assign a machine gun instance.
	collision_layer = 1 # Set to Player layer
	collision_mask = 4  # Set to interact with Bullet layer

func _process(delta):
	#print("Player is at: ", global_position) # Print the position of the player
	var direction = Vector2.ZERO
	if Input.is_action_pressed('ui_right'):
		anim.play("walk-right-blue")
		direction.x += 1
	if Input.is_action_pressed('ui_left'):
		anim.play("walk-left-blue")
		direction.x -= 1
	if Input.is_action_pressed('ui_down'):
		anim.play("walk-towards-blue")
		direction.y += 1
	if Input.is_action_pressed('ui_up'):
		anim.play("walk-away-blue")
		direction.y -= 1
	
	move(direction, delta) # Pass delta to the move function

	if Input.is_action_pressed('ui_select') and can_shoot:
		shoot()

func shoot() -> void:
	var target_position = get_global_mouse_position() # Get the global position of the mouse cursor
	weapon_slot.use_weapon(self, target_position) # Pass the Character instance and target_position to the use_weapon function
	can_shoot = false
	var timer = get_tree().create_timer(1.0 / weapon_slot.fire_rate) # Create a timer
	await timer.timeout # Wait for the timer to timeout
	can_shoot = true




