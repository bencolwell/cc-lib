package cc.util {
    
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    public class BitmapHelper {
        
        public function BitmapHelper() {
            
        }
        
        public static function trimTransparency(trimImage:Bitmap):Bitmap {
            
            var trimRect:Rectangle = trimImage.bitmapData.getColorBoundsRect(0xFF000000, 0x00FF3345, false);
            var trimmedImage:BitmapData = new BitmapData(trimRect.width, trimRect.height);
            trimmedImage.copyPixels(trimImage.bitmapData, trimRect, new Point(0,0));
            
            trimImage.bitmapData = trimmedImage;
            
            return trimImage;
            
        }
        
    }
    
}
