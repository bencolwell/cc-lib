package cc.ui {
    
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import flash.display.Sprite;
    
    public class BitmapButton extends Sprite implements IBitmapButton {
        
        protected var _button:Bitmap;
        protected var _buttonStates:Vector.<BitmapData>;  // expects 4 button states in this order: up, over, down/selected, disabled
        protected var _cancelCallback:Function;
        protected var _callback:Function;
        protected var _isEnabled:Boolean;
        protected var _isMouseOver:Boolean;
        protected var _isDepressed:Boolean;
        protected var _isDepressable:Boolean;
        
        public function BitmapButton(
                                     buttonStates:Vector.<BitmapData>,
                                     callback:Function,  // expects a function with an argument of type BitmapButton
                                     depressable:Boolean = false,
                                     cancelCallback:Function = null
                                     ) {
            
            _buttonStates = buttonStates;
            _cancelCallback = cancelCallback;
            _callback = callback;
            _isEnabled = true;
            _isMouseOver = false;
            _isDepressed = false;
            _isDepressable = depressable;
            
            _button = new Bitmap(_buttonStates[0]);
            this.addChild(_button);
            
            this.mouseChildren = false;
            this.addEventListener(MouseEvent.CLICK, handleClick);
            if (!_isDepressable) {
                this.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
                this.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
            }
            this.addEventListener(MouseEvent.ROLL_OVER, handleRollOver);
            this.addEventListener(MouseEvent.ROLL_OUT, handleRollOut);
            
        }
        
        public function get enabled():Boolean {
            return _isEnabled;
        }
        
        public function set enabled(isEnabled:Boolean):void {
            _isEnabled = isEnabled;
            if (_isEnabled) {
                showRolloverState();
            } else {
                _isDepressed = false;
                _button.bitmapData = _buttonStates[3];
            }
        }
        
        public function get depressed():Boolean {
            return _isDepressed;
        }
        
        public function setDepressedState(isDepressed:Boolean):void {
            _isDepressed = isDepressed;
            if (_isEnabled) {
                showDepressedState(isDepressed);
            }
        }
        
        private function handleClick(e:MouseEvent):void {
            if (_isEnabled) {
                if (_isDepressable) {
                    if (_isDepressed) {
                        if (_cancelCallback != null) {
                            setDepressedState(!_isDepressed);
                            _cancelCallback();
                        }
                    } else {
                        setDepressedState(!_isDepressed);
                        doCallback();
                    }
                } else {
                    doCallback();
                }
            }
        }
        
        protected function doCallback():void {
            _callback(this);
        }
        
        private function handleMouseDown(e:MouseEvent):void {
            if (_isEnabled) showDepressedState(true);
        }
        
        private function handleMouseUp(e:MouseEvent):void {
            if (_isEnabled) showDepressedState(false);
        }
        
        private function handleRollOver(e:MouseEvent):void {
            _isMouseOver = true;
            if (_isEnabled && !_isDepressed) showRolloverState();
        }
        
        private function handleRollOut(e:MouseEvent):void {
            _isMouseOver = false;
            if (_isEnabled && !_isDepressed) showRolloverState();
        }
        
        protected function showDepressedState(isDepressed:Boolean):void {
            if (isDepressed) {
                _button.bitmapData = _buttonStates[2];
            } else {
                showRolloverState();
            }
        }
        
        protected function showRolloverState():void {
            if (_isMouseOver) {
                _button.bitmapData = _buttonStates[1];
            } else {
                _button.bitmapData = _buttonStates[0];
            }
        }
        
    }
    
}
