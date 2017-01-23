import Cocoa
@testable import Utils

class Graph:Element {
    var vValues:[CGFloat] {return [4,2,3,7,5,0,1]}/*vertical amount*///TODO: rename to y-values?
    var hValNames:[String] {return ["A","B","C","D","E","F","G"]}/*horizontal items*///TODO: rename to x-values? 
    var vCount:Int = 5/*Number of vertical indicators*/
    var hCount:Int {return hValNames.count}
    var leftBar:Section?
    var leftBarItems:[TextArea] = []
    var bottomBar:Section?
    var graphArea:Section?/*Holds the GraphLine and GraphPoint*/
    var graphLine:GraphLine?
    var graphPoints:[Element] = []//Visual points
    var graphPts:[CGPoint] = []
    /*layoutData:*/
    var newSize:CGSize?/*the size that contains the graph components*/
    var newPosition:CGPoint?/*the point that the graph components starts from*/
    var itemYSpace:CGFloat?
    var itemXSpace:CGFloat?
    var maxValue:CGFloat?//maxValue represents the max value among the values
    var spacing:CGSize?
    
    override func resolveSkin() {
        super.resolveSkin()
        createUI()
        graphPts = GraphUtils.points(newSize!, newPosition!, spacing!, vValues, maxValue!)//creates the init positions of where the points should lay
        createGraph()
    }
    /**
     * Creates the Ui sorounding the graph (x,y indicators, background, etc)
     * NOTE: override this method if you want ot make a different UI look
     */
    func createUI(){
        newSize = Resizer.fit(CGSize(w,h),4/3)
        newPosition = Align.alignmentPoint(newSize!, CGSize(width/**/,height/**/), Alignment.centerCenter, Alignment.centerCenter,CGPoint(0,0))
        createGraphArea()
        
        itemYSpace = newSize!.height/(vCount.cgFloat + 1.0)
        maxValue = GraphUtils.maxValue(vValues)
        createLeftBar()
        
        itemXSpace = newSize!.width/(hCount.cgFloat + 1.0)
        createBottomBar()
        spacing = CGSize(itemXSpace!,itemYSpace!)
        createVLines(newSize!,newPosition!,spacing!)
    }
    /**
     * Creates the graph components (line and points)
     * NOTE: override this method if you want to make another graph design etc
     */
    func createGraph(){
        createGraphLine()
        createGraphPoints()
    }
    /**
     * Creats the container that graphLine and graphPoint is added to
     * TODO: combine size and pos into rect
     */
    func createGraphArea(){
        graphArea = addSubView(Section(newSize!.width,newSize!.height,self,"graphArea"))
        graphArea?.setPosition(newPosition!)
    }
    /**
     * Creates the Text items that represents data in the y-axis
     */
    func createLeftBar(){
        leftBar = addSubView(Section(NaN,newSize!.height,self,"leftBar"))//create left bar
        leftBar!.setPosition(CGPoint(0,newPosition!.y))
        
        let strings:[String] = GraphUtils.verticalIndicators(vCount, maxValue!)

        var y:CGFloat = itemYSpace!
        strings.forEach{
            let textArea:TextArea = TextArea(NaN,NaN,$0,leftBar!)
            leftBarItems.append(textArea)
            _ = leftBar!.addSubView(textArea)
            textArea.setPosition(CGPoint(0,y))
            y += itemYSpace!
        }
    }
    /**
     * Creates the Text items that represents data in the x-axis
     */
    func createBottomBar(){
        //Swift.print("createBottomBar")
        //Swift.print("size: " + "\(size)")
        //Swift.print("position: " + "\(position)")
        bottomBar = addSubView(Section(newSize!.width,NaN,self,"bottomBar"))/*Create bottom bar*/
        bottomBar!.setPosition(CGPoint(newPosition!.x,newPosition!.y+newSize!.height-bottomBar!.getHeight()))
        
        
        //let itemWidth:CGFloat = size.width / hCount.cgFloat
        
        var x:CGFloat = itemXSpace!
        for i in 0..<hCount{
            let str:String = hValNames[i]
            //Swift.print("str: " + "\(str)")
            let textArea:TextArea = TextArea(NaN,NaN,str,bottomBar!)
            _ = bottomBar!.addSubView(textArea)
            //Swift.print("CGPoint(x,0): " + "\(CGPoint(x,0))")
            textArea.setPosition(CGPoint(x,0))
            x += itemXSpace!
        }
    }
    /**
     * Vertical lines (static)
     */
    func createVLines(_ size:CGSize,_ position:CGPoint,_ spacing:CGSize){
        let count:Int = hValNames.count
        var x:CGFloat = spacing.width
        for _ in 0..<count{
            let vLine = graphArea!.addSubView(Element(NaN,size.height-(spacing.height*2),graphArea,"vLine"))
            vLine.setPosition(CGPoint(x,spacing.height))
            x += spacing.width
        }
    }
    /**
     * Creates The visual Graph points that hover above the Graph line
     * NOTE: We could create something called GraphPoint, but it would be another thing to manager so instead we just use an Element with id: graphPoint
     */
    func createGraphPoints(){
        //Swift.print("createGraphPoints:")
        graphPts.forEach{
            let graphPoint:Element = graphArea!.addSubView(Element(NaN,NaN,graphArea,"graphPoint"))
            graphPoints.append(graphPoint)
            graphPoint.setPosition($0)
        }
    }
    /**
     * Creates the Visual Graph line that represents the Metric Data
     */
    func createGraphLine(){
        let graphPath:IPath = PolyLineGraphicUtils.path(graphPts)/*convert points to a Path*/
        graphLine = graphArea!.addSubView(GraphLine(width,height,graphPath,graphArea))
    }
    /**
     * //onResize, recalc spacing,Realign components,height should be uniform to the width
     */
    func alignUI(){//this method is not in use
        let newSize:CGSize = Resizer.fit(CGSize(w,h),4/3)
        graphArea!.setSize(newSize.width,newSize.height)//Scale to ratio:
        let alignmentPoint:CGPoint = Align.alignmentPoint(CGSize(graphArea!.frame.size.width,graphArea!.frame.size.height), CGSize(width/**/,height/**/), Alignment.centerCenter, Alignment.centerCenter,CGPoint(0,0))
        graphArea?.setPosition(alignmentPoint)
    }
    override func setSize(_ width:CGFloat, _ height:CGFloat) {
        //update different UI elements
    }
    override func getClassType() -> String {
        return "\(Graph.self)"
    }
}
