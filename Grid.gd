extends MeshInstance2D

func _ready():
	
	var vertices = PoolVector2Array()
	var indices = PoolIntArray()
	for x in range(100):
		for y in range(100):
			vertices.push_back(Vector2(x, y))
			indices.push_back(x*100+y)
	var arr_mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(ArrayMesh.ARRAY_MAX)
	arrays[ArrayMesh.ARRAY_VERTEX] = vertices
	arrays[ArrayMesh.ARRAY_INDEX] = indices
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_POINTS, arrays)
	mesh = arr_mesh
