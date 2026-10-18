extends Node2D

const G: float = 8e-7
const SOLAR_MASS: float = 330000.0
const DIST_SCALE: float = 100.0
const TIME_SCALE: float = 10.0

@export var orbit_radius: float = 1.0
@export var display_radius: float = 5.0
@export var body_color: Color = Color.CYAN

var simulation_position: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	simulation_position = Vector2(orbit_radius, 0.0)
	velocity = Vector2(0.0, sqrt(G * SOLAR_MASS / orbit_radius))
	update_visual_position()

func update_visual_position() -> void:
	position = Vector2(simulation_position.x, -simulation_position.y) * DIST_SCALE

func _physics_process(delta: float) -> void:
	var dt: float = delta / TIME_SCALE
	var r_squared: float = simulation_position.length_squared()

	if r_squared == 0.0:
		return

	var acceleration: Vector2 = (-simulation_position.normalized() * G * SOLAR_MASS / r_squared)

	velocity += acceleration * dt
	simulation_position += velocity * dt
	update_visual_position()

func _draw() -> void:
	draw_circle(Vector2.ZERO, display_radius, body_color)
