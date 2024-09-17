package cc.util {
    
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.utils.getTimer;
    
    public class FPSCounter extends Sprite {
        
        private var _last:uint;
        private var _ticks:uint;
        private var _tf:TextField;
        
        public function FPSCounter():void {
            
            _tf = new TextField;
            _tf.textColor = 0xffffff;
            _tf.text = "----- fps";
            _tf.selectable = false;
            _tf.background = true;
            _tf.backgroundColor = 0x000000;
            _tf.autoSize = TextFieldAutoSize.LEFT;
            this.addChild(_tf);
            
            _last = getTimer();
            _ticks = 0;
            this.addEventListener(Event.ENTER_FRAME, tick);
            
        }
        
        private function tick(e:Event):void {
            
            _ticks++;
            var now:uint = getTimer();
            var delta:uint = now - _last;
            if (delta >= 1000) {
                var fps:Number = _ticks / delta * 1000;
                _tf.text = fps.toFixed(0) + " fps";
                _ticks = 0;
                _last = now;
            }
            
        }
        
    }
    
}
