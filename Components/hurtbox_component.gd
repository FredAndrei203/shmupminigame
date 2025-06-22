class_name HurtboxComponent
extends Area2D

var damage: float
var hurtbox_active: bool = true:
	set(active):
		hurtbox_active = active
		if hurtbox_active:
			set_deferred("monitoring", true)
			set_deferred("monitorable", true)
		else:
			set_deferred("monitoring", false)
			set_deferred("monitorable", false)
