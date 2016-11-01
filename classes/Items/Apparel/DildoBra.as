/*
see DildoPanties
Author: Quilen
*/

﻿package classes.Items.Apparel
{
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;

	public class DildoBra extends ItemSlotClass
	{

		//constructor
		public function DildoBra()
		{
			this._latestVersion = 1;

			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.UPPER_UNDERGARMENT;
			
			//Used on inventory buttons
			this.shortName = "DildoBra";
			
			//Regular name
			this.longName = "dildo bra";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Long name
			this.description = "a black dildobra";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "This black, ultralastic bra is usually sold as an acessory for the Humphard hardlight-dildopanties. Like them, the cups of this bra include hardlight generators that can project dildos into the penetrable nipples of those fortunate enough to have them, though there is also a breast massage and nipple-vibrator mode. Pairs with the same app as the panties, spare remote included.";
			
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
