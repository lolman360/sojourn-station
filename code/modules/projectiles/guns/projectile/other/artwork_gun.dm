/obj/item/weapon/gun/projectile/revolver/artwork_revolver
	name = "Weird Revolver"
	desc = "This is an artistically-made revolver with a limited use chameleon projector."
	icon = 'icons/obj/guns/projectile/artwork_revolver.dmi'
	icon_state = "artwork_revolver_1"
	item_state = "artwork_revolver_1"
	drawChargeMeter = FALSE
	max_shells = 6
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 4) //Arbitrary values
<<<<<<< Updated upstream
	matter = list(MATERIAL_PLASTEEL = 12, MATERIAL_WOOD = 6)
=======
	matter = list(MATERIAL_PLASTEEL = 6, MATERIAL_WOOD = 6)
>>>>>>> Stashed changes
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
	load_method = MAGAZINE
	mag_well = MAG_WELL_PISTOL
<<<<<<< Updated upstream
	matter = list(MATERIAL_PLASTEEL = 12, MATERIAL_STEEL = 6)
=======
	matter = list(MATERIAL_PLASTEEL = 6, MATERIAL_STEEL = 6)
>>>>>>> Stashed changes
	price_tag = 1000
	damage_multiplier = 1 //firefly
	penetration_multiplier = 1.4
	recoil_buildup = 6 //slighty more than the firefly
	var/finished = 0

/obj/item/weapon/gun/projectile/automatic/shotgun/pump/artwork_pshotgun
<<<<<<< Updated upstream
	name = "\"Grizzly\" shotgun"
	desc = "A common open-source pump-action shotgun, a bastard child of the three primary pump shotguns on the market, all rolled together once their patents expired. Can hold up to 4+1 20mm shells in its tube magazine."
	icon = 'icons/obj/guns/projectile/shotgun.dmi'
	icon_state = "shotgun"
	item_state = "shotgun"
	max_shells = 4
	slot_flags = SLOT_BACK
	caliber = CAL_SHOTGUN
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 2)
	load_method = SINGLE_CASING
	handle_casings = HOLD_CASINGS
	matter = list(MATERIAL_PLASTEEL = 20, MATERIAL_WOOD = 10)
=======
	name = "Odd Shotgun"
	desc = "This is an artistically-made shotgun with a limited use chameleon projector."
	icon = 'icons/obj/guns/projectile/shotgun.dmi'
	slot_flags = SLOT_BACK
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 2)
	matter = list(MATERIAL_PLASTEEL = 10, MATERIAL_WOOD = 50)
>>>>>>> Stashed changes
	price_tag = 1000


/obj/item/weapon/gun/projectile/automatic/shotgun/artwork_shotgun
<<<<<<< Updated upstream

/obj/item/weapon/gun/projectile/automatic/artwork_rifle

/obj/item/weapon/gun/projectile/automatic/artwork_sniper
=======
	name = "Odd Shotgun"
	desc = "This is an artistically-made autoshotgun with a limited use chameleon projector."
	icon = 'icons/obj/guns/projectile/artwork_revolver.dmi'
	icon_state = "artwork_revolver_1"
	item_state = "artwork_revolver_1"
	damage_multiplier = 0.8
	recoil_buildup = 15
	one_hand_penalty = 20 //automatic shotgun level

/obj/item/weapon/gun/projectile/automatic/artwork_rifle
	name = "Odd Rifle"
	desc = "This is an artistically-made Rifle with a limited use chameleon projector."
	icon = 'icons/obj/guns/projectile/artwork_revolver.dmi'
	icon_state = "artwork_revolver_1"
	item_state = "artwork_revolver_1"
	load_method = MAGAZINE
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 2)
	slot_flags = SLOT_BELT
	matter = list(MATERIAL_PLASTEEL = 10, MATERIAL_PLASTIC = 6)
	price_tag = 1000
	auto_eject_sound = 'sound/weapons/smg_empty_alarm.ogg'
	recoil_buildup = 7
	one_hand_penalty = 9


/obj/item/weapon/gun/projectile/boltgun/artwork_sniper
>>>>>>> Stashed changes

/obj/item/weapon/gun/projectile/grenade/artwork_grenade


/obj/item/weapon/gun/projectile/automatic/artwork_pistol/AltClick(mob/user)
	if(finished)
		return FALSE
	var/list/gun_choices
	if(!gun_choices)
		gun_choices = list()
		for(var/gun_type in typesof(/obj/item/weapon/gun/) - src.type)
			var/obj/item/weapon/gun/G = gun_type
			gun_choices[initial(G.name)] = gun_type

	var/picked = input("Select Appearance", "Select Appearance") as anything in gun_choices

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
