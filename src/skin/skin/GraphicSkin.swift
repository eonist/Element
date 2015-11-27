import Foundation


class GraphicSkin:Skin{
    override init(_ style:IStyle? = nil, _ state:String = "", _ element:IElement? = nil){
        super.init(style, state, element)
    }
    override func drawRect(dirtyRect: NSRect) {
        Swift.print("GraphicSkin.drawRect()")
        
        
        
        
        //Continue here:
        
        //move configure to its original place, and add initialize here
        
            //the path creation should not update when the drawRect is called
        
            //the path creation should happen on init and when a update method is excplicitly called
        
            //reorganize the code to reflect this new scheme
        
        //Actually all graphics data needs to be read from simple variables 
        
            //And if a graphics needs to change, then only this graphics will change, and not all graphics in all NSViews.
        
            //a hasStyleChanged Boolean will be set to true if graphic style has changed
        
                //-> then the cached style data will be updated
        
            //a hasPathDataChanged Boolean will be set to true if path data has been changed
        
                //-> then the cached pathdata will be updated
        
        //todo: test what happends if you set a if flag in the drawRect method, will the graphics be deleted?
        
        
        
        
        
        GraphicSkinParser.configure(self)/*this call is here because CGContext is only accessible after drawRect is called*/
    }
    /**
     * Required by super class
     */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(){
        //Swift.print("GraphicSkin.draw() NOT IMPLEMENTED YET")
        if(hasStateChanged || hasSizeChanged || hasStyleChanged){
            
        }
        super.draw();
    }
    func applyProperties(decoratable:IGraphicDecoratable){
        //Swift.print("GraphicSkin.applyProperties() NOT IMPLEMENTED YET")
    }
}