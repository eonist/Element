class Element:NSView{
	var skinState:String = "";/*protected*//*This is protected so that sub-classes can access it when setting the initial state*/
	var skin:Skin?
	var width:Number?
	var height:Number?
	var parent : IElement?
	var id : String;/*css selector id*/
	var classId : String;/*css selector class identifier*/
	/**
	 * This class serves as a base class for the Element GUI framework
	 * TODO: any method that doesnt rely on internal variables should be moved to an external utility class in order to keep this class as simple as possible
	 * NOTE: subclasing over 1 or 2 deep is hard so try to simplify the dependencies !KISS!
	 */
	public func init(width:Number = NaN, height:Number = NaN, parent:IElement = nil, id:String = nil, classId:String = nil){
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
		self.skin = addSubView(SkinResolver.skin(self)) as Skin;
	}
	/**
	 * Sets the width and height of the skin and this instance.
	 */
	public func setSize(width:Number, height:Number){
		self.width = width;
		self.height = height;
		self.skin.setSize(width, height);
	}
}

//stub code for the Element class

/*
width
height
id
classId
skin
resolveSkin()//Resolves the skin that the this or the sub-class will use
getClassType()
*/

//getters and setters for all variables
//implicit getters and setters for some of the variables

//research how swift handles parent of objects, super.parent etc
//research why you need skinstate in the element class, test with a simple button