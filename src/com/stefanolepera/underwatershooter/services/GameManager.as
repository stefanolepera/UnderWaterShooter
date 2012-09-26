package com.stefanolepera.underwatershooter.services
{
	/**
	 * GameManager Class
	 * A singleton used to store and manage some game information
	 * 
	 * @author Stefano Le Pera
	 * @version 1.0 - 13/08/2012
	 */
	public class GameManager
	{
		private static var _instance:GameManager = null;
		private var _fishProvider:FishProvider;
		private var _fishCaught:Array = [];
		private var _score:int = 0;
		
		/**
		 * Constructor
		 */
		public function GameManager()
		{
			// void
		}
		
		/**
		 * return an instance of a Singleton
		 * @return GameManager type
		 */
		public static function getInstance():GameManager
		{
			if (!_instance)
				_instance = new GameManager();
				
			return _instance;
		}
		
		/**
		 * return the fishCaught Array
		 */
		public function get fishCaught():Array {
			return _fishCaught;
		}
		
		/**
		 * add a fish ID into the array, to track it
		 * @param	id int type
		 */
		public function addFish(id:int):void {
			_fishCaught.push(id);
		}
		
		/**
		 * return the game score
		 */
		public function get score():int {
			return _score;
		}
		
		/**
		 * set the game score
		 */
		public function set score(value:int):void {
			_score = value;
		}
		
		/**
		 * return the fishProvider
		 */
		public function get fishProvider():FishProvider {
			return _fishProvider;
		}
		
		/**
		 * set the fishProvider
		 */
		public function set fishProvider(value:FishProvider):void {
			_fishProvider = value;
		}
		
		/**
		 * match all the ids in the _fishCaught array, build a new array and return it
		 * @return Array type
		 */
		public function getFishCaughtByType():Array
		{
			var fishCaughtByType:Array = new Array();
			
			for (var j:int = 0; j < _fishProvider.getTotalFishes(); j++)
			{
				var idToMatch:int = _fishProvider.fishes[j].id;
				var idCounter:int = 0;
				
				for (var i:int = 0; i < _fishCaught.length; i++) {
					if (_fishCaught[i] == idToMatch)
						idCounter++;
				}
				
				fishCaughtByType.push(idCounter);
			}
			
			return fishCaughtByType;
		}
		
		/**
		 * reset the class values
		 */
		public function dispose():void
		{
			_fishCaught = new Array();
			_score = 0;
		}
		
	}

}