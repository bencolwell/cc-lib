package cc.ui {
    
    import flash.display.DisplayObjectContainer;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    
    public class ScrollHelper {
        
        private var _dispatcher:DisplayObjectContainer;
        private var _handler:IScrollHandler;
        private var _scrollTolerance:int;
        private var _mouseCoord:Point;
        private var _isMouseDown:Boolean;
        private var _isScrolling:Boolean;
        
        public function ScrollHelper(
                                     dispatcher:DisplayObjectContainer,
                                     handler:IScrollHandler,
                                     scrollTolerance:int = 5
                                     ) {
            
            _dispatcher = dispatcher;
            _handler = handler;
            _scrollTolerance = scrollTolerance;
            
            _dispatcher.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
            _dispatcher.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
            _dispatcher.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
            
            _mouseCoord = new Point();
            _isMouseDown = false;
            _isScrolling = false;
            
        }
        
        private function handleMouseDown(e:MouseEvent):void {
            
            _isMouseDown = true;
            _mouseCoord.x = e.stageX;
            _mouseCoord.y = e.stageY;
            
        }
        
        private function handleMouseUp(e:MouseEvent):void {
            
            _isMouseDown = false;
            if (_isScrolling) {
                _isScrolling = false;
                _handler.handleScrollStop();
            }
            
        }
        
        private function handleMouseMove(e:MouseEvent):void {
            
            if (_isMouseDown) {
                if (_isScrolling) {
                    _handler.handleScroll(_mouseCoord.x - e.stageX, _mouseCoord.y - e.stageY);
                    _mouseCoord.x = e.stageX;
                    _mouseCoord.y = e.stageY;
                } else {
                    if (Math.abs(_mouseCoord.x - e.stageX) > _scrollTolerance || Math.abs(_mouseCoord.y - e.stageY) > _scrollTolerance) {
                        _isScrolling = true;
                        _handler.handleScrollStart();
                    }
                }
            }
            
        }
        
    }
    
}
