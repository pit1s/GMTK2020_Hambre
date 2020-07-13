extends Food

const type = 1
export var bites_left = 1
export var health = -20

func _ready():
	.init_prog_bar(bites_left)
	

func take_bite(bite):
	bites_left -= bite
	return .deal_damage(bite, bites_left, health)
