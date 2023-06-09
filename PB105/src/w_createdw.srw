$PBExportHeader$w_createdw.srw
forward
global type w_createdw from window
end type
type cb_restart from commandbutton within w_createdw
end type
type mle_syntax from multilineedit within w_createdw
end type
type dw_1 from datawindow within w_createdw
end type
end forward

global type w_createdw from window
integer width = 2921
integer height = 2144
boolean titlebar = true
string title = "Datawindow"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_restart cb_restart
mle_syntax mle_syntax
dw_1 dw_1
end type
global w_createdw w_createdw

on w_createdw.create
this.cb_restart=create cb_restart
this.mle_syntax=create mle_syntax
this.dw_1=create dw_1
this.Control[]={this.cb_restart,&
this.mle_syntax,&
this.dw_1}
end on

on w_createdw.destroy
destroy(this.cb_restart)
destroy(this.mle_syntax)
destroy(this.dw_1)
end on

event open;
Long lFile

s_dwparms dwparms

String sSyntax
String sError
String sPathName
String sFileName


dwparms = Message.PowerObjectParm

sSyntax = gf_create_from_xml(dwparms, sError, dw_1)

mle_syntax.Text = sSyntax

dw_1.Create(sSyntax, sError)

If sError <> "" Then
	MessageBox("XML2DW", "DW Syntax Error:~r~n~r~n" + sError)
Else
	If GetFileSaveName("Export DW Syntax", sPathName, sFileName, "srd", "DataWindow Syntax (*.srd),*.srd") > 0 Then
		lFile = FileOpen(sPathName, LineMode!, Write!, LockWrite!, Replace!)
		If lFile > 0 Then
			FileWrite(lFile, "$PBExportHeader$" + sFileName + "~r~n" + sSyntax)
			FileClose(lFile)
		End If
	End If
End If

end event

type cb_restart from commandbutton within w_createdw
integer x = 1303
integer y = 1916
integer width = 247
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Restart"
end type

event clicked;g_bRestart = True

Close(Parent)

end event

type mle_syntax from multilineedit within w_createdw
integer x = 46
integer y = 20
integer width = 2775
integer height = 864
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean vscrollbar = true
boolean autohscroll = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_createdw
integer x = 46
integer y = 888
integer width = 2775
integer height = 988
integer taborder = 20
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

