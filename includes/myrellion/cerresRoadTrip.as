import classes.Characters.PlayerCharacter;
import classes.RoomClass;

/*----------------------------------------------------outline----------------------------------------------------
Two weeks after becoming nyrea royal, the player encounters a bunch of activity while collecting their spoils - Queensguard Cerres is preparing a punitive expedition against another tribe that kidnapped some of their males.
The player comes along for a ~2 weeks odyssey to get them back, potentially getting to know Cerres and some of the nyrea better in the process.
They will face seven challenges on the way there, one big challenge to rescue the kidnapped males, and a few more challenges as they make their way back, pursued by the hostile tribe.

Companions:
	-Queensguard Cerres (super loyal, very formal until she knows you better)
	-A massive ganrael that draws the supply wagon (smarter then they let on)
		(can get hurt if something goes wrong)
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

	output("<i>“Ready to go on an adventure?”</i>");
	
	clearMenu();
	addButton(0,"Yes",crtLeaveTown,undefined,"Go on adventure","Yes, you are ready to go on an adventure. It might take a while until you can come back.");
	addButton(1,"No",mainGameMenu,undefined,"Stay here","No, you have better things to do..");
}


public function crtLeaveTown():void {
	clearOutput();
	crtInitFlags();
	output("Descrition of how your journey starts.");
	//TODO
	currentLocation = "crt000";
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}


//--------Challenge 4 begins here--------

public function crtC4fleeTimeStamp():void {
	if (flags["CRT_C4_FLEE_TIMESTAMP"] == undefined) flags["CRT_C4_FLEE_TIMESTAMP"] = GetGameTimestamp();
}

public function crtC4horrifyingMonster():void {
	clearMenu();
	if ( (GetGameTimestamp() - flags["CRT_C4_FLEE_TIMESTAMP"]) <= (8 * 60) ) {
		output("The terrifying monstrositly still looks pissed from your last encounter. She paces up and down next to the diminutive passage you escaped through, her footfalls massive and forceful as thunder.\n\nIt's probably better not to go out yet, lest you end up a ");
		if (pc.armor.defense >= 3) output("crunchy ");
		output("snack for this beast.");
	} else {
		output("You slowly and carefully peek your head out to see if the beast has left in the meantime.\n\nAt first you don't see anything, but upon a closer look you spot the malicious, vengeful glimmer of her eyes in the distance, half hidden behind a bunch of rocks. From afar, the creature is easy to mistake for lifeless scenery - no wonder you ended up in your current predicament...\n\nEither way, it doesn't look like this tenacious terror is going to get tired of hunting you any time soon. You'd better find another way out of here.");
	}
	
	addButton(0, "Go Back", crtC4horrifyingMonsterGoBack);
}

public function crtC4horrifyingMonsterGoBack():void {
	currentLocation = "crtC4R2120";
	mainGameMenu();
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
*/

public function crtInitRooms():void {

	//TODO: remove this
	rooms["crtTestTele"] = new RoomClass(this);
	rooms["crtTestTele"].roomName = "crtPlaceName";
	rooms["crtTestTele"].description = "crtPlaceDesc";
	rooms["crtTestTele"].runOnEnter = null;
	rooms["crtTestTele"].planet = "PLANET: MYRELLION";
	rooms["crtTestTele"].system = "SYSTEM: SINDATHU";
	rooms["crtTestTele"].westExit = "crtC4R2020";

	rooms["crt000"] = new RoomClass(this);
	rooms["crt000"].roomName = "crtPlaceName";
	rooms["crt000"].description = "crtPlaceDesc";
	rooms["crt000"].runOnEnter = null;
	rooms["crt000"].planet = "PLANET: MYRELLION";
	rooms["crt000"].system = "SYSTEM: SINDATHU";
	rooms["crt000"].southExit = "crtTestTele";
	rooms["crt000"].moveMinutes = 60;
	rooms["crt000"].addFlag(GLOBAL.INDOOR);
	rooms["crt000"].addFlag(GLOBAL.HAZARD);
	rooms["crt000"].addFlag(GLOBAL.PUBLIC);
	rooms["crt000"].addFlag(GLOBAL.CAVE);
	
	//--------Challenge 4 begins here--------
	
	rooms["crtC4R2020"] = new RoomClass(this);
	rooms["crtC4R2020"].roomName = "Horrifying\nMonster";
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
	rooms["crtC4R2020"].addFlag(GLOBAL.PUBLIC);
	rooms["crtC4R2020"].addFlag(GLOBAL.CAVE);
	rooms["crtC4R2020"].addFlag(GLOBAL.OBJECTIVE);

	rooms["crtC4R2021"] = new RoomClass(this);
	rooms["crtC4R2021"].roomName = "Passage";
	rooms["crtC4R2021"].description = "A large, wide open passage.";
	rooms["crtC4R2021"].runOnEnter = null;
	rooms["crtC4R2021"].planet = "PLANET: MYRELLION";
	rooms["crtC4R2021"].system = "SYSTEM: SINDATHU";
	rooms["crtC4R2021"].southExit = "crtC4R2020";
	rooms["crtC4R2021"].northExit = "crtC4R2022";
	rooms["crtC4R2021"].moveMinutes = 2;
	rooms["crtC4R2021"].addFlag(GLOBAL.INDOOR);
	rooms["crtC4R2021"].addFlag(GLOBAL.HAZARD);
	rooms["crtC4R2021"].addFlag(GLOBAL.PUBLIC);
	rooms["crtC4R2021"].addFlag(GLOBAL.CAVE);
	
	rooms["crtC4R2022"] = new RoomClass(this);
	rooms["crtC4R2022"].roomName = "Passage";
	rooms["crtC4R2022"].description = "A large, wide open passage.";
	rooms["crtC4R2022"].runOnEnter = null;
	rooms["crtC4R2022"].planet = "PLANET: MYRELLION";
	rooms["crtC4R2022"].system = "SYSTEM: SINDATHU";
	rooms["crtC4R2022"].southExit = "crtC4R2021";
	rooms["crtC4R2022"].moveMinutes = 2;
	rooms["crtC4R2022"].addFlag(GLOBAL.INDOOR);
	rooms["crtC4R2022"].addFlag(GLOBAL.HAZARD);
	rooms["crtC4R2022"].addFlag(GLOBAL.PUBLIC);
	rooms["crtC4R2022"].addFlag(GLOBAL.CAVE);
	
	rooms["crtC4R2019"] = new RoomClass(this);
	rooms["crtC4R2019"].roomName = "Passage";
	rooms["crtC4R2019"].description = "A large, wide open passage.";
	rooms["crtC4R2019"].runOnEnter = null;
	rooms["crtC4R2019"].planet = "PLANET: MYRELLION";
	rooms["crtC4R2019"].system = "SYSTEM: SINDATHU";
	rooms["crtC4R2019"].northExit = "crtC4R2020";
	rooms["crtC4R2019"].southExit = "crtC4R2018";
	rooms["crtC4R2019"].moveMinutes = 2;
	rooms["crtC4R2019"].addFlag(GLOBAL.INDOOR);
	rooms["crtC4R2019"].addFlag(GLOBAL.HAZARD);
	rooms["crtC4R2019"].addFlag(GLOBAL.PUBLIC);
	rooms["crtC4R2019"].addFlag(GLOBAL.CAVE);
	
	rooms["crtC4R2018"] = new RoomClass(this);
	rooms["crtC4R2018"].roomName = "Passage";
	rooms["crtC4R2018"].description = "A large, wide open passage.";
	rooms["crtC4R2018"].runOnEnter = null;
	rooms["crtC4R2018"].planet = "PLANET: MYRELLION";
	rooms["crtC4R2018"].system = "SYSTEM: SINDATHU";
	rooms["crtC4R2018"].northExit = "crtC4R2019";
	rooms["crtC4R2018"].moveMinutes = 2;
	rooms["crtC4R2018"].addFlag(GLOBAL.INDOOR);
	rooms["crtC4R2018"].addFlag(GLOBAL.HAZARD);
	rooms["crtC4R2018"].addFlag(GLOBAL.PUBLIC);
	rooms["crtC4R2018"].addFlag(GLOBAL.CAVE);
	
	rooms["crtC4R2120"] = new RoomClass(this);
	rooms["crtC4R2120"].roomName = "Small Passage";
	rooms["crtC4R2120"].description = "You narrowly escaped the beast through this tiny passage. Well, relatively tiny, anyways - you still managed to fit you ganrael friend through it.";
	rooms["crtC4R2120"].runOnEnter = crtC4fleeTimeStamp;
	rooms["crtC4R2120"].planet = "PLANET: MYRELLION";
	rooms["crtC4R2120"].system = "SYSTEM: SINDATHU";
	rooms["crtC4R2120"].westExit = "crtC4R2020";
	rooms["crtC4R2120"].moveMinutes = 2;
	rooms["crtC4R2120"].addFlag(GLOBAL.INDOOR);
	rooms["crtC4R2120"].addFlag(GLOBAL.PUBLIC);
	rooms["crtC4R2120"].addFlag(GLOBAL.CAVE);
}



//----------------------------------------------------other------------------------------------------------------


