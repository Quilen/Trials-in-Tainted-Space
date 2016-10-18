package classes.Characters 
{
	import classes.CockClass;
	import classes.Creature;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Items.Melee.PolishedLongsword;
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.Items.Protection.DecentShield;
	import classes.Items.Armor.PolishedPlate;
	import classes.ItemSlotClass;
	import classes.kGAMECLASS;
	import classes.Util.RandomInCollection;
	
	import classes.GLOBAL;
	
	import classes.Engine.Combat.*;
	import classes.Engine.Combat.DamageTypes.*;
	import classes.Engine.Interfaces.output;
	import classes.GameData.CombatAttacks;
	import classes.GameData.CombatManager;
	
	import classes.Engine.Utility.weightedRand;
	import classes.StringUtil;
	
	public class crtCerres extends Creature
	{
		
		public function crtCerres() 
		{
			this._latestVersion = 1;
			this.version = this._latestVersion;
			this._neverSerialize = true; // Setting this will stop a given NPC class from ever being serialized.
			
			this.short = "Cerres";
			this.originalRace = "nyrea";
			this.a = "";
			this.capitalA = "";
			this.tallness = 72;
			this.scaleColor = "green";
			
			long = "Cerres, the queen's (and your) brave knight stands next to you, clad head to toe in polished steel and natural chitin. She readies her shield to protect you and her sword to strike down your enemies.";
			
			this.isPlural = false;
			
			this.meleeWeapon = new PolishedLongsword();
			this.meleeWeapon.hasRandomProperties = true;
			this.armor = new PolishedPlate();
						
			this.physiqueRaw = 30;
			this.reflexesRaw = 25;
			this.aimRaw = 10;
			this.intelligenceRaw = 15;
			this.willpowerRaw = 25;
			this.libidoRaw = 20;
			this.shieldsRaw = this.shieldsMax();
			this.energyRaw = 100;
			this.lustRaw = 10;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.kinetic.damageValue = 25.0;
			baseHPResistances.electric.damageValue = 25.0;
			baseHPResistances.burning.damageValue = 25.0;
			
			this.level = 8;
			this.XPRaw = normalXP();
			this.credits = 0;
			this.HPMod = 130;
			this.HPRaw = this.HPMax();
			
			this.femininity = 80;
			this.eyeType = 0;
			this.eyeColor = "black";
			this.thickness = 40;
			this.tone = 45;
			this.hairColor = "black";
			this.furColor = "tawny";
			this.hairLength = 3;
			this.hairType = GLOBAL.HAIR_TYPE_QUILLS;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_SCALES;
			this.skinTone = "pink";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_NYREA;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_NYREA;
			this.lipMod = 1;
			this.earType = GLOBAL.TYPE_NYREA;
			this.antennae = 0;
			this.antennaeType = 0;
			this.horns = 0;
			this.hornType = 0;
			this.armType = GLOBAL.TYPE_NYREA;
			this.gills = false;
			this.wingType = 0;
			this.legType = GLOBAL.TYPE_NYREA;
			this.legCount = 2;
			this.legFlags = [];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = 0;
			this.tailCount = 0;
			this.tailFlags = [];
			
			//Used to set cunt or dick type for cunt/dick tails!
			this.tailGenitalArg = 0;
			//tailGenital:
			//0 - none.
			//1 - cock
			//2 - vagina
			this.tailGenital = 0;
			//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
			this.tailVenom = 0;
			//Tail recharge determines how fast venom/webs comes back per hour.
			this.tailRecharge = 5;
			//hipRating
			//0 - boyish
			//2 - slender
			//4 - average
			//6 - noticable/ample
			//10 - curvy//flaring
			//15 - child-bearing/fertile
			//20 - inhumanly wide
			this.hipRatingRaw = 10;
			//buttRating
			//0 - buttless
			//2 - tight
			//4 - average
			//6 - noticable
			//8 - large
			//10 - jiggly
			//13 - expansive
			//16 - huge
			//20 - inconceivably large/big/huge etc
			this.buttRatingRaw = 10;
			//No dicks here!
			this.cocks = new Array();
			//balls
			this.balls = 0;
			this.cumMultiplierRaw = 1.5;
			//Multiplicative value used for impregnation odds. 0 is infertile. Higher is better.
			this.cumQualityRaw = 1;
			this.cumType = GLOBAL.FLUID_TYPE_CUM;
			this.ballSizeRaw = 2;
			this.ballFullness = 100;
			//How many "normal" orgams worth of jizz your balls can hold.
			this.ballEfficiency = 4;
			//Scales from 0 (never produce more) to infinity.
			this.refractoryRate = 9999;
			this.minutesSinceCum = 9000;
			this.timesCum = 122;
			this.cockVirgin = true;
			this.vaginalVirgin = false;
			this.analVirgin = true;
			//Goo is hyper friendly!
			this.elasticity = 3;
			//Fertility is a % out of 100. 
			this.fertilityRaw = 1;
			this.clitLength = .5;
			this.pregnancyMultiplierRaw = 1;
			
			this.breastRows[0].breastRatingRaw = 6;
			this.nippleColor = "green";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 1;
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 2;
			
			this.hairLength = 3;
			
			this.cocks = [];
			this.createVagina();
			this.vaginas[0].type = GLOBAL.TYPE_NYREA;
			this.vaginas[0].wetnessRaw = 2;
			this.vaginas[0].loosenessRaw = 3;
			this.vaginas[0].hymen = false;
			this.vaginalVirgin = false;
			this.analVirgin = true;
			createStatusEffect("Force Male Gender");
			//this.createStatusEffect("Force Fem Gender");
			//this.createStatusEffect("Flee Disabled",0,0,0,0,true,"","",false,0);
			
			isUniqueInFight = true;
			btnTargetText = "Queensguard";
			sexualPreferences.setRandomPrefs(8, 2);
			
			this._isLoading = false;
		}
		
		override public function get bustDisplay():String
		{
			return "QUEENSGUARD";
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			var player:Creature = selectPlayer(alliedCreatures);
			
			//TODO: more attacks!
			//ideas:
			//	give player a protective buff
			//	a boring single strike attack
			//	a stun attack (pommel strike, low accuracy?)
			//	if at half health: drink potion, drop shield, do halfswording?
			
			if (Math.random() < 0.5) crtSliceAndDice(target);
			else crtStrongAttack(target);
	
		}
		
		//this makes Cherres target injured glass cannons first.
		override protected function selectTarget(otherTeam:Array):Creature
		{
			var selTarget:Creature = null;
			var selTargetAttractiveness:Number = 0;
			
			for (var i:int = 0; i < otherTeam.length; i++)
			{	
				if (otherTeam[i].HP() > 0 && otherTeam[i].lust() < otherTeam[i].lustMax())
				{
					var curTargetAttractiveness:Number = 0;
					var curTargetMelee:Number = 0;
					var curTargetRanged:Number = 0;
					var curTargetHealth:Number = 10;
					
					try {curTargetMelee = otherTeam[i].meleeDamage().getTotal();} catch (error:Error) {}
					try {curTargetRanged = otherTeam[i].rangedDamage().getTotal();} catch (error:Error) {}
					try {curTargetHealth = otherTeam[i].HP();} catch (error:Error) {}
					curTargetAttractiveness = Math.max(curTargetMelee, curTargetRanged, 10) / curTargetHealth;
					
					if (curTargetAttractiveness > selTargetAttractiveness)
					{
						selTarget = otherTeam[i];
						selTargetAttractiveness = curTargetAttractiveness;
					}
				}
			}
			return selTarget;
		}
		
		private function selectPlayer(team:Array):Creature
		{
			var player:Creature = null;
			
			for (var i:int = 0; i < team.length; i++)
			{	
				if (team[i] is PlayerCharacter)
				{
					player = team[i];
				}
			}
			return player;
		}
		
		private function crtSliceAndDice(target:Creature):void
		{
			output("Cerres launches a flurry of quick attacks!\n");
			var hits:int = 0;
			var cerresHitChance:Number;
			if (!target.hasStatusEffect("Tripped")) cerresHitChance = 3; else cerresHitChance = 2;
			
			for (var i:int = 0; i <= 3; i++)
			{
				if(combatMiss(this, target, -1, cerresHitChance))
				{
					output("\nCerres misses " + target.getCombatName() + ".");
				}
				else
				{
					output("\nCerres " + crtRndAttkVerb() + " " + target.getCombatName() + ". ");
					applyDamage(damageRand(this.meleeDamage(), 10), this, target, "minimal");
					hits++;
				}
			}
			if (hits >= 4)
			{
				if(!target.hasStatusEffect("Tripped"))
				{
				output("\n\nShe lands every hit and finishes with a shield bash, knocking " + target.getCombatName() + " prone.");
				applyDamage(this.meleeDamage(), this, target, "minimal");
				target.createStatusEffect("Tripped", 0, 0, 0, 0, false, "DefenseDown", "You've been tripped, reducing your effective physique and reflexes by 4. You'll have to spend an action standing up.", true, 0);
				}
			}
			else if (hits <= 0)
			{
				output("\n\nShe looks slightly embarrassed at her complete failure to hurt the enemy.");
			}
		}
		
		private function crtRndAttkVerb():String
		{
			var verbs:Array = new Array("strikes", "slashes", "slices", "stabs", "kicks", "punches", "headbutts", "rams", "runs through");
			for each (var verb:String in verbs)
			{
				if (Math.random() < 0.2) return verb;
			}
			return "hits";
		}
		
		private function crtStrongAttack(target:Creature):void
		{
			output("Cerres winds up for a strong attack");
			var damage:TypeCollection;

			if (Math.random() < 0.5)
			{
				if(combatMiss(this, target))
				{
					output(" and brings her blade down where " + target.getCombatName() + " stood moments ago.");
				}
				else
				{
					output(" and brings her blade down on " + target.getCombatName() + " with bone-crushing force.");
					damage = damageRand(this.meleeDamage(), 10);
					damage.multiply(2.5);
					applyDamage(damage, this, target);
				}
			}
			else
			{
				if(combatMiss(this, target))
				{
					output(" and lunges at " + target.getCombatName() + ". " + StringUtil.capitalize(target.getCombatPronoun("heShe")) + " barely manages to dodge.");
				}
				else
				{
					output(" and lunges at " + target.getCombatName() + ". ");
					damage = damageRand(this.meleeDamage(), 10);
					damage.multiply(2.5);
					applyDamage(damage, this, target);
				}
			}
				
		}

	}

}
