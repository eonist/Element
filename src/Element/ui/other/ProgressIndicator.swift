import Foundation
@testable import Utils
/**
 * CSS: line-alpha:0.5;line:Gray;line-thickness:2px;width:60px;height:60px;
 */
class ProgressIndicator:Element {
    var lines:[LineGraphic] = []
    var lineStyle:ILineStyle = LineStyle()
    var animator:Animator?
    var revealProgress:CGFloat = 0
    override init(_ width: CGFloat, _ height: CGFloat, _ parent: IElement? = nil, _ id: String? = nil) {
        super.init(width, height, parent, id)
        animator = LoopingAnimator(Animation.sharedInstance,3,1,0,1,progress,Linear.ease)
    }
    override func resolveSkin() {
        skin = SkinResolver.skin(self)
        lineStyle = StylePropertyParser.lineStyle(skin!)!//<--grab the style from that was resolved to this component
        lineStyle.lineCap = CGLineCap.round//add round end style
        let center:CGPoint = CGRect(CGPoint(),CGSize(w,h)).center//center of element
        //Swift.print("center: " + "\(center)")
        let radius:CGFloat = w/2 - lineStyle.thickness/2
        //Swift.print("radius: " + "\(radius)")
        let wedge:CGFloat = π*2/12//Wedge amount
        for i in 0..<12 {
            let angle = wedge * i - π/2//<--minus π/2 so that the start angle is center bottom so to speak
            let startP = center.polarPoint(radius/2, angle)
            let endP = center.polarPoint(radius, angle)
            let line:LineGraphic = LineGraphic(startP,endP,lineStyle.copy())
            lines.append(line)
            _ = addSubView(line.graphic)
            line.draw()
        }
    }
    /**
     * Modulate the progress indicator (For iterative progress or looping animation)
     * PARAM: value: 0 - 1
     */
    func progress(_ value:CGFloat){
        Swift.print("ProgressIndicator.progress: " + "\(value)")
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
            let a:Int = progress + i + 5//<--offset a half circle by adding 5
            let e:Int = IntParser.normalize(a, 12)//clamps the values between 0 and 12
            let line = lines[e]
            line.graphic.lineStyle!.color = line.graphic.lineStyle!.color.alpha(alpha)
            line.draw()
        }
    }
    /**
     * Basically Tick the lines into visibility one by one (from the top one)
     * NOTE: Reveal one tick at the time from top
     * NOTE: You also want to set the alpha gradually from half to full alpha in a half circle
     * TODO: The final tick should be 0, to make this happen you need to offset the i, possibly
     */
    func reveal(_ value:CGFloat){//value goes from 0 to 1
        Swift.print("ProgressIndicator.reveal() value: " + "\(value)")
        revealProgress = value
        let initAlpha = lineStyle.color.alphaComponent//<--can be moved to a global scope
        let restAlpha = 1 - initAlpha//<--can be moved to a global scope
        let p:Int = round(12 * value).int //progression from 0 to 12
        for i in 0..<12{
            var alpha:CGFloat
            if(i < p){//integers before p
                if(i >= p-6 && i <= p){//<--use range here
                    let relLoc:CGFloat = 7 - (p - i).cgFloat//Figure out where the i is in the range: p-6 until p
                    //Swift.print("relLoc: " + "\(relLoc)")
                    let multiplier:CGFloat = relLoc/6//base the relative pos as the multiplier for the alpha level.
                    //Swift.print("multiplier: " + "\(multiplier)")
                    alpha = initAlpha + (restAlpha * multiplier)//max equals 1 alpha, min equals 0.5
                }else{
                    alpha = initAlpha
                }
            }else{//integers after p
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
        Swift.print("💚 ProgressIndicator.start")
        //assert if animator exist else create animator w/ repeatCount : 0 and 0 to 1 sec w/ progress as the call back method
        //start anim
        //lineStyle.color = lineStyle.color.alpha(0.5)
        if(animator != nil){animator!.stop()}//stop any previous running animation
        animator!.start()/*start animator*/
    }
    /**
     *
     */
    func stop(){
        Swift.print("❤️️ ProgressIndicator.stop")
        animator!.stop()/*stop animator*/
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
