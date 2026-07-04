extends Node3D

var timer = 0.0
var state = 0
var rng = RandomNumberGenerator.new()

func _enderman() -> void:
	var jumprange = 5
	var dX = rng.randf_range(-jumprange, jumprange)
	var dY = rng.randf_range(0, jumprange)
	var dZ = rng.randf_range(-jumprange, jumprange)
	$".".translate(Vector3(dX, dY, dZ)) 
	$AudioStreamPlayer3D.play()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	if timer > 2:
		timer = 0
		state+=1
		
	if state == 1:
		var material = $MeshInstance3D.get_surface_override_material(0)
		material.albedo_color = Color(1, 0, 0)
		$MeshInstance3D.set_surface_override_material(0, material)
	
	if state == 2:
		var material = $MeshInstance3D.get_surface_override_material(0)
		material.albedo_color = Color(0, 1, 0)
		$MeshInstance3D.set_surface_override_material(0, material)
		
	if state == 3:
		_enderman()
	
	if state == 3:
		state = 1
