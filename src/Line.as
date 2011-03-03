package  
{
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Zach
	 */
	public class Line extends Shape
	{
		private var _start:Vector3D = new Vector3D();
		private var _end:Vector3D = new Vector3D();
		private var _lineWidth:Number;
		private var _lineColor:int;
		public function Line(fromX:Number = 0, fromY:Number = 0, toX:Number = 0, toY:Number = 0) 
		{
			_lineColor = Math.random()*0xFFFFFF;
			_lineWidth = 1;
			fromTo(new Point(fromX, fromY), new Point(toX, toY));
		}
		public function fromTo(start:Point, end:Point):void {
			_start.x = start.x;
			_start.y = start.y;
			_end.x = end.x;
			_end.y = end.y;
			draw();
		}
		
		private function draw():void
		{
			this.graphics.clear();
			this.graphics.lineStyle(_lineWidth, _lineColor);
			this.graphics.moveTo(_start.x, _start.y);
			this.graphics.lineTo(_end.x, _end.y);
		}
		
		public function get lineWidth():Number { return _lineWidth; }
		
		public function set lineWidth(value:Number):void 
		{
			_lineWidth = value;
			draw();
		}
		
		public function get lineColor():int { return _lineColor; }
		
		public function set lineColor(value:int):void 
		{
			_lineColor = value;
			draw();
		}
		
		public function get start():Vector3D { return _start; }
		
		public function get end():Vector3D { return _end; }
	}

}