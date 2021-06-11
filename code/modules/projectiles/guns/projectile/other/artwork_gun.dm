/obj/item/weapon/gun/projectile/revolver/artwork_revolver
	name = "Weird Revolver"
	desc = "This is an artistically-made revolver with a limited use chameleon projector."
	icon = 'icons/obj/guns/projectile/artwork_revolver.dmi'
	icon_state = "artwork_revolver_1"
	item_state = "artwork_revolver_1"
	drawChargeMeter = FALSE
	max_shells = 6
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 4) //Arbitrary values
	matter = list(MATERIAL_PLASTEEL = 12, MATERIAL_WOOD = 6)
	price_tag = 1000
	damage_multiplier = 1.4 //From havelock.dm
	penetration_multiplier = 1.4
	recoil_buildup = 8 //Same as the Deckard

/obj/item/weapon/gun/projectile/revolver/artwork_revolver/Initialize()
	name = get_weapon_name(capitalize = TRUE)

	var/random_icon = rand(1,5)
	icon_state = "artwork_revolver_[random_icon]"
	item_state = "artwork_revolver_[random_icon]"


	var/sanity_value = 0.2 + pick(0,0.1,0.2)
	AddComponent(/datum/component/atom_sanity, sanity_value, "")

	. = ..()

/obj/item/weapon/gun/projectile/revolver/artwork_revolver/get_item_cost(export)
	. = ..()
	. += rand(0,2500)

/obj/item/weapon/gun/projectile/revolver/artwork_revolver/spin_cylinder()
	set name = "Spin revolver"
	set desc = "Fun when you're bored out of your skull. Or if you want to change your revolvers appearence."
	set category = "Object"

	chamber_offset = 0
	visible_message(SPAN_WARNING("\The [usr] spins \the [src]!"), \
	SPAN_NOTICE("You hear something metallic spin and click."))
	playsound(src.loc, 'sound/weapons/revolver_spin.ogg', 100, 1)
	loaded = shuffle(loaded)
	if(rand(1,max_shells) > loaded.len)
		chamber_offset = rand(0,max_shells - loaded.len)
	icon_state = "[icon_state]_spin"
	spawn(10)
		var/random_icon = rand(1,5)
		icon_state = "artwork_revolver_[random_icon]"


/obj/item/weapon/gun/projectile/automatic/artwork_pistol
	name = "Weird Pistol"
	desc = "This is an artistically-made pistol with a limited use chameleon projector."
	icon = 'icons/obj/guns/projectile/artwork_revolver.dmi'
	icon_state = "artwork_revolver_1"
	item_state = "artwork_revolver_1"
	drawChargeMeter = FALSE
	max_shells = 6
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 4) //Arbitrary values
	matter = list(MATERIAL_PLASTEEL = 12, MATERIAL_WOOD = 6)
	price_tag = 1000
	damage_multiplier = 1 //firefly
	penetration_multiplier = 1.4
	recoil_buildup = 6 //slighty more than the firefly
	var/finished = 0

/obj/item/weapon/gun/projectile/automatic/shotgun/pump/artwork_pshotgun

/obj/item/weapon/gun/projectile/automatic/shotgun/artwork_shotgun

var/obj/item/weapon/gun/projectile/automatic/artwork_rifle

var/obj/item/weapon/gun/projectile/automatic/artwork_sniper

/obj/item/weapon/gun/projectile/grenade/artwork_grenade


/obj/item/weapon/gun/projectile/automatic/artwork_pistol/AltClick(mob/user)
	if(finished)
		return FALSE
	var/list/gun_choices
	if(!gun_choices)
		gun_choices = list()
		for(var/gun_type in typesof(/obj/item/weapon/gun/) - src.type)
			var/obj/item/weapon/gun/G = gun_type
			src.gun_choices[initial(G.name)] = gun_type

	picked = input("Select Appearance", "Select Appearance") as anything in gun_choices

	if(!ispath(gun_choices[picked]))
		return
	..()



	var/obj/item/copy = new picked(null)

	icon = copy.icon
	icon_state = copy.icon_state
	item_state = copy.item_state
	item_icons = copy.item_icons.Copy()
	item_state_slots = copy.item_state_slots.Copy()

	finished = TRUE
	qdel(copy)
