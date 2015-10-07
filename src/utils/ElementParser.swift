class ElementParser{
	/**
	 * Returns an array populated with IElement parents of the target (Basically the ancestry)
	 */
	class func parents(element:IElement):Array {
			var parents:Array = [];
			var parent:AnyObject = element.getParent();// :TODO: seperate this into a check if its DO then that, if its NativeWindow then do that //note to self: this was styleable.parent as DisplayObject but it cant be anymore since it needs suport for NativeWindow
			while(parent is IElement) {//loops up the object hierarchy as long as the parent is a StylableObject supertype 
				parents.unshift(parent);
				parent = (parent as IElement).getParent();
			}
			return parents;
		}
}