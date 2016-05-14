import Cocoa
/**
 * // :TODO: Make the methods more Element cetric less skin centric
 */
class SkinModifier {// :TODO: consider renaming to ElementModifier (or a better name)
    /**
     * Aligns @param view
     */
    class func align(skin:ISkin, _ positional:IPositional,_ depth:Int = 0)->IPositional {
        //Swift.print("SkinModifier.align() positional: " + "\(positional)")
        let offset:CGPoint = StylePropertyParser.offset(skin,depth)
        let padding:Padding = StylePropertyParser.padding(skin,depth)
        let margin:Margin = StylePropertyParser.margin(skin,depth)
        let floatType:String? = SkinParser.float(skin,depth)
        if(floatType == CSSConstants.left || floatType == "" || floatType == nil) { positional.setPosition(CGPoint(margin.left + offset.x, margin.top + offset.y)) }
        else if(floatType == CSSConstants.right) {positional.setPosition(CGPoint(padding.right + margin.right + offset.x, margin.top + padding.top + offset.y))}
        else /*floatType == CSSConstants.NONE*/ {positional.setPosition(CGPoint(margin.left + offset.x/**/, margin.top + offset.y/**/))}// :TODO: this is temp for testing
        return positional
    }
    /**
     * Floats @param skin
     * @Note if clear == "none" no clearing is performed
     * @Note if float == "none" no floating is performed
     * // :TODO: Text instances are inline, button are block (impliment inline and block stuff)
     * // :TODO: Impliment support for box-sizing?!?
     * // :TODO: Add support for hiding the element if its float is none
     * // :TODO: possibly merge floatLeft and clearLeft? and floatRight and clearRight? or have float left/right call the clear calls
     */
    class func float(skin:ISkin){// :TODO: rename since it floats and clears which are two methods, position? // :TODO: move to ElementModifier
        //Swift.print("SkinModifier.float()")
        if(skin.element!.getParent() is IElement == false) {return}/*if the skin.element doesnt have a parent that is IElement skip the code bellow*/// :TODO: this should be done by the caller
        let parent:NSView = skin.element!.getParent(/*true*/) as! NSView/**/
        
        let elementParent:IElement = skin.element!.getParent() as! IElement/**/
        let elements:Array<IElement> = ElementParser.children(parent,IElement.self)
        let index:Int = parent.contains(skin.element as! NSView) ? Utils.elementIndex(parent, skin.element! as! Element) : elements.count/*The index of skin, This creates the correct index even if its not added to the parent yet*/
        let parentTopLeft:CGPoint = SkinParser.relativePosition(elementParent.skin!);/*the top-left-corner of the parent*/
        let parentTopRight:CGPoint = CGPoint(parentTopLeft.x + SkinParser.totalWidth(elementParent.skin!)/*the top-right-corner of the parent*//*was skin.getHeight()*//* - SkinParser.padding(parent.skin).right - SkinParser.margin(parent.skin).right<-these 2 values are beta*/,parentTopLeft.y);
        let leftSiblingSkin:ISkin? = Utils.leftFloatingElementSkin(elements, index)/*the last left floating element-sibling skin*/
        /*
        if(skin.element is Text){
            Swift.print("parentTopLeft: " + "\(parentTopLeft)")
            Swift.print("leftSiblingSkin?.element.y: " + "\(leftSiblingSkin?.element!.y)")
            Swift.print("leftSiblingSkin?.element!: " + "\(leftSiblingSkin?.element!)")
            Swift.print("index: " + "\(index)")
            Swift.print("elements.count: " + "\(elements.count)")
        }
        */
        //if(skin.element!.id == "box2"){/*Swift.print("leftSiblingSkin: " + "\(leftSiblingSkin)")*/}//<--this is how you debug the floating system
        //if(skin is TextSkin){Swift.print("float() leftSiblingSkin.height:" + "\(leftSiblingSkin?.height)" + " clearType: " + "\(clearType)")}//<- or you can debug like this
        let rightSiblingSkin:ISkin? = Utils.rightFloatingElementSkin(elements, index)/*the last right floating element-sibling-skin*/
        let clearType:String? = SkinParser.clear(skin)//TODO:this should be optional as not all Elements will have a clear value in the future
        let floatType:String? = SkinParser.float(skin)
        Utils.float(skin, clearType, floatType, leftSiblingSkin, rightSiblingSkin, parentTopLeft.x, parentTopRight.x)
        Utils.clear(skin, clearType, floatType, leftSiblingSkin, rightSiblingSkin, parentTopLeft.y);
    }
}
/**
 * TODO: You should split some of these methods into sub classes, I think maybe the reason why they are bundled together into one class is because the way the methods are so intertwined
 */
private class Utils{
    /**
     * Clear @param skin to the left, right , both or none
     */
    class func clear(skin:ISkin,_ clearType:String?,_ floatType:String?,_ leftSiblingSkin:ISkin?,_ rightSiblingSkin:ISkin?,_ top:CGFloat){
        if(clearType == CSSConstants.left) {clearLeft(skin,leftSiblingSkin,top)}/*Clear is left*/
        else if(clearType == CSSConstants.right) {clearRight(skin,rightSiblingSkin,top)}/*Clear is right*/
        else if(clearType == CSSConstants.both && (leftSiblingSkin != nil)) {clearBoth(skin,leftSiblingSkin ?? rightSiblingSkin,top)}/*Clear left & right*/
        else if(clearType == CSSConstants.none || clearType == nil) {clearNone(skin, floatType,leftSiblingSkin,rightSiblingSkin, top)}/*Clear is none or null*/
    }
    /**
     * Floats @param skin to the left or right or none
     */
    class func float(skin:ISkin, _ clearType:String?, _ floatType:String?, _ leftSiblingSkin:ISkin?,_ rightSiblingSkin:ISkin?,_ left:CGFloat,_ right:CGFloat) {
        if(floatType == CSSConstants.left) { floatLeft(skin, clearType, leftSiblingSkin, left)}/*Float left*/
        else if(floatType == CSSConstants.right) { floatRight(skin, clearType, rightSiblingSkin, right)}/*Float right*/
    }
    /**
     * Positions @param skin by way of clearing it left
     * @param skin the skin to be cleared
     * @param leftSiblingSkin the skin that is left of skin.element
     * @param top is the y value of the skins parent to align against
     */
    class func clearLeft(skin:ISkin,_ leftSiblingSkin:ISkin?,_ top:CGFloat) {
        
        let y:CGFloat = leftSiblingSkin != nil ? leftSiblingSkin!.element!.y + SkinParser.totalHeight(leftSiblingSkin!) : top
        
        /*if(leftSiblingSkin != nil){
        Swift.print("clearLeft() y: " + "\((leftSiblingSkin!.element as! NSView).frame.y)")
        }*/
        
        skin.element!.y = y
    }
    /**
     * Positions @param skin by way of clearing it right
     * @param skin the skin to be cleared
     * @param rightSiblingSkin the skin that is right of skin.element
     * @param top is the y value of the skins parent to align against
     */
    class func clearRight(skin:ISkin,_ rightSiblingSkin:ISkin?,_ top:CGFloat){
        skin.element!.y = rightSiblingSkin != nil ? rightSiblingSkin!.element!.y + SkinParser.totalHeight(rightSiblingSkin!) : top;
    }
    /**
     *
     */
    class func clearNone(skin:ISkin, _ floatType:String?, _ leftSibling:ISkin?,_ rightSibling:ISkin?,var _ top:CGFloat){
        if(floatType == CSSConstants.left && leftSibling != nil) { top = leftSibling!.element!.y }
        else if(floatType == CSSConstants.right && rightSibling != nil) { top = rightSibling!.element!.y}
        else if(floatType == CSSConstants.none) { top = skin.element!.y}/*0*/
        skin.element!.y = top
    }
    /**
     * Positions @param skin by way of clearing it left & right (both)
     * @param skin the skin to be cleared
     * @param prevSiblingSkin the skin that is previouse of skin.element
     * @param top is the y value of the skins parent to align against
     */
    class func clearBoth(skin:ISkin,_ prevSiblingSkin:ISkin?,_ top:CGFloat){
        skin.element!.y = prevSiblingSkin != nil ? prevSiblingSkin!.element!.y + SkinParser.totalHeight(prevSiblingSkin!) : top;
    }
    /**
     *  Positions @param skin by way of floating it left
     *  @param skin the skin to be floated
     *  @param leftSiblingSkin the skin that is left of skin.element
     *  @param left the x value to align against
     */
    class func floatLeft(skin:ISkin, _ clearType:String?, _ leftSiblingSkin:ISkin?,  var _ left:CGFloat){
        //Swift.print("SkinModifier.floatLeft: " )
        if(leftSiblingSkin != nil && (clearType != CSSConstants.left && clearType != CSSConstants.both)) {left = leftSiblingSkin!.element!.x + SkinParser.totalWidth(leftSiblingSkin!)} /*a previous element-sibling floats left*/
        skin.element!.x = left/*Sets the position of the skin.element*/
    }
    /**
     *  Positions @param skin by way of floating it right
     *  @param skin the skin to be floated
     *  @param rightSiblingSkin the skin that is right of skin.element
     *  @param right the x value to align against
     */
    class func floatRight(skin:ISkin, _ clearType:String?, _ rightSiblingSkin:ISkin?, var _ right:CGFloat){
        /*        if(skin.element!.id == "box1"){
        Swift.print("floatRight right: " + "\(right)")
        Swift.print("SkinParser.totalWidth(skin): " + "\(SkinParser.totalWidth(skin))")
        }
        */
        if(rightSiblingSkin != nil && (clearType != CSSConstants.right && clearType != CSSConstants.both)) {right = rightSiblingSkin!.element!.x}/*a previous element-sibling floats right*/
        skin.element!.x = right - SkinParser.totalWidth(skin)/*Sets the position of the skin.element*/
    }
    /**
     *
     */
    class func elementIndex(parent:NSView,_ element:Element)->Int {
        return ArrayParser.index(ElementParser.children(parent,Element.self), element)
    }
    /**
     *
     */
    class func leftFloatingElementSkin(elements:Array<IElement>,_ index:Int)->ISkin? {
        //Swift.print("leftFloatingElementSkin: index: " + "\(index)")
        let lastIndexOfLeftFloatingElement:Int = Utils.lastIndex(elements, Range(0,index-1), CSSConstants.left);
        return lastIndexOfLeftFloatingElement != -1 ? elements[lastIndexOfLeftFloatingElement].skin : nil;/*the left element-sibling*/
    }
    /**
     * @param index is the index of the skin being floated
     */
    class func rightFloatingElementSkin(elements:Array<IElement>,_ index:Int)->ISkin? {
        let lastIndexOfRightFloatingElement:Int = Utils.lastIndex(elements, Range(0,index-1), CSSConstants.right,exception);
        return lastIndexOfRightFloatingElement != -1 ? elements[lastIndexOfRightFloatingElement].skin! : nil/*the right-sibling-skin*/
    }
    /**
     * Exception method used to fix a problem where Elements would not float correctly to the right if a leftfloating Element that also cleared to the right or both, came before a Right floating Element
     */
    class func exception(skin:ISkin) -> Bool{
        return (SkinParser.float(skin) == CSSConstants.left && (SkinParser.clear(skin) == CSSConstants.right || SkinParser.clear(skin) == CSSConstants.both));
    }
    /**
     * @Note loops backwards
     * @param range is the range within the possible rightfloating skin can be in
     */
    /**/
    class func lastIndex(elements:Array<IElement>,_ range:Range<Int>,_ floatType:String,_ exception:((ISkin)->Bool)? = nil)->Int {
        for(var i:Int = range.end; i >= range.start; i--){
            let skin:ISkin = elements[i].skin!
            if(exception != nil && exception!(skin)) {return -1}
            if(SkinParser.float(skin) == floatType && SkinParser.display(skin) != CSSConstants.none) {return i}
        }
        return -1;
    }
}