import Cocoa

class Graph:Element {
    var hValues:[CGFloat] {return [4,2,3,7,5,0,1]}
    var hValNames:[String] {return ["A","B","C","D","E","F","G"]}/*horizontal items*/
    
    var vCount:Int = 5/*number of vertical indicators*/
    var leftBar:Section?
    var bottomBar:Section?
    var graphArea:Section?
    var graphLine:GraphLine?
    var graphPoints:[Element] = []
    override func resolveSkin() {
        super.resolveSkin()
       
        //Continue here: try making DayGraph which has Day names (remember to return Graph as identifier)
        //contemplate removing the top value and centering the graph a bit more. Basically the graph would stil be contained in a perfect frame.
        //also use 5/3 ratio for a more widescreen look
        //add a user-icon (google material kit icon) that works as a dropdown menu, where you can select users and compare commit linegraphs that then gets different colors (should also be able to filter commits & codeLine.additions & codeLine.deletions), also filter project via repo browser.
        
        let newSize:CGSize = Resizer.fit(CGSize(w,h),4/3)
        //Swift.print("newSize: " + "\(newSize)")
        let newPostition:CGPoint = Align.alignmentPoint(newSize, CGSize(width/**/,height/**/), Alignment.centerCenter, Alignment.centerCenter,CGPoint(0,0))
        //Swift.print("newPostition: " + "\(newPostition)")
        
        createGraphArea(newSize,newPostition)
        let spaceData = createLeftBar(newSize,newPostition)
        let itemYSpace:CGFloat = spaceData.itemYSpace
        let itemXSpace:CGFloat = createBottomBar(newSize,newPostition)
        let spacing:CGSize = CGSize(itemXSpace,itemYSpace)
        
        createVLines(newSize,newPostition,spacing)
        
        let graphPts = GraphUtils.points(newSize, newPostition, spacing, hValues,spaceData.maxValue)
        createGraphLine(newSize,newPostition,spacing,graphPts)
        createGraphPoints(newSize,newPostition,spacing,graphPts)
        
        //alignUI()
    }
    /**
     *
     */
    func createGraphArea(size:CGSize,_ position:CGPoint){
        graphArea = addSubView(Section(size.width,size.height,self,"graphArea"))
        graphArea?.setPosition(position)
    }
    /**
     *
     */
    func createLeftBar(size:CGSize,_ position:CGPoint)->(itemYSpace:CGFloat,maxValue:CGFloat){
        leftBar = addSubView(Section(NaN,size.height,self,"leftBar"))//create left bar
        leftBar!.setPosition(CGPoint(0,position.y))
        
        var maxValue:CGFloat = NumberParser.max(hValues)//you need to map these and ceil them. as you need int values!?!?
        //Swift.print("maxValue: " + "\(maxValue)")
        let itemYSpace:CGFloat = size.height/(vCount.cgFloat+1)
        //Swift.print("itemYSpace: " + "\(itemYSpace)")
        if(NumberAsserter.odd(maxValue)){
            maxValue += 1//We need even values when we devide later
        }
        //Swift.print("maxValue: " + "\(maxValue)")
        var y:CGFloat = itemYSpace
        for i in (0..<vCount).reverse() {
            //Swift.print("i: " + "\(i)")
            var num:CGFloat = (maxValue/(vCount.cgFloat-1))*i
            //Swift.print("num: " + "\(num)")
            num = round(num)//NumberModifier.toFixed(num, 1)//
            let str:String = num.string
            let textArea:TextArea = TextArea(NaN,NaN,str,leftBar!)
            leftBar!.addSubView(textArea)
            textArea.setPosition(CGPoint(0,y))
            y += itemYSpace
            //Tip: use skin.getWidth() if you need to align Element items with Align 
        }
        return (itemYSpace:itemYSpace,maxValue:maxValue)
    }
    /**
     *
     */
    func createBottomBar(size:CGSize,_ position:CGPoint)->CGFloat{
        //Swift.print("createBottomBar")
        //Swift.print("size: " + "\(size)")
        //Swift.print("position: " + "\(position)")
        bottomBar = addSubView(Section(size.width,NaN,self,"bottomBar"))//create bottom bar
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
            bottomBar!.addSubView(textArea)
            //Swift.print("CGPoint(x,0): " + "\(CGPoint(x,0))")
            textArea.setPosition(CGPoint(x,0))
            x += itemXSpace
        }
        return itemXSpace
    }
    /**
     *
     */
    func createGraphPoints(size:CGSize,_ position:CGPoint,_ spacing:CGSize, _ graphPts:[CGPoint]){
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
    
    func createGraphLine(size:CGSize,_ position:CGPoint,_ spacing:CGSize, _ graphPts:[CGPoint]){
        let graphPath:IPath = PolyLineGraphicUtils.path(graphPts)/*convert points to a Path*/
        graphLine = graphArea!.addSubView(GraphLine(width,height,graphPath,graphArea))
        
    }
    /**
     *
     */
    func createVLines(size:CGSize,_ position:CGPoint,_ spacing:CGSize){
        let count:Int = hValNames.count
        var x:CGFloat = spacing.width
        for _ in 0..<count{
            let vLine = graphArea!.addSubView(Element(NaN,size.height-(spacing.height*2),graphArea,"vLine"))
            vLine.setPosition(CGPoint(x,spacing.height))
            x += spacing.width
        }
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
        let alignmentPoint:CGPoint = Align.alignmentPoint(CGSize(graphArea!.frame.width,graphArea!.frame.height), CGSize(width/**/,height/**/), Alignment.centerCenter, Alignment.centerCenter,CGPoint(0,0))
        graphArea?.setPosition(alignmentPoint)
        
    }
  
    override func setSize(width: CGFloat, _ height: CGFloat) {
        //update different UI elements
    }
    
    override func getClassType() -> String {
        return String(Graph)
    }
}
class GraphLine:Element{
    var line:PathGraphic?//<--we could also use PolyLineGraphic, but we may support curvey Graphs in the future
    var path:IPath
    init(_ width: CGFloat, _ height: CGFloat,_ path:IPath, _ parent: IElement? = nil, _ id: String? = nil) {
        self.path = path
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        Swift.print("GraphLine.resolveSkin")
        skin = SkinResolver.skin(self)//you could use let style:IStyle = StyleResolver.style(element), but i think skin has to be created to not cause bugs 
        //I think the most apropriate way is to make a custom skin and add it as a subView wich would implement :ISkin etc, see TextSkin for details
        //Somehow derive the style data and make a basegraphic with it
        let lineStyle:ILineStyle = StylePropertyParser.lineStyle(skin!)!
        //LineStyleParser.describe(lineStyle)
        let baseGraphic = BaseGraphic(nil,lineStyle)
        line = PathGraphic(path,baseGraphic)
        addSubView(line!.graphic)
        line!.draw()
    }
    override func setSkinState(skinState: String) {
        //update the line
    }
    override func setSize(width: CGFloat, _ height: CGFloat) {
        //update the line
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented") }
}
private class GraphUtils{
    /**
     * Returns graph points
     */
    static func points(size:CGSize,_ position:CGPoint,_ spacing:CGSize, _ hValues:[CGFloat], _ maxValue:CGFloat) -> [CGPoint]{
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
}