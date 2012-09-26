package com.stefanolepera.underwatershooter.events
{
	import starling.events.Event;
	
	/**
	 * Navigation Event Class
	 * A custom event to change the game state
	 * 
	 * @author Stefano Le Pera
	 * @version 1.0 - 08/08/2012
	 */
	public class NavigationEvent extends Event
	{
		public static const CHANGE_SCREEN:String = "changeScreen";
		public var screen:String;
		
		/**
		 * Constructor
		 * 
		 * @param	type String
		 * @param	screen String
		 * @param	bubbles Boolean
		 */
		public function NavigationEvent(type:String, screen:String = "", bubbles:Boolean = false)
		{
			super(type, bubbles);
			this.screen = screen;
		}
	}
}