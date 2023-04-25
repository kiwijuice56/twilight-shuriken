extends KinematicBody
class_name Bullet

export var rand_rotation_limit: float = 8.0
export var speed: float = 1.3
export var mesh_rotation_speed: float = 21.0

onready var mesh: MeshInstance = $MeshInstance

var direction: Vector3
var mesh_variations: Array = [
	preload("res://main/player/shuriken/shuriken_model_a.obj"),
	preload("res://main/player/shuriken/shuriken_model_b.obj"),
]

func _ready() -> void:
	$Hurtbox.connect("body_entered", self, "_on_hit_map")
	$WooshSoundSpawner.play_sound()

func _physics_process(delta: float) -> void:
	if not move_and_collide(direction * speed) == null:
		speed = 0
		$Hit.play_sound()
		$Hitbox.queue_free()
		$TrailParticles.emitting = false
		$WooshSoundSpawner.stop_all()
		set_physics_process(false)
	else:
		mesh.rotate_y(mesh_rotation_speed * delta)

func randomize_apperance() -> void:
	rotate_x(randf() * rand_rotation_limit - rand_rotation_limit / 2.0)
	rotate_y(randf() * rand_rotation_limit - rand_rotation_limit / 2.0)
	rotate_z(randf() * rand_rotation_limit - rand_rotation_limit / 2.0)
	mesh.mesh = mesh_variations[randi() % len(mesh_variations)]

func _on_hit_map(body: Node) -> void:
	pass
