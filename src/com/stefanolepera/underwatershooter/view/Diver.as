package com.stefanolepera.underwatershooter.view 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * Diver Class
	 * this class represent the diver object
	 * 
	 * @author Stefano Le Pera
	 * @version 1.0 - 09/08/2012
	 */
	public class Diver extends Sprite
	{
		private var diverImage:Image;
		
		/**
		 * Constructor
		 */
		public function Diver() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * create and add hero image, then flatten the Sprite to improve the performance
		 * @param	e
		 */
		private function init(e:Event):void 
		{
			e.target.removeEventListener(e.type, arguments.callee);
			
			diverImage = new Image(Assets.getAtlas().getTexture("diver"));
			diverImage.x = Math.ceil(-diverImage.width / 2);
			diverImage.y = Math.ceil(-diverImage.height / 2);
			addChild(diverImage);
			
			this.flatten();
		}
		
	}

}