// Disks formated as /designpath = pointcost , if no point cost is specified it defaults to 1.
// To make a design unprotect use -1

// Magazines and ammo

/obj/item/computer_hardware/hard_drive/portable/design/nonlethal_ammo //please, maintain general order (pistol>speedloaders>smg>other>shells)+(smaller/less damaging caliber>bigger/more damaging caliber)
	disk_name = "H&S Nonlethal Magazines Pack"
	icon_state = "frozenstar"

	license = 20
	designs = list(
		//pistol mags
		/datum/design/autolathe/ammo/pistol_rubber,
		/datum/design/autolathe/ammo/magnum_rubber,
		/datum/design/autolathe/ammo/kurtz_rubber,
		//speed loaders
		/datum/design/autolathe/ammo/slpistol_rubber,
		/datum/design/autolathe/ammo/slmagnum_rubber,
		/datum/design/autolathe/ammo/slkurtz_rubber,
		//smg mags
		/datum/design/autolathe/ammo/smg_rubber,
		// rifles
		/datum/design/autolathe/ammo/lrifle_short_rubber,
		/datum/design/autolathe/ammo/rifle_short_rubber,
		/datum/design/autolathe/ammo/hrifle_rubber,
		//shells
		/datum/design/autolathe/ammo/shotgun_blanks = 0,
		/datum/design/autolathe/ammo/shotgun_beanbag,
		/datum/design/autolathe/ammo/shotgun_illumination,
	)

/obj/item/computer_hardware/hard_drive/portable/design/lethal_ammo //please, maintain general order (pistol>speedloaders>smg>other>shells)+(smaller/less damaging caliber>bigger/more damaging caliber)
	disk_name = "SA Lethal Magazines Pack"
	icon_state = "sa"

	license = 20
	designs = list(
		//pistol mags
		/datum/design/autolathe/ammo/pistol,
		/datum/design/autolathe/ammo/pistol_lethal,
		/datum/design/autolathe/ammo/magnum,
		/datum/design/autolathe/ammo/magnum_lethal,
		/datum/design/autolathe/ammo/kurtz_lethal,
		//speed loaders
		/datum/design/autolathe/ammo/slpistol,
		/datum/design/autolathe/ammo/slpistol_lethal,
		/datum/design/autolathe/ammo/slmagnum,
		/datum/design/autolathe/ammo/slmagnum_lethal,
		/datum/design/autolathe/ammo/slkurtz,
		/datum/design/autolathe/ammo/slkurtz_lethal,
		//smg mags
		/datum/design/autolathe/ammo/smg,
		/datum/design/autolathe/ammo/smg_lethal,
		/datum/design/autolathe/ammo/mag_10x24, // The specific model of the Spec Ops.
		// rifles
		/datum/design/autolathe/ammo/lrifle,
		/datum/design/autolathe/ammo/lrifle_short,
		/datum/design/autolathe/ammo/lrifle_short_lethal,
		/datum/design/autolathe/ammo/rifle,
		/datum/design/autolathe/ammo/rifle_short,
		/datum/design/autolathe/ammo/rifle_lethal,
		/datum/design/autolathe/ammo/rifle_short_lethal,
		/datum/design/autolathe/ammo/hrifle,
		/datum/design/autolathe/ammo/hrifle_lethal,
		//shells
		/datum/design/autolathe/ammo/shotgun_pellet,
		/datum/design/autolathe/ammo/shotgun,
		/datum/design/autolathe/container/ammocan_serb,
	)

/obj/item/computer_hardware/hard_drive/portable/design/ammo_boxes_smallarms
	disk_name = "SA Handgun Ammunition"
	icon_state = "sa"

	license = 20
	designs = list(
		/datum/design/autolathe/ammo/pistol_ammobox,
		/datum/design/autolathe/ammo/pistol_ammobox/large,
		/datum/design/autolathe/ammo/pistol_ammobox_practice = 0,
		/datum/design/autolathe/ammo/pistol_ammobox_rubber,
		/datum/design/autolathe/ammo/pistol_ammobox_lethal,
		/datum/design/autolathe/ammo/magnum_ammobox,
		/datum/design/autolathe/ammo/magnum_ammobox/large,
		/datum/design/autolathe/ammo/magnum_ammobox_practice = 0,
		/datum/design/autolathe/ammo/magnum_ammobox_rubber,
		/datum/design/autolathe/ammo/magnum_ammobox_lethal,
		/datum/design/autolathe/ammo/kurtz_ammobox,
		/datum/design/autolathe/ammo/kurtz_ammobox_practice = 0,
		/datum/design/autolathe/ammo/kurtz_ammobox_rubber,
		/datum/design/autolathe/ammo/kurtz_ammobox_lethal,
		/datum/design/autolathe/container/ammocan_serb,
	)

/obj/item/computer_hardware/hard_drive/portable/design/ammo_boxes_rifle
	disk_name = "SA Rifle Ammunition"
	icon_state = "sa"

	license = 20
	designs = list(
		/datum/design/autolathe/ammo/rifle_ammobox_small,
		/datum/design/autolathe/ammo/rifle_ammobox_small_practice = 0,
		/datum/design/autolathe/ammo/rifle_ammobox_small_rubber,
		/datum/design/autolathe/ammo/rifle_ammobox_small_lethal,
		/datum/design/autolathe/ammo/rifle_ammobox,
		/datum/design/autolathe/ammo/lrifle_ammobox_small,
		/datum/design/autolathe/ammo/lrifle_ammobox_small_practice = 0,
		/datum/design/autolathe/ammo/lrifle_ammobox_small_rubber,
		/datum/design/autolathe/ammo/lrifle_ammobox_small_lethal,
		/datum/design/autolathe/ammo/lrifle_ammobox,
		/datum/design/autolathe/ammo/hrifle_ammobox_small,
		/datum/design/autolathe/ammo/hrifle_ammobox_small_practice = 0,
		/datum/design/autolathe/ammo/hrifle_ammobox_small_rubber,
		/datum/design/autolathe/ammo/hrifle_ammobox_small_lethal,
		/datum/design/autolathe/ammo/hrifle_ammobox,
		/datum/design/autolathe/ammo/box_10x24_small = 2, // Small version moved here for Ranger ease of access, double the cost as the spec ops disk as it has double the points
		/datum/design/autolathe/ammo/shotgun_box = 5, //35 x 4 (140 shells while a full disk of 5 x 20 = 100)
		/datum/design/autolathe/ammo/shotgun_pellet_box = 5,
		/datum/design/autolathe/container/ammocan_serb,
	)


/obj/item/computer_hardware/hard_drive/portable/design/exotic_ammo
	disk_name = "SA Exotic Ammunition Pack"
	icon_state = "sa"
	license = 20

	designs = list(
		/datum/design/autolathe/ammo/shotgun_speedloader_empty= 0,
		/datum/design/autolathe/ammo/sbaw_empty = 0,
		/datum/design/autolathe/ammo/m12empty = 0,
		/datum/design/autolathe/ammo/hrifle_drum_empty = 0,
		/datum/design/autolathe/ammo/rifle_pk_empty = 0,
		/datum/design/autolathe/ammo/lrifle_belt_empty = 0,
		/datum/design/autolathe/ammo/hrifle_ammobox_linked_empty = 0,
		/datum/design/autolathe/ammo/maxim_empty = 0,
		/datum/design/autolathe/ammo/c10x24 = 3,
		/datum/design/autolathe/ammo/lrifle_ammobox,
		/datum/design/autolathe/ammo/rifle_ammobox,
		/datum/design/autolathe/ammo/hrifle_ammobox,
		/datum/design/autolathe/ammo/shotgun_box = 3, //35 x 6 (210 shells well a full disk of 5 x 20 = 100)
		/datum/design/autolathe/ammo/shotgun_pellet_box = 3,
		/datum/design/autolathe/ammo/mag_10x24 = 1,
		/datum/design/autolathe/ammo/box_10x24 = 5,
		/datum/design/autolathe/ammo/box_antim = 5,
		/datum/design/autolathe/container/ammocan_serb = 0,
		/datum/design/autolathe/ammo/lrifle_drum = 2,
		/datum/design/autolathe/ammo/lrifle_drum_empty = 1,
		/datum/design/autolathe/ammo/rifle_drum = 2,
		/datum/design/autolathe/ammo/rifle_drum_empty = 1,
		)

// G U N S (minus excelsior and research)
// Pack is used when there is more than one gun on the disk

// 9mm PISTOLS + REVOLVERS

/obj/item/computer_hardware/hard_drive/portable/design/guns/cheap_guns
	disk_name = "H&S - 9mm Economy Pack"
	icon_state = "frozenstar"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/giskard = 2,
		/datum/design/autolathe/gun/olivaw = 2,
		/datum/design/autolathe/gun/detective,
		/datum/design/autolathe/ammo/pistol_practice = 0,
		/datum/design/autolathe/ammo/pistol_rubber,
		/datum/design/autolathe/ammo/slpistol_practice = 0,
		/datum/design/autolathe/ammo/slpistol_rubber,
		/datum/design/autolathe/ammo/hpistol_practice = 1,
		/datum/design/autolathe/ammo/hpistol_rubber = 2,
		/datum/design/autolathe/ammo/hpistol = 2,
		/datum/design/autolathe/ammo/hpistol_lethal = 2,
		/datum/design/autolathe/container/ammocan_serb,
		)


/obj/item/computer_hardware/hard_drive/portable/design/guns/colt
	disk_name = "H&S - 9mm M1911"
	icon_state = "ironhammer"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/colt = 3,
		/datum/design/autolathe/ammo/pistol_practice = 0,
		/datum/design/autolathe/ammo/pistol_rubber,
		/datum/design/autolathe/ammo/pistol,
		/datum/design/autolathe/ammo/pistol_lethal = 2,
		/datum/design/autolathe/ammo/hpistol_practice = 1,
		/datum/design/autolathe/ammo/hpistol_rubber = 2,
		/datum/design/autolathe/ammo/hpistol = 2,
		/datum/design/autolathe/ammo/hpistol_lethal = 2,
	)

/obj/item/computer_hardware/hard_drive/portable/design/guns/glock
	disk_name = "Seinemetall Defense GmbH - 9mm Sky Auto Pistol"
	icon_state = "frozenstar"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/glock = 3,
		/datum/design/autolathe/ammo/hpistol_practice = 0,
		/datum/design/autolathe/ammo/hpistol_rubber,
		/datum/design/autolathe/ammo/hpistol,
		/datum/design/autolathe/ammo/hpistol_lethal = 2,
	)


// 10mm REVOLVERS

/obj/item/computer_hardware/hard_drive/portable/design/guns/revolver
	disk_name = "H&S - 10mm Minotaur Revolver"
	icon_state = "frozenstar"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/revolver = 3,
		/datum/design/autolathe/ammo/slmagnum_practice = 0,
		/datum/design/autolathe/ammo/slmagnum_rubber,
		/datum/design/autolathe/ammo/slmagnum,
		/datum/design/autolathe/ammo/slmagnum_lethal = 2,
		)

/obj/item/computer_hardware/hard_drive/portable/design/guns/rev10
	disk_name = "H&S - 10mm Frontier Revolver"
	icon_state = "ironhammer"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/rev10 = 3,
		/datum/design/autolathe/ammo/slmagnum_practice = 0,
		/datum/design/autolathe/ammo/slmagnum_rubber,
		/datum/design/autolathe/ammo/slmagnum,
		/datum/design/autolathe/ammo/slmagnum_lethal = 2,
		)

// 10mm pistols

/obj/item/computer_hardware/hard_drive/portable/design/guns/ladon/dark
	disk_name = "Seinemetall Defense GmbH - 10mm Auto-Mag Ladon Handgun"
	icon_state = "onestar"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/ladon = 3,
		/datum/design/autolathe/ammo/magnum_practice = 0,
		/datum/design/autolathe/ammo/magnum_rubber,
		/datum/design/autolathe/ammo/magnum,
		/datum/design/autolathe/ammo/magnum_lethal = 2,
		)

/obj/item/computer_hardware/hard_drive/portable/design/guns/ladon
	disk_name = "H&S - 10mm Auto-Mag Porton Handgun"
	icon_state = "frozenstar"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/ladon_hs = 3,
		/datum/design/autolathe/ammo/magnum_practice = 0,
		/datum/design/autolathe/ammo/magnum_rubber,
		/datum/design/autolathe/ammo/magnum,
		/datum/design/autolathe/ammo/magnum_lethal = 2,
		)

/obj/item/computer_hardware/hard_drive/portable/design/guns/ladon/sa
	disk_name = "SA - 10mm Auto-Mag Sigia Handgun"
	icon_state = "sa"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/ladon_sa = 3,
		/datum/design/autolathe/ammo/magnum_practice = 0,
		/datum/design/autolathe/ammo/magnum_rubber,
		/datum/design/autolathe/ammo/magnum,
		/datum/design/autolathe/ammo/magnum_lethal = 2,
		)

/obj/item/computer_hardware/hard_drive/portable/design/guns/colt/ten
	disk_name = "H&S - 10mm Auto-Mag Delta Elite"
	icon_state = "frozenstar"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/ten = 3,
		/datum/design/autolathe/ammo/magnum_practice = 0,
		/datum/design/autolathe/ammo/magnum_rubber,
		/datum/design/autolathe/ammo/magnum,
		/datum/design/autolathe/ammo/magnum_lethal = 2,
		)

/obj/item/computer_hardware/hard_drive/portable/design/guns/rafale
	disk_name = "Seinemetall Defense GmbH - 10mm Auto-Mag Rafale"
	icon_state = "frozenstar"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/rafale = 3,
		/datum/design/autolathe/ammo/magnum_practice = 0,
		/datum/design/autolathe/ammo/magnum_rubber,
		/datum/design/autolathe/ammo/magnum,
		/datum/design/autolathe/ammo/magnum_lethal = 2,
		)

/obj/item/computer_hardware/hard_drive/portable/design/guns/armstrong
	disk_name = "H&S - 10mm lever action Armstrong"
	icon_state = "frozenstar"

	license = 16
	designs = list(
		/datum/design/autolathe/gun/lever = 6,
		/datum/design/autolathe/ammo/magnum_ammobox = 3,
		/datum/design/autolathe/ammo/magnum_ammobox_practice = 0,
		/datum/design/autolathe/ammo/magnum_ammobox_rubber = 3,
		/datum/design/autolathe/ammo/magnum_ammobox_lethal = 4,
		)

// 10mm SMGS
/obj/item/computer_hardware/hard_drive/portable/design/guns/vector
	disk_name = "SA - 10mm Vector SMG"
	icon_state = "sa"

	license = 16
	designs = list(
		/datum/design/autolathe/gun/vector = 0, //The gun is free as this is the only way to get it
		/datum/design/autolathe/ammo/smg_magnum_40 = 3,
		/datum/design/autolathe/ammo/smg_magnum_40_rubber = 2,
		//Free as well do to being the only way to get these mags
		/datum/design/autolathe/ammo/smg_magnum_40_empty = 0,
		/datum/design/autolathe/ammo/smg_magnum_40_practice = 0,
		/datum/design/autolathe/ammo/smg_magnum_40_lethal = 4
		)

/obj/item/computer_hardware/hard_drive/portable/design/guns/thompson
	disk_name = "SolFed - 10mm Thompson SMG"
	icon_state = "solfed"

	license = 12
	designs = list(
		/datum/design/autolathe/gun/thompson = 4,
		/datum/design/autolathe/ammo/smg_magnum_40 = 2,
		/datum/design/autolathe/ammo/smg_magnum_40_rubber = 1,
		/datum/design/autolathe/ammo/smg_magnum_40_lethal = 3,
		/datum/design/autolathe/ammo/smg_magnum_40_practice = 0
		)

// 12mm PISTOLS

/obj/item/computer_hardware/hard_drive/portable/design/guns/lamia
	disk_name = "H&S - 12mm Lamia Handgun"
	icon_state = "frozenstar"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/lamia = 3,
		/datum/design/autolathe/ammo/kurtz_practice = 0,
		/datum/design/autolathe/ammo/kurtz_rubber,
		/datum/design/autolathe/ammo/kurtz,
		/datum/design/autolathe/ammo/kurtz_lethal = 2,
		)

/obj/item/computer_hardware/hard_drive/portable/design/guns/basilisk
	disk_name = "H&S - 12mm Basilisk Handgun"
	icon_state = "frozenstar"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/basilisk = 3,
		/datum/design/autolathe/ammo/kurtz_practice = 0,
		/datum/design/autolathe/ammo/kurtz_rubber,
		/datum/design/autolathe/ammo/kurtz,
		/datum/design/autolathe/ammo/kurtz_lethal = 2,
		)

/obj/item/computer_hardware/hard_drive/portable/design/guns/socom
	disk_name = "SF - 12mm \"SOCOM\" Silenced Handgun"
	icon_state = "solfed"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/socom = 3,
		/datum/design/autolathe/ammo/kurtz_practice = 0,
		/datum/design/autolathe/ammo/kurtz_rubber,
		/datum/design/autolathe/ammo/kurtz,
		/datum/design/autolathe/ammo/kurtz_lethal = 2,
		)

/obj/item/computer_hardware/hard_drive/portable/design/guns/mateba
	disk_name = "Seinemetall Defense GmbH - \"Mateba\" autorevolver"
	icon_state = "frozenstar"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/mateba = 4,
		/datum/design/autolathe/ammo/slkurtz_practice = 0,
		/datum/design/autolathe/ammo/slkurtz_rubber,
		/datum/design/autolathe/ammo/slkurtz,
		/datum/design/autolathe/ammo/slkurtz_lethal = 2,
	)

// SHOTGUNS

/obj/item/computer_hardware/hard_drive/portable/design/guns/doublebarrel
	disk_name = "SA - 20mm Double Barrel Shotgun"
	icon_state = "sa"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/doublebarrel = 3,
		/datum/design/autolathe/ammo/shotgun_beanbag,
		/datum/design/autolathe/ammo/shotgun_blanks = 0,
		/datum/design/autolathe/ammo/shotgun_illumination,
		)

/obj/item/computer_hardware/hard_drive/portable/design/guns/grizzly
	disk_name = "SA - 20mm Grizzly Shotgun"
	icon_state = "sa"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/pump_shotgun = 3,
		/datum/design/autolathe/ammo/shotgun_beanbag,
		/datum/design/autolathe/ammo/shotgun_blanks = 0,
		/datum/design/autolathe/ammo/shotgun_illumination,
		)

/obj/item/computer_hardware/hard_drive/portable/design/guns/sbaw
	disk_name = "20mm SBAW disk"
	icon_state = "solfed"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/sbaw = 3,
		/datum/design/autolathe/ammo/sbaw_slug,
		/datum/design/autolathe/ammo/sbaw_pellet,
		/datum/design/autolathe/ammo/sbaw_beanbag,
		/datum/design/autolathe/ammo/sbaw_payload = 3,
		/datum/design/autolathe/ammo/sbaw_empty = 0, //So we can handload new mags
		)

/obj/item/computer_hardware/hard_drive/portable/design/guns/gladstone
	disk_name = "H&S - 20mm Gladstone Shotgun"
	icon_state = "frozenstar"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/gladstone = 3,
		/datum/design/autolathe/ammo/shotgun_beanbag,
		/datum/design/autolathe/ammo/shotgun_blanks = 0,
		/datum/design/autolathe/ammo/shotgun_illumination,
		)

/obj/item/computer_hardware/hard_drive/portable/design/guns/state
	disk_name = "Seinemetall Defense GmbH - 20mm State Auto Shotgun"
	desc = "Known as the state, an odd shotgun, often redesigned every few years in a way few people are fully happy with."
	icon_state = "frozenstar"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/riot_shotgun = 3,
		/datum/design/autolathe/ammo/shotgun_beanbag,
		/datum/design/autolathe/ammo/shotgun_blanks = 0,
		/datum/design/autolathe/ammo/shotgun_illumination,
		)

/obj/item/computer_hardware/hard_drive/portable/design/guns/pug
	disk_name = "SA - 20mm Pug Auto Shotgun"
	icon_state = "sa"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/pug = 3,
		/datum/design/autolathe/ammo/m12beanbag, // Never add tazershells, for love of god
		/datum/design/autolathe/ammo/m12pellet,
		/datum/design/autolathe/ammo/m12slug,
		)

/obj/item/computer_hardware/hard_drive/portable/design/guns/sixshot
	disk_name = "SA - 20mm Revolving Shotgun"
	icon_state = "sa"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/sixshot = 3,
		/datum/design/autolathe/ammo/shotgun_beanbag,
		/datum/design/autolathe/ammo/shotgun_blanks = 0,
		/datum/design/autolathe/ammo/shotgun_illumination,
		)

// SMGs

/obj/item/computer_hardware/hard_drive/portable/design/guns/texan
	disk_name = "Seinemetall Defense GmbH - 9mm Texan SMG"
	icon_state = "frozenstar"

	license = 12
	designs = list(
		/datum/design/autolathe/gun/texan = 3,
		/datum/design/autolathe/ammo/smg_practice = 0,
		/datum/design/autolathe/ammo/smg_rubber,
		/datum/design/autolathe/ammo/smg,
		/datum/design/autolathe/ammo/smg_lethal = 2,
	)

// 6.5mm carbines


/obj/item/computer_hardware/hard_drive/portable/design/guns/pitbull
	disk_name = "SolFed  - 6.5mm Pitbull Carbine"
	icon_state = "solfed"

	license = 16
	designs = list(
		/datum/design/autolathe/gun/pitbull = 6,
		/datum/design/autolathe/ammo/lrifle_short_practice = 0,
		/datum/design/autolathe/ammo/lrifle_short_rubber,
		/datum/design/autolathe/ammo/lrifle_short,
		/datum/design/autolathe/ammo/lrifle_short_lethal = 2,
		/datum/design/autolathe/ammo/lrifle_practice = 1,
		/datum/design/autolathe/ammo/lrifle_rubber = 2,
		/datum/design/autolathe/ammo/lrifle = 2,
		/datum/design/autolathe/ammo/lrifle_lethal = 4,
	)


/obj/item/computer_hardware/hard_drive/portable/design/guns/bulldog
	disk_name = "Seinemetall Defense GmbH - 6.5mm Bulldog Carbine"
	icon_state = "frozenstar"

	license = 16
	designs = list(
		/datum/design/autolathe/gun/bulldog = 6,
		/datum/design/autolathe/gun/bulldog_rds = 7,
		/datum/design/autolathe/ammo/lrifle_short_practice = 0,
		/datum/design/autolathe/ammo/lrifle_short_rubber,
		/datum/design/autolathe/ammo/lrifle_short,
		/datum/design/autolathe/ammo/lrifle_short_lethal = 2,
		/datum/design/autolathe/ammo/lrifle_practice = 1,
		/datum/design/autolathe/ammo/lrifle_rubber = 2,
		/datum/design/autolathe/ammo/lrifle = 2,
		/datum/design/autolathe/ammo/lrifle_lethal = 4,
	)

/obj/item/computer_hardware/hard_drive/portable/design/guns/sol
	disk_name = "H&S - 6.5mm \"Solarian\" Carbine"
	icon_state = "solfed"

	license = 18
	designs = list(
		/datum/design/autolathe/gun/sol = 6,
		/datum/design/autolathe/ammo/lrifle_short_practice = 0,
		/datum/design/autolathe/ammo/lrifle_short_rubber,
		/datum/design/autolathe/ammo/lrifle_short,
		/datum/design/autolathe/ammo/lrifle_short_lethal = 2,
		/datum/design/autolathe/ammo/lrifle_practice = 1,
		/datum/design/autolathe/ammo/lrifle_rubber = 2,
		/datum/design/autolathe/ammo/lrifle = 2,
		/datum/design/autolathe/ammo/lrifle_lethal = 4,
		/datum/design/autolathe/ammo/shotgun_pellet = 1,
		/datum/design/autolathe/ammo/shotgun = 2,
		/datum/design/autolathe/ammo/shotgun_beanbag = 1,
		)

/obj/item/computer_hardware/hard_drive/portable/design/guns/ostwind
	disk_name = "Seinemetall Defense GmbH - 6.5mm Ostwind Carbine"
	icon_state = "frozenstar"

	license = 16
	designs = list(
		/datum/design/autolathe/gun/ostwind = 6,
		/datum/design/autolathe/ammo/lrifle_short_practice = 0,
		/datum/design/autolathe/ammo/lrifle_short_rubber,
		/datum/design/autolathe/ammo/lrifle_short,
		/datum/design/autolathe/ammo/lrifle_short_lethal = 2,
		/datum/design/autolathe/ammo/lrifle_practice = 1,
		/datum/design/autolathe/ammo/lrifle_rubber = 2,
		/datum/design/autolathe/ammo/lrifle = 2,
		/datum/design/autolathe/ammo/lrifle_lethal = 4,
	)

// 6.5mm Carbine

/obj/item/computer_hardware/hard_drive/portable/design/guns/tk
	disk_name = "SD GmbH - 6.5mm Takeshi LMG"
	icon_state = "frozenstar"

	license = 8 //So we can print 2 and some ammo
	designs = list(
		/datum/design/autolathe/gun/tk = 3,
		/datum/design/autolathe/ammo/lrifle_ammobox = 2,
		/datum/design/autolathe/ammo/lrifle_belt, //This is its linked ammo
		/datum/design/autolathe/ammo/lrifle_belt_empty = 0,
		/datum/design/autolathe/ammo/lrifle_ammobox_small_practice = 0,
		/datum/design/autolathe/ammo/lrifle_ammobox_rubber,
	)

/obj/item/computer_hardware/hard_drive/portable/design/guns/roe
	disk_name = "Hunters Inc - 6.5mm Roe Rifle"
	icon_state = "hunters"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/roe =  3,
		/datum/design/autolathe/ammo/lrifle_speed_loader,
		/datum/design/autolathe/ammo/lrifle_ammobox_small_practice = 0,
		/datum/design/autolathe/ammo/lrifle_ammobox_small_rubber,
		/datum/design/autolathe/ammo/lrifle_ammobox_small,
		/datum/design/autolathe/ammo/lrifle_ammobox_small_lethal = 2,
	)

// 7.62mm Rifles

/obj/item/computer_hardware/hard_drive/portable/design/guns/sa_kalashnikov
	disk_name = "SA - 7.62mm Kalashnikov Rifle"
	icon_state = "sa"

	license = 16
	designs = list(
		/datum/design/autolathe/gun/ak47_sa = 6,
		/datum/design/autolathe/ammo/rifle_short_practice = 0,
		/datum/design/autolathe/ammo/rifle_short_rubber,
		/datum/design/autolathe/ammo/rifle_short,
		/datum/design/autolathe/ammo/rifle_short_lethal = 2,
		/datum/design/autolathe/ammo/rifle_practice = 1,
		/datum/design/autolathe/ammo/rifle_rubber = 2,
		/datum/design/autolathe/ammo/rifle = 2,
		/datum/design/autolathe/ammo/rifle_lethal = 4,
	)

/obj/item/computer_hardware/hard_drive/portable/design/strelki
	disk_name = "Hunters Inc - 7.62mm \"Strelki\""
	icon_state = "hunters"
	license = 8

	designs = list(
		/datum/design/autolathe/gun/strelki = 3,
		/datum/design/autolathe/ammo/rifle,
		/datum/design/autolathe/ammo/rifle_rubber,
		/datum/design/autolathe/ammo/rifle_practice = 0,
		/datum/design/autolathe/ammo/rifle_lethal = 2
		)

/obj/item/computer_hardware/hard_drive/portable/design/guns/tac_kalashnikov
	disk_name = "SA - 7.62mm Breacher Kalashnikov Rifle"
	icon_state = "sa"

	license = 18
	designs = list(
		/datum/design/autolathe/gun/ak47_tac = 6,
		/datum/design/autolathe/ammo/rifle_short_practice = 0,
		/datum/design/autolathe/ammo/rifle_short_rubber,
		/datum/design/autolathe/ammo/rifle_short,
		/datum/design/autolathe/ammo/rifle_short_lethal = 2,
		/datum/design/autolathe/ammo/rifle_practice = 1,
		/datum/design/autolathe/ammo/rifle_rubber = 2,
		/datum/design/autolathe/ammo/rifle = 2,
		/datum/design/autolathe/ammo/rifle_lethal = 4,
		/datum/design/autolathe/ammo/shotgun_pellet = 2,
		/datum/design/autolathe/ammo/shotgun = 2,
		/datum/design/autolathe/ammo/shotgun_beanbag = 1
	)

/obj/item/computer_hardware/hard_drive/portable/design/guns/boltgun_sa
	disk_name = "Hunters Inc - 7.62mm Novakovic Rifle"
	icon_state = "hunters"

	license = 12
	designs = list(
		/datum/design/autolathe/gun/boltgun_sa = 3,
		/datum/design/autolathe/ammo/rifle_ammobox_small_practice = 0,
		/datum/design/autolathe/ammo/rifle_ammobox_small_rubber,
		/datum/design/autolathe/ammo/rifle_ammobox,
		/datum/design/autolathe/ammo/rifle_ammobox_small_lethal = 2,
		/datum/design/autolathe/ammo/sl_rifle,
	)

//8.6mm heavy rifles

/obj/item/computer_hardware/hard_drive/portable/design/guns/omni
	disk_name = "H&S NM - 8.6mm Omnirifle"
	icon_state = "ironhammer"

	license = 12
	designs = list(
		/datum/design/autolathe/gun/omnirifle = 3,
		/datum/design/autolathe/ammo/hrifle_practice = 0,
		/datum/design/autolathe/ammo/hrifle_rubber,
		/datum/design/autolathe/ammo/hrifle,
		/datum/design/autolathe/ammo/hrifle_lethal = 2,
	)

/obj/item/computer_hardware/hard_drive/portable/design/guns/omni/longarm
	disk_name = "H&S NM - 8.6mm Longarm Omnirfile"
	icon_state = "ironhammer"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/scoped_omnirifle = 4,
		/datum/design/autolathe/ammo/hrifle_practice = 0,
		/datum/design/autolathe/ammo/hrifle_rubber,
		/datum/design/autolathe/ammo/hrifle,
		/datum/design/autolathe/ammo/hrifle_lethal = 2,
	)

/obj/item/computer_hardware/hard_drive/portable/design/guns/scout
	disk_name = "H&S - 8.6mm Scout Sniper Rifle"
	icon_state = "frozenstar"

	license = 6
	designs = list(
		/datum/design/autolathe/gun/scout = 3,
		/datum/design/autolathe/ammo/hrifle_ammobox_small_practice = 0,
		/datum/design/autolathe/ammo/hrifle_ammobox_small_rubber,
		/datum/design/autolathe/ammo/hrifle_ammobox_small,
		/datum/design/autolathe/ammo/hrifle_ammobox_small_lethal = 2,
		/datum/design/autolathe/ammo/hrifle_ammobox_small_hv = 3,
	)

/obj/item/computer_hardware/hard_drive/portable/design/guns/custer
	disk_name = "H&S - 8.6mm Custer Repeating Rifle"
	icon_state = "sa"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/custer = 3,
		/datum/design/autolathe/ammo/hrifle_ammobox_small_practice = 0,
		/datum/design/autolathe/ammo/hrifle_ammobox_small_rubber,
		/datum/design/autolathe/ammo/hrifle_ammobox_small,
		/datum/design/autolathe/ammo/hrifle_ammobox_small_lethal = 2,
	)

// Heavy

/obj/item/computer_hardware/hard_drive/portable/design/guns/heavysniper
	disk_name = "SA - 14.5×114mm Penetrator AMR"
	icon_state = "sa"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/heavysniper = 3,
		/datum/design/autolathe/ammo/antim,
		/datum/design/autolathe/ammo/box_antim = 2,
	)


/obj/item/computer_hardware/hard_drive/portable/design/guns/sa_pk
	disk_name = "SA - 7.62mm Pulemyot Kalashnikova MG"
	icon_state = "sa"

	license = 12
	designs = list(
		/datum/design/autolathe/gun/mg_pk = 3,
		/datum/design/autolathe/ammo/rifle_pk,
		/datum/design/autolathe/ammo/rifle_pk_empty = 0,
	)

// Grenade Launchers

obj/item/computer_hardware/hard_drive/portable/design/guns/lenar
	disk_name = "Seinemetall Defense GmbH - Lenar Grenade Launcher"
	icon_state = "frozenstar"

	license = 3
	designs = list(
		/datum/design/autolathe/gun/grenade_launcher_lenar, // "FS GL \"Lenar\""
	)

obj/item/computer_hardware/hard_drive/portable/design/guns/china
	disk_name = "SA GL \"China Lake\""
	icon_state = "ironhammer"

	license = 12
	designs = list(
		/datum/design/autolathe/gun/grenade_launcher_china_lake = 3,
		/datum/design/autolathe/ammo/grenade = 1,
		/datum/design/autolathe/ammo/grenade/frag = 2,
		/datum/design/autolathe/ammo/grenade/emp = 2,
		/datum/design/autolathe/ammo/grenade/blast = 3,
		/datum/design/autolathe/ammo/grenade/flash = 2
		)

// ENERGY ARMS

/obj/item/computer_hardware/hard_drive/portable/design/guns/spiderrose
	disk_name = "H&S - Spider Rose PDW E"
	icon_state = "frozenstar"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/energygun = 3,
		/datum/design/autolathe/cell/medium/high,
	)

/obj/item/computer_hardware/hard_drive/portable/design/guns/martin
	disk_name = "H&S - Martin PDW E"
	icon_state = "frozenstar"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/energygun_martin = 2,
		/datum/design/autolathe/cell/small/high,
	)

/obj/item/computer_hardware/hard_drive/portable/design/guns/lasercore
	disk_name = "H&S - Laser Core PDW E"
	icon_state = "frozenstar"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/lasercore = 2,
		/datum/design/autolathe/cell/medium/high,
	)

/obj/item/computer_hardware/hard_drive/portable/design/guns/firestorm
	disk_name = "H&S - Firestorm PDW E"
	icon_state = "frozenstar"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/firestorm = 2,
		/datum/design/autolathe/cell/small/high,
	)

/obj/item/computer_hardware/hard_drive/portable/design/guns/lasercannon
	disk_name = "H&S - \"Titanica\" Laser Cannon"
	icon_state = "frozenstar"

	license = 8 //2 gun 2 cell,
	designs = list(
		/datum/design/autolathe/gun/titanica = 3,
		/datum/design/autolathe/cell/small/high,
	)

/obj/item/computer_hardware/hard_drive/portable/design/guns/auretian
	disk_name = "SI - \"Auretian\" E Pistol"
	icon_state = "moebius"

	license = 4 //1 gun 1 cell, or 4 good cells that are bette then normal
	designs = list(
		/datum/design/research/item/weapon/auretian = 3,
		/datum/design/research/item/powercell/small/basic,
	)

/obj/item/computer_hardware/hard_drive/portable/design/guns/stun_revolver_sci
	disk_name = "SI - \"Hera\" Stun Revolver"
	icon_state = "moebius"

	license = 8 //2 gun 2 cell, or 8 good cells that are bette then normal
	designs = list(
		/datum/design/research/item/weapon/stunrevolver = 3,
		/datum/design/research/item/powercell/small/basic,
	)

/obj/item/computer_hardware/hard_drive/portable/design/guns/stun_revolver
	disk_name = "Seinemetall Defense GmbH - \"Zeus\" Stun Revolver"
	icon_state = "frozenstar"

	license = 8//2 guns 2 cells
	designs = list(
		/datum/design/autolathe/gun/revolver_taser = 2,
		/datum/design/autolathe/cell/small/high,
	)

/obj/item/computer_hardware/hard_drive/portable/design/guns/lasercannon
	disk_name = "SI - \"Solaris\" Laser Cannon"
	icon_state = "moebius"

	license = 8 //1 gun 1 cell, or 4 good cells that are bette then normal
	designs = list(
		/datum/design/research/item/weapon/lasercannon = 6,
		/datum/design/research/item/powercell/medium/basic = 2,
	)

/obj/item/computer_hardware/hard_drive/portable/design/guns/centauri
	disk_name = "SI - \"Centauri\" PDW E"
	icon_state = "moebius"

	license = 8 //2 gun 1 cell, or 4 good cells that are bette then normal
	designs = list(
		/datum/design/research/item/weapon/centauri = 3,
		/datum/design/research/item/powercell/medium/basic = 2,
	)

/obj/item/computer_hardware/hard_drive/portable/design/guns/ion_pistol
	disk_name = "Seinemetall Defense GmbH - \"Aedes\" Ion Pistol"
	icon_state = "frozenstar"

	license = 6//2 guns 2 cells
	designs = list(
		/datum/design/autolathe/gun/ion_pistol = 2,
		/datum/design/autolathe/cell/medium/high,
	)


// PLASMA ARMS

/obj/item/computer_hardware/hard_drive/portable/design/guns/cassad
	disk_name = "H&S - Cassad Plasma Rifle"
	icon_state = "frozenstar"

	license = 8
	designs = list(
		/datum/design/autolathe/gun/pulse_cassad = 4,
		/datum/design/autolathe/cell/medium/high,
	)

/obj/item/computer_hardware/hard_drive/portable/design/guns/centurio
	disk_name = "SI - \"Centurio\" Plasma Pistol"
	icon_state = "moebius"

	license = 8 //1 gun 1 cell, or 4 good cells that are bette then normal
	designs = list(
		/datum/design/research/item/weapon/centurio = 6,
		/datum/design/research/item/powercell/medium/basic = 2,
	)


//10x24mm Guns

/obj/item/computer_hardware/hard_drive/portable/design/guns/pulse_rifle
	disk_name = "PAR - 10x24mm Caseless Pulse Rifle"
	icon_state = "black"

	license = 10 //2 guns 2 mags and 1 box
	designs = list(
		/datum/design/autolathe/gun/pulse_rifle = 3,
		/datum/design/autolathe/ammo/c10x24,
		/datum/design/autolathe/ammo/box_10x24 = 2,
	)

/obj/item/computer_hardware/hard_drive/portable/design/guns/survivalrifle
	disk_name = "Hunters Inc - 10x24mm Caseless /'Bond/' Rifle"
	icon_state = "hunters"

	license = 10 //2 guns 2 mags and 1 box
	designs = list(
		/datum/design/autolathe/gun/survivalrifle = 3,
		/datum/design/autolathe/ammo/mag_10x24,
		/datum/design/autolathe/ammo/box_10x24_small = 1,
	)

/obj/item/computer_hardware/hard_drive/portable/design/guns/rex10
	disk_name = "H&S - Cowboy Revolver"
	icon_state = "ironhammer"

	license = 12
	designs = list(
		/datum/design/autolathe/gun/rex10 = 3,
		/datum/design/autolathe/ammo/slpistol_rubber = 2,
		/datum/design/autolathe/ammo/slpistol,
		/datum/design/autolathe/ammo/slpistol_lethal,
	)
