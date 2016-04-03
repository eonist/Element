import Cocoa

class ColorPanelUtils {
    /**
     * Applies the color value to the current steppers
     */
    class func applyColor(colorPanel:IColorPanel,_ color:NSColor ) {
        let colorType:String = colorPanel.getColorType()
        switch(colorType){
            case ColorPanel.RGB:
                let rbgObj = ColorParser.rgba(color)
                colorPanel.spinner1!.setValue(rbgObj.r*255)//rb
                colorPanel.spinner2!.setValue(rbgObj.g*255)//gb
                colorPanel.spinner3!.setValue(rbgObj.b*255)//bb
            case ColorPanel.HSB:
                let hsbObj:HSBColor = ColorParser.hsb(color)
                colorPanel.spinner1!.setValue(hsbObj.hue)
                colorPanel.spinner2!.setValue(hsbObj.saturation*100)
                colorPanel.spinner3!.setValue(hsbObj.brightness*100)
            case ColorPanel.HLS:
                let hlsObj:HLS = ColorParser.hls(color)
                colorPanel.spinner1!.setValue(hlsObj.h)
                colorPanel.spinner2!.setValue(hlsObj.l)
                colorPanel.spinner3!.setValue(hlsObj.s)
            case ColorPanel.HSV:
                let hsvObj:HSV = ColorParser.hsv(color)
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
    class func toggleColorType(colorPanel:IColorPanel,_ colorType:String){// :TODO: move to utils class
        var steppers:Array<LeverSpinner> = [colorPanel.spinner1!,colorPanel.spinner2!,colorPanel.spinner3!]
        switch(colorType){
            case ColorPanel.RGB:
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
            case ColorPanel.HSB:
                for hsbStepper in steppers {
                    let stepper:LeverStepper = hsbStepper.stepper!
                    stepper.minVal = 0
                    stepper.maxVal = 100
                    stepper.increment = 1
                    stepper.decimals = 0
                    stepper.leverRange = 100
                }
                colorPanel.spinner1!.stepper!.maxVal = 360
                colorPanel.spinner1!.stepper!.leverRange = 200
                colorPanel.spinner1!.textInput!.text!.setText("Hue: ")
                colorPanel.spinner2!.textInput!.text!.setText("Saturate:")
                colorPanel.spinner3!.textInput!.text!.setText("Brightness:")
            case ColorPanel.HLS:
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
            case ColorPanel.HSV:
                for hsvStepper in steppers {
                    let stepper:LeverStepper = hsvStepper.stepper!
                    stepper.minVal = 0
                    stepper.maxVal = 240
                    stepper.increment = 1
                    stepper.decimals = 0
                    stepper.leverRange = 200		
                }
                colorPanel.spinner1.textInput.text.setText("Hue:");
                colorPanel.spinner2.textInput.text.setText("Saturation:");
                colorPanel.spinner3.textInput.text.setText("Value:");
                break;
        }
    }
}