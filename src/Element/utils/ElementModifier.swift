import Cocoa

class ElementModifier {
    /**
     * Changes the visibility of PARAM: element by PARAM: isVisible
     * // :TODO: what if the state changes? then the StyleManager is queried again and the current display state wont work
     */
    static func hide(_ element:IElement,_ isVisible:Bool) {
        let display:String = isVisible ? "" : CSSConstants.none
        element.skin!.setStyle(StyleModifier.clone(element.skin!.style!))/*This is a temp fix, an original style must be applied to every skin*/
        var styleProperty:IStyleProperty? = element.skin!.style!.getStyleProperty("display")
        if styleProperty != nil {
            styleProperty!.value = display
        }else{
            element.skin!.style!.addStyleProperty(StyleProperty("display", display))
        }
        element.skin!.setStyle(element.skin!.style!)
    }
    static func hideAll(_ elements:[IElement],_ exception:IElement) {
        for element : IElement in elements {ElementModifier.hide(element, (element === exception))}  
    }
    static func hideChildren(_ view:NSView,_ exception:IElement) {
        let elements:[IElement] = ElementParser.children(view,IElement.self)
        hideAll(elements, exception)
    }
    /**
     * IMPORTANT: ⚠️️ Refreshing the skin also calls StyleResolver.resolve which is an expensive call. because it have to parse through StyleManger for the correct Style
     */
    static func refreshSkin(_ element:IElement){
        ElementModifier.refresh(element, Utils.setSkinState)
    }
    /**
     * IMPORTANT: ⚠️️ Refreshing style is cheaper than calling refresh skin
     */
    static func refreshStyle(_ element:IElement){
        ElementModifier.refresh(element, Utils.setStyle)
    }
    /**
     * Refreshes many elements in PARAM: displayObjectContainer
     * // :TODO: skin should have a dedicated redraw method or a simple workaround
     * NOTE: keep in mind that this can be Window
     */
    private static func refresh(_ element:IElement, _ method: (IElement)->Void = Utils.setStyle) {//<--setStyle is the default param method
        guard let display:String = element.skin!.style!.getStyleProperty("display") as? String, display == CSSConstants.none else{return}/*Skip refreshing*/
        method(element)//apply the method
        if let container:NSView = element as? NSView{//element is Window ? Window(element).view : element as NSView;
            container.subviews.forEach{
                if let child = $0 as? IElement{
                    refresh(child,method)/*<--this line makes it recursive*/
                }
            }
        }else{fatalError("element is not NSView")}
    }
    /**
     * Resizes many elements in PARAM: view
     * // :TODO: rename to Resize, its less ambigiouse
     */
    static func size(_ view:NSView,_ size:CGPoint) {
        view.subviews.forEach{
            if($0 is IElement) {($0 as! IElement).setSize(size.x, size.y)}
        }
    }
    /**
     * NOTE: refloats PARAM: view children that are of type IElement
     * NOTE: i.e: after hideing of an element, or changing the depth order etc
     */
    static func floatChildren(_ view:NSView) {
        view.subviews.forEach{
            if($0 is IElement) {
                //Swift.print("text: " + "\((child as! SelectTextButton).getText())")
                SkinModifier.float(($0 as! IElement).skin!)
            }
        }
    }
}
private class Utils{
    static func setStyle(_ element:IElement){
        element.skin!.setStyle(element.skin!.style!)/*Uses the setStyle since its faster than setSkin*/
    }
    /**
     * This operated directly on the skin before as the element.setSkinState may be removed in the future
     */
    static func setSkinState(_ element:IElement){
        element.skin!.setSkinState(element.skin!.state)/*<-- was SkinStates.none but re-applying the same skinState is a better option*/
    }
}
