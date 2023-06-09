$PBExportHeader$w_dwparams.srw
forward
global type w_dwparams from window
end type
type cb_back from commandbutton within w_dwparams
end type
type cb_ok from commandbutton within w_dwparams
end type
type cb_import from commandbutton within w_dwparams
end type
type dw_parms from datawindow within w_dwparams
end type
type dw_preview from datawindow within w_dwparams
end type
type mle_xml from multilineedit within w_dwparams
end type
end forward

global type w_dwparams from window
integer width = 2907
integer height = 2160
boolean titlebar = true
string title = "Datawindow Parms"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_back cb_back
cb_ok cb_ok
cb_import cb_import
dw_parms dw_parms
dw_preview dw_preview
mle_xml mle_xml
end type
global w_dwparams w_dwparams

type variables
s_dwparms i_dwparms

end variables
on w_dwparams.create
this.cb_back=create cb_back
this.cb_ok=create cb_ok
this.cb_import=create cb_import
this.dw_parms=create dw_parms
this.dw_preview=create dw_preview
this.mle_xml=create mle_xml
this.Control[]={this.cb_back,&
this.cb_ok,&
this.cb_import,&
this.dw_parms,&
this.dw_preview,&
this.mle_xml}
end on

on w_dwparams.destroy
destroy(this.cb_back)
destroy(this.cb_ok)
destroy(this.cb_import)
destroy(this.dw_parms)
destroy(this.dw_preview)
destroy(this.mle_xml)
end on

event open;dw_parms.InsertRow(0)
end event

type cb_back from commandbutton within w_dwparams
string tag = "1"
integer x = 1207
integer y = 1936
integer width = 247
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Back"
end type

event clicked;This.Enabled = False

dw_preview.Hide()
mle_xml.Show()
cb_import.Text = "Import"
cb_ok.Text = "Next"
cb_import.X = 2560
cb_import.Y = 40
dw_parms.Width = 2496
dw_parms.Height = 96
dw_parms.DataObject = "d_dwtype"
dw_parms.InsertRow(0)
dw_parms.SetItem(1, "dw_type", i_dwparms.cType)
cb_ok.Tag = "1"

end event

type cb_ok from commandbutton within w_dwparams
string tag = "1"
integer x = 1513
integer y = 1936
integer width = 247
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Next"
end type

event clicked;If This.Tag = "1" Then
	This.Tag = "2"
	This.Text = "Create"
	
	i_dwparms.cType = dw_parms.GetItemString(1, "dw_type")
	i_dwparms.sXML = mle_xml.Text
	
	gf_set_default_dw_parms(i_dwparms)
	
	dw_parms.DataObject = "d_dwparms"
	dw_parms.InsertRow(0)
	
	dw_parms.SetItem(1, "textx", i_dwparms.lTextX)
	dw_parms.SetItem(1, "texty", i_dwparms.lTextY)
	dw_parms.SetItem(1, "textwidth", i_dwparms.lTextWidth)
	dw_parms.SetItem(1, "textfontsize", i_dwparms.lTextFontSize)
	dw_parms.SetItem(1, "textweight", i_dwparms.lTextWeight)
	dw_parms.SetItem(1, "textcolor", i_dwparms.lTextColor)
	dw_parms.SetItem(1, "headerheight", i_dwparms.lHeaderHeight)
	dw_parms.SetItem(1, "detailheight", i_dwparms.lDetailHeight)
	dw_parms.SetItem(1, "backcolor", i_dwparms.lBackColor)
	dw_parms.SetItem(1, "colx", i_dwparms.lColX)
	dw_parms.SetItem(1, "coly", i_dwparms.lColY)
	dw_parms.SetItem(1, "colwidth", i_dwparms.lColWidth)
	dw_parms.SetItem(1, "colheight", i_dwparms.lColHeight)
	dw_parms.SetItem(1, "colfontsize", i_dwparms.lColFontSize)
	dw_parms.SetItem(1, "colweight", i_dwparms.lColWeight)
	dw_parms.SetItem(1, "colcolor", i_dwparms.lColColor)
	dw_parms.SetItem(1, "colbkgcolor", i_dwparms.lColBKGColor)
	dw_parms.SetItem(1, "colborder", i_dwparms.lColBorder)
	dw_parms.SetItem(1, "vertspacing", i_dwparms.lVertSpacing)
	dw_parms.SetItem(1, "tabsequence", i_dwparms.lTabSequence)
	
	dw_preview.TriggerEvent("ue_preview")
	mle_xml.Hide()
	dw_preview.Show()
	dw_parms.Width = 2757
	dw_parms.Height = 1016
	cb_import.Text = "Preview"
	cb_import.X = 1339
	cb_import.Y = 1096
	
	cb_back.Enabled = True
ElseIf This.Tag = "2" Then
	dw_preview.TriggerEvent("ue_preview")
	Hide(Parent)
	OpenWithParm(w_createdw, i_dwparms)
	Close(Parent)
End If
/*<columnset>
<column>dan</column>
<column>fred</column>
</columnset>*/

end event

type cb_import from commandbutton within w_dwparams
integer x = 2560
integer y = 40
integer width = 247
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Import"
end type

event clicked;long lFile

string sFilename
string sPathname
string sLine
string sXML


if this.text = "Import" then
	if GetFileOpenName("Import XML file...", sPathname, sFilename, "*", "All Files (*.*), *.*") > 0 then
		lFile = FileOpen(sPathname)
		if lFile > 0 then
			do while FileRead(lFile, sLine) > 0
				if sXML <> "" then
					sXML += "~r~n"
				end if
				sXML += sLine
			loop
			
			FileClose(lFile)
			mle_XML.text = sXML
		end if
	end if
else
	dw_preview.TriggerEvent("ue_preview")
end if
end event

type dw_parms from datawindow within w_dwparams
integer x = 50
integer y = 40
integer width = 2496
integer height = 96
integer taborder = 10
string title = "none"
string dataobject = "d_dwtype"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_preview from datawindow within w_dwparams
event ue_preview ( )
boolean visible = false
integer x = 50
integer y = 1208
integer width = 2757
integer height = 688
integer taborder = 20
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_preview();string sError


dw_parms.AcceptText()

i_dwparms.lTextX = dw_parms.GetItemNumber(1, "textx")
i_dwparms.lTextY = dw_parms.GetItemNumber(1, "texty")
i_dwparms.lTextWidth = dw_parms.GetItemNumber(1, "textwidth")
i_dwparms.lTextFontSize = dw_parms.GetItemNumber(1, "textfontsize")
i_dwparms.lTextWeight = dw_parms.GetItemNumber(1, "textweight")
i_dwparms.lTextColor = dw_parms.GetItemNumber(1, "textcolor")
i_dwparms.lHeaderHeight = dw_parms.GetItemNumber(1, "headerheight")
i_dwparms.lDetailHeight = dw_parms.GetItemNumber(1, "detailheight")
i_dwparms.lBackColor = dw_parms.GetItemNumber(1, "backcolor")
i_dwparms.lColX = dw_parms.GetItemNumber(1, "colx")
i_dwparms.lColY = dw_parms.GetItemNumber(1, "coly")
i_dwparms.lColWidth = dw_parms.GetItemNumber(1, "colwidth")
i_dwparms.lColHeight = dw_parms.GetItemNumber(1, "colheight")
i_dwparms.lColFontSize = dw_parms.GetItemNumber(1, "colfontsize")
i_dwparms.lColWeight = dw_parms.GetItemNumber(1, "colweight")
i_dwparms.lColColor = dw_parms.GetItemNumber(1, "colcolor")
i_dwparms.lColBKGColor = dw_parms.GetItemNumber(1, "colbkgcolor")
i_dwparms.lColBorder = dw_parms.GetItemNumber(1, "colborder")
i_dwparms.lVertSpacing = dw_parms.GetItemNumber(1, "vertspacing")
i_dwparms.lTabSequence = dw_parms.GetItemNumber(1, "tabsequence")

this.create(gf_create_from_xml(i_dwparms, sError, this), sError)
end event

type mle_xml from multilineedit within w_dwparams
integer x = 50
integer y = 140
integer width = 2757
integer height = 1756
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean vscrollbar = true
boolean autohscroll = true
borderstyle borderstyle = stylelowered!
end type

