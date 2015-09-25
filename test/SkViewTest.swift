cild.node

child.node.removeFromParent()

private let skView:SKView = self.view as! SKView)

//width and height
var size = CGSize(width: self.skView.bounds.width, height: self.skView.bounds.height)

child.node.parent 
self.node.removeChildrenInArray([child.node])

self.node.insertChild(child.node, atIndex: Int(index))
self.numChildren


//SKShapeNode:
//circle
let shapeNode = GraphicsNode(circleOfRadius: radius)
//ellipse
let shapeNode = GraphicsNode(ellipseOfSize: CGSize(width: width, height: height))
//rect
let shapeNode = GraphicsNode(rect: CGRect(x: x, y: Stage.size.height - (y + height), width: width, height: height))
//triangle
let path = CGPathCreateMutable()//path
CGPathMoveToPoint(path, nil, x1, Stage.size.height - y1)
CGPathAddLineToPoint(path, nil, x2, Stage.size.height - y2)
CGPathAddLineToPoint(path, nil, x3, Stage.size.height - y3)
CGPathCloseSubpath(path)
let shapeNode = GraphicsNode(path: path)
//adding to view
self.node.addChild(shapeNode)
//clearing all shape nodes
node.removeFromParent()
node = SKNode()
graphicsParent.addChild(node)

//

shapeNode.fillColor = fillColor
shapeNode.strokeColor = lineColor
shapeNode.lineWidth = thickness
//
shape.userInteractionEnabled = userInteractionEnabled