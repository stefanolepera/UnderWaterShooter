package com.stefanolepera.underwatershooter.view 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * Bullet Class
	 * this class represent the bullet object
	 * 
	 * @author Stefano Le Pera
	 * @version 1.0 - 10/08/2012
	 */
	public class Bullet extends Sprite
	{
		private var bulletImage:Image;
		
		/**
		 * Constructor
		 */
		public function Bullet() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * create and add bullet image
		 * @param	e Event type
		 */
		private function init(e:Event):void 
		{
			e.target.removeEventListener(e.type, arguments.callee);
			
			bulletImage = new Image(Assets.getAtlas().getTexture("harpoon"));
			bulletImage.x = Math.ceil(-bulletImage.width / 2);
			bulletImage.y = Math.ceil(-bulletImage.height / 2);
			addChild(bulletImage);
			
			this.flatten();
		}
		
	}

}