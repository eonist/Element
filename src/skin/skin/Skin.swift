import Foundation
/*
* @Note  having seperate values: hasStyleChanged and :hasSizeChanged and hasSkinState changed is usefull for optimization
* TODO: possibly add setPosition();
* TODO: a sleeker way to refresh the skin is needed for now we use setState(SkinStates.NONE)
* TODO: look to cssedit which takes priority the htm set width or the css set width?
*/
class Skin:ISkin{
    var decoratable:IDecoratable?
    var style:IStyle?
    var state:String
    var width:Int?;
    var height:Int?;
    var element:IElement?
    var hasStyleChanged:Bool = false;
    var hasStateChanged:Bool = false;
    var hasSizeChanged:Bool = false;
    init(_ style:IStyle? = nil, _ state:String = "", _ element:IElement? = nil){
        self.style = style;
        self.state = state;
        self.element = element;
        width = element!.width;// :TODO: is this necassary?
        height = element!.height;// :TODO: is this necassary?
    }
    /**
    * Resets skinState
    */
    func draw(){
        hasStyleChanged = false;
        hasSizeChanged = false;
        hasStateChanged = false;
    }
    /**
     * Sets the style instance to apply to the skin also forces a redraw.
     * @Note this is a great way to update an skin without querying StyleManager
     */
    func setStyle(style:IStyle){
        hasStyleChanged = true;
        self.style = style;
        draw();
    }
    /**
     * sets the skin state and forces a redraw
     * @Note forces a lookup of the style in the StyleManager, since it has to look for the correct state of the style
     */
    func setState(state:String){
        hasStateChanged = true;
        self.state = state;
        style = StyleResolver.style(element!)/*looping through the entire styleManager isnt a good idea for just a state change*/
        draw();
    }
    /**
     * Sets the width and height of skin also forces a redraw.
     * @Note similar to setStyle, this does not querry the styleManger when called
     */
    func setSize(width:Int, height:Int){
        fatalError("not implemented yet")
    }
}