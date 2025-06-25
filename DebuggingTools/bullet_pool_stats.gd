class_name BulletPoolStats
extends VBoxContainer

#I use this developer tool to debug my BulletPool autoloader

#The labels
@onready var total_instances_label = $TotalInstances
@onready var pooled_count_label = $Pooled
@onready var unpooled_count_label = $Unpooled
@onready var discrepancy_label = $Discrepancy

#The bullet type that the pool I'm testing holds
var bullet_type_target: BulletPool.bullet_types = BulletPool.bullet_types.SHOTGUNEER

#Check the number of the bullets, how many of them are pooled and unpooled, and the discrepancy
#(Discrepancy should be 0)
func _process(delta: float) -> void:
	count_total_instances_of_type(bullet_type_target)
	count_pooled_instances_of_type(bullet_type_target)
	count_unpooled_instances_of_type(bullet_type_target)
	get_discrepancy_of_type(bullet_type_target)

#Count number of bullets of a type instantiated
func count_total_instances_of_type(type: BulletPool.bullet_types):
	var instances: Array = BulletPool.get_children_of_type(type)
	total_instances_label.text = "Total bullets in scene: " + str(instances.size())

#Count number of bullets of that type pooled
func count_pooled_instances_of_type(type: BulletPool.bullet_types):
	var pool = BulletPool.bullet_pools[type]
	pooled_count_label.text = "Pooled: " + str(pool.size())

#Count number of bullets of that type unpooled
func count_unpooled_instances_of_type(type: BulletPool.bullet_types):
	var unpooled = BulletPool.unpooled_bullets[type]
	unpooled_count_label.text = "Unpooled: " + str(unpooled.size())

#Check the discrepancy between the number of bullets of that type instantiated, and
#the number of pooled plus unpooled bullets
func get_discrepancy_of_type(type: BulletPool.bullet_types):
	var instances: Array = BulletPool.get_children_of_type(type)
	var pool = BulletPool.bullet_pools[type]
	var unpooled = BulletPool.unpooled_bullets[type]
	var discrepancy: int = instances.size() - (pool.size() + unpooled.size())
	discrepancy_label.text = "Discrepancy: " + str(discrepancy)
