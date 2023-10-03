extends BaseCharacter

var can_shoot: bool = true

func _ready():
	health = 100 # Example health value
	movement_speed = 200.0 # Example movement speed value
	var gun_instance = MachineGun.new()
	add_child(gun_instance)
	weapon_slot = gun_instance
	collision_layer = 1 << 0 # This sets the first bit, representing layer 1
	collision_mask = 1 << 2  # This sets the third bit, representing layer 3 (Bullet)

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




