extends BaseCharacter

var can_shoot: bool = true

# Bullet Time variables
var is_time_slow_active: bool = false
var time_multiplier: int = 1
var bullet_time_duration: float = 2.0
var bullet_time_timer: Timer

# Temporal Shield variables
var is_shield_active: bool = false
var shield_duration: float = 1.0
var shield_cooldown: float = 3.0
var shield_timer: Timer

# Predictive Echo / Dash variables
var dash_speed_multiplier: float = 9.0
var dash_cooldown: float = 2.0
var dash_timer: Timer

func _ready():
	health = 100
	movement_speed = 30.0
	var gun_instance = MachineGun.new()
	add_child(gun_instance)
	weapon_slot = gun_instance
	collision_layer = 1 << 0
	collision_mask = 1 << 2
	
	# Initialize timers
	bullet_time_timer = Timer.new()
	bullet_time_timer.wait_time = bullet_time_duration
	bullet_time_timer.one_shot = true
	bullet_time_timer.connect("timeout", Callable(self, "deactivate_time_slow"))
	add_child(bullet_time_timer)
	
	shield_timer = Timer.new()
	shield_timer.wait_time = shield_duration + shield_cooldown
	shield_timer.one_shot = true
	shield_timer.connect("timeout", Callable(self, "deactivate_shield"))
	add_child(shield_timer)
	
	dash_timer = Timer.new()
	dash_timer.wait_time = dash_cooldown
	dash_timer.one_shot = true
	add_child(dash_timer)

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
	
	move(direction, delta * time_multiplier * movement_speed)

	if Input.is_action_pressed('ui_select') and can_shoot:
		shoot()
	
	# Bullet Time activation
	if Input.is_action_just_pressed('ui_focus_next') and not is_time_slow_active:
		activate_time_slow()
	
	# Temporal Shield activation
	if Input.is_action_just_pressed('ui_text_newline') and not is_shield_active and shield_timer.is_stopped():
		activate_shield()
	
	# Predictive Echo / Dash activation
	if Input.is_action_just_pressed('dash') and dash_timer.is_stopped():
		dash(direction)
		

func shoot():
	var target_position = get_global_mouse_position()
	weapon_slot.use_weapon(self, target_position)
	can_shoot = false
	var timer = get_tree().create_timer(1.0 / weapon_slot.fire_rate)
	await timer.timeout
	can_shoot = true

func activate_time_slow():
	print("Time slow activated")
	Engine.time_scale = 0.5
	time_multiplier = 2
	is_time_slow_active = true
	bullet_time_timer.start()

func deactivate_time_slow():
	print("Time slow deactivated")
	Engine.time_scale = 1.0
	time_multiplier = 1
	is_time_slow_active = false

func activate_shield():
	print("Shield activated")
	is_shield_active = true
	# Here, you can add any visual or gameplay effects to indicate the shield is active
	shield_timer.start()

func deactivate_shield():
	print("Shield deactivated")
	is_shield_active = false
	shield_timer.stop()
	# Here, you can revert any visual or gameplay effects related to the shield

func dash(direction: Vector2):
	global_position += direction.normalized() * movement_speed * dash_speed_multiplier
	dash_timer.start()

func get_is_shield_active() -> bool:
	return is_shield_active
