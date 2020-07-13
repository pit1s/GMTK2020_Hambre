extends Menu


onready var score = get_node_or_null("Sprite/RichTextLabel")

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	score.text = str(GameManager.game_over_points)
