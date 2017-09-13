import Cocoa
@testable import Utils

/**
 * // :TODO: Make the methods more Element cetric less skin centric
 */
class SkinModifier {// :TODO: consider renaming to ElementModifier (or a better name)
    /**
     * Aligns PARAM: view
     * Set the x and y of the decoratable
     * IMPORTANT: ⚠️️ Does not call draw on decoratable, only sets x,y
     */
    static func align(_ skin:Skinable, _ positional:Positional,_ depth:Int = 0)->Positional {
        let offset:CGPoint = StyleMetricParser.offset(skin,depth)
        let padding:Padding = StyleMetricParser.padding(skin,depth)
        let margin:Margin = StyleMetricParser.margin(skin,depth)
        let floatType:String? = SkinParser.float(skin,depth)
        let pos:CGPoint = {
            if floatType == CSS.Align.left || floatType == "" || floatType == nil {
                return CGPoint(margin.left + offset.x, margin.top + offset.y)
            }else if floatType == CSS.Align.right {
                let x:CGFloat = padding.right + margin.right + offset.x
                let y:CGFloat = margin.top + padding.top + offset.y
                return CGPoint(x,y)
            }else /*floatType == CSSConstants.NONE*/ {
                return CGPoint(margin.left + offset.x, margin.top + offset.y)
            }
        }()
        positional.setPosition(pos)
        return positional
    }
    /**
     * Floats PARAM: skin
     * NOTE: if clear == "none" no clearing is performed
     * NOTE: if float == "none" no floating is performed
     * TODO: ⚠️️ Text instances are inline, button are block (impliment inline and block stuff)
     * TODO: ⚠️️ Impliment support for box-sizing?!?
     * TODO: ⚠️️ Add support for hiding the element if its float is none
     * TODO: ⚠️️ possibly merge floatLeft and clearLeft? and floatRight and clearRight? or have float left/right call the clear calls
     */
    static func float(_ skin:Skinable){// :TODO: rename since it floats and clears which are two methods, position? // :TODO: move to ElementModifier
        guard let element = skin.parent as? Element else{fatalError("skin: \(skin) has no element")}
        guard let elementParent = element.superview as? ElementKind else {return}/*if the skin.element doesnt have a parent that is ElementKind skip the code bellow*/// :TODO: this should be done by the caller
        guard let viewParent = element.superview  else{ fatalError("skin has no NSView parent")}
        let siblings:[ElementKind] = ElementParser.children(viewParent,ElementKind.self)//⚠️️ this could clean up this class ⚠️️ -> if ArrayAsserter.has(siblings, element) { _ = ArrayModifier.delete(&siblings, &element) }
        let index:Int = viewParent.contains(element) ? Utils.elementIndex(viewParent, element) : siblings.count/*The index of skin, This creates the correct index even if its not added to the parent yet*/
        guard let parentSkin:Skinable = elementParent.skin else{fatalError("parent: \(elementParent) has no skin")}
        let parentTopLeft:CGPoint = SkinParser.relativePosition(parentSkin)/*the top-left-corner of the parent*/
        let parentTopRight:CGPoint = CGPoint(parentTopLeft.x + SkinParser.totalWidth(parentSkin)/*the top-right-corner of the parent*//*was skin.getHeight()*//* - SkinParser.padding(parent.skin).right - SkinParser.margin(parent.skin).right<-these 2 values are beta*/,parentTopLeft.y);
        let leftSiblingSkin:Skinable? = Utils.leftFloatingElementSkin(siblings, index)/*the last left floating element-sibling skin*/
        let rightSiblingSkin:Skinable? = Utils.rightFloatingElementSkin(siblings, index)/*the last right floating element-sibling-skin*/
        let clearType:String? = SkinParser.clear(skin)//TODO:this should be optional as not all Elements will have a clear value in the future
        let floatType:String? = SkinParser.float(skin)
        Utils.float(skin, clearType, floatType, leftSiblingSkin, rightSiblingSkin, parentTopLeft.x, parentTopRight.x)
        Utils.clear(skin, clearType, floatType, leftSiblingSkin, rightSiblingSkin, parentTopLeft.y)
    }
}
/**
 * TODO: You should split some of these methods into sub classes, I think maybe the reason why they are bundled together into one class is because the way the methods are so intertwined
 */
private class Utils{
    /**
     * Clear PARAM: skin to the left, right , both or none
     */
    static func clear(_ skin:Skinable,_ clearType:String?,_ floatType:String?,_ leftSiblingSkin:Skinable?,_ rightSiblingSkin:Skinable?,_ top:CGFloat){
        if(clearType == CSS.Align.left) {clearLeft(skin,leftSiblingSkin,top)}/*Clear is left*/
        else if(clearType == CSS.Align.right) {clearRight(skin,rightSiblingSkin,top)}/*Clear is right*/
        else if(clearType == CSS.Align.both && (leftSiblingSkin != nil)) {clearBoth(skin,leftSiblingSkin ?? rightSiblingSkin,top)}/*Clear left & right*/
        else if(clearType == CSS.Align.none || clearType == nil) {clearNone(skin, floatType,leftSiblingSkin,rightSiblingSkin, top)}/*Clear is none or null*/
    }
    /**
     * Floats PARAM: skin to the left or right or none
     */
    static func float(_ skin:Skinable, _ clearType:String?, _ floatType:String?, _ leftSiblingSkin:Skinable?,_ rightSiblingSkin:Skinable?,_ leftX:CGFloat,_ rightX:CGFloat) {
        if(floatType == CSS.Align.left) {
            floatLeft(skin, clearType, leftSiblingSkin, leftX)/*Float left*/
        }else if(floatType == CSS.Align.right) {
            floatRight(skin, clearType, rightSiblingSkin, rightX)/*Float right*/
        }
    }
    /**
     * Positions PARAM: skin by way of clearing it left
     * PARAM: skin the skin to be cleared
     * PARAM: leftSiblingSkin the skin that is left of skin.element
     * PARAM: top is the y value of the skins parent to align against
     */
    static func clearLeft(_ skin:Skinable,_ leftSibling:Skinable?,_ top:CGFloat) {
        if let leftSibling = leftSibling {
            skin.parent!.y = leftSibling.parent!.y + SkinParser.margin(leftSibling).ver + SkinParser.height(leftSibling)
        }else {
            skin.parent!.y = top
        }
    }
    /**
     * Positions PARAM: skin by way of clearing it right
     * PARAM: skin the skin to be cleared
     * PARAM: rightSiblingSkin the skin that is right of skin.element
     * PARAM: top is the y value of the skins parent to align against
     */
    static func clearRight(_ skin:Skinable,_ rightSiblingSkin:Skinable?,_ top:CGFloat){
//      Swift.print("⚠️️⚠️️⚠️️ see clearLeft for how to fix this")
        skin.parent!.y = rightSiblingSkin != nil ? rightSiblingSkin!.parent!.y + SkinParser.totalHeight(rightSiblingSkin!) : top
    }
    /**
     *
     */
    static func clearNone(_ skin:Skinable, _ floatType:String?, _ leftSibling:Skinable?,_ rightSibling:Skinable?, _ top:CGFloat){
        skin.parent!.y = {
            if(floatType == CSS.Align.left && leftSibling != nil) { return leftSibling!.parent!.y }
            else if(floatType == CSS.Align.right && rightSibling != nil) { return rightSibling!.parent!.y}
            else if(floatType == CSS.Align.none) { return skin.parent!.y}
            else {return top}
        }()
    }
    /**
     * Positions PARAM: skin by way of clearing it left & right (both)
     * PARAM: skin the skin to be cleared
     * PARAM: prevSiblingSkin the skin that is previouse of skin.element
     * PARAM: top is the y value of the skins parent to align against
     */
    static func clearBoth(_ skin:Skinable,_ prevSiblingSkin:Skinable?,_ top:CGFloat){
        
        Swift.print("⚠️️⚠️️⚠️️ see clearLeft for how to fix this")
        
        skin.parent!.y = prevSiblingSkin != nil ? prevSiblingSkin!.parent!.y + SkinParser.totalHeight(prevSiblingSkin!) : top
    }
    /**
     *  Positions PARAM: skin by way of floating it left
     *  PARAM: skin the skin to be floated
     *  PARAM: leftSiblingSkin the skin that is left of skin.element
     *  PARAM: left the x value to align against
     */
    static func floatLeft(_ skin:Skinable, _ clearType:String?, _ leftSibling:Skinable?,  _ left:CGFloat){
        skin.parent?.x = {
            if let leftSibling = leftSibling, (clearType != CSS.Align.left && clearType != CSS.Align.both) {/*Sets the position of the skin.element*/
                return leftSibling.parent!.x + SkinParser.margin(leftSibling).hor + SkinParser.width(leftSibling)
            };return left/*a previous element-sibling floats left*/
        }()
    }
    /**
     *  Positions PARAM: skin by way of floating it right
     *  PARAM: skin the skin to be floated
     *  PARAM: rightSiblingSkin the skin that is right of skin.element
     *  PARAM: right the x value to align against
     */
    static func floatRight(_ skin:Skinable, _ clearType:String?, _ rightSibling:Skinable?, _ right:CGFloat){
        
        //Swift.print("⚠️️⚠️️⚠️️ see floatLeft for how to fix this")
        
        skin.parent!.x = {
            if let rightSibling = rightSibling , (clearType != CSS.Align.right && clearType != CSS.Align.both) {/*a previous element-sibling floats right*/
                return rightSibling.parent!.x
            };return right - SkinParser.totalWidth(skin)/*Sets the position of the skin.element*/
        }()
    }
    /**
     * NOTE:-1 -> Not found
     */
    static func elementIndex(_ parent:NSView,_ element:Element)->Int {
        return parent.subviews.filter{$0 is Element}.index(where:{$0 === element}) ?? -1// functional programming 🎉, swift4 removed lazy before filter, seems to not work with the "is assert"
    }
    /**
     *
     */
    static func leftFloatingElementSkin(_ elements:[ElementKind],_ index:Int)->Skinable? {
        let lastIndexOfLeftFloatingElement:Int = Utils.lastIndex(elements, 0,index-1, CSS.Align.left)
        return lastIndexOfLeftFloatingElement != -1 ? elements[lastIndexOfLeftFloatingElement].skin : nil/*the left element-sibling*/
    }
    /**
     * PARAM: index is the index of the skin being floated
     */
    static func rightFloatingElementSkin(_ elements:[ElementKind],_ index:Int)->Skinable? {
        let lastIndexOfRightFloatingElement:Int = Utils.lastIndex(elements, 0,index-1, CSS.Align.right,exception)
        return lastIndexOfRightFloatingElement != -1 ? elements[lastIndexOfRightFloatingElement].skin! : nil/*the right-sibling-skin*/
    }
    /**
     * Exception method used to fix a problem where Elements would not float correctly to the right if a leftfloating Element that also cleared to the right or both, came before a Right floating Element
     */
    static func exception(_ skin:Skinable) -> Bool{
        var caseA:Bool {return  SkinParser.float(skin) == CSS.Align.left}
        var caseB:Bool {return SkinParser.clear(skin) == CSS.Align.right}
        var caseC:Bool {return SkinParser.clear(skin) == CSS.Align.both}
        return caseA && caseB || caseC
    }
    /**
     * NOTE: Loops backwards
     * PARAM: Range is the range within the possible rightfloating skin can be in
     * CAUTION: ⚠️️ The reason we don't use range or for in range {} is because the methods that call this doesn't assert for empty arrays. Fix this later. for now the code is clumpsy but works
     */
    static func lastIndex(_ elements:[ElementKind],_ rangeStart:Int,_ rangeEnd:Int,_ floatType:String,_ exception:((Skinable)->Bool)? = nil)->Int {
        var i:Int = rangeEnd
        while i >= rangeStart {
            guard let skin:Skinable = elements[i].skin else {return -1}
            if exception != nil && exception!(skin) {return -1}
            if SkinParser.float(skin) == floatType && SkinParser.display(skin) != CSS.Align.none {
                return i
            }
            i -= 1
        }
        return -1
    }
}
