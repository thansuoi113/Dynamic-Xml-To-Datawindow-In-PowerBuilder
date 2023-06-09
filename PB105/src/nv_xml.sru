$PBExportHeader$nv_xml.sru
forward
global type nv_xml from nonvisualobject
end type
end forward

global type nv_xml from nonvisualobject
end type
global nv_xml nv_xml

forward prototypes
public function string uf_getattribute (string a_sxml, string a_selement, string a_sattribute)
public function string uf_getelement (string a_sxml, string a_selement)
public function string uf_getvalue (string a_sxml, string a_selement)
public function string uf_setattribute (string a_sxml, string a_selement, string a_sattribute, string a_svalue)
public function string uf_setelement (string a_sxml, string a_selement, string a_svalue)
public function string uf_setvalue (string a_sxml, string a_selement, string a_svalue)
public function string uf_addelement (string a_sxml, string a_sparentelement, string a_snewelement, string a_svalue, boolean a_bempty)
public function string uf_parse_into_ds (string a_sxml, string a_snode, datastore a_ds)
end prototypes

public function string uf_getattribute (string a_sxml, string a_selement, string a_sattribute);//====================================================================
// Function: nv_xml.uf_getattribute()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	a_sxml      	
// 	value	string	a_selement  	
// 	value	string	a_sattribute	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2023/03/21
//--------------------------------------------------------------------
// Usage: nv_xml.uf_getattribute ( string a_sxml, string a_selement, string a_sattribute )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Long lPos

String sRet
String sXMLsubstring


lPos = Pos(a_sXML, '<' + a_sElement)
If lPos = 0 Then
	sRet = 'ERROR: Invalid Element'
Else
	sXMLsubstring = Mid( a_sXML, lPos)
	lPos = Pos(sXMLsubstring, a_sAttribute)
	If lPos = 0 Then
		sRet = 'ERROR: Invalid Attribute'
	Else
		sXMLsubstring = Mid( sXMLsubstring, lPos)
		sXMLsubstring = Mid( sXMLsubstring, Pos(sXMLsubstring, '='))
		lPos = Pos(sXMLsubstring, '"')
		sRet = Mid( sXMLsubstring, lPos + 1, Pos(sXMLsubstring, '"', lPos + 1) - lPos - 1)
	End If
End If

Return sRet


end function

public function string uf_getelement (string a_sxml, string a_selement);//====================================================================
// Function: nv_xml.uf_getelement()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	a_sxml    	
// 	value	string	a_selement	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2023/03/21
//--------------------------------------------------------------------
// Usage: nv_xml.uf_getelement ( string a_sxml, string a_selement )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Long  	lPos
Long   	lOpenTagLen

String  	sRet
String   sOpenTag
String   sCloseTag


sOpenTag = '<' + a_sElement + '>'
sCloseTag = '</' + a_sElement + '>'
lOpenTagLen = Len(sOpenTag)

lPos = Pos(a_sXML, sOpenTag)

If lPos = 0 Then
	sRet = 'ERROR: Invalid Element'
Else
	If Pos(a_sXML, sOpenTag, lPos + lOpenTagLen) = 0 Then
		sRet = Mid(a_sXML, lPos, Pos(a_sXML, sCloseTag) - lPos + lOpenTagLen + 1)
	Else
		sRet = 'ERROR: Multiple instances of the element - cannot retrieve a single value.'
	End If
End If

Return sRet



end function

public function string uf_getvalue (string a_sxml, string a_selement);//====================================================================
// Function: nv_xml.uf_getvalue()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	a_sxml    	
// 	value	string	a_selement	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2023/03/21
//--------------------------------------------------------------------
// Usage: nv_xml.uf_getvalue ( string a_sxml, string a_selement )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Long  	lPos
Long   	lOpenTagLen

String  	sRet
String   sOpenTag
String   sCloseTag


sOpenTag = '<' + a_sElement + '>'
sCloseTag = '</' + a_sElement + '>'
lOpenTagLen = Len(sOpenTag)

lPos = Pos(a_sXML, sOpenTag)

If lPos = 0 Then
	sRet = 'ERROR: Invalid Element'
Else
	If Pos(a_sXML, sOpenTag, lPos + lOpenTagLen) = 0 Then
		sRet = Mid(a_sXML, lPos + lOpenTagLen, Pos(a_sXML, sCloseTag) - lPos - lOpenTagLen)
	Else
		sRet = 'ERROR: Multiple instances of the element - cannot retrieve a single value.'
	End If
End If

Return sRet



end function

public function string uf_setattribute (string a_sxml, string a_selement, string a_sattribute, string a_svalue);//====================================================================
// Function: nv_xml.uf_setattribute()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	a_sxml      	
// 	value	string	a_selement  	
// 	value	string	a_sattribute	
// 	value	string	a_svalue    	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2023/03/21
//--------------------------------------------------------------------
// Usage: nv_xml.uf_setattribute ( string a_sxml, string a_selement, string a_sattribute, string a_svalue )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Long lPosAttrib
Long lPos
String sRet
String sXMLSubstring


lPos = Pos(a_sXML, '<' + a_sElement)
If lPos = 0 Then
	sRet = 'ERROR: Invalid Element'
Else
	lPosAttrib = lPos // lposA = pos of element
	sXMLSubstring = Mid( a_sXML, lPos) // substr = xml starting from element
	lPos = Pos(sXMLSubstring, a_sAttribute) //lpos = pos of attribute starting from  element
	If lPos = 0 Then
		sRet = 'ERROR: Invalid Attribute'
	Else
		lPosAttrib = lPosAttrib + lPos - 1 //lPosAttrib = pos of attribute
		sXMLSubstring = Mid( sXMLSubstring, lPos) //substr = xml starting from attribute name
		lPos = Pos(sXMLSubstring, '"') //lPos = pos of first " starting from attribute
		lPosAttrib = lPosAttrib + lPos - 1 //lPosAttrib = pos of first "
		sXMLSubstring = Mid( sXMLSubstring, lPos ) //substr = everything from 1st "
		lPos = Pos(sXMLSubstring, '"', 2) // lPos = pos of next quote
		sRet = Mid(a_sXML, 1, lPosAttrib ) + a_sValue + Mid( sXMLSubstring, lPos )
		//         XML up to just before 1st quote
	End If
End If

Return sRet



end function

public function string uf_setelement (string a_sxml, string a_selement, string a_svalue);//====================================================================
// Function: nv_xml.uf_setelement()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	a_sxml    	
// 	value	string	a_selement	
// 	value	string	a_svalue  	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2023/03/21
//--------------------------------------------------------------------
// Usage: nv_xml.uf_setelement ( string a_sxml, string a_selement, string a_svalue )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Long  lPos
Long  lOpenTagLen

String  sRet
String  sOpenTag
String  sCloseTag


sOpenTag = '<' + a_sElement + '>'
sCloseTag = '</' + a_sElement + '>'
lOpenTagLen = Len(sOpenTag)

lPos = Pos(a_sXML, sOpenTag)

If lPos = 0 Then
	sRet = a_sXML + a_sValue
Else
	If Pos(a_sXML, sOpenTag, lPos + lOpenTagLen) = 0 Then
		sRet = Mid(a_sXML, 1, lPos - 1) + a_sValue + Mid(a_sXML, Pos(a_sXML, sCloseTag) + lOpenTagLen + 1)
	Else
		sRet = 'ERROR: Multiple instances of the element - cannot set a single value.'
	End If
End If

Return sRet



end function

public function string uf_setvalue (string a_sxml, string a_selement, string a_svalue);//====================================================================
// Function: nv_xml.uf_setvalue()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	a_sxml    	
// 	value	string	a_selement	
// 	value	string	a_svalue  	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2023/03/21
//--------------------------------------------------------------------
// Usage: nv_xml.uf_setvalue ( string a_sxml, string a_selement, string a_svalue )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Long  lPos
Long  lOpenTagLen

String  sRet
String  sOpenTag
String  sCloseTag


sOpenTag = '<' + a_sElement + '>'
sCloseTag = '</' + a_sElement + '>'
lOpenTagLen = Len(sOpenTag)

lPos = Pos(a_sXML, sOpenTag)

If lPos = 0 Then
	sRet = a_sXML + sOpenTag + a_sValue + sCloseTag
Else
	If Pos(a_sXML, sOpenTag, lPos + lOpenTagLen) = 0 Then
		sRet = Mid(a_sXML, 1, lPos + lOpenTagLen - 1) + a_sValue + Mid(a_sXML, Pos(a_sXML, sCloseTag) )
	Else
		sRet = 'ERROR: Multiple instances of the element - cannot set a single value.'
	End If
End If

Return sRet



end function

public function string uf_addelement (string a_sxml, string a_sparentelement, string a_snewelement, string a_svalue, boolean a_bempty);//====================================================================
// Function: nv_xml.uf_addelement()
//--------------------------------------------------------------------
// Description: adds a node to the XML string currently value is optional doesn't support attributes
//--------------------------------------------------------------------
// Arguments:
// 	value	string 	a_sxml          	
// 	value	string 	a_sparentelement	
// 	value	string 	a_snewelement   	
// 	value	string 	a_svalue        	
// 	value	boolean	a_bempty        	if true, element is added as <NewElement/>
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2023/03/21
//--------------------------------------------------------------------
// Usage: nv_xml.uf_addelement ( string a_sxml, string a_sparentelement, string a_snewelement, string a_svalue, boolean a_bempty )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


Long  lPosStart
Long lPosEnd
Long  lOpenTagLen

String  sRet
String  sOpenTag
String  sCloseTag
String  sNewString
String  sParentSubstring

If a_bEmpty Then
	sNewString = "<" + a_snewelement + "/>"
Else
	sNewString = "<" + a_snewelement + ">" + a_svalue + "</" + a_snewelement + ">"
End If


sOpenTag = '<' + a_sParentElement + '>'
sCloseTag = '</' + a_sParentElement + '>'
lOpenTagLen = Len(sOpenTag)

lPosStart = Pos(a_sXML, sOpenTag)

If lPosStart = 0 Then
	sRet = 'ERROR: Parent element not found'
Else
	
	lPosEnd = Pos(a_sXML, sCloseTag, lPosStart)
	
	If lPosEnd < 1 Then
		sRet = 'ERROR: Closing tag of parent element not found'
	ElseIf Pos(a_sXML, sOpenTag, lPosEnd) > 0 Then
		sRet = 'ERROR: Multiple instances of parent element found'
	Else
		
		sParentSubstring = Mid(a_sXML, lPosStart, lPosEnd - lPosStart + 1)
		If Pos(sParentSubstring, sNewString) > 0 Then
			sRet = a_sXML
		Else
			sRet =  Left(a_sXML, lPosEnd - 1) + sNewString + Mid(a_sXML, lPosEnd)
		End If
	End If
	
End If

Return sRet



end function

public function string uf_parse_into_ds (string a_sxml, string a_snode, datastore a_ds);//====================================================================
// Function: nv_xml.uf_parse_into_ds()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string   	a_sxml 	
// 	value	string   	a_snode	
// 	value	datastore	a_ds   	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2023/03/21
//--------------------------------------------------------------------
// Usage: nv_xml.uf_parse_into_ds ( string a_sxml, string a_snode, datastore a_ds )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
String sXMLSubstring

If  IsValid(a_ds) Then
	
	sXMLSubstring = uf_getelement(a_sXML, a_sNode)
	a_ds.ImportString(XML!, sXMLSubstring)
	
	
End If

Return "OK"

end function

on nv_xml.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nv_xml.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

