extends Area2D

const ArmourType = preload("res://BaseClasses/Damage/ArmourType.gd").ArmourType

var armour_type: ArmourType = ArmourType.LIGHT

const ArmourTypesArray = [
	ArmourType.LIGHT,
	ArmourType.MEDIUM,
	ArmourType.HEAVY,
	ArmourType.HAZMAT,
	ArmourType.STEALTH,
	ArmourType.TEMPORAL,
	ArmourType.RIOT,
	ArmourType.NANOFIBER,
	ArmourType.ENERGY_SHIELD
]

@onready var armour_label = $Label

func _ready():
	# Randomize armour_type
	armour_type = ArmourTypesArray[randi() % ArmourTypesArray.size()]
	
	# Update the label to reflect the armour type
	armour_label.text = armour_type_to_string(armour_type)

func _on_body_entered(body):
	if body is BaseCharacter:
		body.armour_type = armour_type
		queue_free()  # Remove the drop after it's picked up

func armour_type_to_string(type: ArmourType) -> String:
	match type:
		ArmourType.LIGHT: return "Light"
		ArmourType.MEDIUM: return "Medium"
		ArmourType.HEAVY: return "Heavy"
		ArmourType.HAZMAT: return "Hazmat"
		ArmourType.STEALTH: return "Stealth"
		ArmourType.TEMPORAL: return "Temporal"
		ArmourType.RIOT: return "Riot"
		ArmourType.NANOFIBER: return "Nanofiber"
		ArmourType.ENERGY_SHIELD: return "Energy Shield"
		_: return "Unknown Armour Type"
