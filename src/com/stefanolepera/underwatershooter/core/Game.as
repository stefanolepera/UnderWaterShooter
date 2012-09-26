package com.stefanolepera.underwatershooter.core 
{
	import com.stefanolepera.underwatershooter.events.NavigationEvent;
	import com.stefanolepera.underwatershooter.screens.GameOver;
	import com.stefanolepera.underwatershooter.screens.InGame;
	import com.stefanolepera.underwatershooter.screens.Menu;
	import fr.kouma.starling.utils.Stats;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * Game Class
	 * This class initialize all the game's screens and manage the game state
	 * 
	 * @author Stefano Le Pera
	 * @version 1.0 - 08/08/2012
	 */
	public class Game extends Sprite
	{
		private var screenMenu:Menu;
		private var screenInGame:InGame;
		private var screenGameOver:GameOver;
		
		/**
		 * Constructor
		 */
		public function Game() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * init method, initialize all the screens
		 * @param	e Event type
		 */
		private function init(e:Event):void
		{
			trace("starling framework initialized!");
			
			e.target.removeEventListener(e.type, arguments.callee);
			addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);
			
			screenInGame = new InGame();
			screenInGame.idle();
			addChild(screenInGame);
			
			screenMenu = new Menu();
			addChild(screenMenu);
			screenMenu.initialize();
			
			screenGameOver = new GameOver();
			screenGameOver.idle();
			addChild(screenGameOver);
			
			// comment to hide the stats panel
			addChild(new Stats());
		}
		
		/**
		 * change the game state
		 * @param	e NavigationEvent type
		 */
		private function onChangeScreen(e:NavigationEvent):void
		{
			switch (e.screen)
			{
				case "play":
					screenMenu.idle();
					screenGameOver.idle();
					screenInGame.initialize();
					break;
					
				case "over":
					screenInGame.idle();
					screenGameOver.initialize();
					break;
			}
		}
		
	}

}