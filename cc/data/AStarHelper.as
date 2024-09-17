package cc.data {
    
    public class AStarHelper {
        
        private static var _instance:AStarHelper;
        
        public function AStarHelper(
                                    enforcer:SingletonEnforcer
                                    ) {
            if (enforcer == null) {
                throw new Error("AStarHelper is a singleton class, use getInstance() instead");
            }
        }
        
        public static function getInstance():AStarHelper {
            if (_instance == null) _instance = new AStarHelper(new SingletonEnforcer());
            return _instance;
        }
        
        public function getPath(areaGrid:Vector.<IAStarNode>, origin:IAStarNode, goal:IAStarNode, costValues:Vector.<Number> = null):Vector.<IAStarNode> {
            
            resetGrid(areaGrid, costValues);
            
            var openList:Vector.<IAStarNode> = new Vector.<IAStarNode>();
            
            origin.g = 0;
            origin.h = getDist(origin.loc.x, origin.loc.y, goal.loc.x, goal.loc.y);
            origin.parent = null;
            origin.isOpen = true;
            openList.push(origin);
            
            while (openList.length > 0) {
                
                openList.sort(sortOpenList);
                var node:IAStarNode = openList.pop();
                
                if (node == goal) {
                    
                    // construct path and return it
                    var path:Vector.<IAStarNode> = new Vector.<IAStarNode>();
                    path.push(goal);
                    while (node.parent != null) {
                        path.push(node.parent);
                        node = node.parent;
                    }
                    return path;
                    
                } else {
                    
                    var newg:Number;
                    
                    for each(var adjacentNode:IAStarNode in node.adjacentNodes) {
                        
                        newg = node.g + 1 + adjacentNode.cost
                        
                        if ((adjacentNode.isOpen || adjacentNode.isClosed) && adjacentNode.g <= newg) continue;
                        if (!adjacentNode.isWalkable) continue;
                        
                        adjacentNode.parent = node;
                        adjacentNode.g = newg;
                        adjacentNode.h = getDist(adjacentNode.loc.x, adjacentNode.loc.y, goal.loc.x, goal.loc.y);
                        adjacentNode.isClosed = false;
                        if (!adjacentNode.isOpen) {
                            adjacentNode.isOpen = true;
                            openList.push(adjacentNode);
                        }
                        
                    }
                    
                    for each(var diagonalNode:IAStarNode in node.diagonalNodes) {
                        
                        newg = node.g + 1.5 + diagonalNode.cost
                        
                        if ((diagonalNode.isOpen || diagonalNode.isClosed) && diagonalNode.g <= newg) continue;
                        if (!diagonalNode.isWalkable) continue;
                        
                        diagonalNode.parent = node;
                        diagonalNode.g = newg;
                        diagonalNode.h = getDist(diagonalNode.loc.x, diagonalNode.loc.y, goal.loc.x, goal.loc.y);
                        diagonalNode.isClosed = false;
                        if (!diagonalNode.isOpen) {
                            diagonalNode.isOpen = true;
                            openList.push(diagonalNode);
                        }
                        
                    }
                    
                    node.isClosed = true;
                    
                }
                
            }
            
            // no path found
            return null;
        }
        
        private function resetGrid(areaGrid:Vector.<IAStarNode>, costValues:Vector.<Number>):void {
            var i:int;
            if (costValues == null) {
                for (i = 0; i < areaGrid.length; ++i) {
                    areaGrid[i].isOpen = false;
                    areaGrid[i].isClosed = false;
                    areaGrid[i].parent = null;
                    areaGrid[i].cost = 0;
                }
            } else {
                for (i = 0; i < areaGrid.length; ++i) {
                    areaGrid[i].isOpen = false;
                    areaGrid[i].isClosed = false;
                    areaGrid[i].parent = null;
                    areaGrid[i].cost = costValues[i];
                }
            }
        }
        
        private function sortOpenList(a:IAStarNode, b:IAStarNode):Number {
            if (a.f < b.f) return 1;
            if (a.f > b.f) return -1;
            return 0;
        }
        
        private function getDist(x:int, y:int, tx:int, ty:int):int {
            var dx:int = tx - x;
            var dy:int = ty - y;
            if (sign(dx) != sign(dy)) {
                return Math.max(Math.abs(dx), Math.abs(dy));
            } else {
                return Math.abs(dx) + Math.abs(dy);
            }
        }
        
        private function sign(n:int):int {
            var s:int = n < 0? 1: 0;
            return s;
        }
        
    }
    
}

internal class SingletonEnforcer{};
