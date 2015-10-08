class ElementParser{
	/**
	 * returns all children in @param element that is of type IElement
	 */
	func children(element:IElement){

	}
	/**
	 * Returns an Array instance comprised of Selector instances for each (element,classId,id and state) in the element "cascade" (the spesseficity)
	 * @Note to get the stackString use: trace(SelectorUtils.toString(StyleResolver.stack(checkButton)));
	 */
	func selectors(element:IElement){

	}
	/**
	 * Returns a String instance of Selectors from @param element (i.e: "Window Button#first Text#input")
	 */
	func string(element:IElement){

	}
	/**
	 * Returns an array populated with IElement parents of the target (Basically the ancestry)
	 */
	class func parents(element:IElement)->Array {
		var parents:Array = [];
		var parent:AnyObject = element.getParent();// :TODO: seperate this into a check if its DO then that, if its NativeWindow then do that //note to self: this was styleable.parent as DisplayObject but it cant be anymore since it needs suport for NativeWindow
		while(parent is IElement) {//loops up the object hierarchy as long as the parent is a StylableObject supertype 
			ArrayModifier.unshift(parent)
			parent = (parent as IElement).getParent();
		}
		return parents;
	}
	/**
	 * 
	 */
	class function elementById(elements:Array,id:String)->IElement {
		for element in elements as! [IElement] {if(id == element.id) {return element}}
		return nil;
	}
	/**
	 * 
	 */
	class function ids(elements:Array):Array {
		var ids<String>:Array = [];
		for element in elements as! [IElement] {ids.append(element.id)}
		return ids;
	}
}