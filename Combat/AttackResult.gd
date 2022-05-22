extends Reference

class_name AttackResult

var attacker setget ,get_attacker
var victim setget ,get_victim
var base_damage: float setget ,get_base_damage
var critical_damage: float setget ,get_critical_damage
var total_damage: float setget ,get_total_damage

func _init(attacker_, victim_, base_damage_: float, critical_damage_: float):
	attacker = attacker_
	victim = victim_
	base_damage = base_damage_
	critical_damage = critical_damage_
	total_damage = base_damage + critical_damage

func _to_string():
	return "{atkr} dealt {totl} damage ({base} : base, {crit} : critical) to {vict}".format({"atkr": attacker, "totl": total_damage, "base": base_damage, "crit": critical_damage, "vict": victim})

func get_attacker():
	return attacker

func get_victim():
	return victim

func get_base_damage() -> float:
	return base_damage

func get_critical_damage() -> float:
	return critical_damage

func get_total_damage() -> float:
	return base_damage + total_damage

