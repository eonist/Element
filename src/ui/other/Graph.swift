import Cocoa

class Graph:Element {
    var hValues:[Int] = [0,2,7,1,4,0,3]
    var hValNames:[String] = ["A,B,C,D,E,F,G"]/*horizontal items*/
    var vCount:Int = 4/*number of vertical items*/
    var leftBar:Section?
    var bottomBar:Section?
    var graphArea:Section?
    var graphLine:GraphLine?
    override func resolveSkin() {
        /*LeftBar*/
        leftBar = Section(NaN,NaN,self,"leftBar")//create left bar
        
        var maxValue:Int = IntParser.max(hValues)
        let itemHeight:CGFloat = height/vCount.cgFloat
        if(NumberAsserter.odd(maxValue.cgFloat)){
            maxValue += 1//We need even values when we devide later
        }
        for i in (0..<vCount).reverse() {
            var num:CGFloat = ((maxValue/vCount)*i).cgFloat
            num = round(num)//NumberModifier.toFixed(num, 0)
            let str:String = num.string
            let text:Text = Text(NaN,itemHeight,str,leftBar!)
            leftBar!.addSubView(text)
        }
        
        bottomBar = Section(NaN,NaN,self,"bottomBar")//create bottom bar
        let hCount = hValNames.count
        let itemWidth:CGFloat = width/hCount.cgFloat
        for i in 0..<hCount{
            let str:String = hValNames[i]
            let text:Text = Text(itemWidth,NaN,str,bottomBar!)
            bottomBar!.addSubView(text)
        }
        
        graphArea = Section(NaN,NaN,self,"graphArea")
        
        var graphPoints:[CGPoint] = []
        
        for i in 0..<hCount{
            var p = CGPoint()
            p.x = i * itemWidth
            p.y = hValues[i] * itemHeight
            graphPoints.append(p)
        }
        
        let graphPath:IPath = PolyLineGraphicUtils.path(points)/*convert points to a Path*/
        graphLine = GraphLine(width,height)
        
        //Graph.swift component
            //The graph drawing:
                //calc the graphPoints:
                    //use the vSpace and hSpace
                    //hCount.forEach
                    //points += (x:hSpace*i,y:vSpace*timeArr[i].count)
                //line
                    //use PathGraphic w/ PathParser.points(graph points)
                //Points
                    //graphPoints.forEach
                        //create Button#graph
                        //style the button similar to VolumSlider knob (find isnp for this in ios)
                        //set the size as 12px and offset to -6 (so that its centered)
    }
    /**
     * Aligns UI elements
     * NOTE: we align/scale everything dynamically not via css
     */
    func align(){
        //align things, remember constraints
        
        //4:3 layout ratio
        let h:CGFloat = round((w/4)*3)
        
        var leftBarPos:CGPoint = CGPoint(0,0)
        leftBarPos.y = (height-h)/2
        var bottomBarPos:CGPoint = CGPoint(0,0)
        bottomBarPos.y = height//we use offset in css to move it back into the visible area
        leftBar!.setPosition(leftBarPos)
        bottomBar!.setPosition(bottomBarPos)
        
    }
}
class GraphLine:Element{
    var line:PathGraphic?//<--we could also use PolyLineGraphic, but we may support curvey Graphs in the future
    var path:IPath
    init(_ width: CGFloat, _ height: CGFloat,_ path:IPath, _ parent: IElement?, _ id: String?) {
        self.path = path
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        skin = SkinResolver.skin(self)//you could use let style:IStyle = StyleResolver.style(element), but i think skin has to be created to not cause bugs 
        //I think the most apropriate way is to make a custom skin and add it as a subView wich would implement :ISkin etc, see TextSkin for details
        //Somehow derive the style data and make a basegraphic with it
        let lineStyle:ILineStyle = StylePropertyParser.lineStyle(skin!)!
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
