# Screen Wrapper for nodes. A screen-wrapper node cannot abandon the screen viewport in which it
# is rendered. When the node crosses the boundaries of the viewport it is placed at the exact
# oposite point of the screen. To screen wrap, the scene generates two clones of the node for
# the X & Y axis. These clones are placed off-screen and track the wrapped node. When the node
# approaches the boundaries the clones (mirrors) also do, so when the node touches the boundaries,
# but do not fully crosses them, the part which overpassed the boundaries is already visible in
# the opposite screen boundary.
extends Node

# Node we want to screen-wrap
var mirrored_node = null
# Clone of the mirrored object that will be moved accross X axis when original object moves
var x_mirror = null
# Clone of the mirrored object that will be moved accross X axis when original object moves
var y_mirror = null

# Returns a clone of +node_to_mirror+
# - [Node2D] node_to_mirror node to screen-wrap
# - [String] cloned_node_name name of the clonned node
# - [Lambda] node_initializer (optional) method to initialize clonned node
func _mirror(node_to_mirror, cloned_node_name, node_initializer = null):
	# Duplicate the node we want to clone
	var mirrored_in_game_ship = node_to_mirror.duplicate()

	# Assign a name to clonned node for better identification
	mirrored_in_game_ship.name = cloned_node_name

	if(node_initializer): node_initializer.call(mirrored_in_game_ship)
	
	return mirrored_in_game_ship

# Initializes the screen wrapping
# 
# - [Node2D] parent_node parent node of the one we want to screen-wrap
# - [Node2D] node_to_mirror node to screen-wrap
# - [Lambda] node_initializer (optional) method to initialize clonned node
func initialize(parent_node, node_to_mirror, node_initializer = null):
	x_mirror = _mirror(node_to_mirror, "XMirror", node_initializer)
	y_mirror = _mirror(node_to_mirror, "YMirror", node_initializer)

	mirrored_node = node_to_mirror

	parent_node.add_child(x_mirror)
	parent_node.add_child(y_mirror)

# Updates screen-wrap node mirrors according to node position,
# so the node gives the illusion of having the same node visible
# in both sides of the viewport when crossing its boundaries
#
# - [Vector2D] viewport_size viewport width and height.
func _update_mirrors_position_and_rotation(viewport_size):
	var viewport_center = viewport_size / 2

	x_mirror.rotation = mirrored_node.rotation
	x_mirror.position.y = mirrored_node.position.y

	y_mirror.rotation = mirrored_node.rotation
	y_mirror.position.x = mirrored_node.position.x
	
	if mirrored_node.position.x > (viewport_center.x):
		x_mirror.position.x = -(viewport_size.x - mirrored_node.position.x)
	else:
		x_mirror.position.x = viewport_size.x + mirrored_node.position.x

	if mirrored_node.position.y > (viewport_center.y):
		y_mirror.position.y = -(viewport_size.y - mirrored_node.position.y)
	else:
		y_mirror.position.y = viewport_size.y + mirrored_node.position.y

# Keeps screen-wrap node between viewport boundaries, by setting the x / y position
# values to 0 / viewport size when it touches the right/bottom left/top boundaries
#
# - [Vector2D] viewport_size viewport width and height.
func _wrap_mirrores_node_in_viewport(viewport_size):
	mirrored_node.position.x = wrapf(mirrored_node.position.x, 0, viewport_size.x)
	mirrored_node.position.y = wrapf(mirrored_node.position.y, 0, viewport_size.y)

# Interface for nodes using the +ScreenWrapper+ scene to screen
# wrap the screen-wrapped node once it has been initialized
func screen_wrap(viewport_size = get_viewport().size):
	_wrap_mirrores_node_in_viewport(viewport_size)
	_update_mirrors_position_and_rotation(viewport_size)
