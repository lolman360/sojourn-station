/**
 * If your mob is concious, drop the item in the active hand
 *
 * This is a hidden verb, likely for binding with winset for hotkeys
 */
/client/verb/drop_item()
	set hidden = 1
	if(!isrobot(mob) && mob.stat == CONSCIOUS && isturf(mob.loc))
		return mob.drop_item()
	return


/**
 * Move a client in a direction
 *
 * Huge proc, has a lot of functionality
 *
 * Mostly it will despatch to the mob that you are the owner of to actually move
 * in the physical realm
 *
 * Things that stop you moving as a mob:
 * * world time being less than your next move_delay
 * * not being in a mob, or that mob not having a loc
 * * missing the n and direction parameters
 * * being in remote control of an object (calls Moveobject instead)
 * * being dead (it ghosts you instead)
 *
 * Things that stop you moving as a mob living (why even have OO if you're just shoving it all
 * in the parent proc with istype checks right?):
 * * having incorporeal_move set (calls Process_Incorpmove() instead)
 * * being grabbed
 * * being buckled  (relaymove() is called to the buckled atom instead)
 * * having your loc be some other mob (relaymove() is called on that mob instead)
 * * Not having MOBILITY_MOVE
 * * Failing Process_Spacemove() call
 *
 * At this point, if the mob is is confused, then a random direction and target turf will be calculated for you to travel to instead
 *
 * Now the parent call is made (to the byond builtin move), which moves you
 *
 * Some final move delay calculations (doubling if you moved diagonally successfully)
 *
 * if mob throwing is set I believe it's unset at this point via a call to finalize
 *
 * Finally if you're pulling an object and it's dense, you are turned 180 after the move
 * (if you ask me, this should be at the top of the move so you don't dance around)
 *
 */
/client/Move(new_loc, direct)
	if(world.time < move_delay) //do not move anything ahead of this check please
		return FALSE
	var/old_move_delay = move_delay
	move_delay = world.time + world.tick_lag //this is here because Move() can now be called mutiple times per tick
	if(!mob || !mob.loc)
		return FALSE
	if(!new_loc || !direct)
		return FALSE
	if(mob.notransform)
		return FALSE //This is sota the goto stop mobs from moving var
	if(mob.control_object)
		return Move_object(direct)
	if(!isliving(mob))
		return mob.Move(new_loc, direct)
	if(mob.stat == DEAD)
		mob.ghostize()
		return FALSE
	if(SEND_SIGNAL(mob, COMSIG_MOB_CLIENT_PRE_LIVING_MOVE) & COMSIG_MOB_CLIENT_BLOCK_PRE_LIVING_MOVE)
		return FALSE

	var/mob/living/L = mob //Already checked for isliving earlier
	if(L.incorporeal_move) //Move though walls
		Process_Incorpmove(direct)
		return FALSE

	if(mob.remote_control) //we're controlling something, our movement is relayed to it
		return mob.remote_control.relaymove(mob, direct)

	if(isAI(mob))
		return AIMove(new_loc,direct,mob)

	if(LAZYLEN(mob.grabbed_by)) //are we restrained by someone's grip?
		return

	if(mob.buckled) //if we're buckled to something, tell it we moved.
		return mob.buckled.relaymove(mob, direct)

	if(!(L.mobility_flags & MOBILITY_MOVE))
		return FALSE

	if(isobj(mob.loc) || ismob(mob.loc)) //Inside an object, tell it we moved
		var/atom/O = mob.loc
		return O.relaymove(mob, direct)

	if(!mob.Process_Spacemove(direct))
		return FALSE

	if(SEND_SIGNAL(mob, COMSIG_MOB_CLIENT_PRE_MOVE, args) & COMSIG_MOB_CLIENT_BLOCK_PRE_MOVE)
		return FALSE

	//We are now going to move
	var/add_delay = mob.cached_multiplicative_slowdown
	mob.set_glide_size(DELAY_TO_GLIDE_SIZE(add_delay * ( (NSCOMPONENT(direct) && EWCOMPONENT(direct)) ? SQRT_2 : 1 ) )) // set it now in case of pulled objects
	//If the move was recent, count using old_move_delay
	//We want fractional behavior and all
	if(old_move_delay + world.tick_lag > world.time)
		//Yes this makes smooth movement stutter if add_delay is too fractional
		//Yes this is better then the alternative
		move_delay = old_move_delay
	else
		move_delay = world.time

	//Basically an optional override for our glide size
	//Sometimes you want to look like you're moving with a delay you don't actually have yet
	visual_delay = 0

	. = ..()

	if((direct & (direct - 1)) && mob.loc == new_loc) //moved diagonally successfully
		add_delay *= SQRT_2

	if(visual_delay)
		mob.set_glide_size(visual_delay)
	else
		mob.set_glide_size(DELAY_TO_GLIDE_SIZE(add_delay))
	move_delay += add_delay
	if(.) // If mob is null here, we deserve the runtime
		if(mob.throwing)
			mob.throwing.finalize(FALSE)

		// At this point we've moved the client's attached mob. This is one of the only ways to guess that a move was done
		// as a result of player input and not because they were pulled or any other magic.
		SEND_SIGNAL(mob, COMSIG_MOB_CLIENT_MOVED)

	var/atom/movable/P = mob.pulling
	if(P && !ismob(P) && P.density)
		mob.setDir(turn(mob.dir, 180))

/client/proc/Process_Grab()
	if(!mob.pulledby)
		return FALSE
		return FALSE
	if(mob.incapacitated())
		COOLDOWN_START(src, move_delay, 1 SECONDS)
		return TRUE
	return mob.resist_grab(TRUE)


/**
 * Allows mobs to ignore density and phase through objects
 *
 * Called by client/Move()
 *
 * The behaviour depends on the incorporeal_move value of the mob
 *
 * * INCORPOREAL_MOVE_BASIC - forceMoved to the next tile with no stop
 *
 *
 We have no support for other modes yet, but they can probably be ported over when someone eventually makes another incorp mover

 * You'll note this is another mob living level proc living at the client level
 */
/client/proc/Process_Incorpmove(direct)
	var/turf/mobloc = get_turf(mob)
	if(!isliving(mob))
		return
	var/mob/living/L = mob
	switch(L.incorporeal_move)
		if(INCORPOREAL_MOVE_BASIC)
			var/T = get_step(L,direct)
			if(T)
				L.forceMove(T)
			L.setDir(direct)
	return TRUE

/**
 * Handles mob/living movement in space (or no gravity)
 *
 * Called by /client/Move()
 *
 * return TRUE for movement or FALSE for none
 *
 * You can move in space if you have a spacewalk ability
 */
/mob/Process_Spacemove(movement_dir = 0)
	. = ..()
	if(. || mob_spacewalk_check())
		return TRUE
	var/atom/movable/backup = get_spacemove_backup(movement_dir)
	if(backup)
		if(istype(backup) && movement_dir && !backup.anchored)
			if(backup.newtonian_move(turn(movement_dir, 180), instant = TRUE)) //You're pushing off something movable, so it moves
				to_chat(src, span_info("You push off of [backup] to propel yourself."))
		return TRUE
	return FALSE

/**
 * Finds a target near a mob that is viable for pushing off when moving.
 * Takes the intended movement direction as input.
 */
/mob/get_spacemove_backup(moving_direction)
	for(var/atom/pushover as anything in range(1, get_turf(src)))
		if(pushover == src)
			continue
		if(isarea(pushover))
			continue
		if(isturf(pushover))
			var/turf/turf = pushover
			if(isspaceturf(turf))
				continue
			if(!turf.density && !mob_negates_gravity())
				continue
			return pushover

		var/atom/movable/rebound = pushover
		if(rebound == buckled)
			continue
		if(ismob(rebound))
			var/mob/lover = rebound
			if(lover.buckled)
				continue

		var/pass_allowed = rebound.CanPass(src, get_dir(rebound, src))
		if(!rebound.density && pass_allowed)
			continue
		if(moving_direction == get_dir(src, pushover) && !pass_allowed) // Can't push "off" of something that you're walking into
			continue
		if(rebound.anchored)
			return rebound
		if(pulling == rebound)
			continue
		return rebound

/mob/has_gravity()
	return mob_negates_gravity() || ..()

/**
 * Does this mob ignore gravity
 */
/mob/proc/mob_negates_gravity()
	var/turf/turf = get_turf(src)
	return !isgroundlessturf(turf) && mob.ignore_gravity() //todo

/mob/newtonian_move(direction, instant = FALSE)
	. = ..()
	if(!.) //Only do this if we're actually going somewhere
		return
	if(!client)
		return
	client.visual_delay = MOVEMENT_ADJUSTED_GLIDE_SIZE(inertia_move_delay, SSspacedrift.visual_delay) //Make sure moving into a space move looks like a space move

/// Update the gravity status of this mob
/mob/proc/update_gravity(has_gravity, override=FALSE)
	var/speed_change = max(0, has_gravity - STANDARD_GRAVITY)
	if(!speed_change)
		remove_movespeed_modifier(/datum/movespeed_modifier/gravity)
	else
		add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/gravity, multiplicative_slowdown=speed_change)

/**
 * TODO: MAKE THIS SHIT WORK
 * Toggle the move intent of the mob
 * triggers an update the move intent hud as well
 */
/mob/proc/toggle_move_intent(mob/user)
	if(m_intent == MOVE_INTENT_RUN)
		m_intent = MOVE_INTENT_WALK
	else
		m_intent = MOVE_INTENT_RUN
	if(hud_used?.static_inventory)
		for(var/atom/movable/screen/mov_intent/selector in hud_used.static_inventory)
			selector.update_appearance()

/mob/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if(air_group || (height==0)) return 1

	if(ismob(mover))
		var/mob/moving_mob = mover
		if ((other_mobs && moving_mob.other_mobs))
			return 1
		return (!mover.density || !density || lying)
	else
		return (!mover.density || !density || lying)

/client/proc/client_dir(input, direction=-1)
	return turn(input, direction*dir2angle(dir))

/client/Northeast()
	diagonal_action(NORTHEAST)
/client/Northwest()
	diagonal_action(NORTHWEST)
/client/Southeast()
	diagonal_action(SOUTHEAST)
/client/Southwest()
	diagonal_action(SOUTHWEST)

/client/proc/diagonal_action(direction)
	switch(client_dir(direction, 1))
		if(NORTHEAST)
			swap_hand()
			return
		if(SOUTHEAST)
			attack_self()
			return
		if(SOUTHWEST)
			if(iscarbon(usr))
				var/mob/living/carbon/C = usr
				C.toggle_throw_mode()
			else
				to_chat(usr, SPAN_WARNING("This mob type cannot throw items."))
			return
		if(NORTHWEST)
			mob.hotkey_drop()

/mob/proc/hotkey_drop()
	to_chat(usr, SPAN_WARNING("This mob type cannot drop items."))

/mob/living/carbon/hotkey_drop()
	if(!get_active_hand())
		to_chat(usr, SPAN_WARNING("You have nothing to drop in your hand."))
	if (!isturf(loc))
		return
	else
		unEquip(get_active_hand(), loc)

//This gets called when you press the delete button.
/client/verb/delete_key_pressed()
	set hidden = 1

	if(!usr.pulling)
		to_chat(usr, SPAN_NOTICE("You are not pulling anything."))
		return
	usr.stop_pulling()

/client/verb/swap_hand()
	set hidden = 1

	if(isrobot(mob))
		var/mob/living/silicon/robot/R = mob
		R.cycle_modules()
	else
		mob.swap_hand()
	return



/client/verb/attack_self()
	set hidden = 1
	if(mob)
		mob.mode()
	return


/client/verb/toggle_throw_mode()
	set hidden = 1
	if(!istype(mob, /mob/living/carbon))
		return
	if (!mob.stat && isturf(mob.loc) && !mob.restrained())
		mob:toggle_throw_mode()
	else
		return


/**
 * If your mob is concious, drop the item in the active hand
 *
 * This is a hidden verb, likely for binding with winset for hotkeys
 */


/**
 * force move the control_object of your client mob
 *
 * Used in admin possession and called from the client Move proc
 * ensures the possessed object moves and not the admin mob
 *
 * Has no sanity other than checking density
 */
/client/proc/Move_object(direct)
	if(mob?.control_object)
		if(mob.control_object.density)
			step(mob.control_object,direct)
			if(!mob.control_object)
				return
			mob.control_object.setDir(direct)
		else
			mob.control_object.forceMove(get_step(mob.control_object,direct))


//Checks if a mob has solid ground to stand on
//If there's no gravity then there's no up or down so naturally you can't stand on anything.
//For the same reason lattices in space don't count - those are things you grip, presumably.
/mob/proc/check_gravity()
	if(istype(loc, /turf/space))
		return 0

	lastarea = get_area(src)
	if(!lastarea || !lastarea.has_gravity)
		return 0

	return 1


//This proc specifically checks the floor under us. Both floor turfs and walkable objects like catwalk
//This proc is only called if we have grip, ie magboots
/mob/proc/check_solid_ground()
	if (istype(loc, /turf/simulated))
		if(istype(loc, /turf/simulated/open))
			return FALSE //open spess was fogotten
		return TRUE //We're standing on a simulated floor
	else
		//We're probably in space
		for(var/obj/O in loc)
			if(istype(O, /obj/structure/lattice))
				return TRUE
			if(istype(O, /obj/structure/catwalk))
				return TRUE
	return FALSE

//This proc checks for dense, anchored atoms, or walls.
//It checks all the adjacent tiles
/mob/proc/check_dense_object()

	for(var/turf/simulated/T in trange(1,src)) //we only care for non-space turfs
		if(T.density)	//walls work when you're adjacent
			return TRUE


	for(var/obj/O in orange(1, src))
		if(O.density && O.anchored)
			return TRUE

	return FALSE

/mob/proc/check_shoegrip()
	return 0

/mob/proc/slip_chance(var/prob_slip = 5)
	if(stat)
		return 0
	if(check_shoegrip())
		return 0
	return prob_slip

#define DO_MOVE(this_dir) var/final_dir = turn(this_dir, -dir2angle(dir)); Move(get_step(mob, final_dir), final_dir);

/client/verb/moveup()
	set name = ".moveup"
	set instant = 1
	DO_MOVE(NORTH)

/client/verb/movedown()
	set name = ".movedown"
	set instant = 1
	DO_MOVE(SOUTH)

/client/verb/moveright()
	set name = ".moveright"
	set instant = 1
	DO_MOVE(EAST)

/client/verb/moveleft()
	set name = ".moveleft"
	set instant = 1
	DO_MOVE(WEST)

#undef DO_MOVE

//This is an atom proc for the sake of vehicles and mechas
//Attempts to return the expected total time in deciseconds, between this atom making moves
//TODO: Fix this shit
/atom/movable/proc/total_movement_delay()
	return 0

/mob/total_movement_delay()
	var/delay = 0

	if (MOVING_QUICKLY(src))
		if(drowsyness > 0)
			delay += 6
		delay += 1
	else
		delay += 7
	delay += movement_delay()

	if (speed_factor && speed_factor != 1.0)
		delay /= speed_factor

	return delay

/mob/proc/add_momentum()
	return FALSE
