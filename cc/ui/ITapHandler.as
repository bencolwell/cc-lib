package cc.ui {
    
    public interface ITapHandler {
        
        function handleTap(xCoord:Number, yCoord:Number):void;
        function handleTapHold(xCoord:Number, yCoord:Number):void;
        
    }
    
}
