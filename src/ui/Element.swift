class Element:NSView{
	public var skinState:String = "";/*protected*//*This is protected so that sub-classes can access it when setting the initial state*/
	private var skin:Skin?
	private var width:Number?
	private var height:Number?
	private var var parent : IElement?
	private var var id : String;/*css selector id*/
	private var classId : String;/*css selector class identifier*/
	/**
	 * This class serves as a base class for the Element GUI framework
	 * TODO: research why you need skinstate in the element class, test with a simple button
	 * TODO: any method that doesnt rely on internal variables should be moved to an external utility class in order to keep this class as simple as possible
	 * NOTE: subclasing over 1 or 2 deep is hard so try to simplify the dependencies !KISS!
	 */
	public func init(_ width:Number = NaN, _ height:Number = NaN, _ parent:IElement = nil, _ id:String = nil, _ classId:String = nil){
		self.width = width;
		self.height = height;
		self.parent = parent;
		self.id = id;
		self.classId = classId;
		resolveSkin();
	}
	/**
	 * Resolves the skin that the this or the sub-class will use
	 * @Note resolveSkin sounds like a well-ballanced name, you could consider createContent or createSkin but these doesnt quite describe the action since the skin is resolved not created per se 
	 */
	public func resolveSkin(){/*protected*/
		skin = addSubView(SkinResolver.skin(self)) as Skin;
	}
	/**
	 * Sets the width and height of the skin and this instance.
	 */
	public func setSize(width:Number, height:Number){
		self.width = width;
		self.height = height;
		skin.setSize(width, height);
	}
	/**
	 * Positions the Element instance to @param point
	 */
	public func setPosition(point:Point){
		x = point.x;
		y = point.y;
	}
	/**
	 * Sets the current state of the button, which determins the current drawing of the skin
	 * TODO: this can be moved to an util class
	 */
	public func setSkinState(state:String) {
		skin.setState(state)
	}
	/**
	 * Sets the id
	 */
	public func setId(id : String) {
		self.id = id;
	}
	/**
	 * Applies a style to the skin
	 * @Note this is the function that we need to toggle between css style sheets and have them applied to all Element instances
	 * // :TODO: this method may be unessacary since all changing a style really needs is a call to setSkinState("refresh")
	 */
	public func setStyle(style:IStyle) {// :TODO: remove definitly, make an Utils class if you must have it
		skin.setStyle(style);
	}
	/**
	 * @Note this is the function that we need to toggle between css style sheets and have them applied to all Element instances
	 * TODO: explain the logic of havong this var in this class and also in the skin class, i think its because you need to access the skinstate before the skin is created or initiated in the element.
	 */
	public func getSkinState() : String {// :TODO: the skin should have this state not the element object!!!===???
		return skinState;
	}
	/**
	 * @Note this function is needed say if a Window is the parent of an Element instance, since Window does not inherit from DisplayObjectContainer we cant use the parent
	 * @param isAbsoltuteParent (if you want to get hold of the stage in Window instances use this flag)
	 */
	public func getParent(isAbsoltuteParent:Boolean = false):AnyObject?{// :TODO: beta
//		trace("_parent: " + _parent);
		if(isAbsoltuteParent) return parent is Window ? (parent as Window).view/*<-may need to be superview*/ : parent;
		return parent;// == null || isAbsoltuteParent ? (_parent as Window).stage || super.parent:_parent;
	}
	/**
	 * Returns the class type of the Class instance 
	 * @Note if a class subclasses Element that sub-class will be the class type
	 * @Note override this function in the first subClass and that subclass will be the class type for other sub-classes
	 */
	public func getClassType():String{
		return ClassParser.className(self);
	}
	public func getWidth():Number{
		return skin != nil ? skin.getWidth() : NaN;
	}
	public func getHeight():Number{
		return skin != nil ? skin.getHeight() : NaN;
	}
	//----------------------------------
	//  getters / setters
	//----------------------------------
	/**
	 * Returns an assigned _parent of type iElement, or its original parent if it has one.
	 * // :TODO: this should be renamed to getParent, or elementParent, do futher investigation!
	 */
	override public func get parent():NSView {
//			trace("_parent is DisplayObjectContainer" + Boolean(_parent is DisplayObjectContainer));
		return parent == nil ? super.parent:parent as NSView;
	}
	/**
	 * Returns the id (equivalent to id in html)
	 */
	public func get id():String {
		return id;
	}
	/**
	 * Returns the id (equivalent to class in html)
	 */
	public func get classId() : String {
		return classId;
	}
	/**
	 * Returns the width
	 */
	override public func get width():Number {
		return width;
	}
	/**
	 * Returns the height
	 */
	override public func get height():Number {
		return height;
	}
	/**
	 * Returns ISkin
	 */
	public func get skin():Skin {
		return skin;
	}
}

