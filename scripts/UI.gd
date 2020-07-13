extends Node


var parent = null
var player = null
var prog_bar = null
var score = null

func _ready():
	player = get_parent().get_node("Player")
	prog_bar = get_node("PlayerHealth")
	score = get_node("PlayerScore")
	prog_bar.value = 50
	score.text = "Score: " + str(0)

func update(hp, pts):
	prog_bar.value = hp
	score.text = "Score: " + str(pts)
