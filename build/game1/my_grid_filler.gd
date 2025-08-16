extends GridContainer


@export var inventory: GridInventory

# Called when the node enters the scene tree
func _ready() -> void:
	
	var inv = GridInventory.new()
	var db_res = preload("res://inv_database1.tres")
	inv.database = db_res
	inventory = inv
	inventory.add('item1',1)
	inventory.add('item1',3)
	var itemstack1: ItemStack = load("res://item1_res.tres")
	inventory.add(itemstack1.item_id)
	
	
	
	var item1 :ItemStack = inventory.get_stack_at(Vector2i(0,0))
	print("item1 amount", item1.amount)
	print("item1 resourcepath: ", item1.resource_path)
	item1.generate_scene_unique_id()
	item1.setup_local_to_scene()
	print("item1 resourcepath after gen: ", item1.resource_path)
	#print(item1.resource_path)
	
	
	print("LOADING INVENTORY")
	update_inventory_display()

# Updates the UI to reflect the current inventory state
func update_inventory_display() -> void:
	# Clear existing UI slots
	for child in get_children():
		child.queue_free()
	
	var item1 = inventory.database.get_item("item1")
		
	inventory.add(item1.id, 1)
	#inventory.add_on_new_stack("item1", 1)
	inventory.add("item2", 1)
	
	
	# Assuming GridInventory has an array of items
	print("invenitory has %d items" % [inventory.get_amount()])
	if inventory:
		for item_stack in inventory.stacks:
			var slot = create_inventory_slot(item_stack)
			add_child(slot)

# Creates a visual slot for an inventory item
func create_inventory_slot(item: ItemStack) -> Control:
	var slot = Button.new()
	slot.custom_minimum_size = Vector2(64, 64)
	
	# Create VBoxContainer to stack image and text
	var vbox = VBoxContainer.new()
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	vbox.custom_minimum_size = Vector2(64, 64)
	
	# Create TextureRect for the image
	var texture_rect = TextureRect.new()
	texture_rect.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	texture_rect.custom_minimum_size = Vector2(32, 32)  # Adjust size as needed
	
	# Create Label for the text
	var label = Label.new()
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	
	if item:
		# Set text
		label.text = item.item_id if item.item_id else "Unnamed"
		
		# Load texture
		if item.resource_path and ResourceLoader.exists(item.resource_path):
			
			var texture : Texture2D = inventory.database.get_item(item.item_id).icon 
			if texture:
				texture_rect.texture = texture
				print("Texture loaded for item ", item.item_id, ": ", item.resource_path)
			else:
				print("Failed to load texture at: ", item.resource_path)
				texture_rect.texture = null
				label.text = "No Texture"
		else:
			print("Invalid or missing resource_path for item: ", item.item_id)
			texture_rect.texture = null
			label.text = "No Image"
	else:
		label.text = "Empty"
		texture_rect.texture = null
	
	# Add TextureRect and Label to VBoxContainer
	vbox.add_child(texture_rect)
	vbox.add_child(label)
	
	# Add VBoxContainer to Button
	slot.add_child(vbox)
	
	# Ensure button is clickable
	slot.mouse_filter = Control.MOUSE_FILTER_STOP
	slot.connect("pressed", Callable(self, "_on_slot_pressed").bind(item))
	
	# Add a simple style for visibility
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.2, 0.2, 0.2, 0.8)  # Dark background for visibility
	slot.add_theme_stylebox_override("normal", style)
	
	return slot
	
# Handles slot click events
func _on_slot_pressed(item: ItemStack) -> void:
	if item:
		print("Clicked item: ", item.item_id, "stack size", item.amount)
		# Add logic for item interaction (e.g., show details, use item)
	else:
		print("Clicked empty slot")

## Adds an item to the inventory and updates the UI
#func add_item(item) -> bool:
	#if inventory.add(item):  # Assuming GridInventory has an add_item method
		#update_inventory_display()
		#return true
	#return false
#
## Removes an item from the inventory and updates the UI
#func remove_item(item) -> bool:
	#if inventory.remove_item(item):  # Assuming GridInventory has a remove_item method
		#update_inventory_display()
		#return true
	#return false
