class_name LevelBuilder

var room_templates = []  # Array of preloaded room scenes
var grid_size = Vector2(5, 5)  # Size of the level grid

func _init():
	# Load room templates
	#room_templates.append(preload("res://path/to/room_scene_1.tscn"))
	# ... load other room templates
	pass

func build_level():
	var level_grid = []  # 2D array representing the level grid
	# Initialize the grid with nulls or default values
	for x in range(grid_size.x):
		var column = []
		for y in range(grid_size.y):
			column.append(null)
		level_grid.append(column)

	# Randomly place rooms in the grid
	for x in range(grid_size.x):
		for y in range(grid_size.y):
			var room_scene = room_templates[randi() % room_templates.size()]
			var room_instance = room_scene.instantiate()
			# Set room position based on grid coordinates
			#room_instance.global_position = Vector2(x * room_width, y * room_height)
			# Add room to the level
			#add_child(room_instance)
			# Store the room in the grid
			#level_grid[x][y] = room_instance

	# Add logic to connect rooms and ensure accessibility

	# Spawn enemies and drops in the rooms
	for room in flatten(level_grid):
		if room:
			spawn_enemies_in_room(room)
			spawn_drops_in_room(room)

func spawn_enemies_in_room(room):
	pass

func spawn_drops_in_room(room):
	pass

# Utility function to flatten a 2D array
func flatten(grid):
	var flat_list = []
	for column in grid:
		for element in column:
			flat_list.append(element)
	return flat_list
