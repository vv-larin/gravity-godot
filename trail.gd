extends Node2D

const SAMPLE_INTERVAL: float = 0.1
const MAX_POINTS: int = 600

@export var circle_radius: float = 1.0

var points: Array[Vector2] = []
var elapsed: float = 0.0

@onready var planet: Node2D = get_parent() as Node2D

func _ready() -> void:
	top_level = true
	global_transform = Transform2D.IDENTITY
	z_index = -1

func _physics_process(delta: float) -> void:
	elapsed += delta

	if elapsed < SAMPLE_INTERVAL:
		return

	elapsed -= SAMPLE_INTERVAL
	points.append(planet.global_position)

	if points.size() > MAX_POINTS:
		points.pop_front()


func _process(_delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	var camera: Camera2D = get_viewport().get_camera_2d()
	var zoom_level: float = 1.0

	if camera != null:
		zoom_level = camera.zoom.x

	var radius: float = circle_radius / zoom_level
	var thickness: float = 1.0 / zoom_level

	for point in points:
		draw_circle(point, radius, Color.WHITE, false, thickness, true)
