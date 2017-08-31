import Cocoa
@testable import Utils
/**
 * CustomView is a WindowView with close,min,max buttons
 * TODO: Turn This class into a json component?
 */
class CustomView:WindowView{
    //lazy var header:Section = {self.addSubView(Section(NaN,NaN,self,"header"))}()
    lazy var iconSection:Section = {self.addSubView(Section.init(id:"titleBar"))}()
    lazy var closeButton:Button = {self.iconSection.addSubView(Button.init(id:"close"))}() /*<--TODO: the w and h should be NaN, test if it supports this*/
    lazy var minimizeButton:Button = {self.iconSection.addSubView(Button.init(id:"minimize"))}()
    lazy var maximizeButton:Button = {self.iconSection.addSubView(Button.init(id:"maximize"))}()
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
        self.window!.collectionBehavior = NSWindow.CollectionBehavior.fullScreenPrimary
        //TODO: ⚠️️ make the bellow if let
        window!.setFrame(NSScreen.main!.visibleFrame, display:true, animate:true)
        //[self.window setFrame:screenFrame display:YES];
        self.window?.toggleFullScreen(self.window)
    }
    override func onEvent(_ event:Event) {
        if event.assert(.upInside,closeButton){onCloseButtonReleaseInside()}
        else if event.assert(.upInside,minimizeButton) {onMinimizeButtonReleaseInside()}
        else if event.assert(.upInside,maximizeButton) {onMaximizeButtonReleaseInside()}
        //super.onEvent(event)//<--beta
    }
}
