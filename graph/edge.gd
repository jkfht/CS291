extends Node
#Data object for edges
@export var Incidents: Array = [null,null] #Incidents to contain the start and end nodes
@export var Weight: float
@export var Line: Line2D
@export var Coord_List: Array

#Set the line's incidents and weight. Adds the edge to each vertex's incidents list.
func init(Vert1: Node, Vert2:Node, WeightParam: float = 1): 
	Incidents[0] = Vert1
	Vert1.Incidents.append({"Self": Vert1, "Adjacent": Vert2, "Edge": self})
	Incidents[1] = Vert2
	Vert2.Incidents.append({"Self": Vert2, "Adjacent": Vert1, "Edge": self})
	Weight = WeightParam
