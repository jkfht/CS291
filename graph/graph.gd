extends Node
#Data object for the graph. Also preforms the shortest path calculation.
@export var Vertices: Dictionary = {} #Vertices stored in dictionary under their names
@export var Edges: Array = [] #Edges in unsorted array

#Create the vertex and edge objects and add them to the graph.
func Add_Vert(Name: String, Coords: Vector2i = Vector2i(0,0), Dot: Sprite2D = null, Lab: Label = null):
	var vert = preload("res://graph/vertex.tscn").instantiate()
	vert.init(Name, Coords, Dot)
	Lab.position = Coords + Vector2i(-10,10) #Set the position of the vertex on the map.
	Vertices[Name] = vert
func Add_Edge(Vert1: String, Vert2: String, Weight:float, Line:Line2D = null):
	var edge = preload("res://graph/edge.tscn").instantiate()
	edge.init(Vertices[Vert1], Vertices[Vert2], Weight)	
	Edges.append(edge)
	
func Shortest_Path(Start:String, End:String)->Array:
	var Vert_Tracks: Dictionary = {}
	for vert in Vertices: #Initialize all distances to effectively infinite value
		Vert_Tracks[vert] = [999999,[],[]]
	Vert_Tracks["Dummy-1"] = [999999,[],[]] #Dummy value for comparing other path lengths against
	var Visited = []
	Vert_Tracks[Start] = [0,[Start],[]] #Set start distance to 0
	while Visited.size() < Vertices.size(): #Loop until all vertices visited
		var Min_Vert = "Dummy-1"
		for vert in Vert_Tracks: #Find unvisited vertex with the shortest distance
			if Vert_Tracks[vert][0] < Vert_Tracks[Min_Vert][0] and !Visited.has(vert):
				Min_Vert = vert
		if Min_Vert == "Dummy-1": #If there are no vertices with value less than the dummy, graph is disconnected with no path between start and end, return fail value
			if Vert_Tracks[End][0] == 999999:
				Vert_Tracks[End] = [-1,[],[]]
			break
		Visited.append(Min_Vert)
		if Min_Vert == End: #If visiting the end node, escape early; visited nodes have had their minimum path identified.
			break
		for edge in Vertices[Min_Vert].Incidents:
			if edge["Edge"].Weight + Vert_Tracks[Min_Vert][0] < Vert_Tracks[edge["Adjacent"].Name][0]:
				Vert_Tracks[edge["Adjacent"].Name][0] = edge["Edge"].Weight + Vert_Tracks[Min_Vert][0]
				Vert_Tracks[edge["Adjacent"].Name][1] = Vert_Tracks[Min_Vert][1].duplicate()
				Vert_Tracks[edge["Adjacent"].Name][1].append(edge["Adjacent"].Name)
				Vert_Tracks[edge["Adjacent"].Name][2] = Vert_Tracks[Min_Vert][2].duplicate()
				Vert_Tracks[edge["Adjacent"].Name][2].append(edge["Edge"].Weight)
	return Vert_Tracks[End]
