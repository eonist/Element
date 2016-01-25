import Cocoa
/**
 * This class serves as a base class for the Element GUI framework
 * NOTE: it seems NSViews arent drawn until their NSView parent gets the drawRect call (Everything is drawn in one go)
 * NOTE: Currently we use InteractiveView, we could complicate things by making it only extend View, but for simplicity we use InteractiveView. (Optimization may be required, thus this may be revocated and maybe we will make a method named InteractiveElement etc.)
 * NOTE: subclasing over 1 or 2 deep is hard so try to simplify the dependencies !KISS!
 * NOTE: w,h,x,y are stored in the frame instance
 */
class Element:InteractiveView,IElement {
    var state:String = SkinStates.none
    var skin:ISkin?
    var parent : IElement?
    var id : String?/*css selector id*/
    var style:IStyle = Style.clear//<---what is clear? and how does it behave?
    init(_ width: CGFloat, _ height: CGFloat, _ parent:IElement? = nil,_ id:String? = nil){
        self.parent = parent;
        self.id = id;
        super.init(frame: NSRect(0,0,width/*+2.0*/,height/*+2.0*/))/*<- this is a temp bug fix*/
        resolveSkin()
    }
    /**
     * Draws the graphics
     * TODO: does nsview have a protocol which IElement then can use
     * NOTE: this method was embedded in an extension so that class one can add functionality to Classes that cant extend Element (like NSButton)
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
        return state;
    }
    /**
     * Sets the current state of the button, which determins the current drawing of the skin
     * TODO: this can be moved to an util class
     * NOTE: you cant name this method to setSkinState because this name will be occupied if you have a variable named skinState
     */
    func setSkinState(state:String) {
        skin!.setSkinState(state);
    }
    /**
     * Returns the class type of the Class instance
     * @Note if a class subclasses Element that sub-class will be the class type
     * @Note override this function in the first subClass and that subclass will be the class type for other sub-classes
     */
    func getClassType()->String{
        return String(self.dynamicType)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}/*Required by NSView*/
}
/**
 * NOTE: some of these methods will probably be moved back into the class
 */
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
     * Sets the width and height of the skin and this instance.
     */
    func setSize(width:CGFloat, _ height:CGFloat) {// :TODO: should probably be set to an abstract fuction returning an error. Maybe not. abstract classes confuses people
        frame.size.width = width
        frame.size.height = height
        self.skin!.setSize(width, height);
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
    /**
    * @Note this function is needed say if a Window is the parent of an Element instance, since Window does not inherit from DisplayObjectContainer we cant use the parent
    * @param isAbsoltuteParent (if you want to get hold of the stage in Window instances use this flag)
    * TODO: I think we should redesign the Window element to act more independently, the window should act as an elment and just use the view as a vessle for the content. test if this is possible ofcourse
    */
    func getParent(isAbsoltuteParent:Bool = false)->Any {// :TODO: beta
        //			trace("_parent: " + _parent);
        if(isAbsoltuteParent) return _parent is Window ? (_parent as Window).stage : _parent;
        return _parent;// == null || isAbsoltuteParent ? (_parent as Window).stage || super.parent:_parent;
    }
    
    
    func getWidth()->CGFloat{
        return skin != nil ? skin!.getWidth() : CGFloat.NaN;
    }
    func getHeight()->CGFloat{
        return skin != nil ? skin!.getHeight() : CGFloat.NaN;
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