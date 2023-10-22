extends BaseCharacter

# Exported variables
@export var detection_radius: float = 600.0

# Onready variables
@onready var detection_area: Area2D = $DetectionArea
@onready var detection_collision_shape: CollisionShape2D = $DetectionArea/CollisionShape2D

func _ready():
	health = 50
	movement_speed = 150.0
	var gun_instance = SniperRifle.new()
	add_child(gun_instance)
	weapon_slot = gun_instance
	
	collision_layer = 1 << 1 # This sets the second bit, representing layer 2
	collision_mask = 1 << 2  # This sets the third bit, representing layer 3 (Bullet)

	# Setup detection area
	var detection_shape: CircleShape2D = CircleShape2D.new()
	detection_shape.radius = detection_radius
	detection_collision_shape.shape = detection_shape

	# Connect signals
	detection_area.connect("body_entered", Callable(self, "_on_body_entered"))
	detection_area.connect("body_exited", Callable(self, "_on_body_exited"))

var target: Node2D = null

func _process(delta):
	if target:
		var direction_to_target = target.global_position - global_position
		if direction_to_target.length() < detection_radius:
			velocity = -direction_to_target.normalized() * movement_speed
			move_and_slide()
			weapon_slot.use_weapon(self, target.global_position)
			print("Target Position: ", target.global_position)
		else:
			pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		target = body

func _on_body_exited(body: Node2D) -> void:
	if body == target:
		target = null
