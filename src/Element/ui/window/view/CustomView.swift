import Cocoa
@testable import Utils

//Continue here: 🏀
    //add a container where that you can use to hide all the menubar items

class CustomView:WindowView{
    lazy var headerSection:Section = {self.addSubView(Section(NaN,NaN,self,"header"))}()
    lazy var titleIconSection:Section = {self.headerSection.addSubView(Section(NaN,NaN,self.headerSection,"titleBar"))}()/*height was 26 but we added 4px as padding-top*/
    lazy var closeButton:Button = {self.titleIconSection.addSubView(Button(NaN,NaN,self.titleIconSection,"close"))}() /*<--TODO: the w and h should be NaN, test if it supports this*/
    lazy var minimizeButton:Button = {self.titleIconSection.addSubView(Button(NaN,NaN,self.titleIconSection,"minimize"))}()
    lazy var maximizeButton:Button = {self.titleIconSection.addSubView(Button(NaN,NaN,self.titleIconSection,"maximize"))}()
    /**
     * Add content here
     */
    override func resolveSkin() {
        super.resolveSkin()
        createIcons()
    }
    /**
     * Adds close button, min, max
     */
    func createIcons(){
        _ = closeButton
        _ = minimizeButton
        _ = maximizeButton
    }
    override func setSize(_ width:CGFloat,_ height:CGFloat){
        super.setSize(width, height)
        //section.setSize(width, section.height)
    }
    /**
     * NOTE: for re-usable panels etc, override and use the orderOut and makeKeyandOrderInfront combo. Use visible to assert between the modes
     */
    func onCloseButtonReleaseInside() {
        //Swift.print("onCloseButtonReleaseInside")
        self.window?.close()/*this closes the window*/
    }
    /**
     * Minimizes the window
     */
    func onMinimizeButtonReleaseInside(){
        //NSApp.miniaturizeAll(self)//minimizes all windows in the app
        self.window?.miniaturize(self)
    }
    /**
     * Maximize the window
     * TODO: ⚠️️ Add support for fullscreen mode aswell: window.setFrame(NSScreen.mainScreen()!.visibleFrame, display: true, animate: true)
     * TODO: ⚠️️ Add support for zooming back to normal size
     */
    func onMaximizeButtonReleaseInside(){
        //self.window?.zoom(self)//<--alt + click is the default behaviour to launch zoom
        //NSWindowCollectionBehaviorFullScreenAuxiliary or NSWindowCollectionBehaviorFullScreenPrimary
        self.window!.collectionBehavior = NSWindowCollectionBehavior.fullScreenPrimary
        window!.setFrame(NSScreen.main()!.visibleFrame, display:true, animate:true)
        //[self.window setFrame:screenFrame display:YES];
        self.window?.toggleFullScreen(self.window)
    }
    override func onEvent(_ event:Event) {
        if(event === (ButtonEvent.upInside,closeButton)){onCloseButtonReleaseInside()}
        else if(event === (ButtonEvent.upInside,minimizeButton)){onMinimizeButtonReleaseInside()}
        else if(event === (ButtonEvent.upInside,maximizeButton)){onMaximizeButtonReleaseInside()}
        //super.onEvent(event)//<--beta
    }
}
