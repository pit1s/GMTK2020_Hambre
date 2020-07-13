extends ProgressBar

var colors = [
	Color.red,
	Color.aqua,
	Color.green
]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	self_modulate = colors[set_color()]
	
func set_color():
	var current_value = value / max_value
	if current_value <= .33:
		return 0
	elif current_value <= .66:
		return 1
	elif current_value <= 1:
		return 2
