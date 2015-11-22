import Cocoa
/**
 * NOTE: it seems NSViews arent drawn until their NSView parent gets the drawRect call (Everything is drawn in one go)
 */
class Element:View,IElement {
    var skinState:String = SkinStates.none
    var skin:ISkin?
    /*
    var x:CGFloat = 0;
    var y:CGFloat = 0;
    var width:Double?
    var height:Double?
    */
    var parent : IElement?
    var id : String?;/*css selector id*/
    var style:IStyle = Style.clear
    init(_ width: CGFloat, _ height: CGFloat, _ parent:IElement? = nil,_ id:String? = nil){
        self.parent = parent;
        self.id = id;
        super.init(frame: NSRect(0,0,width,height))
        resolveSkin()/*This cant be moved to init because the CGContext cant be found*/
    }
    /**
     * Draws the graphics
     * TODO: does nsview have a protocol which IElement then can use
     * NOTE: this method is embedded in an extension so that class one can add functionality to Classes that cant extend Element (like NSButton)
     */
    func resolveSkin() {
        //Swift.print("resolveSkin: " + "\(String(self))")
        self.skin = SkinResolver.skin(self)
        self.addSubview(self.skin as! NSView)
    }
    /**
     * @Note this is the function that we need to toggle between css style sheets and have them applied to all Element instances
     * TODO: explain the logic of havong this var in this class and also in the skin class, i think its because you need to access the skinstate before the skin is created or initiated in the element.
     */
    func getSkinState() -> String {// :TODO: the skin should have this state not the element object!!!===???
        return skinState;
    }
    /**
     * Sets the current state of the button, which determins the current drawing of the skin
     * TODO: this can be moved to an util class
     * NOTE: you cant name this method to setSkinState because this name will be occupied if you have a variable named skinState
     */
    func applySkinState(state:String) {
        skin!.applySkinState(state);
    }
    
    /**
     * Returns the class type of the Class instance
     * @Note if a class subclasses Element that sub-class will be the class type
     * @Note override this function in the first subClass and that subclass will be the class type for other sub-classes
     */
    func getClassType()->String{
        return String(self.dynamicType)
    }
    /**
     * Required by NSView
     */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension IElement {
    var width:CGFloat {return self.frame.width}
    var height:CGFloat {return self.frame.height}
    /**
     *
     */
    func getParent()->IElement? {// :TODO: beta
        //Swift.print("_parent: " + _parent);
        return self.parent;
    }
    /**
     * Positions the Element instance to @param point,
     * TODO: this could also be move to an utils class
     */
    func setPosition(point:CGPoint){
        /*
        self.x = point.x;
        self.y = point.y;
        */
        
        frame.x = point.x
        frame.y = point.y
    }
}

extension Element{
    /**
     *
     */
    convenience init(_ width: CGFloat , _ height: CGFloat , _ x:CGFloat , _ y:CGFloat , _ parent:IElement? = nil,_ id:String? = nil){
        self.init(width,height,parent,id)
        setPosition(CGPoint(x,y))
    }
}
/*
override func updateLayer() {
Swift.print("updateLayer")
//resolveSkin()//extension method that draws the graphics
}
*/
//self.layer = CALayer() // Set view to be layer-hosting:
//self.wantsLayer = true//need for the updateLayer method to be called internally, if set to true the drawRect call wont be called
//needsDisplay = true
//layerContentsRedrawPolicy = NSViewLayerContentsRedrawPolicy.OnSetNeedsDisplay //// :TODO: whats this?

//let theLayer:CALayer