import Cocoa

class ElementModifier {
    /**
     * Changes the visibility of @param element by @param isVisible
     * // :TODO: what if the state changes? then the StyleManager is queried again and the current display state wont work
     */
    class func hide(element:IElement,_ isVisible:Bool) {
        let display:String = isVisible ? "" : CSSConstants.none
        element.skin!.setStyle(StyleModifier.clone(element.skin!.style!))/*This is a temp fix, an original style must be applied to every skin*/
        var styleProperty:IStyleProperty? = element.skin!.style!.getStyleProperty("display")
        styleProperty != nil ? styleProperty!.value = display : element.skin!.style!.addStyleProperty(StyleProperty("display", display))
        element.skin!.setStyle(element.skin!.style!)
    }
    /**
     *
     */
    class func hideAll(elements:Array<IElement>,_ exception:IElement) {
        for element : IElement in elements {ElementModifier.hide(element, (element === exception))}  
    }
    /**
     * Refreshes many elements in @param displayObjectContainer
     * // :TODO: skin should have a dedicated redraw method or a simple workaround
     * @Note keep in mind that this can be Window
     */
    class func refresh(element:IElement, _ method: (IElement)->Void = Utils.setStyle) {//<--setStyle is the default param method
        if(element.skin!.style!.getStyleProperty("display") != nil && (element.skin!.style!.getStyleProperty("display")!.value as! String) == CSSConstants.none) {return} /*Skip refreshing*/
        let container:NSView = element as! NSView//element is Window ? Window(element).view : element as NSView;
        let numChildren:Int = container.subviews.count
        for (var i : Int = 0; i < numChildren; i++) {//<- you can use a for each loop here maybe?
            let child:NSView = container.subviews[i]
            if(child is IElement) {
                method(child as! IElement)
                if(child.subviews.count > 0) {refresh(child as! IElement,method)}/*<--this line makes it recursive*/
            }
        }
    }
    /*
     * Applies contentsScale to descendants of a view that has been zoomed (so that we avoid pixelation while zooming)
     * NOTE: maybe you can use a method in ElementModifier as it has similar code
     */
    class func zoomDescenants(view:NSView,_ zoom:CGFloat){
        for child in view.subviews{
            if(child is IGraphic){
                let graphicDecoratable:IGraphicDecoratable = child as! IGraphicDecoratable
                let graphic:IGraphic = graphicDecoratable.graphic
                graphic.fillShape.contentsScale = 2.0 * zoom
                graphic.lineShape.contentsScale = 2.0 * zoom
                graphicDecoratable.draw()//Updates the graphic
            }
            if(child.subviews.count > 0) {zoomDescenants(child,zoom)}/*<--this line makes it recursive*/
        }
        
        //if (child is NSView && child.children > 0)
        //zoomDescenants(child)
    }
    /**
     * new
     */
    class func refreshSkin(element:IElement){
        ElementModifier.refresh(element, Utils.setSkinState)
    }
    /**
     * Resizes many elements in @param view
     * // :TODO: rename to Resize, its less ambigiouse
     */
    class func size(view:NSView,_ size:CGPoint) {
        let numChildren:Int = view.subviews.count;
        for (var i : Int = 0; i < numChildren; i++) {
            let child:NSView = view.getSubviewAt(i)
            if(child is IElement) {(child as! IElement).setSize(size.x, size.y)}
        }
    }
    /**
     * @Note refloats @param view children that are of type IElement
     * @Note i.e: after hideing of an element, or changing the depth order etc
     */
    class func floatChildren(view:NSView) {
        //Swift.print("ElementModifier.floatChildren()")
        let numChildren:Int = view.subviews.count;
        for (var i : Int = 0; i < numChildren; i++) {
            let child:NSView = view.subviews[i]
            if(child is IElement) {
                //Swift.print("text: " + "\((child as! SelectTextButton).getText())")
                SkinModifier.float((child as! IElement).skin!)
            }
        }
    }
}
private class Utils{
    class func setStyle(element:IElement){
        element.skin!.setStyle(element.skin!.style!)/*Uses the setStyle since its faster than setSkin*/
    }
    class func setSkinState(element:IElement){
        element.skin!.setSkinState(element.skin!.state)/*<-- was SkinStates.none but re-applying the same skinState is a better option*/
    }
}