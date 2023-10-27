extends BaseCharacter

var can_shoot: bool = true
var max_health = 100

@onready var anim = get_node("AnimationPlayer")
@onready var ammo_display = get_parent().get_node("./../CanvasLayer/AmmoDisplay")
@onready var grenade_display = get_parent().get_node("./../CanvasLayer/GrenadeDisplay")
@onready var health_display = get_parent().get_node("./../CanvasLayer/HealthRemaining")


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

# Grenade variables
var grenade_scene = preload("res://BaseClasses/Grenades/Grenade.tscn")
var grenade_speed: float = 300.0 # Speed at which the grenade is thrown
var grenade_distance: float = 600.0
var grenade_damage: int = 30
var grenades: int = 5 # Current number of grenades
var max_grenades: int = 5 # Maximum number of grenades
var grenade_cooldown: float = 3.0 # Cooldown between each throw
var grenade_reload_time: float = 5.0 # Time to reload grenades

var grenade_cooldown_timer: Timer
var grenade_reload_timer: Timer


func _ready():
	health = 100
	movement_speed = 100
	set_motion_mode(1)   # default motion mode is for platformers, this mode is for top down's
	var gun_instance = MachineGun.new()
	add_child(gun_instance)
	weapon_slot = gun_instance
	
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

	# Initialize grenade timers
	grenade_cooldown_timer = Timer.new()
	grenade_cooldown_timer.wait_time = grenade_cooldown
	grenade_cooldown_timer.one_shot = true
	add_child(grenade_cooldown_timer)

	grenade_reload_timer = Timer.new()
	grenade_reload_timer.wait_time = grenade_reload_time
	grenade_reload_timer.one_shot = true
	grenade_reload_timer.connect("timeout", Callable(self, "reload_grenades"))
	add_child(grenade_reload_timer)
	

func _physics_process(delta):
	update_health_display()
	update_ammo_display()
	update_grenade_display()
	# move_and_slide() uses this velocity to mvoe the character
	velocity = _get_velocity_from_key_in()  * time_multiplier * movement_speed
	move_and_slide()
	
	if velocity.x == 0 and velocity.y == 0:
		anim.play("idle-blue")

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
		dash(velocity)

	# Grenade throw activation
	if Input.is_action_just_pressed('ui_throw_grenade') and grenades > 0 and grenade_cooldown_timer.is_stopped():
		throw_grenade()
		

func shoot():
	var target_position = get_global_mouse_position()
	weapon_slot.use_weapon(self, target_position)
	can_shoot = false
	var timer = get_tree().create_timer(1.0 / weapon_slot.fire_rate)
	await timer.timeout
	can_shoot = true
	update_ammo_display()

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

func throw_grenade():
	grenades -= 1
	if grenade_scene:
		var grenade_instance = grenade_scene.instantiate()
		if grenade_instance:
			var direction = (get_global_mouse_position() - global_position).normalized()
			var offset = 150
			
			grenade_instance.global_position = global_position + direction * offset
			grenade_instance.setup(direction, grenade_speed, grenade_damage, grenade_distance)
			var character_parent = get_parent()
			character_parent.get_node("./../Grenades").add_child(grenade_instance)
	else:
		printerr("Grenade scene is null!")

	# Start the cooldown timer
	grenade_cooldown_timer.start()
	update_grenade_display()


func reload_grenades():
	grenade_reload_timer.start()
	grenades = max_grenades
	update_grenade_display()
	
func update_ammo_display():
	print(ammo_display)
	if ammo_display and ammo_display is Label:
		ammo_display.text = "Ammo: %d/%d, Bullets Remaining: %d" % [weapon_slot.bullets_left, weapon_slot.magazine_size, weapon_slot.max_bullets]

func refill_weapon():
	weapon_slot.max_bullets = weapon_slot.magazine_size * 10

func update_grenade_display():
	print(grenade_display)
	grenade_display.text = "Grenades: %d/%d" % [grenades, max_grenades]

func update_health_display():
	print(health_display)
	health_display.text = "Health: %d" % [health]


func _get_velocity_from_key_in():
	#TODO separate setting of animation to separate class?
	var vel = Vector2.ZERO
	if Input.is_action_pressed('ui_right'):
		anim.play("walk-right-blue")
		vel.x += 1
	if Input.is_action_pressed('ui_left'):
		anim.play("walk-left-blue")
		vel.x -= 1
	if Input.is_action_pressed('ui_down'):
		anim.play("walk-towards-blue")
		vel.y += 1
	if Input.is_action_pressed('ui_up'):
		anim.play("walk-away-blue")
		vel.y -= 1
	return vel
