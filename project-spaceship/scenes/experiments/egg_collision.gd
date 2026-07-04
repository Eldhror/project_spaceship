extends CollisionShape3D

var mesh_flash 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mesh_flash = $"../MeshInstance3D".flash
	$"..".contact_monitor = true
	$"..".max_contacts_reported = 4

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_egg_body_entered(body: Node) -> void:
	mesh_flash.call() # Replace with function body.
