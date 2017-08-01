import Foundation

enum CSS{
    enum Layout{
        
    }
    enum Sizes{
        
    }
    enum Other{
        
    }
    enum CornerRadius{
        
    }
    enum Margin{
        
    }
    enum LineOffsetType{
        
    }
    enum Text{
        static let ems = "ems"
        static var emsFontSize:CGFloat {return 16}/*emsFontSize*/
        enum Property{
            static let align:String = "align"
            static let blockindent:String = "blockindent"
            static let bold:String = "bold"
            static let bullet:String = "bullet"
            static let color:String = "color"
            static let font:String = "font"
            static let indent:String = "indent"
            static let italic:String = "italic"
            static let kerning:String = "kerning"
            static let leading:String = "leading"
            static let leftmargin:String = "leftmargin"
            static let letterspacing:String = "letterspacing"
            static let rightmargin:String = "rightmargin"
            static let size:String = "size"
            static let tabstops:String = "tabstops"
            static let target:String = "target"
            static let underline:String = "underline"
            static let url:String = "url"
            static let alwaysshowselection:String = "alwaysshowselection"
            static let antialiastype:String = "antialiastype"
            static let autosize:String = "autosize"
            static let alpha:String = "alpha"
            static let background:String = "background"
            static let backgroundcolor:String = "backgroundcolor"
            static let border:String = "border"
            static let bordercolor:String = "bordercolor"
            static let condensewhite:String = "condensewhite"
            static let displayaspassword:String = "displayaspassword"
            static let embedfonts:String = "embedfonts"
            static let gridfittype:String = "gridfittype"
            static let htmltext:String = "htmltext"
            static let maxchars:String = "maxchars"
            static let mousewheelenabled:String = "mousewheelenabled"
            static let mouseenabled:String = "mouseenabled"
            static let multiline:String = "multiline"
            static let restrict:String = "restrict"
            static let sharpness:String = "sharpness"
            static let selectable:String = "selectable"
            static let thickness:String = "thickness"
            static let type:String = "type"
            static let textcolor:String = "textcolor"
            static let userichtextclipboard:String = "userichtextclipboard"
            static let wordwrap:String = "wordwrap"
        }
        static let textPropertyNames:[String] = {
            return [Property.align,Property.blockindent,Property.bold,Property.bullet,Property.color,Property.font,Property.indent,Property.italic,Property.kerning,Property.leading,Property.leftmargin,Property.letterspacing,Property.rightmargin,Property.size,Property.tabstops,Property.target,Property.underline,Property.url,Property.alwaysshowselection,Property.antialiastype,Property.autosize,Property.alpha,Property.background,Property.backgroundcolor,Property.border,Property.bordercolor,Property.condensewhite,Property.displayaspassword,Property.embedfonts,Property.gridfittype,Property.htmltext,Property.maxchars,Property.mousewheelenabled,Property.mouseenabled,Property.multiline,Property.restrict,Property.sharpness,Property.selectable,Property.thickness,Property.type,Property.textcolor,Property.userichtextclipboard,Property.wordwrap]
        }()
    }
}
