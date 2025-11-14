package AIPLUS

public Object aiplusWebModule inherits WEBDSP::WebModule

	override	Boolean	fEnabled = TRUE
	override	String	fModuleName = 'aiplus'
	override	String	fName = 'aiplus'
	override	List	fOSpaces = { 'aiplus' }
	override	String	fSetUpQueryString = 'func=aiplus.configure&module=aiplus&nextUrl=%1'
	override	List	fVersion = { '1', '0', 'r', '0' }

end
