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
 * IMPORTANT: ⚠️️ If you want to set a custom parent, you must create the Element,set the parent value, then add the element
 */
class Element:InteractiveView,ElementKind {
    var parent:ElementKind? {return self.superview is ElementKind ? self.superview as? ElementKind : nil}//TODO: ⚠️️ get rid of parent
    var id:String? /*css selector id, TODO: ⚠️️ Should only be able to be "" not nil*/
    var skinState:String {//TODO: ⚠️️ this should be an array, and rename to skinState, and try to get rid of the default none state
        get {return ""}
        set {skin?.setSkinState(newValue)}
    }
    var skinSize:CGSize
    var skin:Skinable?
    var uiState:UIState = (isDisabled:false,isFocused:false)
    override var frame:CGRect {get{return CGRect(super.frame.x,super.frame.y,skinSize.w.isNaN ? 0 : skinSize.w,skinSize.h.isNaN ? 0 : skinSize.h)}set{super.frame = newValue}}/*this allows you to store NaN values in the frame, TODO: ⚠️️ Should probably be removed */
    
    init(size:CGSize = CGSize(NaN,NaN),id:String? = nil){
        self.id = id
        self.skinSize = size
        super.init(frame: NSRect(0,0,size.width.isNaN ? 0 : size.width,size.height.isNaN ? 0 : size.height))/*<--This check is vital, don't change it if your not planing a big refactor*/
    }
    /**
     * NOTE: default implementation of viewDidMoveToSuperview does nothing, so its safe to override
     * Delays the skin resolving to after its added to the parent. This enables you to not pass the partent on init
     * NOTE: this method is fired when you remove a view as well. So to only check for adding you have this assert
     */
    override func viewDidMoveToSuperview() {
//        Swift.print("viewDidMoveToSuperview superview: \(superview)")
        if superview != nil {resolveSkin()}
    }
    /**
     * Draws the skin (aka graphics)
     */
    func resolveSkin() {
        self.skin = self.addSubView(SkinResolver.skin(self))
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
    init(_ width:CGFloat, _ height:CGFloat, _ parent:ElementKind? = nil,_ id:String? = nil){//⚠️️ TODO: deprecate this init eventually
        self.id = id
        self.skinSize = CGSize(width,height)
        super.init(frame: NSRect(0,0,width.isNaN ? 0 : width,height.isNaN ? 0 : height))/*<--This check is vital, don't change it if your not planing a big refactor*/
    }
}
