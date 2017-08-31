import Cocoa
@testable import Utils
/**
 * TODO: ⚠️️ For the sake of optiomization, TextSkin should not extend Skin, but rather extend NSText. Less views means better speed
 * TODO: ⚠️️ Probably disable ineteractivity when using TextSkin ?
 * TODO: ⚠️️ Add support for disabling interactivty via css: mouseEnabled:true; or alike
 * TODO: ⚠️️ Add support for leading via css like: leading:2px;<--This requires some research effort as an atempt to solve this before yielded nothing (2-3H research): This has the answer but its very complicated to setup: http://stackoverflow.com/questions/11182735/nstextfield-add-line-spacing
 * TODO: ⚠️️ Use NSTextField.init(labelWithAttributedString: ) this way you dont have to set it later
 */
class TextSkin:Skin,TextSkinable{
    lazy var textFormat:TextFormat = StylePropertyParser.textFormat(self)/*Creates the textFormat*/
    lazy var textField:NSTextField =  {
//        let textField = TextField.editableTextField()
        let textField = TextField.textField(textFormat:textFormat)
        return addSubView(textField)/*the bellow variable is a little more complex in the legacy code*/
    }()
//    override var skinSize:CGSize? {
//        get{return CGSize(textField.frame.size.width,super.skinSize?.height ?? 0)}
//        set{
//            guard var _size = newValue else {fatalError("err")}//quick fix for bug in Skin
//            textField.frame.size.width = _size.w.isNaN ? 0 : _size.w
//            super.skinSize?.height = _size.h.isNaN ? 0 : _size.h
//        }
//    }// :TODO: ⚠️️ make a similar funciton for getHeight, based on needed space for the height of the textfield
    var hasTextChanged:Bool = true/*<-Why is is this true by default?*/
    let initText:String
    init(_ style:Stylable, _ text:String, _ state:String = SkinStates.none){
        self.initText = text
        
        super.init(style, state)
        
    }
    /**
     * Sort of like resolveSkin
     */
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        guard superview != nil else {return}/*this method is fired when you remove a view as well. So to only check for adding you have this assert*/
//        Swift.print("skinSize: " + "\(skinSize)")
//        Swift.print("super.skinSize: " + "\(super.skinSize)")
//        Swift.print("getWidth(): " + "\(getWidth())")
//        Swift.print("getHeight(): " + "\(getHeight())")
        textField.stringValue = initText//this shouldnt be needed
        applyProperties(textField)
        SkinModifier.float(self)
        _ = SkinModifier.align(self, textField)
        textField.isHidden = SkinParser.display(self) == CSS.Align.none//TODO: might need to add this to when you setSkinState as well.
    }
    /**
     * TODO: ⚠️️ This method needs some refactoring
     */
    override func draw() {
        if hasChanged.size || hasChanged.state || hasChanged.style || hasTextChanged {
            SkinModifier.float(self)
            if hasChanged.size {
                let padding:Padding = StyleMetricParser.padding(self)
                let w = getWidth()//StyleMetricParser.width(self) ?? {fatalError("err")}()
                let h = getHeight()//StyleMetricParser.height(self) ?? {fatalError("err")}()
                let size = CGSize(w + padding.left + padding.right, h + padding.top + padding.bottom)
                Swift.print("TextSkin.draw.size: " + "\(size)")
                textField.frame.size = size//TextFieldModifier.size(textField, size)
            }
            if hasChanged.size || hasChanged.state || hasChanged.style || hasTextChanged/*<--recently added*/ {applyProperties(textField)}
            if hasTextChanged {hasTextChanged = false}
            _ = SkinModifier.align(self, textField)
        }
        super.draw()
    }
    /**
     * TODO: ⚠️️ Make a similar funciton for getHeight, based on needed space for the height of the textfield
     */
    func getWidth() -> CGFloat {
        if StylePropertyParser.value(self, TextFormat.Key.wordWrap) == nil {/*if the wordWrap is false the the width of the skin is equal to the width of the textfield (based on needed space for the text)*/
            let padding:Padding = StyleMetricParser.padding(self)
            return textField.frame.size.width + padding.left + padding.right//swift 3 update happened
        }else {//temp, remove eventually
            let w = StyleMetricParser.width(self) /*?? self.skinSize?.width*/ ?? {fatalError("getWidth not available")}()
            if w.isNaN || w == 0 {fatalError("err w: \(w)")}
            return w
        }
    }
    /**
     * New
     */
    func getHeight() -> CGFloat{
        return StyleMetricParser.height(self) ?? parent?.frame.height ?? {()->CGFloat in fatalError("err")}()
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}


