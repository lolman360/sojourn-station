//Parent gun type. Guns are weapons that can be aimed at mobs and act over a distance
/obj/item/gun
	name = "gun"
	desc = "It's a gun. It's pretty terrible, though."
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "giskard_old"
	item_state = "gun"
	item_state_slots = list(
		slot_l_hand_str = "lefthand",
		slot_r_hand_str = "righthand",
		slot_back_str   = "back",
		slot_s_store_str= "onsuit",
		)
	flags = CONDUCT
	slot_flags = SLOT_BELT|SLOT_HOLSTER
	matter = list(MATERIAL_STEEL = 6)
	w_class = ITEM_SIZE_NORMAL
	throwforce = 5
	throw_speed = 4
	throw_range = 5
	force = WEAPON_FORCE_WEAK
	origin_tech = list(TECH_COMBAT = 1)
	attack_verb = list("struck", "hit", "bashed")
	zoomdevicename = "scope"
	hud_actions = list()
	max_upgrades = 5

	hitsound = "swing_hit"

	var/auto_eject = FALSE			//if the magazine should automatically eject itself when empty.
	var/auto_eject_sound = 'sound/weapons/smg_empty_alarm.ogg' //The sound that places when a mag is dropped

	var/damage_multiplier = 1 //Multiplies damage of projectiles fired from this gun
	var/penetration_multiplier = 1 //Multiplies armor penetration of projectiles fired from this gun
	var/pierce_multiplier = 0 //ADDITIVE wall penetration to projectiles fired from this gun
	var/extra_damage_mult_scoped = 0 //Adds even more damage mulitplier, when scopped so snipers can sniper
	var/proj_agony_multiplier = 1
	var/burst = 1
	var/fire_delay = 6 	//delay after shooting before the gun can be used again
	var/burst_delay = 2	//delay between shots, if firing in bursts
	var/move_delay = 1
	var/fire_sound = 'sound/weapons/Gunshot.ogg'

	var/fire_sound_text = "gunshot"
	var/rigged = FALSE
	var/recoil_buildup = 2 //How quickly recoil builds up

	var/braced = FALSE //for gun_brace proc.
	var/brace_penalty = FALSE//penalty if not braced.
	var/braceable = 1 //can the gun be used for gun_brace proc, modifies recoil. If the gun has foregrip mod installed, it's not braceable. Bipod mod increases value by 1.

	var/muzzle_flash = 3
	var/dual_wielding
	var/can_dual = FALSE // Controls whether guns can be dual-wielded (firing two at once).
	var/zoom_factor = 0 //How much to scope in when using weapon

	var/suppress_delay_warning = FALSE

	var/safety = TRUE//is safety will be toggled on spawn() or not
	var/restrict_safety = FALSE //To restrict the users ability to toggle the safety
	var/dna_compare_samples = FALSE //If DNA-lock installed
	var/dna_lock_sample = "not_set" //real_name from mob who installed DNA-lock
	var/dna_user_sample = "not_set" //Current user's real_name

	var/next_fire_time = 0

	var/sel_mode = 1 //index of the currently selected mode
	var/list/firemodes = list()
	var/list/init_firemodes = list()

	var/init_offset = 0

	var/mouthshoot = FALSE //To stop people from suiciding twice... >.>
	var/scoped_offset_reduction = 3
	var/list/gun_tags = list() //Attributes of the gun, used to see if an upgrade can be applied to this weapon.
	/*	SILENCER HANDLING */
	var/silenced = FALSE
	var/fire_sound_silenced = 'sound/weapons/Gunshot_silenced.wav' //Firing sound used when silenced

	var/icon_contained = TRUE
	var/static/list/item_icons_cache = list()
	var/wielded_item_state = null
	var/one_hand_penalty = 0 //The higher this number is, the more severe the accuracy penalty for shooting it one handed. 5 is a good baseline for this, but var edit it live and play with it yourself.

	var/projectile_color //Set by a firemode. Sets the fired projectiles color

	var/twohanded = FALSE //If TRUE, gun can only be fired when wileded
	var/recentwield = 0 // to prevent spammage
	var/proj_step_multiplier = 1
	var/list/proj_damage_adjust = list() //What additional damage do we give to the bullet. Type(string) -> Amount(int)

	var/eject_animatio = FALSE //Only currenly in bolt guns. Check boltgun.dm for more information on this
	var/fire_animatio = FALSE //Only used in revolvers atm, animation for each shot being fired

	var/darkness_view = 0
	var/vision_flags = 0
	var/see_invisible_gun = -1

	var/pumpshotgun_sound = 'sound/weapons/shotgunpump.ogg'

	var/folding_stock = FALSE //Can we fold are stock?
	var/folded = TRUE //IS are stock folded? - and that is yes we start folded
	var/currently_firing = FALSE

/obj/item/gun/proc/loadAmmoBestGuess()
	return

/obj/item/gun/Initialize()
	. = ..()
	initialize_firemodes()
	initialize_scope()
	//Properly initialize the default firing mode
	if (firemodes.len)
		set_firemode(sel_mode)

	if(!restrict_safety)
		verbs += /obj/item/gun/proc/toggle_safety_verb//addint it to all guns

		var/obj/screen/item_action/action = new /obj/screen/item_action/top_bar/gun/safety
		action.owner = src
		hud_actions += action

	if(icon_contained)
		if(!item_icons_cache[type])
			item_icons_cache[type] = list(
				slot_l_hand_str = icon,
				slot_r_hand_str = icon,
				slot_back_str = icon,
				slot_s_store_str = icon,
			)
		item_icons = item_icons_cache[type]
	if(one_hand_penalty || twohanded && (!wielded_item_state))//If the gun has a one handed penalty or is twohanded, but has no wielded item state then use this generic one.
		wielded_item_state = "_doble" //Someone mispelled double but they did it so consistently it's staying this way.
	//generate_guntags()
	var/obj/screen/item_action/action = new /obj/screen/item_action/top_bar/weapon_info
	action.owner = src
	hud_actions += action
	refresh_upgrades()

/obj/item/gun/pickup()
	..()
	refresh_upgrades() //Run it again, just in case
	update_icon()

/obj/item/gun/Destroy()
	for(var/i in firemodes)
		if(!islist(i))
			qdel(i)
	firemodes = null
	return ..()

/obj/item/gun/examine(mob/user)
	..()
	if(folding_stock)
		to_chat(user, "<span class='info'>This gun can be folded by Ctrl Shift Clicking it.</span>")

/obj/item/gun/proc/set_item_state(state, hands = FALSE, back = FALSE, onsuit = FALSE)
	var/wield_state = null
	if(wielded_item_state)
		wield_state = wielded_item_state
	if(!(hands || back || onsuit))
		hands = back = onsuit = TRUE
	if(hands)//Ok this is a bit hacky. But basically if the gun is weilded, we want to use the wielded icon state over the other one.
		if(wield_state && wielded)//Because most of the time the "normal" icon state is held in one hand. This could be expanded to be less hacky in the future.
			item_state_slots[slot_l_hand_str] = "lefthand"  + wield_state
			item_state_slots[slot_r_hand_str] = "righthand" + wield_state
		else
			item_state_slots[slot_l_hand_str] = "lefthand"  + state
			item_state_slots[slot_r_hand_str] = "righthand" + state
	state = initial(state)
	if(back)
		item_state_slots[slot_back_str]   = "back"      + state
	if(onsuit)
		item_state_slots[slot_s_store_str]= "onsuit"    + state


/obj/item/gun/update_icon()
	if(wielded_item_state)
		if(icon_contained)//If it has it own icon file then we want to pull from that.
			if(wielded)
				item_state_slots[slot_l_hand_str] = "lefthand"  + wielded_item_state
				item_state_slots[slot_r_hand_str] = "righthand" + wielded_item_state
			else
				item_state_slots[slot_l_hand_str] = "lefthand"
				item_state_slots[slot_r_hand_str] = "righthand"
		else//Otherwise we can just pull from the generic left and right hand icons.
			if(wielded)
				item_state_slots[slot_l_hand_str] = wielded_item_state
				item_state_slots[slot_r_hand_str] = wielded_item_state
			else
				item_state_slots[slot_l_hand_str] = initial(item_state)
				item_state_slots[slot_r_hand_str] = initial(item_state)


//Checks whether a given mob can use the gun
//Any checks that shouldn't result in handle_click_empty() being called if they fail should go here.
//Otherwise, if you want handle_click_empty() to be called, check in consume_next_projectile() and return null there.
/obj/item/gun/proc/special_check(var/mob/user)

	if(!isliving(user))
		return FALSE
	if(!user.IsAdvancedToolUser())
		return FALSE

	var/mob/living/M = user
	if(HULK in M.mutations)
		to_chat(user, SPAN_DANGER("Your fingers are much too large for the trigger guard!"))
		return FALSE
	if(!restrict_safety)
		if(safety)
			to_chat(user, SPAN_DANGER("The gun's safety is on!"))
			handle_click_empty(user)
			return FALSE
	if(restrict_safety) //if we are restructed to be only saft then we also check
		if(safety) //Danger zone dosnt force safety so we check again
			to_chat(user, SPAN_DANGER("The gun's safety is on!"))
			handle_click_empty(user)
			return FALSE

	if(twohanded)
		if(!wielded)
			if (world.time >= recentwield + 1 SECONDS)
				to_chat(user, SPAN_DANGER("The gun is too heavy to shoot in one hand!"))
				recentwield = world.time
			return FALSE

	if(!dna_check(M))
		to_chat(user, SPAN_DANGER("The gun's biometric scanner prevents you from firing!"))
		handle_click_empty(user)
		return FALSE

	if((CLUMSY in M.mutations) && prob(15))
		var/obj/P = consume_next_projectile()
		if(P)
			if(process_projectile(P, user, user, pick(BP_L_LEG, BP_R_LEG)))
				handle_post_fire(user, user)
				user.visible_message(
					SPAN_DANGER("\The [user] fumbles with \the [src] and shoot themselves in the foot with \the [src]!"),
					SPAN_DANGER("You fumble with the gun and accidentally shoot yourself in the foot with \the [src]!")
					)
				M.drop_item()
		else
			handle_click_empty(user)
		return FALSE

	if(rigged)
		var/obj/P = consume_next_projectile()
		if(P)
			if(process_projectile(P, user, user, BP_HEAD))
				handle_post_fire(user, user)
				user.visible_message(
					SPAN_DANGER("As \the [user] pulls the trigger on \the [src], a bullet fires backwards out of it"),
					SPAN_DANGER("Your \the [src] fires backwards, shooting you in the face!")
					)
				user.drop_item()
			if(rigged > TRUE)
				explosion(get_turf(src), 1, 2, 3, 3)
				qdel(src)
			return FALSE
	return TRUE

/obj/item/gun/emp_act(severity)
	for(var/obj/O in contents)
		O.emp_act(severity)

/obj/item/gun/afterattack(atom/A, mob/living/user, adjacent, params)
	if(adjacent) return //A is adjacent, is the user, or is on the user's person

	var/obj/item/gun/off_hand   //DUAL WIELDING
	if(ishuman(user) && user.a_intent == "harm")
		var/mob/living/carbon/human/H = user

		if(H.r_hand == src && istype(H.l_hand, /obj/item/gun))
			off_hand = H.l_hand
			dual_wielding = TRUE

		else if(H.l_hand == src && istype(H.r_hand, /obj/item/gun))
			off_hand = H.r_hand
			dual_wielding = TRUE
		else
			dual_wielding = FALSE

		if(!can_dual)
			dual_wielding = FALSE
		else if(off_hand && off_hand.can_hit(user))
			spawn(1)
			off_hand.Fire(A,user,params)
	else
		dual_wielding = FALSE

	Fire(A,user,params) //Otherwise, fire normally.

/obj/item/gun/attack(atom/A, mob/living/user, def_zone)
	if (A == user && user.targeted_organ == BP_MOUTH && !mouthshoot)
		handle_suicide(user)
	else if(user.a_intent == I_HURT) //point blank shooting
		Fire(A, user, pointblank=1)
	else
		return ..() //Pistolwhippin'

/obj/item/gun/proc/dna_check(user)
	if(dna_compare_samples)
		dna_user_sample = usr.real_name
		if(dna_lock_sample != dna_user_sample)
			return FALSE
	return TRUE

/obj/item/gun/proc/Fire(atom/target, mob/living/user, clickparams, pointblank=0, reflex=0)
	if(!user || !target) return

	if((world.time < next_fire_time) || currently_firing)
		if (!suppress_delay_warning && world.time % 3) //to prevent spam
			to_chat(user, SPAN_WARNING("[src] is not ready to fire again!"))
		return

	if(user)
		add_fingerprint(user)

	if(!special_check(user))
		return

	currently_firing = TRUE

	var/shoot_time = (burst - 1)* burst_delay
	user.setClickCooldown(shoot_time) //no clicking on things while shooting
	next_fire_time = world.time + shoot_time

	//actually attempt to shoot
	var/turf/targloc = get_turf(target) //cache this in case target gets deleted during shooting, e.g. if it was a securitron that got destroyed.
	for(var/i in 1 to burst)
		var/obj/projectile = consume_next_projectile(user)
		if(!projectile)
			handle_click_empty(user)
			break

		projectile.multiply_projectile_damage(damage_multiplier)

		projectile.multiply_projectile_penetration(penetration_multiplier + user.stats.getStat(STAT_VIG) * 0.02)

		projectile.multiply_pierce_penetration(pierce_multiplier)

		projectile.multiply_projectile_step_delay(proj_step_multiplier)

		projectile.multiply_projectile_agony(proj_agony_multiplier)

		if(istype(projectile, /obj/item/projectile))
			var/obj/item/projectile/P = projectile
			P.adjust_damages(proj_damage_adjust)

		if(pointblank)
			process_point_blank(projectile, user, target)
		if(projectile_color)
			projectile.icon = get_proj_icon_by_color(projectile, projectile_color)
			if(istype(projectile, /obj/item/projectile))
				var/obj/item/projectile/P = projectile
				P.proj_color = projectile_color
		if(process_projectile(projectile, user, target, user.targeted_organ, clickparams))
			handle_post_fire(user, target, pointblank, reflex)
			update_icon()

		if(fire_animatio) //Are bullet amination check
			if(silenced)
				flick("fire_s", src)
			else
				flick("fire", src)

		if(i < burst)
			sleep(burst_delay)

		if(!(target && target.loc))
			target = targloc
			pointblank = 0

	//update timing
	user.setClickCooldown(DEFAULT_QUICK_COOLDOWN)
	user.set_move_cooldown(move_delay)
	if(!twohanded && user.stats.getPerk(PERK_GUNSLINGER))
		next_fire_time = world.time + fire_delay - fire_delay * 0.33

	if((CLUMSY in user.mutations) && prob(40)) //Clumsy handling
		var/obj/P = consume_next_projectile()
		if(P)
			if(process_projectile(P, user, user, pick(BP_L_LEG, BP_R_LEG)))
				handle_post_fire(user, user)
				user.visible_message(
					SPAN_DANGER("\The [user] shoots \himself in the foot with \the [src]!"),
					SPAN_DANGER("You shoot yourself in the foot with \the [src]!")
					)
				user.drop_item()
		else
			handle_click_empty(user)
		return FALSE

	currently_firing = FALSE

	if(muzzle_flash)
		set_light(0)

//obtains the next projectile to fire
/obj/item/gun/proc/consume_next_projectile()
	return null

//used by aiming code
/obj/item/gun/proc/can_hit(atom/target as mob, var/mob/living/user as mob)
	if(!special_check(user))
		return 2
	//just assume we can shoot through glass and stuff. No big deal, the player can just choose to not target someone
	//on the other side of a window if it makes a difference. Or if they run behind a window, too bad.
	return check_trajectory(target, user)

//called if there was no projectile to shoot
/obj/item/gun/proc/handle_click_empty(mob/user)
	if (user)
		user.visible_message("*click click*", SPAN_DANGER("*click*"))
	else
		src.visible_message("*click click*")
	playsound(src.loc, 'sound/weapons/guns/misc/gun_empty.ogg', 100, 1)
	update_firemode() //Stops automatic weapons spamming this shit endlessly

//called after successfully firing
/obj/item/gun/proc/handle_post_fire(mob/living/user, atom/target, var/pointblank=0, var/reflex=0)
	SEND_SIGNAL(src, COMSIG_GUN_POST_FIRE, target, pointblank, reflex)
	//The sound we play
	if(silenced)
		//Silenced shots have a lower range and volume
		playsound(user, fire_sound_silenced, 15, 1, -3)
	else
		playsound(user, fire_sound, 60, 1)

		if(reflex)
			user.visible_message(
				"<span class='reflex_shoot'><b>\The [user] fires \the [src][pointblank ? " point blank at \the [target]":""] by reflex!</b></span>",
				"<span class='reflex_shoot'>You fire \the [src] by reflex!</span>",
				"You hear a [fire_sound_text]!"
			)
		else
			user.visible_message(
				SPAN_WARNING("\The [user] fires \the [src][pointblank ? " point blank at \the [target]":""]!"),
				SPAN_WARNING("You fire \the [src]!"),
				"You hear a [fire_sound_text]!"
				)

		if(muzzle_flash)
			set_light(muzzle_flash)

	//Now we tell are user that one handing is a bad idea, even if its cooler
	if(one_hand_penalty)
		if(!wielded && !user.stats.getPerk(PERK_PERFECT_SHOT))
			switch(one_hand_penalty)
				if(1)
					if(prob(50)) //don't need to tell them every single time
						to_chat(user, "<span class='warning'>Your aim wavers slightly.</span>")
				if(2)
					to_chat(user, "<span class='warning'>Your aim wavers as you fire \the [src] with just one hand.</span>")
				if(3)
					to_chat(user, "<span class='warning'>You have trouble keeping \the [src] on target with just one hand.</span>")
				if(4 to INFINITY)
					to_chat(user, "<span class='warning'>You struggle to keep \the [src] on target with just one hand!</span>")

	if(brace_penalty && !braced)
		to_chat(user, "<span class='warning'>You struggle to keep \the [src] on target while carrying it!</span>")

	user.handle_recoil(src)
	update_icon()

/obj/item/gun/proc/process_point_blank(var/obj/item/projectile/P, mob/user, atom/target)
	if(!istype(P))
		return //default behaviour only applies to true projectiles

	if(dual_wielding)
		return //dual wielding deal too much damage as it is, so no point blank for it

	//default point blank multiplier
	var/damage_mult = 1.1

	//determine multiplier due to the target being grabbed
	if(ismob(target))
		var/mob/M = target
		if(M.grabbed_by.len)
			var/grabstate = 0
			for(var/obj/item/grab/G in M.grabbed_by)
				grabstate = max(grabstate, G.state)
			if(grabstate >= GRAB_NECK)
				damage_mult = 1.75
			else if(grabstate >= GRAB_AGGRESSIVE)
				damage_mult = 1.3
		P.multiply_projectile_damage(damage_mult)


//does the actual launching of the projectile
/obj/item/gun/proc/process_projectile(var/obj/item/projectile/P, mob/living/user, atom/target, var/target_zone, var/params=null)
	if(!istype(P))
		return FALSE //default behaviour only applies to true projectiles

	if(params)
		P.set_clickpoint(params)
	var/offset = user.calculate_offset(init_offset)
	offset = rand(-offset, offset)

	return !P.launch_from_gun(target, user, src, target_zone, angle_offset = offset)

//Suicide handling.
/obj/item/gun/proc/handle_suicide(mob/living/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/M = user

	mouthshoot = TRUE
	M.visible_message(SPAN_DANGER("[user] points their gun at their head, ready to pull the trigger..."))
	if(!do_after(user, 40, progress=0))
		M.visible_message(SPAN_NOTICE("[user] decided life was worth living"))
		mouthshoot = FALSE
		return

	if(safety)
		handle_click_empty(user)
		mouthshoot = FALSE
		return

	var/obj/item/projectile/in_chamber = consume_next_projectile()
	if (istype(in_chamber))
		user.visible_message(SPAN_WARNING("[user] pulls the trigger."))
		if(silenced)
			playsound(user, fire_sound, 10, 1)
		else
			playsound(user, fire_sound, 60, 1)
		if(istype(in_chamber, /obj/item/projectile/plasma/lastertag))
			user.show_message(SPAN_WARNING("You feel rather silly, trying to commit suicide with a toy."))
			mouthshoot = FALSE
			return

		in_chamber.on_hit(M)
		if (!in_chamber.is_halloss())
			log_and_message_admins("[key_name(user)] commited suicide using \a [src]")
			for(var/damage_type in in_chamber.damage_types)
				var/damage = in_chamber.damage_types[damage_type]*2.5
				user.apply_damage(damage, damage_type, BP_HEAD, used_weapon = "Point blank shot in the head with \a [in_chamber]", sharp=1)
			user.death()
		else
			to_chat(user, SPAN_NOTICE("Ow..."))
			user.apply_effect(110,AGONY,0)
		qdel(in_chamber)
		mouthshoot = FALSE
		return
	else
		handle_click_empty(user)
		mouthshoot = FALSE
		return

/obj/item/gun/proc/gun_brace(mob/living/user, atom/target)
	if(braceable && user.unstack)
		var/atom/original_loc = user.loc
		var/brace_direction = get_dir(user, target)
		user.unstack = FALSE
		user.facing_dir = null
		to_chat(user, SPAN_NOTICE("You brace your weapon on \the [target]."))
		braced = TRUE
		while(user.loc == original_loc && user.dir == brace_direction)
			sleep(2)
		to_chat(user, SPAN_NOTICE("You stop bracing your weapon."))
		braced = FALSE
		user.unstack = TRUE
	else
		if(!user.unstack)
			to_chat(user, SPAN_NOTICE("You are already bracing your weapon!"))
		else
			to_chat(user, SPAN_WARNING("You can\'t properly place your weapon on \the [target] because of the foregrip!"))

/obj/item/gun/proc/toggle_scope(mob/living/user)
	//looking through a scope limits your periphereal vision
	//still, increase the view size by a tiny amount so that sniping isn't too restricted to NSEW
	if(!zoom_factor)
		zoom = FALSE
		return
	var/zoom_offset = round(world.view * zoom_factor)
	var/view_size = round(world.view + zoom_factor)

	zoom(zoom_offset, view_size)
	check_safety_cursor(user)
	update_hud_actions()

/obj/item/gun/examine(mob/user)
	..()
	if(firemodes.len > 1)
		var/datum/firemode/current_mode = firemodes[sel_mode]
		to_chat(user, SPAN_NOTICE("The fire selector is set to [current_mode.name]."))

	if(safety)
		to_chat(user, SPAN_NOTICE("The safety is on."))
	else
		to_chat(user, SPAN_NOTICE("The safety is off."))

	if(can_dual == TRUE)
		to_chat(user, SPAN_NOTICE("This gun can be duel-wielded effectively, if you're skilled enough."))

	if(iscarbon(user) || issilicon(user))
		if(twohanded)
			to_chat(user, SPAN_NOTICE("This gun would need to be wielded in both hands."))
			return
		if(one_hand_penalty && !user.stats.getPerk(PERK_PERFECT_SHOT))
			to_chat(user, SPAN_WARNING("This gun needs to be wielded in both hands to be used most effectively."))
			return
		if((one_hand_penalty && user.stats.getPerk(PERK_PERFECT_SHOT)))
			to_chat(user, SPAN_NOTICE("This gun would need to be wielded in both hands to stablize the recoil, but your skill overcomes such things."))

/obj/item/gun/proc/initialize_firemodes()
	QDEL_LIST(firemodes)

	for(var/i in 1 to init_firemodes.len)
		var/list/L = init_firemodes[i]
		add_firemode(L)

	var/obj/screen/item_action/action = locate(/obj/screen/item_action/top_bar/gun/fire_mode) in hud_actions
	if(firemodes.len > 1)
		if(!action)
			action = new /obj/screen/item_action/top_bar/gun/fire_mode
			action.owner = src
			hud_actions += action
	else
		qdel(action)
		hud_actions -= action

/obj/item/gun/proc/initialize_scope()
	var/obj/screen/item_action/action = locate(/obj/screen/item_action/top_bar/gun/scope) in hud_actions
	if(zoom_factor > 0)
		if(!action)
			action = new /obj/screen/item_action/top_bar/gun/scope
			action.owner = src
			hud_actions += action
			if(ismob(loc))
				var/mob/user = loc
				user.client?.screen += action
	else
		if(ismob(loc))
			var/mob/user = loc
			user.client?.screen -= action
		hud_actions -= action
		qdel(action)

/obj/item/gun/proc/add_firemode(var/list/firemode)
	//If this var is set, it means spawn a specific subclass of firemode
	if (firemode["mode_type"])
		var/newtype = firemode["mode_type"]
		firemodes.Add(new newtype(src, firemode))
	else
		firemodes.Add(new /datum/firemode(src, firemode))

/obj/item/gun/proc/switch_firemodes()
	if(firemodes.len <= 1)
		return null
	update_firemode(FALSE) //Disable the old firing mode before we switch away from it
	sel_mode++
	if(sel_mode > firemodes.len)
		sel_mode = 1
	return set_firemode(sel_mode)

/obj/item/gun/proc/switch_firemodes_reverse()
	if(firemodes.len <= 1)
		return null
	update_firemode(FALSE) //Disable the old firing mode before we switch away from it
	sel_mode--
	if(sel_mode < 1)
		sel_mode = firemodes.len
	return set_firemode(sel_mode)

/// Set firemode , but without a refresh_upgrades at the start
/obj/item/gun/proc/very_unsafe_set_firemode(index)
	if(index > firemodes.len)
		index = 1
	var/datum/firemode/new_mode = firemodes[sel_mode]
	new_mode.apply_to(src)
	new_mode.update()
	update_hud_actions()
	return new_mode

/obj/item/gun/proc/set_firemode(var/index)
	refresh_upgrades()
	if(index > firemodes.len)
		index = 1
	var/datum/firemode/new_mode = firemodes[sel_mode]
	new_mode.update()
	update_hud_actions()
	return new_mode

/obj/item/gun/attack_self(mob/user)
	if(zoom)
		toggle_scope(user)
		return

	toggle_firemode(user)

/obj/item/gun/proc/toggle_firemode(mob/living/user, forward = TRUE)
	if(currently_firing) // CHEATERS!
		return
	var/datum/firemode/new_mode = switch_firemodes()
	if(new_mode)
		playsound(src.loc, 'sound/weapons/guns/interact/selector.ogg', 100, 1)
		to_chat(user, SPAN_NOTICE("\The [src] is now set to [new_mode.name]."))

/obj/item/gun/proc/toggle_safety(mob/living/user)
	if(restrict_safety || src != user.get_active_hand())
		return

	safety = !safety
	playsound(user, 'sound/weapons/selector.ogg', 50, 1)
	to_chat(user, SPAN_NOTICE("You toggle the safety [safety ? "on":"off"]."))
	//Update firemode when safeties are toggled
	update_firemode()
	update_hud_actions()
	check_safety_cursor(user)

/obj/item/gun/proc/check_safety_cursor(mob/living/user)
	if(safety)
		user.remove_cursor()
	else
		user.update_cursor(src)

/obj/item/gun/proc/get_total_damage_adjust()
	var/val = 0
	for(var/i in proj_damage_adjust)
		val += proj_damage_adjust[i]
	return val

//Finds the current firemode and calls update on it. This is called from a few places:
//When firemode is changed
//When safety is toggled
//When gun is picked up
//When gun is readied
/obj/item/gun/proc/update_firemode(var/force_state = null)
	if (sel_mode && firemodes && firemodes.len)
		var/datum/firemode/new_mode = firemodes[sel_mode]
		new_mode.update(force_state)

/obj/item/gun/AltClick(mob/user)
	if(user.incapacitated())
		to_chat(user, SPAN_WARNING("You can't do that right now!"))
		return
	toggle_safety(user)

/obj/item/gun/CtrlShiftClick(mob/user)
	. = ..()

	var/able = can_interact(user)

	if(able == 1)
		return

	if(able == 2)
		to_chat(user, SPAN_NOTICE("You cannot [folded ? "unfold" : "fold"] the stock while \the [src] is in a container."))
		return

	fold(span_chat = TRUE)

/obj/item/gun/proc/can_interact(mob/user)
	if((!ishuman(user) && (loc != user)) || user.stat || user.restrained())
		return 1
	if(istype(loc, /obj/item/storage))
		return 2
	return 0

/obj/item/gun/proc/fold(user, span_chat)
	if(folding_stock)
		if(!folded)
			if(span_chat)
				to_chat(usr, SPAN_NOTICE("You unfold the stock on \the [src]."))
			folded = TRUE
		else
			if(span_chat)
				to_chat(usr, SPAN_NOTICE("You fold the stock on \the [src]."))
			folded = FALSE
	refresh_upgrades() //First we grab are upgrades to not do anything silly
	update_icon() //Likely has alt icons for being folded or not so we refresh are icon

//Updating firing modes at appropriate times
/obj/item/gun/pickup(mob/user)
	.=..()
	update_firemode()

/obj/item/gun/dropped(mob/user)
	.=..()
	update_firemode(FALSE)

/obj/item/gun/swapped_from()
	.=..()
	update_firemode(FALSE)

/obj/item/gun/swapped_to()
	.=..()
	update_firemode()

/obj/item/gun/proc/toggle_safety_verb()
	set name = "Toggle gun's safety"
	set category = "Object"
	set src in view(1)

	toggle_safety(usr)

/obj/item/gun/ui_data(mob/user)
	var/list/data = list()
	data["damage_multiplier"] = damage_multiplier
	data["pierce_multiplier"] = pierce_multiplier
	data["penetration_multiplier"] = penetration_multiplier

	data["fire_delay"] = fire_delay //time between shot, in ms
	data["burst"] = burst //How many shots are fired per click
	data["burst_delay"] = burst_delay //time between shot in burst mode, in ms

	data["force"] = force
	data["force_max"] = initial(force)*10
	data["muzzle_flash"] = muzzle_flash

	data["recoil_buildup"] = recoil_buildup
	data["recoil_buildup_max"] = initial(recoil_buildup)*10

	data["extra_volume"] = extra_bulk

	data["upgrades_max"] = max_upgrades

	data += ui_data_projectile(get_dud_projectile())

	if(firemodes.len)
		var/list/firemodes_info = list()
		for(var/i = 1 to firemodes.len)
			data["firemode_count"] += 1
			var/datum/firemode/F = firemodes[i]
			var/list/firemode_info = list(
				"index" = i,
				"current" = (i == sel_mode),
				"name" = F.name,
				"desc" = F.desc,
				"burst" = F.settings["burst"],
				"fire_delay" = F.settings["fire_delay"],
				"move_delay" = F.settings["move_delay"],
				)
			if(F.settings["projectile_type"])
				var/proj_path = F.settings["projectile_type"]
				var/list/proj_data = ui_data_projectile(new proj_path)
				firemode_info += proj_data
			firemodes_info += list(firemode_info)
		data["firemode_info"] = firemodes_info

	if(item_upgrades.len)
		data["attachments"] = list()
		for(var/atom/A in item_upgrades)
			data["attachments"] += list(list("name" = A.name, "icon" = getAtomCacheFilename(A)))

	return data

/obj/item/gun/Topic(href, href_list, var/datum/topic_state/state)
	if(..(href, href_list, state))
		return 1

	if(href_list["firemode"])
		sel_mode = text2num(href_list["firemode"])
		set_firemode(sel_mode)
		return 1

//Returns a projectile that's not for active usage.
/obj/item/gun/proc/get_dud_projectile()
	return null

/obj/item/gun/proc/ui_data_projectile(var/obj/item/projectile/P)
	if(!P)
		return list()
	var/list/data = list()
	data["projectile_name"] = P.name
	data["projectile_damage"] = (P.get_total_damage() * damage_multiplier) + get_total_damage_adjust()
	data["projectile_AP"] = P.armor_penetration * penetration_multiplier
	qdel(P)
	return data

/obj/item/gun/refresh_upgrades()
	//First of all, lets reset any var that could possibly be altered by an upgrade
	damage_multiplier = initial(damage_multiplier)
	penetration_multiplier = initial(penetration_multiplier)
	pierce_multiplier = initial(pierce_multiplier)
	proj_step_multiplier = initial(proj_step_multiplier)
	proj_agony_multiplier = initial(proj_agony_multiplier)
	fire_delay = initial(fire_delay)
	move_delay = initial(move_delay)
	recoil_buildup = initial(recoil_buildup)
	muzzle_flash = initial(muzzle_flash)
	silenced = initial(silenced)
	restrict_safety = initial(restrict_safety)
	init_offset = initial(init_offset)
	proj_damage_adjust = list()
	fire_sound = initial(fire_sound)
	restrict_safety = initial(restrict_safety)
	dna_compare_samples = initial(dna_compare_samples)
	rigged = initial(rigged)
	zoom_factor = initial(zoom_factor)
	darkness_view = initial(darkness_view)
	vision_flags = initial(vision_flags)
	see_invisible_gun = initial(see_invisible_gun)
	force = initial(force)
	armor_penetration = initial(armor_penetration)
	sharp = initial(sharp)
	attack_verb = list()
	one_hand_penalty = initial(one_hand_penalty)
	auto_eject = initial(auto_eject) //SoJ edit
	initialize_scope()
	initialize_firemodes()
	//Lets get are prefixes and name fresh
	name = initial(name)
	max_upgrades = initial(max_upgrades)
	color = initial(color)
	prefixes = list()
	item_flags = initial(item_flags)
	extra_bulk = initial(extra_bulk)

	//Now lets have each upgrade reapply its modifications
	SEND_SIGNAL(src, COMSIG_ADDVAL, src)
	SEND_SIGNAL(src, COMSIG_APPVAL, src)

	if(firemodes.len)
		very_unsafe_set_firemode(sel_mode) // Reset the firemode so it gets the new changes

	for (var/prefix in prefixes)
		name = "[prefix] [name]"

	if(folding_stock)// TODO: make this somehow modular - (it prob will be a massive line if var/stock_name_of_change
		if(!folded) //Exstended! This means are stock is out
			extra_bulk += 6 //Simular to 6 plates, your getting a lot out of this tho
			//Not modular *yet* as it dosnt need to be for what is basiclly just 10% more damage and 50% less recoil
			recoil_buildup *= 0.5 //50% less recoil
			one_hand_penalty *= 0.5 //50% less recoil
			damage_multiplier += 0.1 //10% more damage
			proj_step_multiplier  -= 0.4 //40% more sped on the bullet
			penetration_multiplier += 0.2 //Makes the gun have more AP when shooting
			extra_damage_mult_scoped += 0.2 //Gives 20% more damage when its scoped. Makes folding stock snipers more viable


	update_icon()
	//then update any UIs with the new stats
	SSnano.update_uis(src)

/obj/item/gun/zoom(tileoffset, viewsize)
	..()
	if(zoom)
		refresh_upgrades() //Lets not allow some silly stacking exploits
		init_offset -= scoped_offset_reduction
		damage_multiplier += extra_damage_mult_scoped
	else
		refresh_upgrades()

/* //Eris has this but it, unsurpringly, has issues, just gonna comment it out for now incase I use the code for something else later.
/obj/item/gun/proc/generate_guntags()
	if(!zoom_factor && !(slot_flags & SLOT_HOLSTER))
		gun_tags |= GUN_SCOPE
*/
