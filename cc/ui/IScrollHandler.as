package cc.ui {
    
    public interface IScrollHandler {
        
        function handleScrollStart():void;
        function handleScrollStop():void;
        function handleScroll(xDelta:Number, yDelta:Number):void;
        
    }
    
}
