extends TileMap
const EnemyFactory = preload("res://BaseClasses/Characters/Enemy/EnemyFactory.gd")
const EnemyType = preload("res://BaseClasses/Characters/Enemy/EnemyTypes.gd").EnemyType
const DropType = preload("res://BaseClasses/Drops/DropType.gd").DropType

# Define the boundaries of the map (or area) where enemies can spawn
var spawn_area_rect := Rect2(Vector2(100, 100), Vector2(1000, 500)) # Example values

# Define the types of enemies and their spawn probabilities
var enemy_types := [
	{"type": EnemyType.GRENADER, "weight": 20}, # 20% chance
	{"type": EnemyType.BRUTE, "weight": 30},   # 30% chance
	{"type": EnemyType.SNIPER, "weight": 50}   # 50% chance
]

# Drop spawn configuration
var drop_types := [
	{"type": DropType.HEALTH, "weight": 25},         # Common
	{"type": DropType.GRENADEREFILL, "weight": 20},  # Common
	{"type": DropType.AMMOREFILL, "weight": 20},     # Common
	{"type": DropType.WEAPON, "weight": 15},         # Somewhat common
	{"type": DropType.ARMOUR, "weight": 15},         # Somewhat common
	{"type": DropType.GRENADETYPE, "weight": 3},     # Rare
	{"type": DropType.AMMOTYPE, "weight": 2}         # Rare
]



# Call this method to spawn enemies
func spawn_enemies():
	var num_enemies := randf_range(10, 20) # Random number between 10 and 20
	for i in range(num_enemies):
		var enemy_type := weighted_choice(enemy_types) as int
		var position := random_position_in_area(spawn_area_rect)
		var enemy := EnemyFactory.create_enemy(enemy_type, position)
		get_node("Enemies").add_child(enemy)
		
func spawn_drops():
	var num_drops := randi_range(5, 10)
	for i in range(num_drops):
		var drop_type := weighted_choice(drop_types) as int
		var position := random_position_in_area(spawn_area_rect)
		var drop := DropFactory.create_drop(drop_type, position)
		add_child(drop)  # Or add to a specific node for drops

func random_position_in_area(area: Rect2) -> Vector2:
	return Vector2(
		randf_range(area.position.x, area.position.x + area.size.x),
		randf_range(area.position.y, area.position.y + area.size.y)
	)

# Helper function for weighted random choice
func weighted_choice(choices):
	var sum_of_weights := 0
	for choice in choices:
		sum_of_weights += choice["weight"]
	
	var random_num := randf() * sum_of_weights
	for choice in choices:
		if random_num < choice["weight"]:
			return choice["type"]
		random_num -= choice["weight"]
	return choices[choices.size() - 1]["type"] # Fallback to the last one

# Don't forget to initialize the random number generator
func _ready():
	randomize()
	spawn_enemies()
	spawn_drops()


func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
