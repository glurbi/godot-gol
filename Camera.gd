extends Camera2D

var dragging = false
var from: Vector2

const GOL_EXTENT = Rect2(10.0, 10.0, 90.0, 90.0)

func _ready():
	set_process_input(true)
	position = Vector2(50, 50)
	
func _input(e):
	
	if e is InputEventMouseButton:
		get_tree().set_input_as_handled()
		dragging = e.pressed
		from = get_local_mouse_position()
		
	if e is InputEventMouseMotion and dragging:
		get_tree().set_input_as_handled()
		var lmp = get_local_mouse_position()
		var move = transform.get_scale() * (from - lmp)
		if (is_within_camera_bounds(move)):
			position += move
			from = lmp
		
	if e is InputEventPanGesture:
		get_tree().set_input_as_handled()
		var z = zoom * (1.0 + e.get_delta().y)
		var zoom_save = zoom
		zoom = Vector2(clamp(z.x, 0.01, 0.5), clamp(z.y, 0.01, 0.5))
		if not is_within_camera_bounds(Vector2(0,0)):
			zoom = zoom_save

func is_within_camera_bounds(move):
	var ctrans = get_canvas_transform()
	var min_pos = -ctrans.get_origin() / ctrans.get_scale()
	var view_size = get_viewport_rect().size / ctrans.get_scale()
	var max_pos = min_pos + view_size
	var extent = Rect2(min_pos + move, view_size)
	#print("{0}{1}{2}{3}".format([min_pos, view_size, max_pos, position]))
	return extent.intersects(GOL_EXTENT)

