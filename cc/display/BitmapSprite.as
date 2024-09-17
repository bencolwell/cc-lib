package cc.display {
    
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    
    public class BitmapSprite extends Sprite {
        
        protected var _zIndex:int;
        protected var _bitmap:Bitmap;
        
        public function BitmapSprite(
                                     zIndex:int = 0
                                     ) {
            
            _zIndex = zIndex;
            _bitmap = new Bitmap();
            this.addChild(_bitmap);
            
        }
        
        public function get zIndex():int {
            return _zIndex;
        }
        
        public function set zIndex(z:int):void {
            _zIndex = z;
        }
        
        public function get bitmap():BitmapData {
            return _bitmap.bitmapData;
        }
        
        public function set bitmap(data:BitmapData):void {
            _bitmap.bitmapData = data;
        }
        
        public function setRegistration(xCoord:Number, yCoord:Number):void {
            _bitmap.x = -xCoord;
            _bitmap.y = -yCoord;
        }
        
    }
    
}
