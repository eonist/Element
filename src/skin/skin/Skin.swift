import Foundation


class Skin:ISkin{
    var style:IStyle?
    var state:String
    var element:IElement?
    init(style:IStyle? = nil, state:String = "", element:IElement? = nil){
        self.style = style;
        self.state = state;
        self.element = element;
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
        style = StyleResolver.style(element);/*looping through the entire styleManager isnt a good idea for just a state change*/
        draw();
    }
    /**
     * Sets the width and height of skin also forces a redraw.
     * @Note similar to setStyle, this does not querry the styleManger when called
     */
    func setSize(width:Int, height:Int){
        
    }
}