extends Area2D

const ArmourType = preload("res://BaseClasses/Damage/ArmourType.gd").ArmourType

var armour_type: int = ArmourType.LIGHT

@onready var armour_label = $Label

func _ready():
	# Randomize armour_type
	armour_type = ArmourType.values()[randi() % ArmourType.values().size()]
	
	# Update the label to reflect the armour type
	armour_label.text = ArmourType.keys()[armour_type]

func _on_body_entered(body):
	if body is BaseCharacter:
		body.armour_type = armour_type
		queue_free()  # Remove the drop after it's picked up
