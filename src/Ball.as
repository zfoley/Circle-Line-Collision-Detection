package  
{
	import flash.display.Shape;
	import flash.geom.Vector3D;
	/**
	 * The Ball class creates a randomly colored circle of a specified radius.
	 * @author Zach
	 */
	public class Ball extends Shape
	{
		private var color:uint;
		private var _radius:Number;
		private var _position:Vector3D = new Vector3D();
		public function Ball(radius:Number = 20) 
		{
			color = Math.random() * 0xFFFFFF;
			this.radius = radius;
		}
		
		public function get radius():Number { return _radius; }
		
		public function set radius(value:Number):void 
		{
			_radius = value;
			this.graphics.beginFill(color, 1);
			this.graphics.drawCircle(0, 0, _radius);

		}
		
		public function get position():Vector3D { return _position; }
		
		public function set position(value:Vector3D):void 
		{
			_position = value;
		}
		
	}

}