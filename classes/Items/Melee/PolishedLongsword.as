package classes.Items.Melee 
{
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	
	public class NyreanSpear extends ItemSlotClass
	{	
		public function PolishedLongsword() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.MELEE_WEAPON;
			
			this.shortName = "Longsword";
			this.longName = "polished longsword";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			this.description = "a polished hand and a half sword";
			
			this.tooltip = "A polished hand and a half sword, queensguard Cerres' signature weapon.\n\nIt's just over a meter long, has a diamond shaped cross-section and weighs little enough that a strong person can wield it in one hand, though most would find it more comfortable as a two handed wepon. This particular one has been well taken care of, it's surfaces silvery and polished and it's edge sharp enough to cut you if you so much as think about it.";
			this.attackVerb = "slash";
			attackNoun = "slash";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.basePrice = 650;
			this.attack = 2;
			this.critBonus = 2;
			baseDamage.kinetic.damageValue = 13.0;
			baseDamage.addFlag(DamageFlag.PENETRATING);
			
			this.version = _latestVersion;	
		}	
	}
}
