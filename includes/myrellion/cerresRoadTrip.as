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
	2. Accidentally make camp in the mouth of a (sleeping) giant monster
		-avoid if aim and intelligence are high or player eyes are better than human (see teeth)
		-else notice breathing/snoring if intelligence decent or player's ears are better than human
			-sneak out of mouth
		-else discover when monster wakes up and tries to swallow the group
			-fight to hurt the monster enough that it spits you out while it chews you
			-if you fail the ganrael breaks through the monster's teeth and gets chewed on in the process
		-afterwards: angry monster chases you
	3. Get lost in the maze
		-giant monster from previous challenge chases you into small labyrinthine side tunnel
		-if low intelligence, maze is physically impossible/loops around on itself
		-ganrael can tunnel through some walls
		-minotaur-like creature hunts you (or maybe a dragon-person with a hoard)
			-attacks directly if someone get's seperated from the group, else stalks you audibly
		-challenge resolved when player finds the exit
	4. Cross a large underground river
		-Wings or jetpack: fly a rope across to make crossing possible for others
		-high aim and physique: tie a rope to spear, throw it across river, pass alon yourself and tie properly

Callenges there:


Challenges on the way back:



TODOS:
	-set flags["CRT_DONE"] when trip finished

*/



//----------------------------------------------------functions--------------------------------------------------

public function crtInitFlags():void
{
	flags["CRT_HUNTRESSES_NUMBER"] = 12;
	flags["CRT_HUNTRESSES_MORALE"] = 50;
	flags["CRT_GANRAEL_HEALTH"] = 2000;
}



//----------------------------------------------------dialog-----------------------------------------------------

public function crtStart():void
{
	if (flags["QUEENSGUARD_STAB_TIME"] == undefined || flags["QUEENSGUARD_STAB_TIME"] + (14 * 24 * 60) > GetGameTimestamp())
	{
		rooms["2I11"].removeFlag(GLOBAL.NPC);
		output("Several stone pillars line the passage on either side, clearly hand-carved and polished to a shine. Rather than glowing fungus coating the walls, several small clay sconces have been bolted onto the pillars, filled with colonies of the glowing fungus that sheds a soft, warm light across the tunnel. To the west, you can see what looks like a pair of heavy gates, flanked by a pair of large sconces filled with pulsing, glowing fungus.");
	}
	else
	{
		rooms["2I11"].addFlag(GLOBAL.NPC);
		output("You find the Queens Road less quiet than you are used to. Cerres, Taivra’s personal bodyguard, is standing amidst a flurry of activity - a dozen nyrea loading supplies onto a wagon the size of a hovertruck, huntresses sharpening their spears, arguing over routes and putting on armor. Cerres herself is directing several nervous looking males as they strap a humongous ganrael into a harness made of ropes thick enough to anchor a warship. The dark green ganrael has taken the shape of a massive caterpillar, all overlapping armorplates and legs as thick as tree trunks, dwarfing the surounding nyrea. When one of the males walks around its almost featureless front it grunts at her. She squeaks and jumps, holding her hands to her chest for a moment before continuing her tasks.\n\nAs soon as Cerres notices you, she takes a few steps towards you, bows, and says <i>“At your service, my liege.”</i>");
		variableRoomUpdateCheck();
		addButton(0, "Queensguard", crtPrep, undefined, "Approch Queensguard", "Ask what's going on here.");
	}
}

public function crtPrep():void
{
	clearOutput();
	showBust("QUEENSGUARD");
	showName("\nCERRES");
	author("Quilen")

	output("<i>“Ready to go on an adventure?”</i>");
	
	clearMenu();
	addButton(0,"Yes",crtLeaveTown,undefined,"Go on adventure","Yes, you are ready to go on an adventure. It might take a while until you can come back.");
	addButton(1,"No",mainGameMenu,undefined,"Stay here","No, you have better things to do..");
}


public function crtLeaveTown():void
{
	clearOutput();
	crtInitFlags();
	output("Descrition of how your journey starts.");
	//TODO
	currentLocation = "crt000";
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}



//----------------------------------------------------spaces-----------------------------------------------------

	// map
	/*




  crt011                        crt005c
     |                             |
  crt010 -- crt009              crt005b
               |                   |
    	    crt008              crt005a <-- red myr territory diplomatic
    	       |                   |
stealth --> crt007 -- crt006 -- crt005
    	                           |
    	                        crt004
    	                           |
    	                        crt003
    	                           |
    	                        crt002
    	                           |
    	                        crt001
    	                           |
    	                        crt000 <-- entry point

	*/

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
	
	public function crtInitRooms():void
	{
		rooms["crt000"] = new RoomClass(this);
		rooms["crt000"].roomName = "crtPlaceName";
		rooms["crt000"].description = "crtPlaceDesc";
		rooms["crt000"].runOnEnter = null;
		rooms["crt000"].planet = "PLANET: MYRELLION";
		rooms["crt000"].system = "SYSTEM: SINDATHU";
		rooms["crt000"].northExit = "crt001";
		rooms["crt000"].moveMinutes = 60;
		rooms["crt000"].addFlag(GLOBAL.INDOOR);
		rooms["crt000"].addFlag(GLOBAL.HAZARD);
		rooms["crt000"].addFlag(GLOBAL.PUBLIC);
		rooms["crt000"].addFlag(GLOBAL.CAVE);

		rooms["crt001"] = new RoomClass(this);
		rooms["crt001"].roomName = "crtPlaceName";
		rooms["crt001"].description = "crtPlaceDesc";
		rooms["crt001"].runOnEnter = null;
		rooms["crt001"].planet = "PLANET: MYRELLION";
		rooms["crt001"].system = "SYSTEM: SINDATHU";
		rooms["crt001"].northExit = "crt002";
		rooms["crt001"].southExit = "crt000";
		rooms["crt001"].moveMinutes = 60;
		rooms["crt001"].addFlag(GLOBAL.INDOOR);
		rooms["crt001"].addFlag(GLOBAL.HAZARD);
		rooms["crt001"].addFlag(GLOBAL.PUBLIC);
		rooms["crt001"].addFlag(GLOBAL.CAVE);
		
		rooms["crt002"] = new RoomClass(this);
		rooms["crt002"].roomName = "crtPlaceName";
		rooms["crt002"].description = "crtPlaceDesc";
		rooms["crt002"].runOnEnter = null;
		rooms["crt002"].planet = "PLANET: MYRELLION";
		rooms["crt002"].system = "SYSTEM: SINDATHU";
		rooms["crt002"].northExit = "crt003";
		rooms["crt002"].southExit = "crt001";
		rooms["crt002"].moveMinutes = 60;
		rooms["crt002"].addFlag(GLOBAL.INDOOR);
		rooms["crt002"].addFlag(GLOBAL.HAZARD);
		rooms["crt002"].addFlag(GLOBAL.PUBLIC);
		rooms["crt002"].addFlag(GLOBAL.CAVE);
		
		rooms["crt003"] = new RoomClass(this);
		rooms["crt003"].roomName = "crtPlaceName";
		rooms["crt003"].description = "crtPlaceDesc";
		rooms["crt003"].runOnEnter = null;
		rooms["crt003"].planet = "PLANET: MYRELLION";
		rooms["crt003"].system = "SYSTEM: SINDATHU";
		rooms["crt003"].northExit = "crt004";
		rooms["crt003"].southExit = "crt002";
		rooms["crt003"].moveMinutes = 60;
		rooms["crt003"].addFlag(GLOBAL.INDOOR);
		rooms["crt003"].addFlag(GLOBAL.HAZARD);
		rooms["crt003"].addFlag(GLOBAL.PUBLIC);
		rooms["crt003"].addFlag(GLOBAL.CAVE);
		
		rooms["crt004"] = new RoomClass(this);
		rooms["crt004"].roomName = "crtPlaceName";
		rooms["crt004"].description = "crtPlaceDesc";
		rooms["crt004"].runOnEnter = null;
		rooms["crt004"].planet = "PLANET: MYRELLION";
		rooms["crt004"].system = "SYSTEM: SINDATHU";
		rooms["crt004"].northExit = "crt005";
		rooms["crt004"].southExit = "crt003";
		rooms["crt004"].moveMinutes = 60;
		rooms["crt004"].addFlag(GLOBAL.INDOOR);
		rooms["crt004"].addFlag(GLOBAL.HAZARD);
		rooms["crt004"].addFlag(GLOBAL.PUBLIC);
		rooms["crt004"].addFlag(GLOBAL.CAVE);
		
		rooms["crt005"] = new RoomClass(this);
		rooms["crt005"].roomName = "crtPlaceName";
		rooms["crt005"].description = "crtPlaceDesc";
		rooms["crt005"].runOnEnter = null;
		rooms["crt005"].planet = "PLANET: MYRELLION";
		rooms["crt005"].system = "SYSTEM: SINDATHU";
		rooms["crt005"].southExit = "crt004";
		//rooms["crt005"].westExit = "crt006";
		//rooms["crt005"].northExit = "crt005a";
		rooms["crt005"].moveMinutes = 60;
		rooms["crt005"].addFlag(GLOBAL.INDOOR);
		rooms["crt005"].addFlag(GLOBAL.HAZARD);
		rooms["crt005"].addFlag(GLOBAL.PUBLIC);
		rooms["crt005"].addFlag(GLOBAL.CAVE);
	}



//----------------------------------------------------other------------------------------------------------------


