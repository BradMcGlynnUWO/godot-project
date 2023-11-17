extends BaseCharacter

# Exported variables
@export var engagement_radius: float = 200.0  # Grunt will try to get within this radius to attack

# Onready variables
@onready var engagement_area: Area2D = $EngagementArea
@onready var engagement_collision_shape: CollisionShape2D = $EngagementArea/CollisionShape2D

func _ready():
	armour_type = ArmourType.LIGHT  # Weak armor
	movement_speed = 250.0  # Fast movement speed
	var dual_pistols_instance = DualPistols.new()
	add_child(dual_pistols_instance)
	weapon_slot = dual_pistols_instance

	# Setup engagement area
	var engagement_shape: CircleShape2D = CircleShape2D.new()
	engagement_shape.radius = engagement_radius
	engagement_collision_shape.shape = engagement_shape

	# Connect signals
	engagement_area.connect("body_entered", Callable(self, "_on_body_entered"))
	engagement_area.connect("body_exited", Callable(self, "_on_body_exited"))

var target: Node2D = null

func _process(delta):
	if target:
		var direction_to_target = target.global_position - global_position
		if direction_to_target.length() > engagement_radius:
			# Move towards the target to get within engagement radius
			velocity = direction_to_target.normalized() * movement_speed
		else:
			# If within engagement radius, attempt to circle around or avoid direct line of fire
			var strafe_direction = direction_to_target.tangent().normalized() * movement_speed
			velocity = strafe_direction

		move_and_slide()
		weapon_slot.use_weapon(self, target.global_position)
		print("Engaging Target at Position: ", target.global_position)
	else:
		velocity = Vector2.ZERO

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		target = body

func _on_body_exited(body: Node2D) -> void:
	if body == target:
		target = null


