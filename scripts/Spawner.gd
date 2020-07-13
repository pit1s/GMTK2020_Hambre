extends Node


export var serve_by_time = true
var can_serve = true
var wave_done = false

var menu = [
	"scenes/Apple.tscn",
	"scenes/Tomato.tscn",
	"scenes/Blueberry.tscn",
	"scenes/Orange.tscn",
	"scenes/Cupcake.tscn",
	"scenes/Cupcake.tscn"
]

var dirs = [
	Vector2.UP,
	Vector2.DOWN,
	Vector2.LEFT,
	Vector2.RIGHT
]

onready var rnd_timer = get_node("RoundTimer")
onready var wave_timer = get_node("WaveTimer")

func _ready():
	randomize()
	print_debug(name, " is ready")
	self.position = GameManager.center_scene()
	rnd_timer.connect("timeout", self, "on_rnd_timer_timeout")
	wave_timer.connect("timeout", self, "on_wave_timer_timeout")

func _process(delta):
	if not GameManager.food_is_over:
		if wave_done:
			if get_child_count() <= 6:
				print_debug("here")
				wave_timer.start()
				can_serve = true
				wave_done = false
		elif serve_by_time:
			if can_serve:
				for dir in dirs:
					serve_food(set_spawn_position(dir))
		elif Input.is_action_just_pressed("ui_accept"):
			for dir in dirs:
				serve_food(set_spawn_position(dir))
		
		
		
func on_rnd_timer_timeout():
	rnd_timer.stop()
	can_serve = true
#	print_debug("can_serve ", can_serve)

func on_wave_timer_timeout():
	wave_timer.stop()
	can_serve = false
	wave_done = true
#	print_debug("can_serve ", can_serve)

func serve_food(spawn_pos):
	if serve_by_time:
		can_serve = false
		rnd_timer.start()
	var food = load(menu[randi() % menu.size()])
#	var food = menu[2]
	var serving = food.instance()
	serving.position = spawn_pos
#	print_debug("instance ", serving.name, " at position ", spawn_pos)
	add_child(serving)

func set_spawn_position(d):	
	return d * 800

