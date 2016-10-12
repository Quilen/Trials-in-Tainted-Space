import classes.Characters.PlayerCharacter;
import classes.RoomClass;

/*----------------------------------------------------outline----------------------------------------------------
Two weeks after becoming nyrea royal, the player encounters a bunch of activity while collecting their spoils - Queensguard Cerres is preparing a punitive expedition against another tribe that kidnapped some of their males.
The player comes along for a ~2 weeks odyssey to get them back, potentially getting to know Cerres and some of the nyrea better in the process.
They will face like four or five challenges on the way there, one big challenge to rescue the kidnapped males, and a few more challenges as they make their way back, pursued by the hostile tribe.

Companions:
	-Queensguard Cerres (super loyal, very formal until she knows you better)
	-A massive ganrael that draws the supply wagon (smarter then they let on)
		(can get hurt if something goes wrong) (name: Iumen)
	-A dozen nyrea huntresses (they act as a pack most of the time)
		(some of them may die if something goes very wrong)
		(lose morale if things go somewhat wrong, gain morale if you do cool stuff)
	-Maybe one of the rescued males will be fleshed out more on the way back
	
Notes:
	-everything is underground, time of day doesn't make a difference
	-player get's one rest after every challenge
	-rest time is opportunity to chat with your companions and learn more about them

Challenges on the way there:
	1. Pass through red myr controlled territory.
		-Diplomatically 
			-maybe pretend to be a merchant caravan(smuggler?) or just request passage
			-at least one of them is a douche you want to punch
			-at least one of them is nice
			-at least one of your huntresses will want to punch the douche and you have to help keep them in line
				-if you fail, one of the huntresses get's hurt
			-relatively uneventful aside from that
		-Stealthily
			-use a small side path
			-get ambushed by some ganrael ambushers or something
			-a huntress falls down a cliff and you have to rescue her
			-if you screw up near the end, be chased away by a red tank
	2. Cross a large underground river
		-Wings or jetpack: fly a rope across to make crossing possible for others
		-high aim and physique: tie a rope to spear, throw it across river, pass alon yourself and tie properly
	3. Accidentally make camp in the mouth of a (sleeping) giant monster
		-avoid if aim and intelligence are high or player eyes are better than human (see teeth)
		-else notice breathing/snoring if intelligence decent or player's ears are better than human
			-sneak out of mouth
		-else discover when monster wakes up and tries to swallow the group
			-fight to hurt the monster enough that it spits you out while it chews you
			-if you fail the ganrael breaks through the monster's teeth and gets chewed on in the process
		-afterwards: angry monster chases you
	4. Get lost in the maze
		-giant monster from previous challenge chases you into small labyrinthine side tunnel
		-if low intelligence, maze is physically impossible/loops around on itself
		-ganrael can tunnel through some walls
		-minotaur-like creature hunts you (or maybe a dragon-person with a hoard)
			-attacks directly if someone get's seperated from the group, else stalks you audibly
		-challenge resolved when player finds the exit
	5. Deal with a scout from the enemy tribe

Callenges there:


Challenges on the way back:

	n. Get greeted by your crew who is happy to have you back.



TODOS:
	-set flags["CRT_DONE"] when trip finished

*/



//----------------------------------------------------functions--------------------------------------------------

public function crtInitFlags():void {
	flags["CRT_HUNTRESSES_NUMBER"] = 12;
	flags["CRT_HUNTRESSES_MORALE"] = 50;
	flags["CRT_GANRAEL_HEALTH"] = 2000;
}

public function crtC4MakeCamp():void {
	flags["CRT_C4_CAMP_MADE"] = 1;
	rooms["crtC4R2319"].addFlag(GLOBAL.COMMERCE);
	rooms["crtC4R2318"].addFlag(GLOBAL.NPC);
}



//----------------------------------------------------dialog-----------------------------------------------------

public function crtStart():void {
	if (flags["QUEENSGUARD_STAB_TIME"] == undefined || flags["QUEENSGUARD_STAB_TIME"] + (14 * 24 * 60) > GetGameTimestamp()) {
		rooms["2I11"].removeFlag(GLOBAL.NPC);
		output("Several stone pillars line the passage on either side, clearly hand-carved and polished to a shine. Rather than glowing fungus coating the walls, several small clay sconces have been bolted onto the pillars, filled with colonies of the glowing fungus that sheds a soft, warm light across the tunnel. To the west, you can see what looks like a pair of heavy gates, flanked by a pair of large sconces filled with pulsing, glowing fungus.");
	} else {
		rooms["2I11"].addFlag(GLOBAL.NPC);
		output("You find the Queens Road less quiet than you are used to. Cerres, Taivra’s personal bodyguard, is standing amidst a flurry of activity - a dozen nyrea loading supplies onto a wagon the size of a hovertruck, huntresses sharpening their spears, arguing over routes and putting on armor. Cerres herself is directing several nervous looking males as they strap a humongous ganrael into a harness made of ropes thick enough to anchor a warship. The dark green ganrael has taken the shape of a massive caterpillar, all overlapping armorplates and legs as thick as tree trunks, dwarfing the surounding nyrea. When one of the males walks around its almost featureless front it grunts at her. She squeaks and jumps, holding her hands to her chest for a moment before continuing her tasks.\n\nAs soon as Cerres notices you, she takes a few steps towards you, bows, and says <i>“At your service, my liege.”</i>");
		variableRoomUpdateCheck();
		addButton(0, "Queensguard", crtPrep, undefined, "Approch Queensguard", "Ask what's going on here.");
	}
}

public function crtPrep():void {
	clearOutput();
	showBust("QUEENSGUARD");
	showName("\nCERRES");
	author("Quilen")

	//TODO: needs flavor
	output("<i>“Ready to go on an adventure?”</i>");
	
	clearMenu();
	addButton(0,"Yes",crtLeaveTown,undefined,"Go on adventure","Yes, you are ready to go on an adventure. It might take a while until you can come back.");
	addButton(1,"No",mainGameMenu,undefined,"Stay here","No, you have better things to do..");
}


public function crtLeaveTown():void {
	clearOutput();
	crtInitFlags();
	//TODO: needs flavor
	output("Descrition of how your journey starts.");
	currentLocation = "crtTestTele";
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}


//--------Challenge 4 begins here--------

public function crtC4horrifyingMonster():Boolean {
	clearOutput();
	clearMenu();
	author("Quilen")
	if (flags["CRT_C4_FLEE_TIMESTAMP"] == undefined) flags["CRT_C4_FLEE_TIMESTAMP"] = GetGameTimestamp();
	
	if (flags["CRT_C4_CAMP_MADE"] == undefined) {
		output("You can't turn around right now. The tunnel behind you is completely filled by Iumen and you can't demand he crawl ass first into the monster's mouth.");
	} else if ( (GetGameTimestamp() - flags["CRT_C4_FLEE_TIMESTAMP"]) <= (8 * 60) && flags["CRT_C4_SHOT_TAKEN"] == undefined ) {
		output("The terrifying monstrosity is still there and she still looks pissed from your last encounter. She paces up and down next to the diminutive passage you escaped through, her footfalls massive and forceful as thunder.\n\nIt's probably better not to go out yet, lest you end up a ");
		if (pc.armor.defense >= 3) output("crunchy ");
		output("snack for this beast.");
	} else if (flags["CRT_C4_SHOT_TAKEN"] != undefined) {
		output("You slowly and carefully peek your head out to look for the beast.\n\nYou can't see her, but you just <i>know</i> that she hasn't given up. Not after your previous fights.");
	} else {
		output("You slowly and carefully peek your head out to see if the beast has left in the meantime.\n\nAt first you don't see anything, but upon a closer look you spot the malicious, vengeful glimmer of her eyes in the distance, half hidden behind a rock formation. From afar, the creature is easy to mistake for lifeless scenery - no wonder you ended up in your current predicament...\n\nEither way, it doesn't look like this tenacious terror is going to get tired of hunting you any time soon. You'd better find another way out of here.");
	}
	clearMenu();
	if (flags["CRT_C4_CAMP_MADE"] == undefined) {
		addButton(0, "Go Back", crtC4horrifyingMonsterGoBack);
	} else {
		addButton(0, "Go Back", crtC4horrifyingMonsterGoBack, undefined, "Go Back", "This creature is too tough a nut to crack.");
		if (flags["CRT_C4_SHOT_TAKEN"] == undefined && !(pc.meleeWeapon is EmptySlot)) {
			addButton(1, "Shoot", crtC4horrifyingMonsterTakeShot, undefined, "Shoot", "The monster can't reach you! You can shoot her until she dies or runs off!");
		} else {
			if (!(pc.meleeWeapon is EmptySlot)) {
				addDisabledButton(1, "Shoot", "Shoot", "You have no reason to assume that you would get her this time. No point wasting ammunition.");
			} else {
				addDisabledButton(1, "Shoot", "Shoot", "You don't even <i>have</i> a ranged weapon...");
			}
		}
	}
	return true;
}

public function crtC4horrifyingMonsterGoBack():void {
	currentLocation = "crtC4R2120";
	mainGameMenu();
}

public function crtC4horrifyingMonsterTakeShot():void {
	clearOutput();
	clearMenu();
	author("Quilen")
	flags["CRT_C4_SHOT_TAKEN"] = 1;

	if ( (GetGameTimestamp() - flags["CRT_C4_FLEE_TIMESTAMP"]) <= (8 * 60) ) {
		output("The monstrosity is an easy target, big as a barn and clomping around only meters away. You level your [pc.rangedWeapon] at her and " + pc.rangedWeapon.attackVerb + "! And hit!\n\n...And it didn't do very much.\n\nStill, you can keep " + pc.rangedWeapon.attackVerb + "ing her until she finally succumbs to her injuries. Maybe. After a couple more hits the beast jumps behind an massive rock formation, landing with a <i>THUMP</i> that shakes the ground under you. Looks like you won't get another shot. You briefly consider sneaking away while the beast hides, but there is no way you're going to get your entire entourage out of harms way before she catches wind of what you are doing. " + (2 + flags["CRT_HUNTRESSES_NUMBER"]) + " people and an oversized ganrael make a lot of noise.");
		addButton(0, "Go Back", crtC4horrifyingMonsterGoBack, undefined, "Go Back", "That didn't help very much. You might as well wait for her to die of erosion.");
	} else {
		output("You level your [pc.rangedWeapon] at the creature in the distance. This is going to be a hard shot...\n\nSteady...\n\n...and...\n\n..." + pc.rangedWeapon.attackVerb + "!");
		if (pc.aim() >= 40) {
			output("\n\nRight in the eye! The beast shrieks in pain and almost panicly scrabbles backwards further into the rock formation before roaring out her now very personal hatred for you.");
		} else {
			output("\n\nDamn. Missed.");
			if (pc.isAss()) output(" You wanted to hurt that fucker so badly.");
			output("\n\nThe beast gives you a nasty stare before retreating a little further into the rocks.");
		}
		output(" Looks like you won't get another shot. You briefly consider sneaking away while the beast hides, but there is no way you're going to get your entire entourage out of harms way before she catches wind of what you are doing. " + (2 + flags["CRT_HUNTRESSES_NUMBER"]) + " people and an oversized ganrael make a lot of noise.");
		addButton(0, "Go Back", crtC4horrifyingMonsterGoBack, undefined, "Go Back", "The side passage is the more realistic option.");
	}
}

public function crtC4R2120RoomDesc():void {
	author("Quilen")
	if (flags["CRT_C4_CAMP_MADE"] == undefined) {
		output("You narrowly escaped the beast through this tiny passage. Well, tiny compared to the massive monstrosity outside, anyways - your ganrael friend managed to squeeze in here behind you, though it was a tight fit that left some new scratches on Iumen's carapace.\n\nThe path ahead is shrouded in darkness, unlike the large road you came from. Clearly nobody thought to plant bioluminescent mushrooms in this side passage. No matter - as Cerres points out, you do have lanterns on the supply wagon, though you won't be able to use them until Iumen is no longer stuck in the tunnel like a cork in a bottle.");
	} else {
		output("You carefully make your way through the dark tunnel back to where you escaped the beast. Maybe she gave up her chase and you can leave through where you came from?");
	}
}

public function crtC4R2220RoomDesc():void {
	author("Quilen")
	if (flags["CRT_C4_CAMP_MADE"] == undefined) {
		if (pc.intelligence() >= 7) {
			output("It's getting pretty cramped in here. Behind you, the path is completely filled by Iumen while the huntresses ahead of you are hesitatant to move forward into the pitch black darkness. You remember that your codex has a pretty bright screen and use it to light the way. The huntresses appreciate it and regain some of their confidence.");
			flags["CRT_HUNTRESSES_MORALE"] += 1;
		} else {
			output("It's getting pretty cramped in here. Behind you, the path is completely filled by Iumen while the huntresses ahead of you are hesitatant to move forward into the pitch black darkness. Cerres ends up taking the lead, carefully feeling her way around using her sword's sheath as a cane.");
		}
	} else {
		output("Now that you have some more light and aren't under time pressure, you examine the tunnel a little more closely. It is made of the same white-grey stone as the cavern, but instead of being smoothly worn down by time it is full of jagged edges, as though large plates of rock were broken away with great force. Some rock splinters still lie on the ground, and you think you now know where the pile of stones back at the camp came from. Someone made this tunnel with primitive tools, though it's hard to tell if that was decades or weeks ago.");
	}
}

public function crtC4R2320RoomDesc():void {
	author("Quilen")
	if (flags["CRT_C4_CAMP_MADE"] == undefined) {
		if (pc.intelligence() >= 7) {
			output("Things are finally opening up here - your huntresses quickly circle around to the cart, grab their lanterns and start illuminating the surrounding area.\n\nTo the west is the tight passage you came from. To the east, the passage continues beyond the flickering light of the lanterns - there might be a way out there. To the south lies a somewhat larger cavern made of smooth stone. It's a dead end, but a decent enough place to rest for a bit and get your bearings. Cerres orders the huntresses to make camp. You'll have a a little while to tend to your needs and catch up with everyone before you have to find a way out.");
		} else {
			output("Things are finally opening up here - your huntresses feel their way back to the cart and after a bit of groping around they light their lanterns and things start to look a whole lot brighter - literally and figuratively.\n\nTo the west is the tight passage you came from. To the east, the passage continues beyond the flickering light of the lanterns - there might be a way out there. To the south lies a somewhat larger cavern made of smooth stone. It's a dead end, but a decent enough place to rest for a bit and get your bearings. Cerres orders the huntresses to make camp. You'll have a a little while to tend to your needs and catch up with everyone before you have to find a way out.");
		}
		crtC4MakeCamp()
	} else {
		output("The passage you came from continues here from west to east. To the south is the cavern where you made camp. The huntresses have placed their lanterns so that every inch of it is brightly lit.");
	}
}

public function crtC4R2520RoomDesc():void {
	author("Quilen")
	output("You shine a light into the cavern and see an exit on the other end, as well as a large pile of rocks near the entrance. There's a drop halfway through - nothing too big, but it will be hard to get the wagon down there and you don't even want to think about getting it back up.");
	if (pc.intelligence() >= 10) {
		output(" Still, the rocks imply that the passage was made from this side, so there should be some way out over there.");
	} else {
		output(" Still better than the mouth of a giant monster.");
	}
}

public function crtC4R2319RoomDesc():void {
	author("Quilen")
	output("The cavern is at its most spacious here, a good five meters across. Iumen has rolled up across its width, blocking most of it with his armor. Two huntresses look watchfully past him.");
	addButton(0, "Iumen", crtC4CampIumen, undefined, "Iumen", "Check up on the large ganrael.")
}

public function crtC4CampIumen():Boolean {
	clearMenu();
	clearOutput();
	author("Quilen")
	output("TODO");
	addButton(14, "Back", mainGameMenu);
	return true;
}

public function crtC4R2318RoomDesc():void {
	author("Quilen")
	output("TODO small campfire");
	addButton(0, "Campfire", crtC4CampFire, undefined, "Campfire", "Talk to the nyrea that have gathered around the campfire.")
}

public function crtC4CampFire():Boolean {
	clearMenu();
	clearOutput();
	author("Quilen")
	output("TODO");
	addButton(14, "Back", mainGameMenu);
	return true;
}


//----------------------------------------------------spaces-----------------------------------------------------

// Room template
/*
	rooms[""] = new RoomClass(this);
	rooms[""].roomName = "";
	rooms[""].description = "";
	rooms[""].runOnEnter = null;
	rooms[""].planet = "PLANET: MYRELLION";
	rooms[""].system = "SYSTEM: SINDATHU";
	rooms[""].northExit = "";
	rooms[""].eastExit = "";
	rooms[""].southExit = "";
	rooms[""].westExit = "";
	rooms[""].moveMinutes = 60;
	rooms[""].addFlag(GLOBAL.OUTDOOR);
	rooms[""].addFlag(GLOBAL.INDOOR);
	rooms[""].addFlag(GLOBAL.HAZARD);
	rooms[""].addFlag(GLOBAL.PUBLIC);
	rooms[""].addFlag(GLOBAL.CAVE);
	rooms[""].addFlag(GLOBAL.NPC);
	rooms[""].addFlag(GLOBAL.PLANE);
	rooms[""].addFlag(GLOBAL.OBJECTIVE);
	rooms[""].addFlag(GLOBAL.COMMERCE);
	rooms[""].addFlag(GLOBAL.LIFTDOWN);
	rooms[""].addFlag(GLOBAL.LIFTUP);
	rooms[""].addFlag(GLOBAL.MEDICAL);
	rooms[""].addFlag(GLOBAL.NOFAP);
	rooms[""].addFlag(GLOBAL.BED);
	rooms[""].addFlag(GLOBAL.SHIPHANGAR);
	rooms[""].addFlag(GLOBAL.TAXI);
	rooms[""].addFlag(GLOBAL.QUEST);
*/

public function crtInitRooms():void {

	//TODO: remove debug/dev room
	rooms["crtTestTele"] = new RoomClass(this);
	rooms["crtTestTele"].roomName = "Artifical\nEntrypoint";
	rooms["crtTestTele"].description = "This room isn't. It won't once all the other rooms will."
	rooms["crtTestTele"].runOnEnter = null;
	rooms["crtTestTele"].planet = "PLANET: MYRELLION";
	rooms["crtTestTele"].system = "SYSTEM: SINDATHU";
	rooms["crtTestTele"].northExit = "crtC4R2120";
	
	//--------Challenge 4 begins here--------
	
	rooms["crtC4R2020"] = new RoomClass(this);
	rooms["crtC4R2020"].roomName = "HORRIFYING\nMONSTER";
	rooms["crtC4R2020"].description = "";
	rooms["crtC4R2020"].runOnEnter = crtC4horrifyingMonster;
	rooms["crtC4R2020"].planet = "PLANET: MYRELLION";
	rooms["crtC4R2020"].system = "SYSTEM: SINDATHU";
	rooms["crtC4R2020"].northExit = "crtC4R2021";
	rooms["crtC4R2020"].southExit = "crtC4R2019";
	rooms["crtC4R2020"].eastExit = "crtC4R2120";
	rooms["crtC4R2020"].moveMinutes = 2;
	rooms["crtC4R2020"].addFlag(GLOBAL.INDOOR);
	rooms["crtC4R2020"].addFlag(GLOBAL.HAZARD);
	rooms["crtC4R2020"].addFlag(GLOBAL.CAVE);
	rooms["crtC4R2020"].addFlag(GLOBAL.QUEST);

	rooms["crtC4R2021"] = new RoomClass(this);
	rooms["crtC4R2021"].roomName = "MAIN\nROAD";
	rooms["crtC4R2021"].description = "A large, wide open passage.";
	rooms["crtC4R2021"].runOnEnter = null;
	rooms["crtC4R2021"].planet = "PLANET: MYRELLION";
	rooms["crtC4R2021"].system = "SYSTEM: SINDATHU";
	rooms["crtC4R2021"].southExit = "crtC4R2020";
	rooms["crtC4R2021"].northExit = "crtC4R2022";
	rooms["crtC4R2021"].moveMinutes = 2;
	rooms["crtC4R2021"].addFlag(GLOBAL.INDOOR);
	rooms["crtC4R2021"].addFlag(GLOBAL.HAZARD);
	rooms["crtC4R2021"].addFlag(GLOBAL.CAVE);
	
	rooms["crtC4R2022"] = new RoomClass(this);
	rooms["crtC4R2022"].roomName = "MAIN\nROAD";
	rooms["crtC4R2022"].description = "A large, wide open passage.";
	rooms["crtC4R2022"].runOnEnter = null;
	rooms["crtC4R2022"].planet = "PLANET: MYRELLION";
	rooms["crtC4R2022"].system = "SYSTEM: SINDATHU";
	rooms["crtC4R2022"].southExit = "crtC4R2021";
	rooms["crtC4R2022"].northExit = "crtC4R2023";
	rooms["crtC4R2022"].moveMinutes = 2;
	rooms["crtC4R2022"].addFlag(GLOBAL.INDOOR);
	rooms["crtC4R2022"].addFlag(GLOBAL.HAZARD);
	rooms["crtC4R2022"].addFlag(GLOBAL.CAVE);
	
	rooms["crtC4R2023"] = new RoomClass(this);
	rooms["crtC4R2023"].roomName = "MAIN\nROAD";
	rooms["crtC4R2023"].description = "A large, wide open passage.";
	rooms["crtC4R2023"].runOnEnter = null;
	rooms["crtC4R2023"].planet = "PLANET: MYRELLION";
	rooms["crtC4R2023"].system = "SYSTEM: SINDATHU";
	rooms["crtC4R2023"].southExit = "crtC4R2022";
	rooms["crtC4R2023"].moveMinutes = 2;
	rooms["crtC4R2023"].addFlag(GLOBAL.INDOOR);
	rooms["crtC4R2023"].addFlag(GLOBAL.HAZARD);
	rooms["crtC4R2023"].addFlag(GLOBAL.CAVE);
	
	rooms["crtC4R2019"] = new RoomClass(this);
	rooms["crtC4R2019"].roomName = "MAIN\nROAD";
	rooms["crtC4R2019"].description = "A large, wide open passage.";
	rooms["crtC4R2019"].runOnEnter = null;
	rooms["crtC4R2019"].planet = "PLANET: MYRELLION";
	rooms["crtC4R2019"].system = "SYSTEM: SINDATHU";
	rooms["crtC4R2019"].northExit = "crtC4R2020";
	rooms["crtC4R2019"].southExit = "crtC4R2018";
	rooms["crtC4R2019"].moveMinutes = 2;
	rooms["crtC4R2019"].addFlag(GLOBAL.INDOOR);
	rooms["crtC4R2019"].addFlag(GLOBAL.HAZARD);
	rooms["crtC4R2019"].addFlag(GLOBAL.CAVE);
	
	rooms["crtC4R2018"] = new RoomClass(this);
	rooms["crtC4R2018"].roomName = "MAIN\nROAD";
	rooms["crtC4R2018"].description = "A large, wide open passage.";
	rooms["crtC4R2018"].runOnEnter = null;
	rooms["crtC4R2018"].planet = "PLANET: MYRELLION";
	rooms["crtC4R2018"].system = "SYSTEM: SINDATHU";
	rooms["crtC4R2018"].northExit = "crtC4R2019";
	rooms["crtC4R2018"].southExit = "crtC4R2017";
	rooms["crtC4R2018"].moveMinutes = 2;
	rooms["crtC4R2018"].addFlag(GLOBAL.INDOOR);
	rooms["crtC4R2018"].addFlag(GLOBAL.HAZARD);
	rooms["crtC4R2018"].addFlag(GLOBAL.CAVE);
	
	rooms["crtC4R2017"] = new RoomClass(this);
	rooms["crtC4R2017"].roomName = "MAIN\nROAD";
	rooms["crtC4R2017"].description = "A large, wide open passage.";
	rooms["crtC4R2017"].runOnEnter = null;
	rooms["crtC4R2017"].planet = "PLANET: MYRELLION";
	rooms["crtC4R2017"].system = "SYSTEM: SINDATHU";
	rooms["crtC4R2017"].northExit = "crtC4R2018";
	rooms["crtC4R2017"].moveMinutes = 2;
	rooms["crtC4R2017"].addFlag(GLOBAL.INDOOR);
	rooms["crtC4R2017"].addFlag(GLOBAL.HAZARD);
	rooms["crtC4R2017"].addFlag(GLOBAL.CAVE);
	
	rooms["crtC4R2120"] = new RoomClass(this);
	rooms["crtC4R2120"].roomName = "CAVE\nMOUTH";
	rooms["crtC4R2120"].description = "";
	rooms["crtC4R2120"].runOnEnter = crtC4R2120RoomDesc;
	rooms["crtC4R2120"].planet = "PLANET: MYRELLION";
	rooms["crtC4R2120"].system = "SYSTEM: SINDATHU";
	rooms["crtC4R2120"].westExit = "crtC4R2020";
	rooms["crtC4R2120"].eastExit = "crtC4R2220";
	rooms["crtC4R2120"].moveMinutes = 2;
	rooms["crtC4R2120"].addFlag(GLOBAL.INDOOR);
	rooms["crtC4R2120"].addFlag(GLOBAL.CAVE);
	
	rooms["crtC4R2220"] = new RoomClass(this);
	rooms["crtC4R2220"].roomName = "NARROW\nPASSAGE";
	rooms["crtC4R2220"].description = "";
	rooms["crtC4R2220"].runOnEnter = crtC4R2220RoomDesc;
	rooms["crtC4R2220"].planet = "PLANET: MYRELLION";
	rooms["crtC4R2220"].system = "SYSTEM: SINDATHU";
	rooms["crtC4R2220"].westExit = "crtC4R2120";
	rooms["crtC4R2220"].eastExit = "crtC4R2320";
	rooms["crtC4R2220"].moveMinutes = 2;
	rooms["crtC4R2220"].addFlag(GLOBAL.INDOOR);
	rooms["crtC4R2220"].addFlag(GLOBAL.CAVE);
	
	rooms["crtC4R2320"] = new RoomClass(this);
	rooms["crtC4R2320"].roomName = "\nCROSSROADS";
	rooms["crtC4R2320"].description = "";
	rooms["crtC4R2320"].runOnEnter = crtC4R2320RoomDesc;
	rooms["crtC4R2320"].planet = "PLANET: MYRELLION";
	rooms["crtC4R2320"].system = "SYSTEM: SINDATHU";
	rooms["crtC4R2320"].westExit = "crtC4R2220";
	rooms["crtC4R2320"].eastExit = "crtC4R2420";
	rooms["crtC4R2320"].southExit = "crtC4R2319";
	rooms["crtC4R2320"].moveMinutes = 2;
	rooms["crtC4R2320"].addFlag(GLOBAL.INDOOR);
	rooms["crtC4R2320"].addFlag(GLOBAL.CAVE);
	
	rooms["crtC4R2420"] = new RoomClass(this);
	rooms["crtC4R2420"].roomName = "JAGGED\nPASSAGE";
	rooms["crtC4R2420"].description = "The roughly hewn passage continues to the east until it opens up into another cavern. This place must look like swiss cheese...";
	rooms["crtC4R2420"].runOnEnter = null;
	rooms["crtC4R2420"].planet = "PLANET: MYRELLION";
	rooms["crtC4R2420"].system = "SYSTEM: SINDATHU";
	rooms["crtC4R2420"].westExit = "crtC4R2320";
	rooms["crtC4R2420"].eastExit = "crtC4R2520";
	rooms["crtC4R2420"].moveMinutes = 2;
	rooms["crtC4R2420"].addFlag(GLOBAL.INDOOR);
	rooms["crtC4R2420"].addFlag(GLOBAL.CAVE);
	
	rooms["crtC4R2520"] = new RoomClass(this);
	rooms["crtC4R2520"].roomName = "NATURAL\nCAVERN";
	rooms["crtC4R2520"].description = "";
	rooms["crtC4R2520"].runOnEnter = crtC4R2520RoomDesc;
	rooms["crtC4R2520"].planet = "PLANET: MYRELLION";
	rooms["crtC4R2520"].system = "SYSTEM: SINDATHU";
	rooms["crtC4R2520"].westExit = "crtC4R2420";
	//rooms["crtC4R2520"].eastExit = "crtC4R2620";
	rooms["crtC4R2520"].moveMinutes = 2;
	rooms["crtC4R2520"].addFlag(GLOBAL.INDOOR);
	rooms["crtC4R2520"].addFlag(GLOBAL.CAVE);
	rooms["crtC4R2520"].addFlag(GLOBAL.HAZARD);
	rooms["crtC4R2520"].addFlag(GLOBAL.OBJECTIVE);
	
	rooms["crtC4R2319"] = new RoomClass(this);
	rooms["crtC4R2319"].roomName = "CAVERN\nNORTH";
	rooms["crtC4R2319"].description = "";
	rooms["crtC4R2319"].runOnEnter = crtC4R2319RoomDesc;
	rooms["crtC4R2319"].planet = "PLANET: MYRELLION";
	rooms["crtC4R2319"].system = "SYSTEM: SINDATHU";
	rooms["crtC4R2319"].northExit = "crtC4R2320";
	rooms["crtC4R2319"].southExit = "crtC4R2318";
	rooms["crtC4R2319"].moveMinutes = 2;
	rooms["crtC4R2319"].addFlag(GLOBAL.INDOOR);
	rooms["crtC4R2319"].addFlag(GLOBAL.CAVE);
	
	rooms["crtC4R2318"] = new RoomClass(this);
	rooms["crtC4R2318"].roomName = "CAVERN\nSOUTH";
	rooms["crtC4R2318"].description = "";
	rooms["crtC4R2318"].runOnEnter = crtC4R2318RoomDesc;
	rooms["crtC4R2318"].planet = "PLANET: MYRELLION";
	rooms["crtC4R2318"].system = "SYSTEM: SINDATHU";
	rooms["crtC4R2318"].northExit = "crtC4R2319";
	rooms["crtC4R2318"].westExit = "crtC4R2218";
	rooms["crtC4R2318"].moveMinutes = 2;
	rooms["crtC4R2318"].addFlag(GLOBAL.INDOOR);
	rooms["crtC4R2318"].addFlag(GLOBAL.CAVE);
	
	rooms["crtC4R2218"] = new RoomClass(this);
	rooms["crtC4R2218"].roomName = "CAVERN\nEND";
	rooms["crtC4R2218"].description = "The cavern ends here. The stone is smooth and the cold air feels slightly moist - this cavern was probably washed out over centuries. The nyrea left some bedrolls here, though most of them are still sitting around the campfire, too full of adrenaline to sleep just yet.";
	rooms["crtC4R2218"].runOnEnter = null;
	rooms["crtC4R2218"].planet = "PLANET: MYRELLION";
	rooms["crtC4R2218"].system = "SYSTEM: SINDATHU";
	rooms["crtC4R2218"].eastExit = "crtC4R2318";
	rooms["crtC4R2218"].moveMinutes = 2;
	rooms["crtC4R2218"].addFlag(GLOBAL.INDOOR);
	rooms["crtC4R2218"].addFlag(GLOBAL.CAVE);
	rooms["crtC4R2218"].addFlag(GLOBAL.BED);
}



//----------------------------------------------------other------------------------------------------------------


