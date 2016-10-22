import Cocoa

class Graph:Element {
    var hValues:[Int] = [0,2,7,1,4,0,3]
    var hValNames:[String] = ["A,B,C,D,E,F,G"]/*horizontal items*/
    var vCount:Int = 4/*number of vertical items*/
    var leftBar:Section?
    var bottomBar:Section?
    var graphArea:Section?
    var graphLine:GraphLine?
    var graphPoints:[Element] = []
    override func resolveSkin() {
        createGraphElements()
    }
    fu
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
        
        //align the graphPoints
        
    }
    override func setSize(width: CGFloat, _ height: CGFloat) {
        //update different UI elements
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
