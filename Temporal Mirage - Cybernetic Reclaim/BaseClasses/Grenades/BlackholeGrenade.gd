extends Grenade

var pull_force: float = 100.0
var pull_duration: float = 3.0
var is_active: bool = false

# For swirling animation
var rotation_speed: float = 5.0

func _ready():
	initial_position = global_position
	initial_position = global_position
	timer = Timer.new()
	timer.wait_time = 2.0
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "explode"))
	add_child(timer)
	timer.start()

	explosion_radius = 400
	# Add a new timer for the pull duration
	var pull_timer = Timer.new()
	pull_timer.wait_time = pull_duration
	pull_timer.one_shot = true
	pull_timer.wait_time = 3.0
	pull_timer.connect("timeout", Callable(self, "_on_pull_timer_timeout"))
	add_child(pull_timer)
	# to be implemented once animation stuff is added
	#$AnimationPlayer.play("swirl")


func _physics_process(delta):
	global_position += direction * speed * delta
	if global_position.distance_to(initial_position) >= max_distance and not timer_started:
		direction = Vector2.ZERO # Stop the grenade's movement
		timer.start() # Start the timer if it hasn't started yet
		timer_started = true
	
	# Swirling animation
	rotation += rotation_speed * delta
	
	if is_active:
		# Get all bodies in the "enemies", "player", and "bullets" groups
		var all_bodies = get_tree().get_nodes_in_group("enemies") + get_tree().get_nodes_in_group("player") + get_tree().get_nodes_in_group("bullets")

		for body in all_bodies:
			var distance_to_body = global_position.distance_to(body.global_position)
			
			# Check if the body is within the explosion radius
			if distance_to_body <= explosion_radius:
				# Calculate pull direction and magnitude
				var pull_direction = (global_position - body.global_position).normalized()
				var pull_magnitude = pull_force * (1 - distance_to_body / explosion_radius)
				
				# Apply pull force
				body.global_position += pull_direction * pull_magnitude * delta

				#if body is BaseCharacter:
				#	body.take_damage(damage, ammo_type)

func explode():
	# Activate the blackhole pull effect
	is_active = true

func _on_pull_timer_timeout():
	is_active = false
	queue_free()
