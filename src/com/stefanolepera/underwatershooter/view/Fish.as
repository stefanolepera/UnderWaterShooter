package com.stefanolepera.underwatershooter.view 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * Fish Class
	 * This class represent the fish object
	 * 
	 * @author Stefano Le Pera
	 * @version 1.0 - 10/08/2012
	 */
	public class Fish extends Sprite
	{
		protected var _id:int;
		protected var _fishImage:Image;
		
		private var _speed:int;
		private var _score:int;
		private var _alreadyHit:Boolean;
		
		/**
		 * Constructor
		 * @param	id int type
		 * @param	score int type
		 * @param	speed int type
		 */
		public function Fish(id:int, score:int = 0, speed:int = 0)
		{
			super();
			
			_id = id;
			_score = score;
			_speed = speed;
			
			_alreadyHit = false;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * call a method to create a fishImage and flatten the Sprite (to improve the performance)
		 * @param	e
		 */
		protected function init(e:Event):void
		{
			e.target.removeEventListener(e.type, arguments.callee);
			
			createFishImage();
			this.flatten();
		}
		
		/**
		 * create and add fish image
		 */
		protected function createFishImage():void 
		{
			_fishImage = new Image(Assets.getAtlas().getTexture("fish_" + _id));
			_fishImage.x = 0;
			_fishImage.y = 0;
			addChild(_fishImage);
		}
		
		/////////////////////////////////////////////
		////////// GETTERS & SETTERS ///////////////
		///////////////////////////////////////////
		public function get id():int {
			return _id;
		}
		
		public function get speed():int {
			return _speed;
		}
		
		public function set speed(value:int):void {
			_speed = value;
		}
		
		public function get score():int {
			return _score;
		}
		
		public function set score(value:int):void {
			_score = value;
		}
		
		public function get alreadyHit():Boolean {
			return _alreadyHit;
		}
		
		public function set alreadyHit(value:Boolean):void {
			_alreadyHit = value;
		}
		
		public function get fishImage():Image {
			return _fishImage;
		}
		
	}

}