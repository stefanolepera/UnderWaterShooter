package com.stefanolepera.underwatershooter.screens
{	
	import com.greensock.TweenLite;
	import com.stefanolepera.underwatershooter.events.NavigationEvent;
	import com.stefanolepera.underwatershooter.services.SoundManager;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * Menu Class.
	 * This class represent the menu screen that appears at the beginning of the game.
	 * 
	 * @author Stefano Le Pera
	 * @version 1.0 - 08/08/2012
	 */
	public class Menu extends Sprite
	{
		private var bg:Image;
		private var logo:Image;
		private var diver:Image;
		private var playBtn:Button;
		
		/**
		 * Constructor
		 */
		public function Menu()
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
			trace("welcome screen initialized");
			e.target.removeEventListener(e.type, arguments.callee);
			
			SoundManager.getInstance().initialize();
			
			drawScreen();
		}
		
		/**
		 * create all images
		 */
		private function drawScreen():void
		{
			bg = new Image(Assets.getTexture("BgMenu"));
			addChild(bg);
			
			logo = new Image(Assets.getAtlas().getTexture("logo"));
			logo.x = (stage.stageWidth - logo.width) >> 1;
			logo.y = (stage.stageHeight - logo.height) >> 1;
			addChild(logo);
			
			playBtn = new Button(Assets.getAtlas().getTexture("playButton"));
			playBtn.x = (stage.stageWidth - playBtn.width) >> 1;
			playBtn.y = logo.y + logo.height + 10;
			addChild(playBtn);
			
			
			diver = new Image(Assets.getAtlas().getTexture("diver_menu"));
			diver.x = -diver.width;
			diver.y = (stage.stageHeight - diver.height) >> 1;
			addChild(diver);
			
			addEventListener(Event.TRIGGERED, onMainMenuClick);
		}
		
		/**
		 * play the game
		 * @param	e Event type
		 */
		private function onMainMenuClick(e:Event):void
		{
			var buttonClicked:Button = e.target as Button;
			
			if ((buttonClicked as Button) == playBtn)
				dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, "play", true));
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
		 * tween the hero inside the screen
		 */
		public function initialize():void
		{
			visible = true;
			
			diver.x = -diver.width;
			diver.y = (stage.stageHeight - diver.height) >> 1;
			
			TweenLite.to(diver, 2, { x: logo.x - 150 } );
			
			SoundManager.getInstance().play(SoundManager.SPLASH);
			
			addEventListener(Event.ENTER_FRAME, diverAnimation);
		}
		
		/**
		 * create the floating effect
		 * @param	e Event type
		 */
		private function diverAnimation(e:Event):void
		{
			var currentDate:Date = new Date();
			diver.y = ((stage.stageHeight - diver.height) >> 1) + (Math.cos(currentDate.getTime() * 0.002) * 25);
			playBtn.y = (logo.y + logo.height + 10) + (Math.cos(currentDate.getTime() * 0.002) * 10);
		}
	}
}