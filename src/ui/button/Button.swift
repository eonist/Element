class Button:Element{
	private var isFocused:Boolean
	private var isDisabled:Boolean
	/*
	 * TODO: use extensions to simplify the init process when everything is setup and working
	 * // :TODO: it could be possible to merge the two skin lines in every event handler somehow
	 * // :TODO: impliment IFocusable and IDisablble in this class, the argument that the button must be super simple doesnt hold, if you want a simpler button you can just make an alternate Button class
	 */
	overide func init(_ width:Number = NaN, _ height:Number = NaN, _ isFocused:Boolean = false, _ isDisabled:Boolean = false, _ parent:IElement = nil, _ id:String = nil,_ classId:String = nil){
		isFocused = isFocused;
		_isDisabled = isDisabled;
		super(width,height,parent,id,classId);
		addObservers();
	}
	override public function resolveSkin() : void {
		super.resolveSkin();/*draws the button skin*/
		self.userInteractionEnabled = skin.userInteractionEnabled = true;/*enables the interactivity and hand cursor on mouse-over*/
	}
	/**
	 * Handles actions and drawing states for the down event.
	 */
	public func down() {
		skinState = SkinStates.DOWN+" "+SkinStates.OVER;// :TODO: why do we set the skin here and then on the line bellow again?
		setSkinState(getSkinState());// :TODO: we could potentially do setSkinState(getSkinState()+SkinStates.DOWN+" "+SkinStates.OVER); in one line like that
		NSNotificationCenter.defaultCenter.postNotificationName(ButtonEvent.DOWN,object:self)
	}	
	/**
	 * Handles actions and drawing states for the release event.
	 * TODO: test how you can listen for this notification, since swift doesnt support bubbeling of events
	 */
	public func releaseInside() {
		_skinState = SkinStates.OVER;// :TODO: why in two lines like this?
		setSkinState(getSkinState());
		NSNotificationCenter.defaultCenter.postNotificationName(ButtonEvent.RELEASE_INSIDE,object:self)
	}
	/**
	 * Handles actions and drawing states for the release outside event.
	 * TODO: test how you can listen for this notification, since swift doesnt support bubbeling of events
	 */
	public func releaseOutside() {
		_skinState = SkinStates.NONE;
		setSkinState(getSkinState());
		NSNotificationCenter.defaultCenter.postNotificationName(ButtonEvent.RELEASE_OUTSIDE,object:self)
	}
	/**
	 * Handles actions and drawing states for the rollOut event.
	 */
	public func rollOut() {
		_skinState = SkinStates.NONE;
		setSkinState(getSkinState());
		NSNotificationCenter.defaultCenter.postNotificationName(ButtonEvent.ROLL_OUT,object:self)
	}	
	/**
	 * Handles actions and drawing states for the rollOver event.
	 */
	public func rollOver() {
		_skinState = SkinStates.OVER;
		setSkinState(getSkinState());
		NSNotificationCenter.defaultCenter.postNotificationName(ButtonEvent.ROLL_OVER,object:self)
	}
	
	
	
	//continue here - do more research around how swift handles events. https://github.com/Megatron1000/MKBOSXCloseButton
	
	
	
	
}