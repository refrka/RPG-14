class_name EquipmentSlot extends ItemSlot


enum EquipmentType {

	WEAPON,

	ARMOR,

	TOOL,

}


@export var equipment_type: EquipmentType





func can_accept_item(_item: Item) -> bool:

	return _item is Weapon