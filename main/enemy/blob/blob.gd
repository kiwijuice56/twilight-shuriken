class_name Blob
extends Area

export var rand_size_limit: float = 0.1
export var rand_rotation_limit: float = 0.1
export var rand_speed_limit: float = 0.1
export var gravity_strength: float = 3.0
export var speed: float = 16.0

var direction: Vector3
var velocity: Vector3

func _ready() -> void:
	set_process(false)
	direction = direction.rotated(Vector3.LEFT, rand_range(-rand_rotation_limit / 2, rand_rotation_limit / 2))
	direction = direction.rotated(Vector3.FORWARD, rand_range(-rand_rotation_limit / 2, rand_rotation_limit / 2))
	velocity = direction
	speed *= 1.0 + rand_range(-rand_speed_limit, rand_speed_limit)
	$MeshInstance.scale *= 1.0 + rand_range(-rand_size_limit, rand_size_limit)
	set_process(true)
	
	connect("body_entered", self, "_on_body_entered")

func _process(delta: float) -> void:
	velocity.y -= gravity_strength * delta
	global_translation += speed * velocity * delta

func _on_body_entered(body: PhysicsBody) -> void:
	$RayCast.cast_to = velocity.normalized() 
	$RayCast.force_raycast_update()
	body.get_parent().paint($RayCast.get_collision_point(), $RayCast.get_collision_normal())
	queue_free()
