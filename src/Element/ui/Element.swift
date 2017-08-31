import Cocoa
@testable import Utils
/**
 * This class serves as a base class for the Element GUI framework
 * NOTE: It seems NSViews aren't drawn until their NSView parent gets the drawRect call (Everything is drawn in one go)
 * NOTE: Currently we use InteractiveView, we could complicate things by making it only extend View, but for simplicity we use InteractiveView. (Optimization may be required, thus this may be revocated and maybe we will make a method named InteractiveElement etc.)
 * NOTE: Subclasing over 1 or 2 deep is hard so try to simplify the dependencies !KISS!
 * NOTE: w,h,x,y are stored in the frame instance
 * TODO: ⚠️️ The width,height,x,y could be stored in a deeper super class. As it's not related to Styling per se
 * PARAM state get: This is the function that we need to toggle between css style sheets and have them applied to all Element instances
 * PARAM state get: you need to access the skinstate before the skin is created or initiated in the element.
 * PARAM state set: This is used by subclasses to change their apperance when the user hover over an ui etc.
 * PARAM state set: Sets the current state of the button, which determins the current drawing of the skin
 * PARAM frame: you can set size manually or via css, if css is percentage you it looks to parent for size
 * IMPORTANT: ⚠️️ If you want to set a custom parent, you must create the Element,set the parent value, then add the element
 */
class Element:InteractiveView,ElementKind {
    var id:String? /*css selector id, TODO: ⚠️️ Should only be able to be "" not nil*/
    var skinState:String {get {return ""}set {skin?.setSkinState(newValue)}}/*Enables overriding of skinState*///TODO: ⚠️️ this should be an array, and rename to skinState, and try to get rid of the default none state
    var skin:Skinable?
    var uiState:UIState = (isDisabled:false,isFocused:false)
    
    init(size:CGSize = CGSize(0,0),id:String? = nil){
        self.id = id
        var size = size//temp fix, until you remove NaN initializers
        if size.w.isNaN {size.w = 0}//temp fix, until you remove NaN initializers
        if size.h.isNaN {size.h = 0}//temp fix, until you remove NaN initializers
        super.init(frame: NSRect.init(CGPoint(), size))/*<--This check is vital, don't change it if your not planing a big refactor*/
    }
    /**
     * NOTE: default implementation of viewDidMoveToSuperview does nothing, so its safe to override
     * Delays the skin resolving to after it's added to the parent. This enables you to not pass the parent on init
     * NOTE: this method is fired when you remove a view as well. So to only check for adding you have this assert
     * TODO: ⚠️️ remove resolveSkin and just override viewDidMoveToSuperView with guard
     */
    override func viewDidMoveToSuperview() {
//        Swift.print("viewDidMoveToSuperview superview: \(superview)")
        guard superview != nil else {return}
        resolveSkin()
    }
    /**
     * Draws the skin (aka graphics)
     */
    func resolveSkin() {
        self.skin = SkinResolver.skin(self)//don't inline these 2 lines, as you need the ref to skin in the addSubView excecution
        self.addSubview(self.skin as! Skin)
    }
    func setSize(_ width:CGFloat, _ height:CGFloat) {// :TODO: ⚠️️ should probably be set to an abstract fuction returning an error. Maybe not. abstract classes confuses people
        self.skinSize.w = width//<--I'm not sure these are correct? I get that we have to store size somewhere but frame is such a central variable fro appkit
        self.skinSize.h = height
        self.skin?.setSize(width, height)
    }
    /**
     * Returns the class type of the Class instance
     * NOTE: if a class subclasses Element that sub-class will be the class type
     * NOTE: override this function in the first subClass and that subclass will be the class type for other sub-classes
     * NOTE: to return a specific class type: String(TextEditor)
     */
    func getClassType()->String{
        return "\(type(of: self))"
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}/*Required by NSView*/
    //DEPRECATE
    convenience init(_ width:CGFloat, _ height:CGFloat, _ parent:ElementKind? = nil,_ id:String? = nil){//⚠️️ TODO: deprecate this init eventually
//        self.id = id
//        self.skinSize = CGSize(width,height)
        self.init(size: CGSize(width,height), id: id)
        //super.init(frame: NSRect(0,0,width.isNaN ? 0 : width,height.isNaN ? 0 : height))/*<--This check is vital, don't change it if your not planing a big refactor*/
    }
}
