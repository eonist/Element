import Foundation
/**
 * CSS: line-alpha:0.5;line:Gray;line-thickness:2px;width:60px;height:60px;
 */
class ProgressIndicator:Element {
    var lines:[LineGraphic] = []
    var lineStyle:ILineStyle = LineStyle()
    override func resolveSkin() {
        skin = SkinResolver.skin(self)
        lineStyle = StylePropertyParser.lineStyle(skin!)!//<--grab the style from that was resolved to this component
        lineStyle.lineCap = CGLineCap.Round//add round end style
        let center:CGPoint = CGRect(CGPoint(),CGSize(w,h)).center//center of element
        Swift.print("center: " + "\(center)")
        let radius:CGFloat = w/2 - lineStyle.thickness/2
        Swift.print("radius: " + "\(radius)")
        let wedge:CGFloat = π*2/12
        for i in 0..<12 {
            let angle = wedge * i
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
        
        //Continue here:
        
        //Could the bellow be done simpler: think sequence looping in a video.
        let initAlpha = lineStyle.color.alphaComponent//<--can be moved to a global scope
        let restAlpha = 1 - initAlpha//<--can be moved to a global scope
        for i in 0..<12{//reset all values
            let line = lines[i]
            
            line.graphic.lineStyle!.color.alpha(initAlpha)
        }
        let progress:Int = round(12*value).int//value = 0.25 -> 3, value = 0.5 -> 6 etc etc (values from 0 - 12 )
        let start:Int = progress
        let end:Int = progress + 7
        for i in start..<end{//iterates 7 times
            let e:Int = IntParser.normalize(i, 12)//clamps the values between 0 and 12
            let alpha:CGFloat = initAlpha + (restAlpha/7) * ()
            //alpha += 0.5 * i (i/7)
            //setStyle(), draw()
        }
    }
    /**
     * Esentially you start a repeating animation that modulates a value from 0 - 1 of a defined time over n-times
     */
    func start(){
        //assert if animator exist else create animator w/ repeatCount : 0 and 0 to 1 sec w/ progress as the call back method
        //start anim
    }
    /**
     *
     */
    func stop(){
        //stop animator
    }
    
    
    //Continue here: figure out how you can use one animator object to do looping and progress seemlesly
        //using the LoopingAnimator should be fine, carry on
    
}