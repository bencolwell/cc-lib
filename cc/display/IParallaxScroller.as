package cc.display {
    
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    
    public interface IParallaxScroller {
        
        function get clippedRect():Rectangle;                      // returns a rect representing the total scrollable size minus the viewport size
        function set viewportRect(rect:Rectangle);                 // sets the size of the viewport
        function set scrollableRect(rect:Rectangle);               // sets the total scrollable size
        function addBitmapLayers(layers:Vector.<BitmapData>);      // adds bitmap layers in the order specified
        function addVectorLayer(layer:VectorLayer);                // adds a vector layer
        function updateBitmapLayer(index:int, bitmap:BitmapData);  // updates an existing bitmap layer at target index (must match the exact size)
        function scrollTo(coord:Point):void;                       // scroll to the coordinate specified
        
    }
    
}
