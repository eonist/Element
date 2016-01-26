import Cocoa
/**
 * // :TODO: Make the methods more Element cetric less skin centric
 */
class SkinModifier {
    /**
     * Aligns @param view
     */
    class func align(skin:ISkin, _ positional:IPositional,_ depth:Int = 0)->IPositional {
        //Swift.print("SkinModifier.align() positional: " + "\(positional)")
        //var offset:CGPoint = StylePropertyParser.offset(skin,depth);
        //var padding:Padding2 = StylePropertyParser.padding(skin,depth);
        let margin:Margin = StylePropertyParser.margin(skin,depth);
        //var floatType:String = SkinParser.float(skin,depth);
        //if(floatType == CSSConstants.LEFT || floatType == "" || floatType == null) DisplayObjectModifier.position(displayObject, new Point(margin.left + offset.x, margin.top + offset.y));
        //else if(floatType == CSSConstants.RIGHT) DisplayObjectModifier.position(displayObject, new Point(padding.right + margin.right + offset.x, margin.top + padding.top + offset.y));
        //else /*floatType == CSSConstants.NONE*/
        
        positional.setPosition(CGPoint(margin.left/* + offset.x*/, margin.top/* + offset.y*/))// :TODO: this is temp for testing
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
    class func float(skin:Skin){// :TODO: rename since it floats and clears which are two methods, position? // :TODO: move to ElementModifier
        
        if(skin.element!.getParent() is IElement == false) {return}/*if the skin.element doesnt have a parent that is IElement skip the code bellow*/// :TODO: this should be done by the caller
        let parent:NSView = skin.element!.getParent(/*true*/) as! NSView/**/
        //Swift.print("parent: " + parent);
        let elementParent:IElement = skin.element!.getParent() as! IElement/**/
        //Swift.print("elementParent: " + elementParent);
        let elements:Array<IElement> = ElementParser.children(parent,IElement.self)
        
        let index:Int = parent.contains(skin.element as! NSView) ? Utils.elementIndex(parent, skin.element!) : elements.count/*The index of skin, This creates the correct index even if its not added to the parent yet*/
        Swift.print("index: " + "\(index)")
        let parentTopLeft:CGPoint = SkinParser.relativePosition(elementParent.skin!);/*the top-left-corner of the parent*/
        //			if(skin is TextSkin) trace("topLeft: " + topLeft);
        let parentTopRight:CGPoint = CGPoint(parentTopLeft.x + SkinParser.totalWidth(elementParent.skin!)/*the top-right-corner of the parent*//*was skin.getHeight()*//* - SkinParser.padding(parent.skin).right - SkinParser.margin(parent.skin).right<-these 2 values are beta*/,parentTopLeft.y);
        Swift.print("parentTopRight: " + "\(parentTopRight)")
        let leftSiblingSkin:ISkin = Utils.leftFloatingElementSkin(elements, index)!;/*the last left floating element-sibling skin*/
        Swift.print("leftSiblingSkin: " + "\(leftSiblingSkin)")
        let rightSiblingSkin:Skin = Utils.rightFloatingElementSkin(elements, index);/*the last right floating element-sibling-skin*/
        Swift.print("rightSiblingSkin: " + "\(rightSiblingSkin)")
        //if(skin.element.id == "four") trace("rightSiblingSkin: " + rightSiblingSkin);
        
        
        
        //continue here: check your research for Range. You need to work with Int range. 
        //also check your research for using methods as arguments
        
    }
}
private class Utils{
    /**
     *
     */
    class func elementIndex(parent:NSView,_ element:IElement)->Int {
        return parent.subviews.indexOf(element as! NSView)!
    }
    /**
     *
     */
    class func leftFloatingElementSkin(elements:Array<IElement>,_ index:Int)->ISkin? {
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
            //if(exception != null && exception(skin)) return -1;
            if(SkinParser.float(skin) == floatType && SkinParser.display(skin) != CSSConstants.none) {return i}
        }
        return -1;
    }
}


/*thingToDo: (Int)->Int*/

