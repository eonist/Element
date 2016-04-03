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
        var steppers:Array = [colorPanel.spinner1,colorPanel.spinner2,colorPanel.spinner3];
        switch(colorType){
            case ColorPanel.RGB:
                for each (var rgbStepper : LeverSpinner in steppers) {
                    with(rgbStepper.stepper){
                        min = 0;
                        max = 255;
                        increment = 1;
                        decimals = 0;
                        leverRange = 200;
                    }			
                }
                colorPanel.spinner1.textInput.text.setText("Red:");
                colorPanel.spinner2.textInput.text.setText("Green:");
                colorPanel.spinner3.textInput.text.setText("Blue:");
                break;
            case ColorPanel.HSB_TYPE:
                for each (var hsbStepper : LeverSpinner in steppers) {
                    with(hsbStepper.stepper){
                        min = 0;
                        max = 100;
                        increment = 1;
                        decimals = 0;
                        leverRange = 100;
                    }			
                }
                with(colorPanel.spinner1){
                    stepper.max = 360;
                    stepper.leverRange = 200;
                    textInput.text.setText("Hue: ");
                }
                colorPanel.spinner2.textInput.text.setText("Saturate:");
                colorPanel.spinner3.textInput.text.setText("Brightness:");
                break;
            case ColorPanel.HLS_TYPE:
                for each (var hlsStepper : LeverSpinner in steppers) {
                    with(hlsStepper.stepper){
                        min = 0;
                        max = 240;
                        increment = 1;
                        decimals = 0;
                        leverRange = 200;
                    }			
                }
                colorPanel.spinner1.textInput.text.setText("Hue:");
                colorPanel.spinner2.textInput.text.setText("Lightness:");
                colorPanel.spinner3.textInput.text.setText("Saturation:");
                break;
            case ColorPanel.HSV_TYPE:
                for each (var hsvStepper : LeverSpinner in steppers) {
                    with(hsvStepper.stepper){
                        min = 0;
                        max = 240;
                        increment = 1;
                        decimals = 0;
                        leverRange = 200;
                    }			
                }
                colorPanel.spinner1.textInput.text.setText("Hue:");
                colorPanel.spinner2.textInput.text.setText("Saturation:");
                colorPanel.spinner3.textInput.text.setText("Value:");
                break;
        }
    }
}