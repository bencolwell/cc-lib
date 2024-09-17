package cc.display {
    
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    public class BitmapSequence {
        
        private var _frames:Vector.<BitmapData>;
        private var _bounds:Rectangle;
        private var _registration:Point;
        private var _framerate:int;
        private var _callback:Function;
        private var _frame:int;
        private var _delay:int;
        
        private var _doCall:Boolean;
        private var _callFrames:int;
        
        public function BitmapSequence(
                                       frames:Vector.<BitmapData>,
                                       bounds:Rectangle,
                                       registration:Point,
                                       framerate:int = 1,
                                       callback:Function = null
                                       ) {
            
            _frames = frames;
            _bounds = bounds;
            _registration = registration;
            _framerate = framerate;
            _callback = callback;
            _frame = 0;
            _delay = 0;
            
            _doCall = false;
            _callFrames = 0;
            
        }
        
        public function get currentFrame():int {
            return _frame;
        }
        
        public function get totalFrames():int {
            return _frames.length;
        }
        
        public function get bounds():Rectangle {
            return _bounds;
        }
        
        public function get registration():Point {
            return _registration;
        }
        
        public function get framerate():int {
            return _framerate;
        }
        
        public function set framerate(rate:int):void {
            _framerate = rate;
        }
        
        public function get bitmap():BitmapData {
            return _frames[_frame];
        }
        
        public function getBitmapAt(frame:int):BitmapData {
            if (frame < 0) frame = 0;
            if (frame >= _frames.length) frame = _frames.length - 1;
            return _frames[frame];
        }
        
        public function gotoFrame(frame:int):void {
            if (frame < 0) frame = 0;
            if (frame >= _frames.length) frame = _frames.length - 1;
            _frame = frame;
            _delay = 0;
        }
        
        public function update(deltaTime:int = 1):void {
            _delay += deltaTime;
            if (_delay >= _framerate) {
                _delay -= _framerate;
                _frame++;
                if (_frame >= _frames.length) {
                    _frame = 0;
                    if (!_doCall && _callback != null) _callback();
                }
                if (_doCall) {
                    _callFrames--;
                    if (_callFrames <= 0) {
                        if (_callback != null) _callback();
                        _doCall = false;
                    }
                }
            }
        }
        
        public function callAfter(frames:int):void {
            _doCall = true;
            _callFrames = frames;
        }
        
    }
    
}
