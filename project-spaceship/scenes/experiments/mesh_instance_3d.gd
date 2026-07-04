extends MeshInstance3D

var mat
var flash_on = false
var flash_time = 100
var flash_start

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mat = $".".get_active_material(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if flash_on and flash_start+flash_time < Time.get_ticks_msec():
		flash_on = false
		mat.albedo_color = Color.html("#5a6566") 

func flash():
	flash_start = Time.get_ticks_msec()
	mat.albedo_color =  Color.html("#ff3981")
	flash_on = true

	
