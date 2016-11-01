/*
Idea: Dildo Panties. The kind where the dildos go into the wearer rather than their partner. That shouldn't conflict too badly with anything since you just remove them before sex, and if they are hardlight dildos on ultralastic panties all body and genital configurations can be supported.
Also: A dildo bra for those with cunt/lip nipples because that's a hot concept.


When the player puts them on they get a menu to decide if they want to activate the dildo(s) that looks like this:

[Dildo(s)] [No Dildos] [Repeat]

Repeat uses the last configuration, Dildo(s) allows the player to choose wich orifice(s) are penetrated, how big the dildos are and wether or not they vibrate. Probably via a menu for each appropriate orifice, like the DongDesigner. The per orifice menu could look like this:

[None] [Small] [Medium] [Large] [Huge]
[Still] [Vibrate] [Pulse] [Fuck]
[Back]


Choosing an option should come with an appropriate blurb.
-When it comes to sizes, it would be best to be somewhat vague and either only talk about how they make the character feel, or else compare them to the character's other bodyparts. That avoids awkwardness like a tiny character ending up with a dildo larger than their torso or a giant feeling oh so full from something that is no bigger than their pinky.
-Maybe check for orifice capacity/looseness, too, to make the blurbs more appropriate.
-Also: Disallow/limit nipple dildos for characters with tiny boobs. Wouldn't want them poking through their ribcage.
-The long description and dildo selection menu can have a mention that the dildos are remote controlled - I don't plan to do anything with that, but it would hypothetically allow someone to write a scene where an NPC controls the PC's dildos or the other way around. Plus the mere suggestion ought to be hot.
-The bra could have a breast/nipple massager/vibrator mode for those without penetrable nipples.


While running around, wearing the dildo panties triggers occasional messages about how you are getting aroused, how your orifices are being stretched, how hot it is to hide this secret from the people around you etc. (And wearing them should actually increase lust and orifice looseness.)
(Topping out lust while wearing them causes the pc to orgasm.)


Addendum: I would actually quite like to cater to the inflation fetish a little and add an option to let the butt-dildo pump some air into the character's ass whenever they take a step or over time. I don't think the current cumflation system would give appropriate sounding blurbs, though. Idk if the community would be into that - there is afaik nothing with that specific fetish in the game, but there is a fair bit of belly stuff in general...

Author: Quilen
*/

﻿package classes.Items.Apparel
{
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	
	public class DildoPanties extends ItemSlotClass
	{
		//constructor
		public function DildoPanties()
		{
			this._latestVersion = 1;

			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.LOWER_UNDERGARMENT;
			
			//Used on inventory buttons
			this.shortName = "DildoPanties";
			
			//Regular name
			this.longName = "dildo panties";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Long name
			this.description = "a set of black dildopanties";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "These seemingly unremarkable black panties house a naughty secret: Underneath the ultralastic fabric is an array of hardlight generators that can project customizable dildos right up the wearer's crotch. Stylish, subtle, sexy & Humphard approved. Download the app for the full range of customizations or hand the included remote to a friend for some fun amongst the unsuspecting public! Safety and guaranteed by Orisafe-Sizelimiters!";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "null";
			
			//Information
			this.basePrice = 2000;
			this.attack = 0;
			this.defense = 0;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 1;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;
			
			this.version = _latestVersion;
		}
	}
}
