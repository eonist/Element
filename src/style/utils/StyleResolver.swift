import Foundation

//Continue here: to bring id into the fold you need to bring in the origional code, atleast take a look

class StyleResolver{
    /**
     * Returns a style comprised of all the styleProperties element inherit from
     * NOTE: creates a list with styles in the styleManger the styles with highest priority goes to the top, then each consequtive style in this priority list is merged into the first one (if a styleProperty exists it is not overriden, all others are added), styles in the stylemanager that has nothing to do with the current cascade are not included in the priorityList
     * // :TODO: should only inherit when property is marked inherit or from * universal selectors!?!?
     */
    class func style2(element:IElement)->IStyle{
        var querrySelectors:Array<ISelector> = ElementParser.selectors(element);// :TODO: possibly move up in scope for optimizing
        let finalStyle:IStyle = Style()
        return finalStyle
    }
    /**
     *
     */
    class func style(element:IElement)->IStyle{
        //let querrySelectors:Array = ElementParser.selectors(element);// :TODO: possibly move up in scope for optimizing
        //Swift.print("STACK: " + SelectorParser.string(querrySelectors));
        var styleComposition:IStyle = Style("styleComp")
        //let classType:String = element.getClassType()//gets the classtype from the component
        let querrySelector:ISelector = ElementParser.selector(element);// :TODO: possibly move up in scope for optimizing

        //Swift.print("styleComposition")
        //Swift.print(StyleManager.styles.count)
        for style in StyleManager.styles{//loop through styles
            //Swift.print("style.selector.element: " + style.selector.element)
            for selector in style.selectors{
                if(selector.element == querrySelector.element){ //if style.selector == classType
                    //Swift.print("  element match found")
                    if(selector.states.count > 0){
                        for state in selector.states{//loop style.selector.states
                            //Swift.print("state: " + state)
                            //Swift.print("element.skinState: " + element.skinState)
                            for s in querrySelector.states{
                                if(state == s){//if state == any of the current states TODO: figure out how the statemaschine works and impliment that
                                    //Swift.print("    state match found")
                                    StyleModifier.combine(&styleComposition, style)//gracefully append this style to styleComposition, forced overwrite
                                }
                            }
                        }
                    }else{//temp solution
                        StyleModifier.combine(&styleComposition, style)
                    }
                }
            }
            
        }
        
        //Swift.print("styleComposition.styleProperties.count: " + "\(styleComposition.styleProperties.count)")
        //StyleParser.describe(styleComposition)
        return styleComposition
    }
}