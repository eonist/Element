import Foundation
@testable import Utils

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
