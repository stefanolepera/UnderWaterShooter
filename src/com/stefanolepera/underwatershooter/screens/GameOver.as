package com.stefanolepera.underwatershooter.screens 
{
	import com.greensock.TweenLite;
	import com.stefanolepera.underwatershooter.events.NavigationEvent;
	import com.stefanolepera.underwatershooter.services.FishProvider;
	import com.stefanolepera.underwatershooter.services.GameManager;
	import com.stefanolepera.underwatershooter.services.SoundManager;
	import com.stefanolepera.underwatershooter.view.FishItem;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	/**
	 * GameOver Class.
	 * This class represent the report screen that appears at the end of the game.
	 * 
	 * @author Stefano Le Pera
	 * @version 1.0 - 13/08/2012
	 */
	public class GameOver extends Sprite
	{
		private var bg:Image;
		private var diver:Image;
		private var playAgainBtn:Button;
		private var totalScoreText:TextField;
		private var totalFishCaughtText:TextField;
		private var fishItem:FishItem;
		private var fishItemContainer:Sprite;
		private var provider:FishProvider;
		
		private const DELTA_FISH:int = 80;
		
		/**
		 * Constructor
		 */
		public function GameOver() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * init method
		 * @param	e Event type
		 */
		private function init(e:Event):void
		{
			trace("gameover screen initialized");
			e.target.removeEventListener(e.type, arguments.callee);
			drawScreen();
		}
		
		/**
		 * create all images
		 */
		private function drawScreen():void
		{
			bg = new Image(Assets.getTexture("BgMenu"));
			addChild(bg);
			
			diver = new Image(Assets.getAtlas().getTexture("diver_menu"));
			diver.x = -diver.width;
			diver.y = (stage.stageHeight - diver.height) >> 1;
			addChild(diver);
			
			totalScoreText = new TextField(260, 50, "TOTAL SCORE: 0", "MyFont", 24, 0xFFFFFF);
			totalScoreText.x = (stage.stageWidth - totalScoreText.width) >> 1;
			totalScoreText.y = ((stage.stageHeight - totalScoreText.height) >> 1) - 100;
			addChild(totalScoreText);
			
			totalFishCaughtText = new TextField(260, 50, "FISH CAUGHT: 0", "MyFont", 24, 0xFFFFFF);
			totalFishCaughtText.x = (stage.stageWidth - totalFishCaughtText.width) >> 1;
			totalFishCaughtText.y = totalScoreText.y + totalScoreText.height;
			addChild(totalFishCaughtText);
			
			playAgainBtn = new Button(Assets.getAtlas().getTexture("playAgainButton"));
			playAgainBtn.x = (stage.stageWidth - playAgainBtn.width) >> 1;
			playAgainBtn.y = totalFishCaughtText.y + totalFishCaughtText.height + 10;
			addChild(playAgainBtn);
			
			addEventListener(Event.TRIGGERED, onPlayAgainClick);
		}
		
		/**
		 * create all fishItem object, add them to fishItemContainer
		 */
		private function drawFishReport():void
		{
			provider = GameManager.getInstance().fishProvider;
			fishItemContainer = new Sprite();
			addChild(fishItemContainer);
			
			var fishCaughtByType:Array = GameManager.getInstance().getFishCaughtByType().concat();
			for (var i:int = 0; i < provider.fishes.length; i++) {
				fishItem = new FishItem(provider.fishes[i].id);
				fishItemContainer.addChild(fishItem);
				
				fishItem.x = DELTA_FISH * i;
				fishItem.y = 0
				fishItem.setNumCaught(fishCaughtByType[i]);
			}
			
			fishItemContainer.x = (stage.stageWidth - fishItemContainer.width) >> 1;
			fishItemContainer.y = stage.stageHeight - fishItemContainer.height - 30;
			fishItemContainer.flatten();
		}
		
		/**
		 * destroy fishItemContainer and all its children
		 */
		private function disposeFishReport():void 
		{
			fishItemContainer.dispose();
			fishItemContainer = null;
		}
		
		/**
		 * play again the game and reset both GameManager and fishContainer
		 * @param	e Event type
		 */
		private function onPlayAgainClick(e:Event):void
		{
			var buttonClicked:Button = e.target as Button;
			
			if ((buttonClicked as Button) == playAgainBtn) {
				disposeFishReport();
				GameManager.getInstance().dispose();
				dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, "play", true));
			}
		}
		
		/**
		 * idle the screen
		 */
		public function idle():void
		{
			visible = false;
			
			if (hasEventListener(Event.ENTER_FRAME)) 
				removeEventListener(Event.ENTER_FRAME, diverAnimation);
		}
		
		/**
		 * tween the hero inside the screen, write the value inside textfields
		 */
		public function initialize():void
		{
			visible = true;
			
			totalScoreText.text = "TOTAL SCORE: " + GameManager.getInstance().score;
			totalFishCaughtText.text = "FISH CAUGHT: " + GameManager.getInstance().fishCaught.length;
			
			drawFishReport();
			
			diver.x = -diver.width;
			diver.y = (stage.stageHeight - diver.height) >> 1;
			
			TweenLite.to(diver, 2, { x: totalScoreText.x - 150 } );
			
			SoundManager.getInstance().play(SoundManager.SPLASH);
			
			addEventListener(Event.ENTER_FRAME, diverAnimation);
		}
		
		/**
		 * create the floating effect
		 * @param	e Event type
		 */
		private function diverAnimation(event:Event):void
		{
			var currentDate:Date = new Date();
			diver.y = ((stage.stageHeight - diver.height) >> 1) + (Math.cos(currentDate.getTime() * 0.002) * 25);
			playAgainBtn.y = (totalFishCaughtText.y + totalFishCaughtText.height + 10) + (Math.cos(currentDate.getTime() * 0.002) * 10);
		}
		
	}

}