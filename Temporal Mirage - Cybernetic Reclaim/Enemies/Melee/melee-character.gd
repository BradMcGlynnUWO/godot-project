extends CharacterBody2D

const SPEED = 250.0
@onready var player = get_node("../../Character")  # Adjust the path to your player node
var chase = false


func _physics_process(delta):

	if chase == true:

		
		var direction = (player.position).normalized()
		position += direction * SPEED * delta

func _on_player_detection_body_entered(body):
	if body.name == "CharacterBody2D":
		chase = true

func _on_player_detection_body_exited(body):
	if body.name == "CharacterBody2D":
		chase = false
		
func _on_player_death_body_entered(body):
	if body.name == "CharacterBody2d":
		death()

func _on_player_collison_body_entered(body):
	if body.name == "CharacterBody2d":
		death()

func death():
	chase = false
	self.queue_free()

