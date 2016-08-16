import Foundation

class CSSConstants{
    /*Font*/
    static var emsFontSize:CGFloat = 16
    static var ems:String = "ems"
    /*layout*/
    static var display:String = "display"
    static var float:String = "float"
    static var inline:String = "inline"
    static var block:String = "block"
    static var inline_block:String = "inlineblock"
    static var right:String = "right"
    static var left:String = "left"
    static var none:String = "none"
    static var clear:String = "clear"
    static var both:String = "both"
    static var margin:String = "margin"
    static var marginLeft:String = "margin-left"
    static var marginRight:String = "margin-right"
    static var marginTop:String = "margin-top"
    static var marginBottom:String = "margin-bottom"
    static var padding:String = "padding"
    static var paddingLeft:String = "padding-left"
    static var paddingRight:String = "padding-right"
    static var paddingTop:String = "padding-top"
    static var paddingBottom:String = "padding-bottom"
    static var cornerRadius:String = "corner-radius"
    static var cornerRadiusTopLeft:String = "corner-radius-top-left"
    static var cornerRadiusTopRight:String = "corner-radius-top-right"
    static var cornerRadiusBottomLeft:String = "corner-radius-bottom-left"
    static var cornerRadiusBottomRight:String = "corner-radius-bottom-right"
    static var lineOffsetType:String = "line-offset-type"
    static var lineOffsetTypeLeft:String = "line-offset-type-left"
    static var lineOffsetTypeRight:String = "line-offset-type-right"
    static var lineOffsetTypeTop:String = "line-offset-type-top"
    static var lineOffsetTypeBottom:String = "line-offset-type-bottom"
    /*these property names are inheritable, they are originally from textformat and textfieldconstants sans width and height since these should not inherit*/
    static var textPropertyNames:Array<String> = ["align","blockindent","bold","bullet","color","font","indent","italic","kerning","leading","leftmargin","letterspacing","rightmargin","size","tabstops","target","underline","url","alwaysshowselection","antialiastype","autosize","alpha","background","backgroundcolor","border","bordercolor","condensewhite","displayaspassword","embedfonts","gridfittype","htmltext","maxchars","mousewheelenabled","mouseenabled","multiline","restrict","sharpness","selectable","thickness","type","textcolor","userichtextclipboard","wordwrap"]
    static var width:String = "width"
    static var height:String = "height"
    /*other*/
    static var drop_shadow:String = "drop-shadow"
    static var offset:String = "offset"
    static var fill:String = "fill"
    static var line:String = "line"
    static var lineAlpha:String = "line-alpha"
    static var fillAlpha:String = "fill-alpha"
    static var lineThickness:String = "line-thickness"
}
