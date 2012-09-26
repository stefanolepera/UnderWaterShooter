package com.stefanolepera.underwatershooter.view
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * GameBackground Class
	 * This class manage the layers movement
	 * 
	 * @author Stefano Le Pera
	 * @version 1.0 - 13/08/2012
	 */
	public class GameBackground extends Sprite
	{
		private var bgLayer1:BgLayer;
		private var bgLayer2:BgLayer;
		
		private var _speed:Number = 0;
		
		/**
		 * Constructor
		 */
		public function GameBackground()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * create the background layers
		 * @param	e Event type
		 */
		private function init(e:Event):void
		{
			e.target.removeEventListener(e.type, arguments.callee);
			
			bgLayer1 = new BgLayer(1);
			bgLayer1.parallax = 0.02;
			addChild(bgLayer1);
			
			bgLayer2 = new BgLayer(2);
			bgLayer2.parallax = 0.5;
			addChild(bgLayer2);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		/**
		 * move the layers at different speed to simulate parallax
		 * @param	e Event type
		 */
		private function onEnterFrame(e:Event):void
		{
			bgLayer1.x -= Math.ceil(_speed * bgLayer1.parallax);
			if (bgLayer1.x < -stage.stageWidth) 
				bgLayer1.x = 0;
			
			bgLayer2.x -= Math.ceil(_speed * bgLayer2.parallax);
			if (bgLayer2.x < -stage.stageWidth) 
				bgLayer2.x = 0;
		}
		
		/////////////////////////////////////////////
		////////// GETTERS & SETTERS ///////////////
		///////////////////////////////////////////
		public function get speed():Number {
			return _speed;
		}
		
		public function set speed(value:Number):void {
			_speed = value;
		}
		
	}
}