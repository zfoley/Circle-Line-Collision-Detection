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
		//private var separationVector:Vector3D;
		private var lines:Vector.<Line> = new Vector.<Line>();
		private var _line:Line;
		private var _movingBall:Ball;
		
		public function CircleLineCollision() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			lines.push(new Line(50, 150, 350, 150));
			lines.push(new Line(200, 50, 200, 250));
			//lines.push(new Line(300, 50, 200, 250));
			_movingBall = new Ball();
			for (var i:int = 0; i < lines.length; i++) 
			{
				addChild(lines[i]);	
			}
			addChild(_movingBall);
			
			
			//create a vector3D object to use to separate overlapping objects;
			//separationVector = new Vector3D(0, 0);
			
			// Add a listener to move one fo the balls.
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onMouseMove(e:MouseEvent):void 
		{
			this.graphics.clear();
			var newBallPosition:Vector3D = new Vector3D(stage.mouseX, stage.mouseY);
			
			for (var i:int = 0; i < lines.length; i++) 
			{
				var closestPoint:Vector3D = findClosestPoint(newBallPosition, lines[i]);
				collisionReaction(newBallPosition, closestPoint, i);	
			}			
			_movingBall.x = newBallPosition.x;
			_movingBall.y = newBallPosition.y;
		}
		
		private function findClosestPoint(pendingLocation:Vector3D, line:Line):Vector3D
		{
			// Find closest Point On Line
			var mousePosition:Vector3D = new Vector3D(pendingLocation.x, pendingLocation.y);
			var lineVector:Vector3D = line.start.subtract(line.end);
			var mouseVector:Vector3D = mousePosition.subtract(line.start);
			var scaleFactor:Number = lineVector.dotProduct(mouseVector) / lineVector.lengthSquared;
			scaleFactor = Math.min(0, Math.max(scaleFactor, -1));
			lineVector.scaleBy(scaleFactor);
			var closestPoint:Vector3D = line.start.clone().add(lineVector);
			// Draw Closest point on line
			
			this.graphics.beginFill(0xFF0000, 1);
			this.graphics.drawCircle(closestPoint.x, closestPoint.y, 2);
			this.graphics.endFill();
			
			return closestPoint;
		}
		
		private function collisionReaction(movingBall:Vector3D, closestPoint:Vector3D, i:int):void
		{
			// Now Check to see if the distance to the point is smaller than the radius of the circle.
					//Simple collision detection
			// using pyhagorean theorum
			// (a*a) + (b*b) = (c*c);
			var distanceX:Number = movingBall.x - closestPoint.x; //Note - uses stage.mouseX now.			
			var distanceY:Number = movingBall.y - closestPoint.y; //Note - uses stage.mouseY now.
			var distance:Number = Math.sqrt( (distanceX * distanceX) + (distanceY * distanceY));
			
			if (distance < _movingBall.radius ) {
				// the balls overlap
				//now a better reaction			
				// point our vector the correct separation direction
				var separationVector:Vector3D = new Vector3D();
				separationVector.x = distanceX;
				separationVector.y = distanceY;
				//scale the vector length to be the sum of the two ball radii				
				if (separationVector.length > 0) {
					//Protect the operation from a divide by zero error when separationVector.length is zero.
					var scaleFactor:Number = (_movingBall.radius ) / separationVector.length;
					separationVector.scaleBy(scaleFactor);				
				}
				// position the moving ball at the separation vector and offset the vector by the stationary ball's position
				movingBall.x = separationVector.x +closestPoint.x;
				movingBall.y = separationVector.y +closestPoint.y;
				
			} else {
				// the balls do not overlap
				//movingBall.x = mouseX;
				//movingBall.y = mouseY;
			}
		}
		
	}

}