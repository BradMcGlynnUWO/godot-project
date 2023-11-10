extends TileMap
const EnemyFactory = preload("res://BaseClasses/Characters/Enemy/EnemyFactory.gd")
const EnemyType = preload("res://BaseClasses/Characters/Enemy/EnemyTypes.gd").EnemyType

# Define the boundaries of the map (or area) where enemies can spawn
var spawn_area_rect := Rect2(Vector2(100, 100), Vector2(3000, 3000)) # Example values

# Define the types of enemies and their spawn probabilities
var enemy_types := [
	{"type": EnemyType.GRENADER, "weight": 50}, # 50% chance
	{"type": EnemyType.BRUTE, "weight": 30},   # 30% chance
	{"type": EnemyType.SNIPER, "weight": 20}   # 20% chance
]

# Call this method to spawn enemies
func spawn_enemies():
	var num_enemies := randf_range(10, 20) # Random number between 10 and 20
	for i in range(num_enemies):
		var enemy_type := weighted_choice(enemy_types) as int
		var position := Vector2(
			randf_range(spawn_area_rect.position.x, spawn_area_rect.position.x + spawn_area_rect.size.x),
			randf_range(spawn_area_rect.position.y, spawn_area_rect.position.y + spawn_area_rect.size.y)
		)
		var enemy := EnemyFactory.create_enemy(enemy_type, position)
		get_node("Enemies").add_child(enemy)

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


func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
