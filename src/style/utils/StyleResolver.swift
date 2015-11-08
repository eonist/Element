import Foundation

class StyleResolver{
    /**
     *
     */
    class func style(element:IElement)->IStyle{
        //let querrySelectors:Array = ElementParser.selectors(element);// :TODO: possibly move up in scope for optimizing
        //Swift.print("STACK: " + SelectorParser.string(querrySelectors));
        var styleComposition:IStyle = Style("styleComp")
        let classType:String = element.getClassType()//gets the classtype from the component

        Swift.print("styleComposition")
        //Swift.print(StyleManager.styles.count)
        for style in StyleManager.styles{//loop through styles
            //Swift.print("style.selector.element: " + style.selector.element)
            for selector in style.selectors{
                if(selector.element == classType){ //if style.selector == classType
                    Swift.print("  element match found")
                    for state in selector.states{//loop style.selector.states
                        if(state == element.skinState){//if state == any of the current states TODO: figure out how the statemaschine works and impliment that
                            Swift.print("    state match found")
                            StyleModifier.combine(&styleComposition, style)//gracefully append this style to styleComposition, forced overwrite
                        }
                    }
                }
            }
            
        }
        
        Swift.print("styleComposition.styleProperties.count: " + "\(styleComposition.styleProperties.count)")
        StyleParser.describe(styleComposition)
        return styleComposition
    }
}