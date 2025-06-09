extends CharacterBody2D
class_name Bird

signal game_started

@export var gravity = 900.00
@export var jump_force = - 300
@export var rotation_speed = 2
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var should_process_input = true
var is_started = false
var max_speed = 400

func _ready():
	velocity = Vector2.ZERO
	animation_player.play("Idle")
	
func _physics_process(delta): 
	if Input.is_action_just_pressed("Jump") && should_process_input:
		if !is_started:
			game_started.emit() 
			animation_player.play("Wing_Flap")
			is_started = true
		jump()
	
	if !is_started:
		return
	velocity.y += gravity*delta
	velocity.y = min (velocity.y , max_speed)
	
	move_and_collide(velocity * delta)
	
	rotate_bird()
		
	
func jump():
	rotation = deg_to_rad(-30)
	velocity.y=jump_force
func rotate_bird():
	#rotating downwards when falling
	if velocity.y >0 && rad_to_deg(rotation)< 90:
		rotation += rotation_speed * deg_to_rad(1)
		#rotate upward when jumping
	elif velocity.y < 0 && rad_to_deg(rotation)>-30:
		rotation -= rotation_speed * rad_to_deg(1)

func kill():
	should_process_input = false

func stop():
	animation_player.stop()
	gravity = 0 
	velocity = Vector2.ZERO
	should_process_input = false
