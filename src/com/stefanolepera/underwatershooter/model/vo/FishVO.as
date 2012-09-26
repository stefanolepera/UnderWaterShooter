package com.stefanolepera.underwatershooter.model.vo 
{
	/**
	 * FishVO Class
	 * A value object class to store the fish information
	 * 
	 * @author Stefano Le Pera
	 * @version 1.0 - 10/08/2012
	 */
	public class FishVO 
	{
		private var _id:int;
		private var _score:int;
		private var _speed:int;
		
		/**
		 * Constructor
		 */
		public function FishVO() 
		{
			// void
		}
		
		/////////////////////////////////////////////
		////////// GETTERS & SETTERS ///////////////
		///////////////////////////////////////////
		/**
		 * return the ID
		 */
		public function get id():int {
			return _id;
		}
		
		/**
		 * return the score
		 */
		public function get score():int {
			return _score;
		}
		
		/**
		 * return the speed
		 */
		public function get speed():int {
			return _speed;
		}
		
		/**
		 * set the speed
		 */
		public function set id(value:int):void {
			_id = value;
		}
		
		/**
		 * set the score
		 */
		public function set score(value:int):void {
			_score = value;
		}
		
		/**
		 * set the speed
		 */
		public function set speed(value:int):void {
			_speed = value;
		}
		
	}

}