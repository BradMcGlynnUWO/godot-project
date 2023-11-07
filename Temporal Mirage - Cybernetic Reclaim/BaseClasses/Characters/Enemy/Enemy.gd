class_name Enemy
extends BaseCharacter

const MovementStrategy = preload("res://BaseClasses/Characters/Enemy/Movement/MovementStrategy.gd")
const EnemyType = preload("res://BaseClasses/Characters/Enemy/EnemyTypes.gd").EnemyType

var movement_strategy: MovementStrategy
var melee_attack_range: float = -1
var melee_damage: float
var target: Node2D = null
var detection_radius: float

func _ready():
	pass

func _physics_process(delta: float) -> void:
	movement_strategy.move(self, delta)
	if target:
		if(weapon_slot != null):
			weapon_slot.use_weapon(self, target.global_position)
		elif (melee_attack_range != -1):
			pass

func initialize(config: Dictionary) -> void:
	# Set up the base character properties based on the config
	health = config.get("health", health)
	movement_speed = config.get("movement_speed", movement_speed)
	armour_type = config.get("armour_type", armour_type)
	movement_strategy = config["movement_strategy"].new()
	detection_radius = config.get("detection_radius", detection_radius)
	
	if config.has("weapon_class"):
		weapon_slot = config["weapon_class"].new()
		add_child(weapon_slot)
	# ... other base character properties

	# Set up specific enemy properties based on the type
	match config.get("type"):
		EnemyType.GRENADER:
			pass
			# ... other grenader-specific setup
		EnemyType.BRUTE:
			melee_attack_range = config["melee_attack_range"]
			melee_damage = config["melee_damage"]
			# ... other brute-specific setup
		EnemyType.SNIPER:
			pass
			# ... other sniper-specific setup
	# ... setup for other enemy types

	# ... any additional setup
	
	
func _on_detection_area_body_entered(body):
	if body.is_in_group("player"):
		target = body


func _on_detection_area_body_exited(body):
	if body == target:
		target = null

