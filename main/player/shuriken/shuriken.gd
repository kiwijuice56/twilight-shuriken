extends KinematicBody
class_name Shuriken

export var rand_rotation_limit: float = 6.0
export var speed: float = 1.8
export var mesh_rotation_speed: float = 21.0
export var stabilize_amount: float = 2.0

onready var mesh: MeshInstance = $MeshInstance

var direction: Vector3
var desired_direction: Vector3
var mesh_variations: Array = [
	preload("res://main/player/shuriken/shuriken_model_a.obj"),
	preload("res://main/player/shuriken/shuriken_model_b.obj"),
	preload("res://main/player/shuriken/shuriken_model_c.obj")
]

func _ready() -> void:
	$Hurtbox.connect("body_entered", self, "_on_hit_map")
	$WooshSoundSpawner.play_sound()

func _physics_process(delta: float) -> void:
	var collision: KinematicCollision = move_and_collide(direction * speed)
	if not collision == null:
		stop_flying()
		hit_wall(collision)
	else:
		mesh.rotate_y(mesh_rotation_speed * delta)
		direction = lerp(direction, desired_direction, delta * stabilize_amount)

func _on_hit_map(body: Node) -> void:
	pass

func randomize_apperance() -> void:
	rotate_x(randf() * rand_rotation_limit - rand_rotation_limit / 2.0)
	rotate_y(randf() * rand_rotation_limit - rand_rotation_limit / 2.0)
	rotate_z(randf() * rand_rotation_limit - rand_rotation_limit / 2.0)
	mesh.mesh = mesh_variations[0] # randi() % len(mesh_variations)]

func stop_flying() -> void:
	speed = 0
	$Hurtbox.queue_free()
	$WooshSoundSpawner.stop_all()
	$TrailParticles.emitting = false
	set_physics_process(false)

func hit_wall(collision: KinematicCollision) -> void:
	$HitParticles.global_rotation = Vector3()
	$HitParticles.direction = collision.normal
	$HitParticles.emitting = true
	$HitSoundSpawner.play_sound()
