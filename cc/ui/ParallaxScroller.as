package cc.ui {
    
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    public class ParallaxScroller extends Sprite {
        
        private var _viewportRect:Rectangle;
        private var _scrollableRect:Rectangle;
        private var _clippedRect:Rectangle;
        private var _bitmapLayers:Vector.<Bitmap>;
        
        public function ParallaxScroller(
                                         viewportRect:Rectangle,
                                         scrollableRect:Rectangle
                                         ) {
            
            _viewportRect = viewportRect;
            _scrollableRect = scrollableRect;
            calculateClippedRect();
            _bitmapLayers = new Vector.<Bitmap>();
            
        }
        
        public function get clippedRect():Rectangle {
            return _clippedRect;
        }
        
        public function set viewportRect(rect:Rectangle):void {
            _viewportRect = rect;
            calculateClippedRect();
        }
        
        public function set scrollableRect(rect:Rectangle):void {
            _scrollableRect = rect;
            calculateClippedRect();
        }
        
        private function calculateClippedRect():void {
            _clippedRect = new Rectangle(0, 0, _scrollableRect.width - _viewportRect.width, _scrollableRect.height - _viewportRect.height);
        }
        
        public function addBitmapLayers(layers:Vector.<BitmapData>):void {
            
            var startIndex:int = _bitmapLayers.length;
            for each(var bitmap:BitmapData in layers) {
                if (bitmap.width >= _viewportRect.width && bitmap.height >= _viewportRect.height) {
                    _bitmapLayers.push(new Bitmap(bitmap));
                }
            }
            for (var i:int = startIndex; i < _bitmapLayers.length; ++i) {
                _bitmapLayers[i].scrollRect = new Rectangle(0, 0, _viewportRect.width, _viewportRect.height);
                this.addChild(_bitmapLayers[i]);
            }
            
        }
        
        public function updateBitmapLayer(index:int, bitmap:BitmapData):void {
            
            if (index < 0 || index > _bitmapLayers.length - 1) return;
            if (bitmap.width != _bitmapLayers[index].bitmapData.width || bitmap.height != _bitmapLayers[index].bitmapData.height) return;
            _bitmapLayers[index].bitmapData = bitmap;
            
        }
        
        public function scrollTo(coord:Point):void {
            
            // ensure coord is valid
            if (coord.x < 0) return;
            if (coord.y < 0) return;
            if (coord.x > _clippedRect.width) return;
            if (coord.y > _clippedRect.height) return;
            
            for (var i:int = 0; i < _bitmapLayers.length; ++i) {
                _bitmapLayers[i].scrollRect = new Rectangle((_bitmapLayers[i].bitmapData.width - _viewportRect.width) * (coord.x / _clippedRect.width),
                                                            (_bitmapLayers[i].bitmapData.height - _viewportRect.height) * (coord.y / _clippedRect.height),
                                                            _viewportRect.width, _viewportRect.height);
            }
            
        }
        
    }
    
}
