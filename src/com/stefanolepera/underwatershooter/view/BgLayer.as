package com.stefanolepera.underwatershooter.view
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * BgLayer Class
	 * This class represent the layer object
	 * 
	 * @author Stefano Le Pera
	 * @version 1.0 - 10/08/2012
	 */
	public class BgLayer extends Sprite
	{
		private var image1:Image;
		private var image2:Image;
		
		private var _layer:int;
		private var _parallax:Number;
		
		/**
		 * Constructor
		 * @param	layer int type
		 */
		public function BgLayer(layer:int)
		{
			super();
			_layer = layer;
			addEventListener(starling.events.Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * create the 2 images to simulate a parallax effect
		 * @param	e Event type
		 */
		private function init(e:Event):void
		{
			e.target.removeEventListener(e.type, arguments.callee);
			
			if (_layer == 1) {
				image1 = new Image(Assets.getTexture("BgLayer_" + _layer));
				image2 = new Image(Assets.getTexture("BgLayer_" + _layer));
			}
			else {
				image1 = new Image(Assets.getAtlas().getTexture("bgLayer_" + _layer));
				image2 = new Image(Assets.getAtlas().getTexture("bgLayer_" + _layer));
			}
			
			image1.x = 0;
			image1.y = stage.stageHeight - image1.height;
			
			image2.x = image2.width;
			image2.y = image1.y;
			
			addChild(image1);
			addChild(image2);
		}
		
		/**
		 * get parallax value
		 */
		public function get parallax():Number {
			return _parallax;
		}
		
		/**
		 * set parallax value
		 */
		public function set parallax(value:Number):void {
			_parallax = value;
		}
	}
}