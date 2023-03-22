$PBExportHeader$dynamicxmltodw.sra
$PBExportComments$Generated Application Object
forward
global type dynamicxmltodw from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
boolean g_bRestart
end variables

global type dynamicxmltodw from application
string appname = "dynamicxmltodw"
end type
global dynamicxmltodw dynamicxmltodw

on dynamicxmltodw.create
appname="dynamicxmltodw"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on dynamicxmltodw.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;Do
	g_bRestart = False
	Open(w_dwparams)
Loop While g_bRestart

end event

