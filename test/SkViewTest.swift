cild.node

child.node.removeFromParent()

private let skView:SKView = self.view as! SKView)

//width and height
var size = CGSize(width: self.skView.bounds.width, height: self.skView.bounds.height)

child.node.parent 
self.node.removeChildrenInArray([child.node])

self.node.insertChild(child.node, atIndex: Int(index))
self.numChildren

//SpriteKit:
//NOTE: you can also use:CAShapeLayer

//SKShapeNode:
//circle
let shapeNode = SKShapeNode(circleOfRadius: radius)
//ellipse
let shapeNode = SKShapeNode(ellipseOfSize: CGSize(width: width, height: height))
//rect
let shapeNode = SKShapeNode(rect: CGRect(x: x, y: Stage.size.height - (y + height), width: width, height: height))
//triangle
let path = CGPathCreateMutable()//path
CGPathMoveToPoint(path, nil, x1, Stage.size.height - y1)
CGPathAddLineToPoint(path, nil, x2, Stage.size.height - y2)
CGPathAddLineToPoint(path, nil, x3, Stage.size.height - y3)
CGPathCloseSubpath(path)
let shapeNode = SKShapeNode(path: path)
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





//multiple shapes in an skshape: (obj-c)
SKShapeNode  *shape = [[SKShapeNode alloc] init];
CGMutablePathRef myPath = CGPathCreateMutable();
CGPathAddArc(myPath, NULL, 0,0, 15, 0, M_PI*2, YES);

CGMutablePathRef pathTwo = CGPathCreateMutable();
CGPathAddArc(pathTwo, NULL, 50,0, 15, 0, M_PI*2, YES);     
CGPathAddPath(myPath, NULL, pathTwo);

CGMutablePathRef pathThree = CGPathCreateMutable();
CGPathAddArc(pathThree, NULL, 100,0, 15, 0, M_PI*2, YES);
CGPathAddPath(myPath, NULL, pathThree);

shape.path = myPath;

[self addChild:shape];