import Cocoa
@testable import Utils

class Graph:Element {
    var hValues:[CGFloat] {return [4,2,3,7,5,0,1]}
    var hValNames:[String] {return ["A","B","C","D","E","F","G"]}/*horizontal items*/
    var vCount:Int = 5/*Number of vertical indicators*/
    var leftBar:Section?
    var leftBarItems:[TextArea] = []
    var bottomBar:Section?
    var graphArea:Section?
    var graphLine:GraphLine?
    var graphPoints:[Element] = []
    /*layoutData:*/
    var newSize:CGSize?/*the size that contains the graph components*/
    var newPostition:CGPoint?/*the point that the graph components starts from*/
    var spaceData:(itemYSpace:CGFloat,maxValue:CGFloat)?
    var itemYSpace:CGFloat?
    var itemXSpace:CGFloat?
    var spacing:CGSize?
    override func resolveSkin() {
        super.resolveSkin()
        createUI()
        
        let graphPts:[CGPoint] = GraphUtils.points(newSize!, newPostition!, spacing!, hValues,spaceData!.maxValue)
        createGraph(graphPts)
        
        //alignUI()
    }
    /**
     * Creates the Ui sorounding the graph (x,y indicators, background, etc)
     * NOTE: override this method if you want ot make a different UI look
     */
    func createUI(){
        newSize = Resizer.fit(CGSize(w,h),4/3)
        //Swift.print("newSize: " + "\(newSize)")
        newPostition = Align.alignmentPoint(newSize!, CGSize(width/**/,height/**/), Alignment.centerCenter, Alignment.centerCenter,CGPoint(0,0))
        //Swift.print("newPostition: " + "\(newPostition)")
        
        createGraphArea(newSize!,newPostition!)
        spaceData = createLeftBar(newSize!,newPostition!)
        itemYSpace = spaceData!.itemYSpace
        itemXSpace = createBottomBar(newSize!,newPostition!)
        spacing = CGSize(itemXSpace!,itemYSpace!)
        
        createVLines(newSize!,newPostition!,spacing!)
    }
    /**
     * Creates the graph components (line and points)
     * NOTE: override this method if you want to make another graph design etc
     */
    func createGraph(_ graphPts:[CGPoint]){
        createGraphLine(newSize!,newPostition!,spacing!,graphPts)
        createGraphPoints(newSize!,newPostition!,spacing!,graphPts)
    }
    /**
     * Creats the container that graphLine and graphPoint is added to
     */
    func createGraphArea(_ size:CGSize,_ position:CGPoint){
        graphArea = addSubView(Section(size.width,size.height,self,"graphArea"))
        graphArea?.setPosition(position)
    }
    /**
     * Creates the Text items that represents data in the y-axis
     */
    func createLeftBar(_ size:CGSize,_ position:CGPoint)->(itemYSpace:CGFloat,maxValue:CGFloat){
        leftBar = addSubView(Section(NaN,size.height,self,"leftBar"))//create left bar
        leftBar!.setPosition(CGPoint(0,position.y))
        
        var maxValue:CGFloat = NumberParser.max(hValues)//you need to map these and ceil them. as you need int values!?!?
        //Swift.print("maxValue: " + "\(maxValue)")
        let itemYSpace:CGFloat = size.height/(vCount.cgFloat+1)
        //Swift.print("itemYSpace: " + "\(itemYSpace)")
        if(CGFloatAsserter.odd(maxValue)){
            maxValue += 1//We need even values when we devide later
        }
        //Swift.print("maxValue: " + "\(maxValue)")
        
        
        let strings:[String] = GraphUtils.verticalIndicators(vCount, maxValue)

        var y:CGFloat = itemYSpace
        strings.forEach{
            let textArea:TextArea = TextArea(NaN,NaN,$0,leftBar!)
            leftBarItems.append(textArea)
            _ = leftBar!.addSubView(textArea)
            textArea.setPosition(CGPoint(0,y))
            y += itemYSpace
        }
        return (itemYSpace:itemYSpace,maxValue:maxValue)
    }
    /**
     * Creates the Text items that represents data in the x-axis
     */
    func createBottomBar(_ size:CGSize,_ position:CGPoint)->CGFloat{
        //Swift.print("createBottomBar")
        //Swift.print("size: " + "\(size)")
        //Swift.print("position: " + "\(position)")
        bottomBar = addSubView(Section(size.width,NaN,self,"bottomBar"))/*Create bottom bar*/
        bottomBar!.setPosition(CGPoint(position.x,position.y+size.height-bottomBar!.getHeight()))
        
        let hCount:Int = hValNames.count
        //Swift.print("hCount: " + "\(hCount)")
        //let itemWidth:CGFloat = size.width / hCount.cgFloat
        let itemXSpace:CGFloat = size.width/(hCount.cgFloat + 1)
        //Swift.print("itemXSpace: " + "\(itemXSpace)")
        var x:CGFloat = itemXSpace
        for i in 0..<hCount{
            let str:String = hValNames[i]
            //Swift.print("str: " + "\(str)")
            let textArea:TextArea = TextArea(NaN,NaN,str,bottomBar!)
            _ = bottomBar!.addSubView(textArea)
            //Swift.print("CGPoint(x,0): " + "\(CGPoint(x,0))")
            textArea.setPosition(CGPoint(x,0))
            x += itemXSpace
        }
        return itemXSpace
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
    func createGraphPoints(_ size:CGSize,_ position:CGPoint,_ spacing:CGSize, _ graphPts:[CGPoint]){
        //Swift.print("createGraphPoints:")
        //Swift.print("graphPts: " + "\(graphPts)")
        //Swift.print("graphPts.count: " + "\(graphPts.count)")
        graphPts.forEach{
            let graphPoint:Element = graphArea!.addSubView(Element(NaN,NaN,graphArea,"graphPoint"))
            graphPoints.append(graphPoint)
            graphPoint.setPosition($0)
            //style the button similar to VolumSlider knob (with a blue center, a shadow and white border, test different designs)
            //set the size as 12px and offset to -6 (so that its centered)
        }
    }
    /**
     * Creates the Visual Graph line that represents the Metric Data
     */
    func createGraphLine(_ size:CGSize,_ position:CGPoint,_ spacing:CGSize, _ graphPts:[CGPoint]){
        let graphPath:IPath = PolyLineGraphicUtils.path(graphPts)/*convert points to a Path*/
        graphLine = graphArea!.addSubView(GraphLine(width,height,graphPath,graphArea))
    }
    /**
     * //onResize
     * //recalc spacing
     * //height should be uniform to the width
     * //Realign components
     */
    func alignUI(){
        //this method is not in use
        //Scale to ratio:
        let newSize:CGSize = Resizer.fit(CGSize(w,h),4/3)
        graphArea!.setSize(newSize.width,newSize.height)
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
/**
 * GraphLine represents the Visual Graph line int the Graph component. 
 * NOTE: GraphLine avoids adding the skin to its view, and then passes on the StyleProperty to the custom PathLine. This enables you to set the style via CSS
 * TODO: Contemplate Adding a new Skin type that you manually add instead of resolve, this way you dont have to add PathGraphic etc
 */
class GraphLine:Element{
    var line:PathGraphic?//<--we could also use PolyLineGraphic, but we may support curvey Graphs in the future
    var path:IPath
    init(_ width:CGFloat, _ height:CGFloat,_ path:IPath, _ parent:IElement? = nil, _ id:String? = nil) {
        self.path = path
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        //Swift.print("GraphLine.resolveSkin")
        skin = SkinResolver.skin(self)//you could use let style:IStyle = StyleResolver.style(element), but i think skin has to be created to not cause bugs 
        //I think the most apropriate way is to make a custom skin and add it as a subView wich would implement :ISkin etc, see TextSkin for details
        //Somehow derive the style data and make a basegraphic with it
        let lineStyle:ILineStyle = StylePropertyParser.lineStyle(skin!)!//<--grab the style from that was resolved to this component
        //LineStyleParser.describe(lineStyle)
        line = PathGraphic(path,nil,lineStyle)
        _ = addSubView(line!.graphic)
        line!.draw()
    }
    override func setSkinState(_ skinState:String) {
        //update the line, implement this if you want to be able to set the theme of this component
    }
    override func setSize(_ width:CGFloat, _ height:CGFloat) {
        //update the line, implement this if you need win resize support for this component
    }
    required init(coder:NSCoder) {fatalError("init(coder:) has not been implemented") }
}
class GraphUtils{
    /**
     * Returns graph points (Basically the coordinates of where to place the visual graph points)
     */
    static func points(_ size:CGSize,_ position:CGPoint,_ spacing:CGSize, _ hValues:[CGFloat], _ maxValue:CGFloat) -> [CGPoint]{
        var points:[CGPoint] = []
        let hCount:Int = hValues.count
        let x:CGFloat = /*position.x*/ spacing.width
        let y:CGFloat = /*position.y +*/ size.height - spacing.height
        for i in 0..<hCount{//calc the graphPoints:
            var p = CGPoint()
            p.x = x + (i * spacing.width)
            p.y = y - ((size.height-(spacing.height*2))/maxValue * hValues[i])
            points.append(p)
        }
        return points
    }
    /**
     * Generates value indicators that match up with the (data set)
     */
    static func verticalIndicators(_ vCount:Int,_ maxValue:CGFloat)->[String]{
        var strings:[String] = []
        for i in (0..<vCount).reversed() {//swift 3 update
            //Swift.print("i: " + "\(i)")
            var num:CGFloat = (maxValue/(vCount.cgFloat-1))*i
            //Swift.print("num: " + "\(num)")
            num = round(num)//NumberModifier.toFixed(num, 1)//
            let str:String = num.string
            strings.append(str)
            //Tip: use skin.getWidth() if you need to align Element items with Align
        }
        return strings
    }
}

//try making DayGraph which has Day names (remember to return Graph as identifier)
//contemplate removing the top value and centering the graph a bit more. Basically the graph would stil be contained in a perfect frame.
//also use 5/3 ratio for a more widescreen look
//add a user-icon (google material kit icon) that works as a dropdown menu, where you can select users and compare commit linegraphs that then gets different colors (should also be able to filter commits & codeLine.additions & codeLine.deletions), also filter project via repo browser.



/**
 * the values are the collected values from 1 to end of month
 */
/*
class YearGraph:Graph{
    override var hValNames:[String] {return ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]}
    override var hValues:[CGFloat] {return [14,8,13,17,25,9,14,20,33,25,15,19]}
}
*/
/*
class WeekGraph:Graph{
    override var hValues:[CGFloat] {return [4,2,3,7,5,0,1]}
    override var hValNames:[String] {return ["M","T","W","T","F","S","S"]}
}
*/

/*


class MonthGraph:Graph{
    override var hValues:[CGFloat] {
        var arr:[CGFloat] = []
        for _ in 0..<numOfDaysInMonth{
            let val:CGFloat = NumberParser.random(4, 24).cgFloat//generate hValues via random
            arr.append(val)
        }
        return arr
    }
    override var hValNames:[String] {
        var arr:[String] = []
        for i in 1...numOfDaysInMonth{//you need 1 until numOfDaysInMonth as hvalnames
            arr.append(i.string)
        }
        return arr
    }
    var numOfDaysInMonth:Int
    var curMonth:Int
    init(_ width: CGFloat, _ height: CGFloat,_ curMonth:Int, _ parent: IElement?, _ id: String? = nil) {
        self.curMonth = curMonth
        let date:NSDate = NSDate.createDate(nil,4)!
        numOfDaysInMonth = date.numOfDaysInMonth
        
        super.init(width, height, parent, id)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

*/
//day,week,month,year,all (focus on day and week)
//12a 1a 2a 3a 4a 5a 6a 7a 8a 9a 10a 11a 12p 1p 2p 3p 4p 5p 6p 7p 8p 9p 10p 11p
//00:00, 01:00, 02
//00,02,04,06,08,10,12,14,16,18,20,22,24 (12 part time)
//00:00,04:00,08:00,12:00,16:00,20:00 ()
//00,04,08,12,16,20 (6 part time)

//Night 00, Morning 06, Noon 12, evening: 18 night 00

//00,03,06,09,12,15,18,21,00
//12a,03a,06a,09a,12a,03p,06p,09p,12a

