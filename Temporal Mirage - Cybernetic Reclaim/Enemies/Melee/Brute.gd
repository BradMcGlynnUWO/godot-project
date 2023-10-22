extends BaseCharacter

# Brute specific variables
var melee_attack_range: float = 150.0
var melee_damage: int = 50
var is_attacking: bool = false

var target: Node2D = null

# Exported variables
@export var detection_radius: float = 600.0

# Onready variables
@onready var detection_area: Area2D = $DetectionArea
@onready var detection_collision_shape: CollisionShape2D = $DetectionArea/CollisionShape2D



func _ready():
	health = 300 # High health
	movement_speed = 100.0 # Low movement speed
	collision_layer = 1 << 1 # This sets the second bit, representing layer 2
	collision_mask = 1 << 2  # This sets the third bit, representing layer 3 (Bullet)
	
	
	# Setup detection area
	var detection_shape: CircleShape2D = CircleShape2D.new()
	detection_shape.radius = detection_radius
	detection_collision_shape.shape = detection_shape

	# Connect signals
	detection_area.connect("body_entered", Callable(self, "_on_body_entered"))
	detection_area.connect("body_exited", Callable(self, "_on_body_exited"))

func _process(delta):
	if target:
		var direction_to_target = target.global_position - global_position
		if direction_to_target.length() < melee_attack_range and not is_attacking:
			attack(target)
		elif direction_to_target.length() < detection_radius:
			velocity = direction_to_target.normalized() * movement_speed
			move_and_slide()

func attack(target: Node2D) -> void:
	is_attacking = true
	target.take_damage(melee_damage)
	# Add any visual or sound effects for the hammer swing here
	var attack_timer = Timer.new()
	attack_timer.wait_time = 2.0 # 1 second attack cooldown
	attack_timer.one_shot = true
	attack_timer.connect("timeout", Callable(self, "_on_attack_timer_timeout"))
	add_child(attack_timer)
	attack_timer.start()

func _on_attack_timer_timeout():
	is_attacking = false

# Override the take_damage method to prevent knockback
func take_damage(amount: int) -> void:
	health -= amount
	print(health)
	if health <= 0:
		die()

func _on_body_entered(body: Node2D):
	if body.is_in_group("player"):
		target = body


func _on_body_exited(body: Node2D):
	if body == target:
		target = null
