extends Area2D

var speed: float = 700.0 # Default speed of the bullet
var damage: int = 10 # Default damage dealt by the bullet
var direction: Vector2 = Vector2.ZERO # Direction of the bullet
var weapon_range: float = 100 # Default weapon range

func _process(delta):
	var line = Line2D.new() # Create a new Line2D instance
	line.width = 2.0 # Set the width of the line
	add_child(line) # Add the line as a child of the bullet
	collision_layer = 4 # Set to Bullet layer
	collision_mask = 3  # Set to interact with Player and Enemy layers
	
	print("Bullet is at: ", global_position) # Print the position of the bullet
	global_position += direction * speed * delta
	if global_position.distance_to(direction * speed * delta) > weapon_range:
		queue_free() # Free the bullet if it has traveled its maximum range
	
func _on_Bullet_area_entered(area: Area2D):
	if area.is_in_group("enemies") or area.is_in_group("player"):
		area.take_damage(damage)
		queue_free() # Destroy the bullet after hitting the target

func setup(dir: Vector2, spd: float, dmg: int, weapon_range: float) -> void:
	self.direction = dir
	print("Bullet Direction: ", dir) 
	self.speed = spd
	self.damage = dmg
	self.weapon_range = weapon_range
	# Set points of the Line2D to represent direction
	#var line = $Line2D # Assuming Line2D is a direct child of Bullet
	#line.add_point(Vector2.ZERO) # Start point
	#line.add_point(dir * 50.0) # End point, 50.0 is the length of the line
