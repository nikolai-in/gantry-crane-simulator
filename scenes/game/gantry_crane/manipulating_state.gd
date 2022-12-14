@tool
extends State


@onready var space: Node3D = owner.owner.get_node("Space")
var container: RigidBody3D


#
# FUNCTIONS TO INHERIT IN YOUR STATES
#

# This function is called when the state enters
# XSM enters the root first, the the children
func _on_enter(_args) -> void:
	print("Manipulating")


# This function is called just after the state enters
# XSM after_enters the children first, then the parent
func _after_enter(_args) -> void:
	pass


# This function is called each frame if the state is ACTIVE
# XSM updates the root first, then the children
func _on_update(_delta: float) -> void:
	if Input.is_action_pressed("arm_down"):
		%Arm.position.y -= 1 * _delta
	elif Input.is_action_pressed("arm_up"):
		%Arm.position.y += 1 * _delta
	elif Input.is_action_pressed("arm_left"):
		%Cabin.position.x -= 1 * _delta
	elif Input.is_action_pressed("arm_right"):
		%Cabin.position.x += 1 * _delta
	elif Input.is_action_pressed("container_action"):
		if container:
			%Arm.remove_child(container)
			space.add_child(container)
			container.position = Vector3(%Cabin.position.x, %Arm.position.y - 2, %Wheels.position.z)
			container.freeze = false
			container = null
			%CollisionShape3D.disabled = true
			%CollisionTimer.start()
	elif Input.is_action_just_pressed("crane_up") || Input.is_action_just_pressed("crane_down"):
		change_state("Moving")
	%Arm.position.y = clamp(%Arm.position.y, 4, 22)
	%Cabin.position.x = clamp(%Cabin.position.x, -9, 9)



# This function is called each frame after all the update calls
# XSM after_updates the children first, then the root
func _after_update(_delta: float) -> void:
	pass


# This function is called before the State exits
# XSM before_exits the root first, then the children
func _before_exit(_args) -> void:
	pass


# This function is called when the State exits
# XSM before_exits the children first, then the root
func _on_exit(_args) -> void:
	pass


# when StateAutomaticTimer timeout()
func _state_timeout() -> void:
	pass


# Called when any other Timer times out
func _on_timeout(_name) -> void:
	pass



func _on_area_3d_body_entered(body):
	if !container:
		container = body
		space.remove_child(body)
		%Arm.add_child(body)
		body.position = Vector3(0, -2, 0)
		body.freeze = true
	else:
		print("HOW!?")


func _on_collision_timer_timeout():
	%CollisionShape3D.disabled = false
