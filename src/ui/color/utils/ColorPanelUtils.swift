import Cocoa
@testable import Utils

class ColorPanelUtils {
    /**
     * Applies the color value to the current steppers
     */
    static func applyColor(_ colorPanel:IColorPanel,_ color:NSColor ) {
        let colorType:String = colorPanel.getColorType()
        switch(colorType){
            case ColorPanel.rgb:
                let rbgObj:RGB = color.rgb
                colorPanel.spinner1!.setValue(rbgObj.r.cgFloat)/*rb*/
                colorPanel.spinner2!.setValue(rbgObj.g.cgFloat)/*gb*/
                colorPanel.spinner3!.setValue(rbgObj.b.cgFloat)/*bb*/
            case ColorPanel.hsb:
                let hsbObj:HSB = color.hsb
                colorPanel.spinner1!.setValue(hsbObj.h*360)
                colorPanel.spinner2!.setValue(hsbObj.s*100)
                colorPanel.spinner3!.setValue(hsbObj.b*100)
            case ColorPanel.hls:
                let hlsObj:HLS = color.hls
                colorPanel.spinner1!.setValue(hlsObj.h)
                colorPanel.spinner2!.setValue(hlsObj.l)
                colorPanel.spinner3!.setValue(hlsObj.s)
            case ColorPanel.hsv:
                let hsvObj:HSV = color.hsv
                colorPanel.spinner1!.setValue(hsvObj.h)
                colorPanel.spinner2!.setValue(hsvObj.s * 240)
                colorPanel.spinner3!.setValue(hsvObj.v * 240)
            default:
                break;
        }
    }
    /**
     * 
     */
    static func toggleColorType(_ colorPanel:IColorPanel,_ colorType:String){
        let steppers:Array<LeverSpinner> = [colorPanel.spinner1!,colorPanel.spinner2!,colorPanel.spinner3!]
        switch(colorType){
            case ColorPanel.rgb:
                for rgbStepper in steppers {
                    let stepper:LeverStepper = rgbStepper.stepper!
                    stepper.minVal = 0
                    stepper.maxVal = 255
                    stepper.increment = 1
                    stepper.decimals = 0
                    stepper.leverRange = 200
                }
                colorPanel.spinner1!.textInput!.text!.setText("Red:")
                colorPanel.spinner2!.textInput!.text!.setText("Green:")
                colorPanel.spinner3!.textInput!.text!.setText("Blue:")
            case ColorPanel.hsb:
                for hsbStepper in steppers {
                    let stepper:LeverStepper = hsbStepper.stepper!
                    stepper.minVal = 0
                    stepper.maxVal = 100
                    stepper.increment = 1
                    stepper.decimals = 0
                    stepper.leverRange = 100
                }
                colorPanel.spinner1!.stepper!.maxVal = 360
                colorPanel.spinner1!.maxVal = 360//temp fix
                colorPanel.spinner1!.stepper!.leverRange = 200
                colorPanel.spinner1!.textInput!.text!.setText("Hue: ")
                colorPanel.spinner2!.textInput!.text!.setText("Saturate:")
                colorPanel.spinner3!.textInput!.text!.setText("Brightness:")
            case ColorPanel.hls:
                for hlsStepper in steppers {
                    let stepper:LeverStepper = hlsStepper.stepper!
                    stepper.minVal = 0
                    stepper.maxVal = 240
                    stepper.increment = 1
                    stepper.decimals = 0
                    stepper.leverRange = 200
                }
                colorPanel.spinner1!.textInput!.text!.setText("Hue:");
                colorPanel.spinner2!.textInput!.text!.setText("Lightness:");
                colorPanel.spinner3!.textInput!.text!.setText("Saturation:");
            case ColorPanel.hsv:
                for hsvStepper in steppers {
                    let stepper:LeverStepper = hsvStepper.stepper!
                    stepper.minVal = 0
                    stepper.maxVal = 240
                    stepper.increment = 1
                    stepper.decimals = 0
                    stepper.leverRange = 200
                }
                colorPanel.spinner1!.textInput!.text!.setText("Hue:");
                colorPanel.spinner2!.textInput!.text!.setText("Saturation:");
                colorPanel.spinner3!.textInput!.text!.setText("Value:");
            default:
                break;
        }
    }
}
