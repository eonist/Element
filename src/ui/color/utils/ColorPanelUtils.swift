import Cocoa

class ColorPanelUtils {
    /**
     * Applies the color value to the current steppers
     */
    class func applyColor(colorPanel:IColorPanel,_ color:NSColor ) {
        var colorType:String = colorPanel.getColorType()
        switch(colorType){
        case ColorPanel.RGB:
            var rbgObj = ColorParser.rgba(color)
            colorPanel.spinner1!.setValue(rbgObj.r*255)//rb
            colorPanel.spinner2!.setValue(rbgObj.g*255)//gb
            colorPanel.spinner3!.setValue(rbgObj.b*255)//bb
            break
        case ColorPanel.HSB:
            var hsbObj:HSBColor = ColorParser.hsb(color)
            colorPanel.spinner1!.setValue(hsbObj.hue)
            colorPanel.spinner2!.setValue(hsbObj.saturation*100)
            colorPanel.spinner3!.setValue(hsbObj.brightness*100)
            break
        case ColorPanel.HLS:
            var hlsObj:HLS = ColorParser.hls(color)
            colorPanel.spinner1!.setValue(hlsObj.h)
            colorPanel.spinner2!.setValue(hlsObj.l)
            colorPanel.spinner3!.setValue(hlsObj.s)
            break
        case ColorPanel.HSV:
            var hsvObj:HSV = ColorParser.hsv(color)
            colorPanel.spinner1!.setValue(hsvObj.h)
            colorPanel.spinner2!.setValue(hsvObj.s * 240)
            colorPanel.spinner3!.setValue(hsvObj.v * 240)
            break
        }
    }
}