 /**
 * public static constant methods and properties:

 */
 class StringUtil{
 	class var STRING_UTIL_NAME = "string util"//this is what is typically refered to as a public staic constant in other languages and is accessible from the class it self, not instances of it
 	/**
 	 * Returns a list of text items by splitting a text at every delimiter
	 */
	class func split(string, delimiter)->Array{
		return string.componentsSeperatedByString(delimiter)
	}
	/**
 	* NOTE: you cant access instance level variables when using public static constants
	 */
	class func name(){
		return STRING_UTIL_NAME
	}
 }
StringUtil.name//string util
StringUtil.split("abc 123"," ")[0]//"123"