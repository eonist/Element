protocol{
	//----------------------------------
	//  implicit getters / setters
	//----------------------------------
	func setSize(width:Number, height:Number)
	func setPosition(position:Point)
	func setId(id:String)
	func setSkinState(state:String)
	func setStyle(style:IStyle)
	func getParent(isAbsoltuteParent:Boolean = false)->Any//weak
	func getClassType()->String
	func getSkinState()->String
	func getHeight()->Number
	func getWidth()->Number
	//----------------------------------
	//  getters / setters
	//----------------------------------
	var skin()->Skin {get}
	vae parent()->NSView {get}//weak
	var id()->String {get}
	var width()->Number {get}
	var height()->Number {get}
	var classId() -> String {get}
}