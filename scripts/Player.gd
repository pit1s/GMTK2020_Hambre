extends KinematicBody2D

const FORK_RANGE = 48

var rotateable = true
var fork_reach = null
var can_eat = true

onready var fork = get_node("RayCast2D")
onready var sprite = get_node("Sprite")
onready var dead_sprite = get_node("Dead")
onready var move_timer = get_node("MoveTimer")
onready var eat_timer = get_node("EatTimer")
onready var grab = get_node("Grab")
onready var star = get_node("Star")
onready var chomp = get_node("Chomp")

export var health = 50
var health_diff = 0
var points = 0
export var bite_damage = 1

var star_power = false


func _ready():
	print_debug(name, " is ready")
	position = GameManager.center_scene()
	GameManager.food_is_over = false
	fork_reach = Vector2.DOWN * FORK_RANGE
	fork.cast_to = fork_reach
	move_timer.connect("timeout", self, "on_move_timer_timeout")
	eat_timer.connect("timeout", self, "on_eat_timer_timeout")
	
func _process(delta):
	pass
	
func _physics_process(delta):
	update()
	if not GameManager.food_is_over:
		if rotateable:
			if Input.is_action_pressed("ui_left"):
				rotate_player(90)
			if Input.is_action_pressed("ui_right"):
				rotate_player(-90)
		aim_fork()
	
#func _draw():
#	draw_line(Vector2(), fork_reach, Color.red)
	
func on_move_timer_timeout():
	move_timer.stop()
	rotateable = true
#	print_debug("rotateable ", rotateable)

func on_eat_timer_timeout():
	eat_timer.stop()
	can_eat = true
#	print_debug("rotateable ", rotateable)

func rotate_player(dir):
	rotation_degrees += dir
	if abs(rotation_degrees) == 360:
		rotation_degrees = 0
	rotateable = false
#	print_debug("rotateable ", rotateable)
	move_timer.start()
	
func aim_fork():
	if fork.is_colliding():
		var food = fork.get_collider()
		if food.type == 1 or star_power:
			eat_food(food)
		elif can_eat:
			if Input.is_action_just_pressed("ui_down"):
				eat_food(food)
			
func eat_food(fd):
	chomp.play("Chomp")
	can_eat = false
	eat_timer.start()
#	print_debug("eating ", fd, " doing ", bite_damage, " damage")
	health_diff = fd.take_bite(bite_damage)
	if star_power: 
		can_eat = true
		health_diff = abs(health_diff)
	health += health_diff
	if (fd.type != 1) or (star_power):
		points += health_diff
	GameManager.update_ui(health, points)
	health_check()
		
			
func health_check():
	print_debug(points)
#	print_debug("player health ", health)
	grab.play("Grab")
	health_diff = 0
	if health >= 100:
		if not star_power:
			set_star_status()
	elif health <= 0:
		dead_sprite.visible = true
		GameManager.game_over()

func set_star_status():
#	print_debug("enter star status")
	star_power = true
	star.play("Star")
	yield(get_tree().create_timer(10), "timeout")
	star_power = false
	star.stop()
	self_modulate = Color.white
	health = 50
	GameManager.update_ui(health, points)
#	print_debug("exit star status")
