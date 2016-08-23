import Cocoa
/**
 * This class serves as a base class for the Element GUI framework
 * NOTE: it seems NSViews arent drawn until their NSView parent gets the drawRect call (Everything is drawn in one go)
 * NOTE: Currently we use InteractiveView, we could complicate things by making it only extend View, but for simplicity we use InteractiveView. (Optimization may be required, thus this may be revocated and maybe we will make a method named InteractiveElement etc.)
 * NOTE: subclasing over 1 or 2 deep is hard so try to simplify the dependencies !KISS!
 * NOTE: w,h,x,y are stored in the frame instance
 * TODO: The width,height,x,y could be stored in a deeper super class. As its not related to Styling per se
 */
class Element:InteractiveView2,IElement {
    var width:CGFloat //{get{return super.frame.width}set{super.frame.width = newValue}}
    var height:CGFloat //{get{return super.frame.height}set{super.frame.height = newValue}}
    //var x:CGFloat{get{return super.frame.x}set{super.frame.x = newValue}}
    //var y:CGFloat{get{return super.frame.y}set{super.frame.y = newValue}}
    var state:String = SkinStates.none/*This is protected so that sub-classes can access it when setting the initial state*/
    var skin:ISkin?
    var parent : IElement?
    var id : String?/*css selector id*/
    override var frame:CGRect {get{return CGRect(super.frame.x,super.frame.y,width.isNaN ? 0 : width,height.isNaN ? 0 : height)}set{super.frame = newValue}}/*this allows you to store NaN values in the frame*/
    init(_ width: CGFloat, _ height: CGFloat, _ parent:IElement? = nil,_ id:String? = nil){
        self.parent = parent;
        self.id = id;
        self.width = width
        self.height = height
        super.init(frame: NSRect(0,0,width.isNaN ? 0 : width,height.isNaN ? 0 : height))
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
        return state
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
     * Sets the width and height of the skin and this instance.
     */
    func setSize(width:CGFloat, _ height:CGFloat) {// :TODO: should probably be set to an abstract fuction returning an error. Maybe not. abstract classes confuses people
        /*frame.size*/self.width = width//<--im not sure these are correct? i get that we have to store size somewhere but frame is such a central variable fro appkit
        /*frame.size*/self.height = height
        self.skin!.setSize(width, height)
        //fatalError("Element.setSize() you dont use frame anymore")
    }
    /**
     * 
     */
    func getWidth()->CGFloat{
        return skin != nil ? skin!.getWidth() : CGFloat.NaN
    }
    /**
     *
     */
    func getHeight()->CGFloat{
        return skin != nil ? skin!.getHeight() : CGFloat.NaN
    }
    /**
     * Returns the class type of the Class instance
     * @Note if a class subclasses Element that sub-class will be the class type
     * @Note override this function in the first subClass and that subclass will be the class type for other sub-classes
     * NOTE: to return a specific class type: String(TextEditor)
     */
    func getClassType()->String{
        return String(self.dynamicType)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}/*Required by NSView*/
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