extends Node

func _ready() -> void: # _ready function runs once all children have initialized. Using for a main function here.
	#Campus child is acting as data structure holding the nodes and edges. Placeholder for non-hardcoded solutions.
	$Map.Load_Map_Image()
	$Campus.Read_Graph_Data()
	
	var verts = $Campus.Vertices #Vertices are stored in a dictionary, with the key:vertex name and value:vertex location
	var edges = $Campus.Edges #Edges are store as arrays [Vertex 1, Vertex 2, Weight]
	var keys = verts.keys()
	keys.sort() #Sort keys for dropdown legibility
	for vert in keys: #Add each vertex to the graph and non-transitory ndoes to the UI selectors
		$Graph.Add_Vert(vert,verts[vert],$Map.New_Dot(), $Map.New_Label(vert))
		if vert.substr(0,2) != "RS" and vert.substr(0,2) != "SQ":
			$UI/Selectors/StartSelector.add_item(vert)
			$UI/Selectors/EndSelector.add_item(vert)
	$UI.scale = Vector2(0.8,1)
	for edge in edges: #Add each edge to the graph and add a visual representation to the map
		$Graph.Add_Edge(edge[0],edge[1],edge[2])
		$Map.Add_Ghost_Edge(verts[edge[0]],verts[edge[1]],edge[2])

func Shortest_Path(): #Function triggered by signals emitted when the selectors are changed
	$Map.Clear_Lines() #Clear any existing highlighted lines.
	#Get shortest path data
	var path = $Graph.Shortest_Path($UI/Selectors/StartSelector.get_item_text($UI/Selectors/StartSelector.selected),$UI/Selectors/EndSelector.get_item_text($UI/Selectors/EndSelector.selected))
	#Set UI labels and create highlighted lines
	$UI/Distance.text = "Distance : " + str(path[0])
	var line: Array = []
	for vert in path[1]:
		line.append($Graph.Vertices[vert].Coords)
	$Map.Add_Line(line)
	$UI/Path.text = ""
	for i in range(0, path[2].size()):
		$UI/Path.text = $UI/Path.text + path[1][i] + " to " + path[1][i+1] + ": " + str(path[2][i]) + "\n"
	if path[0] == -1: #If shortest path function returns code for disconnected nodes, overwrite UI elements
		$UI/Distance.text = "Distance : -"
		$UI/Path.text = "Start and end nodes are not connected."
