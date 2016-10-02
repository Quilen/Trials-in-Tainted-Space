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
		-minotaur-like creature hunts you
			-attacks directly if someone get's seperated from the group, else stalks you audibly
		-challenge resolved when player finds the exit

Callenges there:


Challenges on the way back:


*/



//----------------------------------------------------functions--------------------------------------------------

public function crtInitFlags():void
{
	flags["CRT_HUNTRESSES_NUMBER"] = 12;
	flags["CRT_HUNTRESSES_MORALE"] = 50;
	flags["CRT_GANRAEL_HEALTH"] = 2000;
}



//----------------------------------------------------dialog-----------------------------------------------------

public function cerresRoadTripPrep():void
{
	clearOutput();
	showBust("QUEENSGUARD");
	showName("\nCERRES");
	author("Quilen")
	
	//----------------introduce roadtrip----------------
	if (flags["CRT_READY_FOR_ROADTRIP"] == undefined) {
		output("<i>“So, what's going on here?”</i>, you ask as a nyrea passes by with a crate full of dried mushrooms.");
		output("\n\nShe responds, <i>“I am mustering a punitive expedition against our enemies, my liege. Not long ago, a few of our citizens were kidnapped outside our gates. Thanks to huntress Quilena's initiative and skill, we now hold one of the kidnappers captive and discovered their origin through interrogation.”</i>");
		if(pc.isNice()) output("\nPc is nice.");
		//TODO
		clearMenu();
		addButton(0,"Come With",crtPrep1,undefined,"Come With","That sounds interesting. Ask to join her.");
		addButton(1,"Carry On",mainGameMenu,undefined,"Carry On","Tell her to carry on.");
	}
	else //----------------start roadtrip----------------
	{
		output("<i>“Are your preparations completed, " + pc.mf("king","queen") + " [pc.name]?”</i>");
		
		clearMenu();
		addButton(0,"Yes",crtStart,undefined,"Go on adventure","Yes, you are ready to go on an adventure. It might take a while until you can come back.");
		addButton(1,"No",mainGameMenu,undefined,"Stay here","No, you still have things to do here - you are sure Cerres will wait patiently for her liege if that is what you desire.");
	}
}

public function crtPrep1():void
{
	clearOutput();
	//TODO
	output("You ask to come along. Maybe have the option to explain your reasoning - want to see how your subjects do things, lust for adventure, etc. \n\nCerres tells you that it will take a little longer to get everything ready - they will leave once you are back.");
	flags["CRT_READY_FOR_ROADTRIP"] = 1;
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}

public function crtStart():void
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
		rooms["crt001"].moveMinutes = 60;
		rooms["crt001"].addFlag(GLOBAL.INDOOR);
		rooms["crt001"].addFlag(GLOBAL.HAZARD);
		rooms["crt001"].addFlag(GLOBAL.PUBLIC);
		rooms["crt001"].addFlag(GLOBAL.CAVE);
	}



//----------------------------------------------------other------------------------------------------------------


