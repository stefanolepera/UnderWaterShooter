package com.stefanolepera.underwatershooter.services 
{
	import com.stefanolepera.underwatershooter.model.vo.FishVO;
	/**
	 * FishProvider Class
	 * @author Stefano Le Pera
	 * @version 1.0 - 10/08/2012
	 */
	public class FishProvider 
	{
		private var _fishes:Vector.<FishVO>;
		
		/**
		 * Constructor
		 * @param	data XML type
		 */
		public function FishProvider(data:XML) 
		{
			_fishes = new Vector.<FishVO>();
			
			parseData(data);
		}
		
		/**
		 * parse the XML and build the fishVO items
		 * @param	data XML type
		 */
		private function parseData(data:XML):void 
		{
			var list:XMLList = data.fish;
			
			for each (var item:XML in list) {
				var fishVO:FishVO = new FishVO();
				fishVO.id = int(item.@id);
				fishVO.score = int(item.@score);
				fishVO.speed = int(item.@speed);
				
				_fishes.push(fishVO);
			}
		}
		
		/**
		 * return a FishVO item by its ID
		 * @param	id int type
		 * @return FishVO type
		 */
		public function getFishByID(id:int):FishVO 
		{
			for (var i:int = 0; i < _fishes.length; i++ ) {
				if (id == _fishes[i].id) 
					return _fishes[i];
			}
			
			return null;
		}
		
		/**
		 * return the lenght of array (the amount of unique fish)
		 * @return int type
		 */
		public function getTotalFishes():int {
			return _fishes.length;
		}
		
		/**
		 * return the FishVO Vector
		 */
		public function get fishes():Vector.<FishVO> {
			return _fishes;
		}
		
	}

}