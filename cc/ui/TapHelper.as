package cc.ui {
    
    import flash.display.DisplayObjectContainer;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    
    public class TapHelper {
        
        private var _dispatcher:DisplayObjectContainer;
        private var _handler:ITapHandler;
        private var _tapTolerance:int;
        private var _holdTimer:int;
        private var _mouseCoord:Point;
        private var _isMouseDown:Boolean;
        private var _isMouseHeld:Boolean;
        
        public function TapHelper(
                                  dispatcher:DisplayObjectContainer,
                                  handler:ITapHandler,
                                  tapTolerance:int = 300  // milliseconds
                                  ) {
            
            _dispatcher = dispatcher;
            _handler = handler;
            _tapTolerance = tapTolerance;
            
            _dispatcher.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
            _dispatcher.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
            
            _mouseCoord = new Point();
            _isMouseDown = false;
            _isMouseHeld = false;
            
        }
        
        public function update(dt:int):void {
            
            if (_isMouseDown) {
                _holdTimer += dt;
                if (_holdTimer >= _tapTolerance) {
                    _isMouseHeld = true;
                    _handler.handleTapHold(_mouseCoord.x, _mouseCoord.y);
                }
            }
            
        }
        
        private function handleMouseDown(e:MouseEvent):void {
            
            _isMouseDown = true;
            _isMouseHeld = false;
            _mouseCoord.x = e.stageX;
            _mouseCoord.y = e.stageY;
            _holdTimer = 0;
            
        }
        
        private function handleMouseUp(e:MouseEvent):void {
            
            _isMouseDown = false;
            if (!_isMouseHeld) {
                _handler.handleTap(_mouseCoord.x, _mouseCoord.y);
            }
            
        }
        
    }
    
}
