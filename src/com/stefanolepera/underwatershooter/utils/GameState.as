package com.stefanolepera.underwatershooter.utils 
{
	/**
	 * GameState Class
	 * store the gameState constants
	 * 
	 * @author Stefano Le Pera
	 * @version 1.0 - 13/08/2012
	 */
	public class GameState 
	{
		private static const _IDLE:String = "idle";
		private static const _PLAY:String = "play";
		private static const _OVER:String = "over";
		
		public function GameState() 
		{
			throw new Error("GameState is a static container only");
		}
		
		/////////////////////////////////////////////
		////////// GETTERS & SETTERS ///////////////
		///////////////////////////////////////////
		static public function get IDLE():String {
			return _IDLE;
		}
		
		static public function get PLAY():String {
			return _PLAY;
		}
		
		static public function get OVER():String {
			return _OVER;
		}
		
	}

}