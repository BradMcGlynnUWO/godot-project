extends BaseCharacter

# Brute specific variables
var melee_attack_range: float = 150.0
var melee_damage: int = 50
var is_attacking: bool = false

var target: Node2D = null

# Exported variables
@export var detection_radius: float = 600.0

# Onready variables
@onready var detection_area: Area2D = $TargetDetectionArea
@onready var detection_collision_shape: CollisionShape2D = $TargetDetectionArea/CollisionShape2D
@onready var anim = get_node("AnimationPlayer")
@onready var health_bar: ProgressBar = $Health/ProgressBar

func _ready():
	health = 300 # High health
	movement_speed = 100.0 # Low movement speed
	
	health_bar.set_value_no_signal(health)  # set health in health bar
	
	# Setup detection area
	var detection_shape: CircleShape2D = CircleShape2D.new()
	detection_shape.radius = detection_radius
	detection_collision_shape.shape = detection_shape

func _physics_process(delta):
	if target:
		anim.play("walk-towards")
		var direction_to_target = target.global_position - global_position
		if direction_to_target.length() < melee_attack_range and not is_attacking:
			attack(target)
		elif direction_to_target.length() < detection_radius:
			velocity = direction_to_target.normalized() * movement_speed
			move_and_slide()
	else:
		anim.play("idle")

func attack(target: Node2D) -> void:
	is_attacking = true
	target.take_damage(melee_damage)
	var knockback_direction = (target.global_position - global_position).normalized()
	target.apply_knockback(knockback_direction, 100)  # Adjust the magnitude as needed
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
	health_bar.set_value_no_signal(health)
	
	if health <= 0:
		die()
	
	health_bar.set_value_no_signal(health)

func _on_detection_area_body_entered(body):
	if body.is_in_group("player"):
		target = body


func _on_detection_area_body_exited(body):
	if body == target:
		target = null
