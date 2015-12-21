import Cocoa
/*
* @Note  having seperate values: hasStyleChanged and :hasSizeChanged and hasSkinState changed is usefull for optimization
* TODO: possibly add setPosition();
* TODO: a sleeker way to refresh the skin is needed for now we use setState(SkinStates.NONE)
* TODO: look to cssedit which takes priority the htm set width or the css set width?
*/
class Skin:FlippedView,ISkin{
    var decoratable:IGraphicDecoratable!
    var style:IStyle?
    var state:String
    var width:CGFloat?;
    var height:CGFloat?;
    var element:IElement?
    var hasStyleChanged:Bool = false;
    var hasStateChanged:Bool = false;
    var hasSizeChanged:Bool = false;
    //override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    //override var wantsUpdateLayer:Bool {return true}
    init(_ style:IStyle? = nil, _ state:String = "", _ element:IElement? = nil){
        
        self.style = style;
        self.state = state;
        self.element = element;
        
        width = element!.width;// :TODO: is this necassary?
        //Swift.print("element!.width" + "\(element!.width)")
        height = element!.height;// :TODO: is this necassary?
        //Swift.print("element!.width: " + "\(element!.width)")
        super.init(frame: NSRect(x: 0, y: 0, width: element!.width/*+2.0*/, height: element!.height/*+2.0*/))/*this used to be a generic size, but since wants deault clipping doesnt work anymore we have to set this size to something as big as the skin needs to be*/
        self.wantsLayer = true/*if true then view is layer backed*/
        layer = CALayer()/*needs to be layer-hosted so that we dont get clipping of children*/
        layer!.masksToBounds = false//this is needed!!!
    }
    /**
     * Required by super class
     */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /**
     * Resets skinState
     */
    func draw(){
        //Swift.print("Skin.draw() refresh the graphics")
        hasStyleChanged = false;
        hasSizeChanged = false;
        hasStateChanged = false;
        needsDisplay = true//Refereshes the graphics , THIS IS NEW!!!
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
    
    
    
    //TODO:rename to set_skinState() and blame swift for the underscore
    
    
    func setSkinState(state:String){
        //Swift.print("Skin.applySkinState")
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
    /**
     *
     */
    override func hitTest(aPoint: NSPoint) -> NSView? {
        return nil
    }
}