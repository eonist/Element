import Cocoa
/**
 * HorizontalNodeSlider is used when 2 sliders are need, as in section definition or zoom, or gradient values
 * // :TODO: to get the toFront method working you need to support relative positioning, currently the Element framework doesnt support this
 * // :TODO: support for custom node shape design
 * // :TODO: when implimenting selectgroup functionality you need to be able to change set the selection on press not on release (You might need to impliment NodeButton that impliments iselectable in order to make this happen)
 */
class VNodeSlider:Element,INodeSlider{
    var startNode:SelectButton?
    var endNode:SelectButton?
    var selectGroup:SelectGroup?
    var nodeHeight:CGFloat
    var tempNodeMouseY:CGFloat?
    var startProgress:CGFloat
    var endProgress:CGFloat
    var globalMouseMovedHandeler:AnyObject?
    init(_ width:CGFloat = NaN, _ height:CGFloat = NaN, _ nodeHeight:CGFloat = NaN, _ startProgress:CGFloat = 0, _ endProgress:CGFloat = 1, _ parent:IElement? = nil, _ id:String? = nil, _ classId:String? = nil) {
        self.startProgress = startProgress
        self.endProgress = endProgress
        self.nodeHeight = nodeHeight.isNaN ? width:nodeHeight
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin();
        startNode = addSubView(SelectButton(width, nodeHeight,false,self,"start"))
        setStartProgressValue(startProgress)
        endNode = addSubView(SelectButton(width, nodeHeight,false,self,"end"))
        setEndProgressValue(endProgress)
        selectGroup = SelectGroup([startNode!,endNode!],startNode)
    }
    func onStartNodeDown() {
        Swift.print("onStartNodeDown")
//		DepthModifier.toFront(_startNode, this);// :TODO: this may now work since they are floating:none
        tempNodeMouseY = startNode!.localPos().y
        globalMouseMovedHandeler = NSEvent.addLocalMonitorForEventsMatchingMask([.LeftMouseDraggedMask], handler:onStartNodeMove)//we add a global mouse move event listener
    }
    func onEndNodeDown() {
        Swift.print("onEndNodeDown")
//		DepthModifier.toFront(_endNode, this);// :TODO: this may now work since they are floating:none
        tempNodeMouseY = endNode!.localPos().y
        globalMouseMovedHandeler = NSEvent.addLocalMonitorForEventsMatchingMask([.LeftMouseDraggedMask], handler:onEndNodeMove)//we add a global mouse move event listener
    }
    func onStartNodeMove(event:NSEvent)-> NSEvent? {
        Swift.print("onStartNodeMove()")
        startProgress = Utils.progress(event.localPos(self).y, tempNodeMouseY!, height, nodeHeight)
        startNode!.y = Utils.nodePosition(startProgress, height, nodeHeight)
        super.onEvent(NodeSliderEvent(NodeSliderEvent.change,self))
        return event
    }
    func onEndNodeMove(event:NSEvent)-> NSEvent? {
        Swift.print("onEndNodeMove()")
        endProgress = Utils.progress(event.localPos(self).y, tempNodeMouseY!, height, nodeHeight)
        endNode!.y = Utils.nodePosition(endProgress, height, nodeHeight)
        super.onEvent(NodeSliderEvent(NodeSliderEvent.change,self))
        return event
    }
    func onStartNodeUp() {
        Swift.print("onStartNodeUp()")
        if(globalMouseMovedHandeler != nil){NSEvent.removeMonitor(globalMouseMovedHandeler!)}//we remove a global mouse move event listener
    }
    func onEndNodeUp() {
        Swift.print("onEndNodeUp()")
        if(globalMouseMovedHandeler != nil){NSEvent.removeMonitor(globalMouseMovedHandeler!)}//we remove a global mouse move event listener
    }
    override func onEvent(event: Event) {
        Swift.print("\(self.dynamicType)" + ".onEvent() event: " + "\(event)")
        if(event.origin === startNode && event.type == ButtonEvent.down){onStartNodeDown()}//if thumbButton is down call onThumbDown
        else if(event.origin === startNode && event.type == ButtonEvent.up){onStartNodeUp()}//if thumbButton is down call onThumbUp
        else if(event.origin === endNode && event.type == ButtonEvent.down){onEndNodeDown()}
        else if(event.origin === endNode && event.type == ButtonEvent.up){onEndNodeUp()}
        //super.onEvent(event)/*forward events, or stop the bubbeling of events by commenting this line out*/
    }
    /**
     * @param progress (0-1)
     */
    func setStartProgressValue(progress:CGFloat){
        startProgress = progress
        startNode!.y = Utils.nodePosition(progress, height, nodeHeight)
    }
    func setEndProgressValue(progress:CGFloat){
        endProgress = progress
        endNode!.y = Utils.nodePosition(progress, height, nodeHeight)
    }
    override func setSize(width:CGFloat, _ height:CGFloat) {
        super.setSize(width, height)
        setEndProgressValue(endProgress)
        setStartProgressValue(startProgress)
        startNode!.setSize(width, startNode!.height)
        endNode!.setSize(width, startNode!.height)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
private class Utils{
	/**
	 * Returns the x position of a nodes @param progress
	 */
	static func nodePosition(progress:CGFloat, _ height:CGFloat, _ nodeHeight:CGFloat) -> CGFloat {
		let minThumbPos:CGFloat = height - nodeHeight/*Minimum thumb position*/
		return progress * minThumbPos
	}
	/**
	 * Returns the progress derived from a node 
	 * @return a number between 0 and 1
	 */
	static func progress(mouseY:CGFloat,_ tempNodeMouseX:CGFloat,_ height:CGFloat,_ nodeHeight:CGFloat) -> CGFloat {
		let progress:CGFloat = (mouseY-tempNodeMouseX) / (height-nodeHeight)
		return max(0,min(progress,1))/*Ensures that progress is between 0 and 1 and if its beyond 0 or 1 then it is 0 or 1*/
	}
}