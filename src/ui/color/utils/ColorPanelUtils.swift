import Cocoa

class ColorPanelUtils {
    /**
     * Applies the color value to the current steppers
     */
    class func applyColor(colorPanel:IColorPanel,_ color:NSColor ) {
        var colorType:String = colorPanel.getColorType()
        switch(colorType){
        case ColorPanel.RGB_TYPE:
            var rbgObj:Object = ColorParser.rgbByHex(color)
            colorPanel.spinner1.setValue(rbgObj["rb"])
            colorPanel.spinner2.setValue(rbgObj["gb"])
            colorPanel.spinner3.setValue(rbgObj["bb"])
            break
        case ColorPanel.HSB_TYPE:
            var hsbObj:Object = ColorParser.hsbByRgb(color);
            colorPanel.spinner1.setValue(hsbObj["hue"])
            colorPanel.spinner2.setValue(hsbObj["saturation"]*100)
            colorPanel.spinner3.setValue(hsbObj["brightness"]*100)
            break
        case ColorPanel.HLS_TYPE:
            var hlsObj:Object = ColorParser.hlsByNumericRgb(color)
            colorPanel.spinner1.setValue(hlsObj["h"])
            colorPanel.spinner2.setValue(hlsObj["l"])
            colorPanel.spinner3.setValue(hlsObj["s"])
            break
        case ColorPanel.HSV_TYPE:
            var hsvObj:Object = ColorParser.hsvByNumericRgb(color)
            colorPanel.spinner1.setValue(hsvObj["h"])
            colorPanel.spinner2.setValue(hsvObj["s"]*240)
            colorPanel.spinner3.setValue(hsvObj["v"]*240)
            break;
        }
    }
}
