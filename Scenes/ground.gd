extends Node2D

class_name Ground

signal bird_crashed

@export var speed = -150

@onready var sprite1 = $Ground1/Sprite2D
@onready var sprite2 = $Ground2/Sprite2D


func _ready(): 
	sprite2.global_position.x = sprite1.global_position.x + sprite1.texture.get_width()
	
func _process(delta):
	sprite1.global_position.x += speed * delta
	sprite2.global_position.x += speed * delta
	
	#If sprite 1 has completely left the screen, move it to the right end of sprite 2
	#A more math way, if sprite 1 has travled it's entire width, it will be off the screen
	#so, we move it to the right of sprite 2.
	#The comparion < - sprite.1 serves to show that as the position of sprite moves in the -x direction
	#and starts becoming less than negative of the width, it will have traveled off the screen
	if sprite1.global_position.x < -sprite1.texture.get_width():
		sprite1.global_position.x = sprite2.global_position.x + sprite2.texture.get_width()
		
	if sprite2.global_position.x < -sprite2.texture.get_width():
		sprite2.global_position.x = sprite1.global_position.x + sprite1.texture.get_width()


func _on_body_entered(body):
	bird_crashed.emit()
	stop()
	(body as Bird).stop()
func stop():
	speed = 0
