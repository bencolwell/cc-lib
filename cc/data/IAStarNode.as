package cc.data {
    
    import flash.geom.Point;
    
    public interface IAStarNode {
        
        function get loc():Point;           // an x,y coordinate measured in grid units from a single origin point
        function get isWalkable():Boolean;
        function get adjacentNodes():Vector.<IAStarNode>;
        function get diagonalNodes():Vector.<IAStarNode>;
        function addAdjacentNode(node:IAStarNode):void;
        function addDiagonalNode(node:IAStarNode):void;
        
        function get g():Number;            // cost from origin along best known path
        function set g(value:Number):void;
        function get h():Number;            // heuristic cost estimate
        function set h(value:Number):void;
        function get f():Number;            // estimated total cost from origin to goal
        function get cost():Number;
        function set cost(value:Number):void;
        function get parent():IAStarNode;
        function set parent(node:IAStarNode):void;
        function get isOpen():Boolean;
        function set isOpen(value:Boolean):void;
        function get isClosed():Boolean;
        function set isClosed(value:Boolean):void;
        
    }
    
}
