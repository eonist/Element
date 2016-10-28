import Foundation
/**
 * CSS: line-alpha:0.5;line:Gray;line-thickness:2px;width:60px;height:60px;
 */
class ProgressIndicator:Element {
    var lines:[LineGraphic] = []
    var lineStyle:ILineStyle = LineStyle()
    var animator:Animator?
    override init(_ width: CGFloat, _ height: CGFloat, _ parent: IElement? = nil, _ id: String? = nil) {
        super.init(width, height, parent, id)
        animator = LoopingAnimator(Animation.sharedInstance,3,1,0,1,progress,Easing.easeLinear)
    }
    override func resolveSkin() {
        skin = SkinResolver.skin(self)
        lineStyle = StylePropertyParser.lineStyle(skin!)!//<--grab the style from that was resolved to this component
        lineStyle.lineCap = CGLineCap.Round//add round end style
        let center:CGPoint = CGRect(CGPoint(),CGSize(w,h)).center//center of element
        //Swift.print("center: " + "\(center)")
        let radius:CGFloat = w/2 - lineStyle.thickness/2
        //Swift.print("radius: " + "\(radius)")
        let wedge:CGFloat = π*2/12
        for i in 0..<12 {
            let angle = wedge * i - π/2//<--minus π/2 so that the start angle is center bottom so to speak
            let startP = center.polarPoint(radius/2, angle)
            let endP = center.polarPoint(radius, angle)
            let line:LineGraphic = LineGraphic(startP,endP,lineStyle.copy())
            lines.append(line)
            addSubView(line.graphic)
            line.draw()
        }
    }
    /**
     * Modulate the progress indicator (For iterative progress or looping animation)
     * PARAM: value: 0 - 1
     */
    func progress(value:CGFloat){
        //Swift.print("progress: " + "\(value)")
        //Could the bellow be done simpler: think sequence looping in a video.
        let initAlpha = lineStyle.color.alphaComponent//<--can be moved to a global scope
        let restAlpha = 1 - initAlpha//<--can be moved to a global scope
        for i in 0..<12{//reset all values
            let line = lines[i]
            line.graphic.lineStyle!.color = line.graphic.lineStyle!.color.alpha(initAlpha)
            line.draw()
        }
        
        let progress:Int = round(12*value).int//value = 0.25 -> 3, value = 0.5 -> 6 etc etc (values from 0 - 12 )
        
        for i in 0..<7{//iterates 7 times
            let alpha:CGFloat = initAlpha + restAlpha * (1/7*i)//we need a half circle with gradually increasing alpha values starting from initAlpha
            let a:Int = progress + i
            let e:Int = IntParser.normalize(a, 12)//clamps the values between 0 and 12
            let line = lines[e]
            line.graphic.lineStyle!.color = line.graphic.lineStyle!.color.alpha(alpha)
            line.draw()
        }
    }
    /**
     *
     */
    func reveal(value:CGFloat){//value goes from 0 to 1
        //what you want to do...
        //Reveal one tick at the time from top
        let progression:Int = round(12 * value).int //from 0 to 12
        for i in 0..<12{
            let alpha:CGFloat
            if(i < progression){
                alpha = 1
            }else{
                alpha = 0
            }
            let line = lines[i]
            line.graphic.lineStyle!.color = line.graphic.lineStyle!.color.alpha(alpha)
            line.draw()
        }
    }
    /**
     * Esentially you start a repeating animation that modulates a value from 0 - 1 of a defined time over n-times
     */
    func start(){
        //assert if animator exist else create animator w/ repeatCount : 0 and 0 to 1 sec w/ progress as the call back method
        //start anim
        if(animator != nil){animator!.stop()}//stop any previous running animation
        animator!.start()
    }
    /**
     *
     */
    func stop(){
        //stop animator
        animator!.stop()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}