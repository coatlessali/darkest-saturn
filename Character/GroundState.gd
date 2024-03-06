extends State

class_name GroundState

@export var jump_velocity : float = -150.0
@export var air_state : State
@export var running_state : State

func state_process(_delta, direction):
	# you shouldn't be in the air!
	if(!character.is_on_floor()):
		next_state = air_state
	else:
		#print(direction.x)
		# check if we're pressing anything and transition into running
		if direction.x != 0:
			#character.local_velocity.x = move_toward(character.local_velocity.x, character.local_velocity_cap*sign(direction.x), character.speed)
			character.local_velocity.x = character.speed*sign(direction.x) 
			next_state = running_state
			playback.travel("running")
		else:
			character.local_velocity.x = 0

func state_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		jump()
	

func jump():
	character.local_velocity.y = jump_velocity
	next_state = air_state
	playback.travel("jump_end")
