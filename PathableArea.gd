extends NavigationRegion2D

var new_navigation_polygon: NavigationPolygon = get_navigation_polygon()

func _ready():

	parse_2d_collisionshapes(self)

	new_navigation_polygon.make_polygons_from_outlines()
	set_navigation_polygon(new_navigation_polygon)

func parse_2d_collisionshapes(root_node: Node2D):
	print("root_node: ", root_node.name)

	for node in root_node.get_children():
		print("node: ", node.name)

		if node.get_child_count() > 0:
			parse_2d_collisionshapes(node)

		if node is CollisionPolygon2D:
			print("CollisionPolygon2D: ", node.name)

			var collisionpolygon_transform: Transform2D = node.get_global_transform()
			var collisionpolygon: PackedVector2Array = node.polygon

			var new_collision_outline: PackedVector2Array = collisionpolygon_transform * collisionpolygon

			new_navigation_polygon.add_outline(new_collision_outline)

