extends Node

#Stores vertices and edges to be read into the program. Separated due to constraints of prior versions.
#Reads the graph data from a json file in the executable directory
@export var Vertices: Dictionary 
@export var Edges: Array

func Read_Graph_Data():
	var file
	if OS.has_feature("standalone"):
		file = FileAccess.open(OS.get_executable_path().get_base_dir()+"/graph_sets.json", FileAccess.READ)
	else:
		file= FileAccess.open("res://graph_sets.json", FileAccess.READ)
	var json_string = file.get_as_text()
	var json = JSON.parse_string(json_string)
	Vertices = json["Vertices"]
	for vert in Vertices:
		Vertices[vert] = Vector2i(Vertices[vert][0],Vertices[vert][1])
	Edges = json["Edges"]
