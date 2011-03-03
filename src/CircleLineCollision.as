package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Zach
	 */
	public class CircleLineCollision extends Sprite
	{
		private var separationVector:Vector3D;
		private var line:Line;
		private var ball:Ball;
		
		public function CircleLineCollision() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			line = new Line(250, 150, 50, 175);
			ball = new Ball();
			addChild(line);
			addChild(ball);
			
			
			//create a vector3D object to use to separate overlapping objects;
			separationVector = new Vector3D(0, 0);
			
			// Add a listener to move one fo the balls.
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onMouseMove(e:MouseEvent):void 
		{
			// Find closest Point On Line
			var mousePosition:Vector3D = new Vector3D(stage.mouseX, stage.mouseY);
			var lineVector:Vector3D = line.start.subtract(line.end);
			var mouseVector:Vector3D = mousePosition.subtract(line.start);
			var scaleFactor:Number = lineVector.dotProduct(mouseVector) / lineVector.lengthSquared;
			scaleFactor = Math.min(0, Math.max(scaleFactor, -1));
			lineVector.scaleBy(scaleFactor);
			var closestPoint:Vector3D = line.start.clone().add(lineVector);
			// Draw Closest point on line
			this.graphics.clear();
			this.graphics.beginFill(0xFF0000, 1);
			this.graphics.drawCircle(closestPoint.x, closestPoint.y, 2);
			this.graphics.endFill();
			
		}
	}

}