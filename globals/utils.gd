extends Node

# Globals
var currently_selected_item : ItemBase
var currently_hovered_item: ItemBase

var found_items: float = 0

# Enums
enum RARITY {
	COMMON,
	UNCOMMON,
	RARE,
	EPIC,
	LEGENDARY,
}
