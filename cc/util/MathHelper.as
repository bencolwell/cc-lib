package cc.util {
    
    import flash.geom.Point;
    
    public class MathHelper {
        
        public static function toRadians(degrees:Number):Number {
            return degrees * Math.PI / 180;
        }
        
        public static function toDegrees(radians:Number):Number {
            return radians * 180 / Math.PI;
        }
        
        public static function getDistance(xOrigin:Number, yOrigin:Number, xTarget:Number, yTarget:Number):Number {
            var dx:Number = xTarget - xOrigin;
            var dy:Number = yTarget - yOrigin;
            return Math.sqrt(dx * dx + dy * dy);
        }
        
        public static function getDistance2(pointA:Point, pointB:Point):Number {
            return getDistance(pointA.x, pointA.y, pointB.x, pointB.y);
        }
        
        /**
         * All angles are in radians, use conversion methods to get degrees.
         */
        
        public static function getAngle(xOrigin:Number, yOrigin:Number, xTarget:Number, yTarget:Number):Number {
            return Math.atan2(yTarget - yOrigin, xTarget - xOrigin);
        }
        
        public static function getAngle2(pointA:Point, pointB:Point):Number {
            return Math.atan2(pointB.y - pointA.y, pointB.x - pointA.x);
        }
        
        public static function getVelocityX(angle:Number, speed:Number):Number {
            return Math.cos(angle) * speed;
        }
        
        public static function getVelocityY(angle:Number, speed:Number):Number {
            return Math.sin(angle) * speed;
        }
        
        public static function getVector(vector:Point, angle:Number, speed:Number):void {
            vector.x = Math.cos(angle) * speed;
            vector.y = Math.sin(angle) * speed;
        }
        
        /**
         * Finds a point on a bezier curve based on t.
         * @param  point  Point instance to have its x and y properties set
         * @param  t      Value range from 0-1
         */
        public static function getPointOnBezier(point:Point, t:Number, xOrigin:Number, yOrigin:Number, xControl:Number, yControl:Number, xTarget:Number, yTarget:Number):void {
            point.x = (1 - t) * (1 - t) * xOrigin + 2 * (1 - t) * t * xControl + t * t * xTarget;
            point.y = (1 - t) * (1 - t) * yOrigin + 2 * (1 - t) * t * yControl + t * t * yTarget;
        }
        
        public static function logx(val:Number, base:Number = 10):Number {
            return Math.log(val) / Math.log(base);
        }
        
    }
    
}
