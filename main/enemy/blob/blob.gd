# The 3D ink blobs that emit from enemies when they are killed
class_name Blob
extends Area

export var rand_size_limit: float = 0.1
export var rand_rotation_limit: float = 0.1
export var rand_process_speed_limit: float = 0.1
export var rand_velocity_limit: float = 0.1
export var gravity_strength: float = 3.0
export var initial_process_speed: float = 16.0
export var initial_velocity: float = 0.5
export var initial_height: float = 0.9

var color: Color
var initial_direction: Vector3
var velocity: Vector3
var process_speed: float

func _ready() -> void:
	set_process(false)
	initial_direction.y = initial_height
	initial_direction = initial_direction.rotated(Vector3.LEFT, rand_range(-rand_rotation_limit / 2, rand_rotation_limit / 2))
	initial_direction = initial_direction.rotated(Vector3.UP, rand_range(-rand_rotation_limit / 2, rand_rotation_limit / 2))
	
	velocity = initial_direction * (initial_velocity + rand_range(-rand_velocity_limit, rand_velocity_limit))
	
	process_speed = initial_process_speed
	process_speed *= 1.0 + rand_range(-rand_process_speed_limit, rand_process_speed_limit)
	
	$MeshInstance.scale *= 1.0 + rand_range(-rand_size_limit, rand_size_limit)
	$MeshInstance.get_active_material(0).albedo_color = color
	
	set_process(true)
	
	connect("body_entered", self, "_on_body_entered")

func _process(delta: float) -> void:
	velocity.y -= gravity_strength * delta
	global_translation += process_speed * velocity * delta

# Blobs should only detect collisions with the map
func _on_body_entered(body: PhysicsBody) -> void:
	$RayCast.cast_to = velocity.normalized() 
	$RayCast.force_raycast_update()
	if body.get_parent() is PaintMesh:
		body.get_parent().paint($RayCast.get_collision_point(), $RayCast.get_collision_normal(), color)
	queue_free()
