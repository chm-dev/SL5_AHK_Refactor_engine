;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ please use this ! as first line in every script before all includes! :)
isDevellopperMode=true ; enth�llt auch update script.
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#Include init_global.init.inc.ahk


#InstallKeybdHook

DetectHiddenWindows,on
SetTitleMatchMode,2



#IfWinActive ahk_class SciTEWindow 

; Refactoring Engine
ExtractMethod:
Ctrl_Alt_M:
Strg_Alt_M:
Ctrl & m::
      Last_A_This:=A_ThisFunc . A_ThisLabel
      ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)

  if( !GetKeyState("alt", "P") ){
    Suspend,on
    send,^
    Suspend,off
    return
  }
  ;~ jkj

  ;~ MsgBox,15-06-12_22-08
ClipboardBackup := Clipboard
Clipboard:=""
loopCounter:=0
c:=copySelection2clipBoard()
;~ c=%Clipboard%

 defaultInput:=""
 cMethodBody := ""
 line:=""
 lineNotEmpty:=""
 Loop , Parse , c, `n
{
  line := A_LoopField
  
  if(!defaultInput)
    defaultInput:=RTrim(RegExReplace(line,"i).*?(\w+).*?","m$1") , "`s`n`t`r")
  ;~ MsgBox, %A_LoopField% 
  line := RegExReplace(line,"^[\s\n\t\r]+","")
  if(StrLen(line))
    lineNotEmpty := line
  cMethodBody .= "   "  .  line . "`n"
}
; 
returnValue :=RegExReplace( lineNotEmpty ,"i)^[`a.]*?([a-z]+)[^w]*$","$1")
;~ MsgBox,'%returnValue%' = returnValue `n 
;~ Reload
cMethodBody := RegExReplace(cMethodBody,"i)[\s\n\t\r]+$","")
  inputH := 200
  timeoutSec := ""
    SetTitleMatchMode,3
    ;~ msg= Extract Clipboard as Method? 
    
    msg=Extract as Method: Method Name?
    InputBox, methodName , %msg%,%msg% , , 200 , %inputH%  , 330 , %inputH% , , %timeoutSec%  , %defaultInput%
    WinSet, AlwaysOnTop, On, %msg%
    if ErrorLevel = 1  
      return
    WinWaitNotActive, %msg% 
    send,{esc} ; go out of search text box or so
    Sleep,10
  markerXXXXstring :="xxxxxxxx" . "xxxxxxxx"
    Send,{BackSpace} `; %markerXXXXstring%
    
    
    ;~ mName=%defaultInput%
    
    ;~ i Case-insensitive matching, which treats the letters A through Z as identical to their lowercase counterparts. 
    ;~ `a In v1.0.46.06+, `a recognizes any type of newline, namely `r, `n, `r`n, `v/VT/vertical tab/chr(0xB), `f/FF/formfeed/chr(0xC), and NEL/next-line/chr(0x85). In v1.0.47.05+, newlines can be restricted to only CR, LF, and CRLF by instead specifying (*ANYCRLF) in uppercase at the beginning of the pattern (after the options); e.g. im)(*ANYCRLF)^abc$. 
    defaultInput := LTrim( RegExReplace( RegExReplace( cMethodBody , "i)[^w]*?([a-z_0.9]+)[^w]*?" , ", $1" ) ,"im)[\s\n\t\r]+" , " "),"`n,`s")  ; ugly buti dont have tim :-D ;)
    ;~ MsgBox,%defaultInput% 
    ;~ Reload
        msg=Method Parameters of '%methodName%' ?
    InputBox, methodParameters , %msg%,%msg% , , 555 , %inputH%  , 330 , %inputH% , , %timeoutSec%  , %defaultInput%
    WinSet, AlwaysOnTop, On, %msg%
    if ErrorLevel = 1  
      return
    WinWaitNotActive, %msg% 

    
    Send,{Blind}
    ;~ Send,{Home}{enter}{up}%mName% 
    ; 
    methodSignature := methodName . "(" . methodParameters . ")"
    Suspend,on
    Send,`n%methodSignature%`n 
    Sleep,100

    c1=`n%methodSignature%{`n
    c3= `n   return %returnValue% `n}
    c := c1 . cMethodBody . c3
    ;~ StringReplace,c,c,`n`n,`n
  Clipboard := c
  
  Send,{CtrlDown}{End}{CtrlUp}
  SetKeyDelay,50,50
  Sleep,200
  Send,^v
  Send,^f
  Send,%markerXXXXstring%{enter}{del}{esc}
  Send,{Space}
  ;~ Send,{Blind}

  Suspend,off
  ;~ MsgBox,new function is inside your clipboard. please paste it.
Clipboard := ClipboardBackup
send,{Blind}
return



;~ d_12356 := 12356
;~ 2, 2, 2, 
; change commas
; different stiles 
alt & c::
    Last_A_This:=A_ThisFunc . A_ThisLabel
  	ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
  doSelectLine := false
    if( GetKeyState("Ctrl", "P") ) 
  {
    ; thats bullshit. it shuld never happen. to go in here. 
    ; lets better make an normal copy then? 
    Suspend,on
    send,^c{Blind}
    Suspend,off
    return
  }

  
  if( GetKeyState("shift", "P") ) 
  {
    doSelectLine:=true
    c := copyLineOrWord2clipBoard(doSelectLine)
  }
  else 
  {
  doSelectLine:=false
    ;~ ; normal copy. dont change it
    Suspend,on
    c := copySelection2clipBoard()
    if(!c)
    {
      Suspend,off
      return
    }
; 1,  2:5:5: 5
     ;~ Send,^c
  }
  Suspend,On
  c := trim(c)
  ClipboardBackup:= Clipboard

  if(!doSelectLine)
{
  timeoutSec:=0
  inputH:=150
  
      msg= wiche delimiter would you replace? alle kind of delimiters is default. please insert a regular expression`n or Esc for cancel this refactoring
 delimiterOld := "[^\w]" 
    InputBox,delimiterOld,%msg%,%msg% , , 400 , %inputH%  , 330 , %inputH% , , %timeoutSec%  , %delimiterOld%
    WinSet, AlwaysOnTop, On, %msg%
    if ErrorLevel = 1  
      return 
  
  ; newline then its easy to change it later with additional shift without selecting it
  ;~ Send,`n
      msg= choose delimiter you like for your selection`n or Esc for cancel this refactoring
        if(RegExMatch(c, "," )){
    defaultInput := ":"
  }else if(RegExMatch(c, ":" )){
    defaultInput := " "   
  }else{ 
    defaultInput := ","
  }
    InputBox,delimiter,%msg%,%msg% , , 400 , %inputH%  , 330 , %inputH% , , %timeoutSec%  , %defaultInput%
    WinSet, AlwaysOnTop, On, %msg%
    if ErrorLevel = 1  
      return 
;  l l l ll k k jku i o 1uio 2uio 3 
;~  , 4,5 6  ,1,23 ,1,2,3 ,1,2,3 ,1,2 ,3  ,1 2 3 1  2  3
    ;~ Clipboard := SubStr(  RegExReplace(c , "i)(\s*?[a-z0-9]+?)[^\w]?" , "$1" . delimiter . "")   , 1 , -1) ; works
    Clipboard := RegExReplace(c , "i)(\s*?[a-z0-9]+?)" . delimiterOld , "$1" . delimiter . "")   
  ; 1, 2, 3
}
  if(doSelectLine)
{  
  ; RegExMatch() returns the position
  if(RegExMatch(c, "," )){
    Clipboard := RegExReplace(c , "," , ":")   
  }else if(RegExMatch(c, ":" )){
    Clipboard := RegExReplace(c , "`:" , ",")   ; this the beep ? [:]
    ToolTip3sec(A_LineNumber)
  }else{ 
  ;~ if(RegExMatch(c, RegExMatch(c, "\s" ) )){
    Clipboard := RegExReplace(c , "([^,])\s(\s*)" , "$1,$2")   
  }
}
   ; i: i: i:
    ;, :,  , :, :,  ,  , :,  , 4, :,  , 4, :,  , 4, :,  , 4, :, 
    ;: i: i:
    ;~ MsgBox,%Clipboard% = Clipboard 
    ;~ Reload

;~ 1, 2, 3, 5, 6, 
if(Clipboard == ClipboardBackup)
{
  ;~ ToolTip,-----------
  ;~ Sleep,2000
  c2:=""
strLen_c := StrLen(c)
  Loop, %strLen_c%
    c2 .= SubStr(c,A_Index,1) . ", "
  Clipboard := c2
}
   ; i:   i:   i:
    ;, :,  , :, :,  ,  , :,  , 4, :,  , 4, :,  , 4, :,  , 4, :, 
    ;: i: i:
    ;~ MsgBox,%Clipboard% = Clipboard 
    ;~ Reload

Send,{CtrlDown}v{CtrlUp}
Clipboard := ClipboardBackup
  ; newline then its easy to change it later with additional shift without selecting it
  ;~ ToolTip3sec("press Shift+Alt+c if you want change comma style for this line.`npress backspace if you bring your code back to last line.")
;~ Send,{CtrlDown}v{CtrlUp}{home}{Space}{Shift Down}{home}{Shift up}{BackSpace} ; jumps into new line and waits for backspace
Suspend,off
Send,{Blind}
;~ Now when you are coding you can quickly wrap commay with a quick cmd+shift+c for totals line or selection and the selection will be wrapped with quotes.  if you type it additional with shift line is wraped. try it :)
return

;~ bugs if you us the follwoing with shift alt c
;~ 0: 1: 2: 3: 4: 5: 6:
;~ a: b: c:^^^^


Surrounding_with_Quotes:
Ctrl & q::
Ctrl & j::
    Last_A_This:=A_ThisFunc . A_ThisLabel
  	ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
    
  doSelectLine := false
  if( GetKeyState("shift", "P") ) 
  {
    doSelectLine := true
    ;~ ToolTip,'%doSelectLine%' = doSelectLine `n 
  }
  
;   uuu 
c := copyLineOrWord2clipBoard(doSelectLine)
Suspend,On
;~ lk 
; it toggles beetwn ( " and empty  and much more. try ;) . if you press shift it sorrounds the lline. default is the actually word
if(doSelectLine)
{
  c := trim(c)
  az_wd := ".*"
}
else
  az_wd := "[\w\d_���]+"
az_wd1 = "%az_wd%"
az_wd2 = `%%az_wd%`%
az_wd3 = \(%az_wd%\)
az_wd4 = \{%az_wd%\}
;~ oiuoi lkjl oi o 
if(RegExMatch(c,az_wd1)){
  ; " c " => c
  Clipboard := RegExReplace(c,"""","")   . " " 
}else if(RegExMatch(c,az_wd2)){
  ;~ Clipboard := RegExReplace(c,"%","""")   . " "  
; % => "
  Clipboard := RegExReplace(c,"%","""")   . " "  
}
else{
  if(doSelectLine){
    if(RegExMatch(c,az_wd4)){    
      ; { c } => c
      Clipboard := RegExReplace(c,"\{(.*)\}","""$1""")   . " "  
    }
    else if(RegExMatch(c,az_wd3)){  
      Clipboard := RegExReplace(c,"\((.*)\)","{$1}")   . " "  
      ; ( c ) => { c }
    }
    else{
      ; c => ( c )
      Clipboard := "(" . c . ")" . " " 
      ;~ Clipboard := RegExReplace(c,"""(.*)""","($1)")   . " "  lkjlkj 
    }
  }else{
    ; c => % c %
    Clipboard := RegExReplace(c,"([^\s]+)$","%$1%") . " " 
}
}

if(doSelectLine)
Send,{CtrlDown}v{CtrlUp}{home}{Space}{Shift Down}{home}{Shift up}{BackSpace} ; jumps into new line and waits for backspace
else
Send,{CtrlDown}v{CtrlUp}  
    Suspend,off
;~ Now when you are coding you can quickly wrap text in quotes with a quick cmd+j and the selection will be wrapped with quotes.  if you type it additional with shift line is wraped. try it :)
send,{Blind}
return






^ & enter::
  Last_A_This:=A_ThisFunc . A_ThisLabel
  ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
  lll(A_LineNumber, "keys_SL5_AHK_Refactor_engine.ahk",Last_A_This)
MsgBox,%Last_A_This% = Last_A_This `n 15-05-18_13-46
Suspend,on
  send,{ShiftDown}{Home}^c{ShiftUp}
  temp =RegExReplace("i)uff(\d+)oh", "x$1yz", ReplacementCount)  
sourceLine=%Clipboard%  
NewStr := RegExReplace(sourceLine, "^(\s*)RegExReplace(\s*)$", "$1" . temp . "$2")  
  send,%NewStr%
Suspend,off 
MsgBox ,%NewStr% 
return

;~ RegExReplacelll(A_LineNumber, "keys_SL5_AHK_Refactor_engine.ahk",Last_A_This)

^ & Space::
;~ MsgBox,lllkk
  Last_A_This:=A_ThisFunc . A_ThisLabel
  ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
  lll(A_LineNumber, "keys_SL5_AHK_Refactor_engine.ahk",Last_A_This)
  Suspend,on
  Send,^i
  Suspend,off
return

Tab::
    ; usaly i dont use tabs inside text. onliy for block indent
    Last_A_This:=A_ThisFunc . A_ThisLabel
  	ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
    send,{Home}
    Suspend,on
    ;~ send,{Space4}{Space}{Space}
    send,{Tab}{down}
    Suspend,off
return



#IfWinActive ahk_class SciTEWindow 
;~ i: ::  : :: ::  :  : ::  : i: ::  : :: ::  :  : ::  : i: ::  : :: ::  :  : ::  : i: ::  : :: ::  :  : ::  : i: ::  : :: ::
;~ i dont know why but this days ^ key not work in scite. so try a dirty bugFix
^::
  Last_A_This:=A_ThisFunc . A_ThisLabel . not_implemented_jet
    ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)

  If ( GetKeyState("shift", "P") || GetKeyState("alt", "P")  || GetKeyState("tab", "P") ) 
return
Suspend,on
SendRaw,^
Send,{Space}
Suspend,off
return

; ^ ui ^^^ ^{Space}^^^^press

alt & f7::
  
  not_implemented_jet := not implemented jet
  ; todo create function for word selection
  Last_A_This:=A_ThisFunc . A_ThisLabel . not_implemented_jet
    ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)


return


tillagoto_properties:
;~ TillaGoto tillagoto.properties s
;~ same as strg+b in jetbrains
;~ # Specify the hotkey you want to use to go to a function/label on whose name the
;~ # caret is located. Similar to the middleclicking feature.
;~ tillagoto.hk.goto.def=+Enter
; this worked: open it with notepad, save it to desktop, copy it back, and click yes to do it as administrator.
StrgB:
^b::
    Last_A_This:=A_ThisFunc . A_ThisLabel 
    ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
; this worked: open it with notepad, save it to desktop, copy it back, and click yes to do it as administrator.
;~ http://www.autohotkey.com/board/topic/38186-tillagoto-go-to-functions-labels-hks-in-your-script/page-10#entry704036
;~ MsgBox,15-06-10_12-51
;~ Suspend,on
; not use tillagoto.hk.goto.def=+Enter
  ;~ SendEvent,{ShiftDown}{Enter}{ShiftUp} ; dont work
  ;~ Suspend,off
return

Ctrl_f:
^f::
;~ ctr alt i
 Suspend,on
 Send,{Blind} 
 Send,{CtrlDown}{AltDown}i{AltUp}{CtrlUp}
 Send,{Blind}

    Last_A_This:=A_ThisFunc . A_ThisLabel . " p"
    ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
  lll(A_LineNumber, "keys_SL5_AHK_Refactor_engine.ahk",Last_A_This)
   Suspend,Off
   send,{Blind}
return

Ctrl & Enter::
    Last_A_This:=A_ThisFunc . A_ThisLabel . " p"
    ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
    Send,{Blind}
    Send,{End}{ShiftDown}{Home}
    
    ClipboardB:=Clipboard
    Loop,15
    {
      Send,^c
      Sleep,10
      if(ClipboardB != Clipboard)
        break
      Sleep,10
      
    }
    codeLine=%Clipboard% ; 
    ;~ codeLine := RegExReplace(codeLine, "\s*(:?=)\s*", " $1 ", 1)  ;  
     deli1 := StrSplit(codeLine, "(") 
    deli1close := StrSplit(codeLine, ")") 
    deli1diff := deli1.MaxIndex() - deli1close.MaxIndex()
    
    deli4open := StrSplit(codeLine, "{","") 
    deli4close := StrSplit( codeLine, "}","") 
    deli4diff := deli4open.MaxIndex() - deli4close.MaxIndex()
    
    deli2open := StrSplit( codeLine, "[","") 
    deli2close := StrSplit( codeLine, "]","") 
    deli2diff := deli2open.MaxIndex() - deli2close.MaxIndex()
    
    deli3open := StrSplit(" " . codeLine, """","") 
    deli3diff := deli3open.MaxIndex() - 1
    ;~ MsgBox,  % deli3open.MaxIndex()
  ;~ du = (["ja"])
    add:=""
    if(deli3diff > 0 && Mod(deli3diff, 2) != 0 )
      Loop,%deli3diff% 
        add .= """"
    if(deli2diff > 0)
      Loop,%deli2diff% 
        add .= "]"
    if(deli1diff > 0)
      Loop,%deli1diff% 
        add .= ")"
    if(deli4diff > 0)
      Loop,%deli4diff% 
        add .= "{return}{tab}{}}"
    add .= "{Space}`;{Space}"
    ;~ MsgBox, %count_deli% := count_deli `n
    ;~ return ;  { k
    ; 
       ; 
    
    
    Send,{Blind}
    Suspend,on
    send,{Right}
    ;~ Sourceline=%Clipboard% = Clipboard `n 
    ;~ varName:=SubStr(Clipboard,1,20)
    ;~ varName:=RegExReplace(varName,"[^\w_]+","_")
    strLen_add := StrLen(RegExReplace(add,"{[^}]+}","_" )) ; 
         if(debug65)
      lll(A_LineNumber, "keys_SL5_AHK_Refactor_engine.ahk",Last_A_This . " " . %codeLine%)

    if(deli4diff > 0)
      strLen_add += 1
    Send,%add%{left %strLen_add%}  
         if(debug65)
      lll(A_LineNumber, "keys_SL5_AHK_Refactor_engine.ahk",Last_A_This . " " . %codeLine%)

    Suspend,off
return

Ctrl_v:
Ctrl & v::
Ctrl_Alt_v:
Str_alt_v:
  Last_A_This:=A_ThisFunc . A_ThisLabel . not_implemented_jet
    ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)

;~ ju_hu = ju hu lkjllkjllkjlstrg alt v strg alt v strg alt v strg alt v strg alt v 
; its writes a variable = expression ; input is the complete line. so pls use for each variable a exclusive line
  If (GetKeyState("Alt", "p"))
  {
    ctrl_alt_v()
    return
  }

Ctrl_Shift_v:
  If (GetKeyState("Shift", "p")) {
    runCopyQ_Ctrl_Shift_v()
  }
  Send,^v
  Suspend,off
  lll(A_LineNumber, "keys_SL5_AHK_Refactor_engine.ahk",Last_A_This)
return

getInputBoxOnTop( title, prompt, timeout, default)
getInputBoxOnTop( title, prompt, timeout, default){
  MsgBox, not yet implemented 15-06-12_15-06
  ;~ InputBox, value , %title% , %prompt% , , width, height, x, y, font, %timeout% , %default% 
  return value
}


;
; CCCCClipboard ClipboardClipboard Clipboard
; Clipboard Clipboard Clipboard Clipboard
#IfWinActive ahk_class SciTEWindow 

Ctrl_Shift_z:
+^z::
  Last_A_This:=A_ThisFunc . A_ThisLabel
  ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
  Suspend,on
  send,^y ; redo
  Suspend,off
return




Ctrl_Shift_up:
+^up::
  Suspend,on
  send,^t{up}
  Suspend,off
  Last_A_This:=A_ThisFunc . A_ThisLabel
  ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
return
Ctrl_Shift_down:
+^Down::
  ;~ If (GetKeyState("Shift", "p")) {
;  if u want trigger ^z and you missed. its creates lots of confusion. and i nealy never use this funktion. so turn it off.
  Suspend,on
  send,{Down}
  ;~ {Home}
  Send,^t
  ;~ ^t{Down}
  Suspend,off
  Last_A_This:=A_ThisFunc . A_ThisLabel
  ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
return


;test

^t::
;  if u want trigger ^z and you missed. its creates lots of confusion. and i nealy never use this funktion. so turn it off.
    Last_A_This:=A_ThisFunc . A_ThisLabel
  	ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
return

; seems to delete many rows. seems dagerous for me
^r::
    Last_A_This:=A_ThisFunc . A_ThisLabel
  	ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
    Suspend,on
    Send,{Blind}
    ControlSend,,^h,ahk_class SciTEWindow 
    Suspend,Off
return


;~ BTW there is a great shortcut implemented in scite: SHIFT + %
;~ thats the standard editor for autohotkey. i want shortcats like i use it in phpstorm
  ;~ StrgY:
  ^y::
    Last_A_This:=A_ThisFunc . A_ThisLabel
  	ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
    Suspend,on
    Sleep,100
    Loop,15
    {
    If ( !GetKeyState("Ctrl", "P") ) 
    {
      ;~ Suspend,off
      ;~ return
      break
    }
    Send,{CtrlUp} ; {Blind}
    Sleep,100
    }
    If ( GetKeyState("Ctrl", "P") ) 
    {
      Suspend,off
      return
      ;~ break
    }
    ; do it only it
    ;~ ControlSend,,{Home}{Shift}{End}{ShiftUp},ahk_class SciTEWindow 
    ControlSend,,{Home}{ShiftDown}{End}{ShiftUp},ahk_class SciTEWindow 
    ControlSend,,{Del}{BackSpace}{Right},ahk_class SciTEWindow 
    Suspend,Off
    lll(A_LineNumber, "keys_SL5_AHK_Refactor_engine.ahk",Last_A_This)
  return
^BackSpace:: ; works but we dont need so many shortcuts n15-05-12_15-53
;~ !BackSpace:: ; works but we dont need so many shortcuts n15-05-12_15-53
+BackSpace:: ; works 
  setCaret2lastEditPosition() ; 
return

;~ !	Alt
;~ ^	Control
;~ +	Shift

+^BackSpace::
  If (GetKeyState("Shift", "p")) {
    ;~ GetKeyState() function returns true (1) for "on" and false (0) for "off").
    ;~ P: holding down. You can force the hooks to be installed by adding the #InstallKeybdHook and/or #InstallMouseHook directives to the script.
    Sleep,10
    KeyWait, Shift,L
    Sleep,10
;~ MsgBox,this shortcut is buggy. pls use shift + backspace or ctrl + backspace
    Last_A_This:=A_ThisFunc . A_ThisLabel
  	ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
    setCaret2lastEditPosition()
}
return

setCaret2lastEditPosition()
{
      Last_A_This:=A_ThisFunc . A_ThisLabel
  	ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
    Suspend,on
    Send,{Blind}
    ;~ Sleep,10
    ;~ Send,{Blind}
    If (!GetKeyState("z", "P") && !GetKeyState("y", "P")) {
    ; do it only its not pressed
  ;~ SetKeyDelay,0
  Suspend,on
  SetKeyDelay,40
  ControlSend,,{CtrlDown}zy{CtrlUp},ahk_class SciTEWindow 
  ControlSend,,{up 6}{Down 12}{up 6},ahk_class SciTEWindow 
  Suspend,off
}
;~ MsgBox,lh
Suspend,Off
send,{Blind}
  return
}

; thats the standard editor for autohotkey. i want shortcats like i use it in phpstorm
  ;~ StrgY:78987877
  ;~ asdkf
  ;~ asfdzyzyzy
  
  
NumpadAdd::
;~ MsgBox,asdftesttest++++++++
    Suspend,on
    ControlSendRaw,,+,ahk_class SciTEWindow 
    Suspend,Off
  return

;~ #IfWinActive ahk_class SciTEWindow 
  ; thats the standard editor for autohotkey. i want shortcats like i use it in phpstorm
  ; comment
  ; ctrl shift b
  ^NumpadDiv::
      Last_A_This:=A_ThisFunc . A_ThisLabel
  	ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)

    ;Send,{CtrlDown}{ShiftDown}b{ShiftUp}{CtrlUp
    Send,^q{Down}
  return
  
SetTitleMatchMode,2
#IfWinActive, ahk_class SciTEWindow 
; eventually you need to push ; STRG+SHIFT+%/5  means 3 keys . dont know whey but its sometimes needet. so whey dont use it anytime
Ctrl_Shif_5:
Shift_5:
; %test% %test% := test `n %test% := test `n
^%::
+%::
  Last_A_This:=A_ThisFunc . A_ThisLabel
  ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
  ;~ MsgBox,StrLen(clipboard)
  
  if(StrLen(clipboard) < 100 )    
  {
 ; !!!!!! warning \w in autohotkey also includes numbers !!!
    c = %clipboard% 
    cAdd :=  "(line:%A_LineNumber%)" ; 
  
    ;~ lenc:=StrLen(c), %cAdd% = cAdd (line:%A_LineNumber%) `n % 
    leftSteps:=StrLen(c) + StrLen(cAdd) + 7
;~ %kk% = kk `n ttt%ttt% = ttt `n  , %cAdd% = cAdd "(line:3845)" `n % 
; %h% = h %cAdd% `n , %cAdd% = cAdd "(line:�)" `n % 
    m := RegExReplace(c,"i)\b([a-z]+[\w\d_]*)\b",", %$1% = $1 " . cAdd . " ``n ") ; %key%= value
    ;%Clipboard% = Clipboard `n   ff
    ;~ MsgBox,%c% %m%
    ;~ return

    ;~ m := RegExReplace(c,"\b([a-z]+[\w\d_]*)\b",", '%$1%' = $1 ``n ") ; '%key%' = value
    ;~ m := RegExReplace(c,"(\w[\w\d_]*)[^\w\d_]*?",", '%$1%' = $1 ``n ")
    m := trim(SubStr(m,2,StrLen(m) - 1))  .  " "
    ;~ Suspend,on
    ;~ MsgBox,'%m%' = m `n 



    Send,% convert123To_NumPad123(m) 
    SetKeyDelay,20,22
    Send,{ShiftDown}{Left %leftSteps%}{ShiftUp}
    ; CCcCCcCCc
      ; asldf lkj lk lkj  '%asldf%' = asldf `n  , '%lkj%' = lkj `n  , '%lk%' = lk `n  , '%lkj%' = lkj `n %leftSteps% = leftSteps `n  %uuu% 
      }
;      kkk%lenc% = lenc `n %iiiiiiii% = iiiiiiii `n 
  return






copySelection2clipBoard(){
  ;~ WinGetActiveTitle,at
Clipboard:=""
a_TimeIdleStart := A_TimeIdle
   loopCounter:=0
   
   while(!clipboard && loopCounter < 100){
    ;~ IfWinNotActive,%at% 
      ;~ return
    ; be sure that cursor not aut of the carret this shortime
    if(a_TimeIdleStart > A_TimeIdle) 
      return
    Send,^c
   ;:1:2: 3
    loopCounter += 1
    Sleep,1
   }
   c=%Clipboard%
   Suspend,Off
   if(!c)
   {
   return false
   }  
   
  return c 
}   

copyLineOrWord2clipBoard(doSelectLine){
  Suspend,on
   if(doSelectLine){
   Send,{Home}{ShiftDown}
   Send,{ShiftDown}{End}
   } else {
   Send,^{Left 3}{ShiftDown}  
   Send,{ShiftDown}^{Right 3}
   }
   Send,{ShiftUp}
   
   c:=copySelection2clipBoard()
   return c 
}   
; lk luuu:u:u0
ctrl_alt_v(){
   WinGetActiveTitle,activeTitle
   WinSet, AlwaysOnTop, Off, %activeTitle%
   Last_A_This:=A_ThisFunc . A_ThisLabel . " p"
   ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
   Suspend,on
   
   
   doSelectLine:=true
   copyLineOrWord2clipBoard(doSelectLine)
   Send,{Blind}
   send,{Left}

   ; bug
   ;~ E:\temp\2015-06-10 09_31_37-Aufnahme l�uft....png
   ;~ e_temp____ := E:\te"mp\2015-06-10 09_31_37-Aufnahme l�uft....p
   
   ;~ clipboard clipboard
   varFIRST=%Clipboard%
   varName:=SubStr(varFIRST,1,20)
   
   ;,uuu,3076
   ;  lkolk()
   ;~ MsgBox,1
   ;~ }else
   ;~ MsgBox,2
   ;~ return
   
   varName:=RegExReplace(varName,"[^\w\d_]+","_")
   varName := Trim(varName,"_")
   varName := RegExReplace(varName,"^.*?(\w+[\w_\d]*).*?","$1")
   varName1 := SubStr(varName,1,1)
   ;~ varFIRST1 := SubStr(varFIRST,1,1)

StringLower,varName1,varName1
   varName:= varName1 . SubStr(varName,2)
   strLen_varName := StrLen(varName)
   Send,{Blind}
   ;~ Send,%varName% :={Space}{home}{Right %strLen_varName_%}
   ;~ %lkj% = lkj
   ;~ lkj
   ;~ %lkj% := =lkj=
   inputH := 200
   timeoutSec := 6
   SetTitleMatchMode,3
   noInputs:=false
   
   ;~ ein_bisschen_text = %ein bisschen text%
   
   ;~ 1+2+3*4
   ;~ isProbablyFuntionCallInside := RegExMatch(varFIRST,"i)[a-z_]+\([^)]*\)")
   
   isDigitFirst := RegExMatch(varFIRST,"^\d+") 
   if( isDigitFirst ||  InStr(varFIRST," .")   ||  InStr(varFIRST," +")  ||  InStr(varFIRST,":=") || StrLen(varFIRST) > Round(StrLen(varName) * 1.2) )
   {
   
   isValueProbablyNotString := true
   ;~ %A_LineNumber% = A_LineNumber `n 
   }else if (RegExMatch(varFIRST , "i)[a-z_]+\([^)]*\)"))
   isValueProbablyNotString := true
   ;  ; 
   ;~ isProbablyFuntionCallInside := RegExMatch(varFIRST,"i)[a-z_]+\([^)]*\)")
   if(isValueProbablyNotString)
  {
           varFIRST1 := RegExReplace(varFIRST,"^`a*(.).*?$","$1")

    if(varFIRST1 == "%")
      isValueProbablyNotString := false
   ;~ MsgBox,%varFIRST1% = varFIRST1 (line:%A_LineNumber%) `n 
;~ return
}
if(isValueProbablyNotString)
   defaultInput := ":="

   ;~ MsgBox,%varName% := varName `n 15-06-12_16-20
   ;~ %_% := _]%
   ;~ %5_6% := 5_6
   
   else
  {
   defaultInput := "="
   }
   
   msg= Delimiter ? `n`nPress Shift+Enter for use intelligent defaults.
   InputBox,delimiter,%msg%,%msg% , , 200 , %inputH%  , 330 , %inputH% , , %timeoutSec%  , %defaultInput%
   WinSet, AlwaysOnTop, On, %msg%
   if ErrorLevel = 1  
   noDel:=true
   
   If ( GetKeyState("shift", "P") ) {
   m=pressed shift+enter lets use defaults
   ;~ MsgBox, ,% m,% m,1
   noInputs:=true
   }
   
   
   ; Qoutes of Key
   if(delimiter == ":=")
   {
   ;~ if(isValueProbablyNotString)
   defaultInput := ""
   ;~ MsgBox,%defaultInput%  15-06-12_16-36
   }
   else if(delimiter == ":")
   defaultInput := ""
   else if(delimiter == "=")
   defaultInput := ""
   else if(delimiter == ",")  
   defaultInput := """"
   else
   defaultInput := ""
   ;~ ein_bisschen_text := ein bisschen text
   ;~ test = %test%
   ;~ d_1_2_1_2222 := d_1_2 := 1+2222
   ;~ MsgBox,%delimiter% := delimiter `n %delimiter% := delimiter `n %noInputs% := noInputs `n
   ;~ Reload
   
   ;~ Qoutes of Key?
   if(noInputs)
   {
   ToolTip1sec("noInputs 15-06-12_17-20")
   firstQoute:=defaultInput
   ;~ MsgBox,15-06-12_17-20
   }
   else
   {
   msg= Qoutes of Key?
   InputBox,firstQoute,%msg%,%msg% , , 200 , %inputH%  , 330 , 200, , %timeoutSec%  , %defaultInput%
   WinSet, AlwaysOnTop, On, %msg%
   if ErrorLevel = 1  
   noKey:=true
   }
   
   ; value qoutes
   if(firstQoute == "%")
   defaultInput := ""
   else if(firstQoute == """")
   defaultInput := """"
   else{
   if(delimiter == ":=")
   {
   ;~ calculation ? not a sting?
   ;~ isValueProbablyNotString
   ;~ A_TimeIdle kkk 
   varName_1_3 := SubStr(varName,1,2)
   StringLower, varName_1_3lo ,varName_1_3
   ;~ MsgBox,%subStr_varName_1_3% = subStr_varName_1_3 `n 
   ;~ return
   if(!isValueProbablyNotString && varName_1_3lo == "a_")
   isValueProbablyNotString:=true
   
   if(isValueProbablyNotString)
   defaultInput := ""
   else
   defaultInput := """"
   }
   else if(delimiter == ":")
   defaultInput := """"
   else if(delimiter == "=")
   {
   ;~ isDigitFirst
   ;~ isValueProbablyNotString := true
   isCorrectForVarName := RegExMatch(trim(varFIRST),"^\w+[\w_\d]+$")
   if(isDigitFirst || !isCorrectForVarName )
   defaultInput := ""
   else
   defaultInput := "%"
   ;~ ein_bischen = ein bischen
   }
   else if(delimiter == ",")  
   defaultInput := """"
   else
   defaultInput := ""
   }
   ;~ 1_2_3 1+2+3
   if(noInputs)
   secQoute:=defaultInput
   else
   {
   msg= Qoutes of Value?
   InputBox,secQoute,%msg%,%msg% , , 200 , 100 , 330 , %inputH% , , %timeoutSec%  , %defaultInput%
   WinSet, AlwaysOnTop, On, %msg%
   if ErrorLevel = 1
   noVal:=true
   }
   
   if(noKey &&  noDel &&  noVal )
   {
   ToolTip3sec(A_LineNumber . ": InputDialogs canceld (15-06-12_14-36)" ) 
   return
   }
   
   Send,{Blind}
   WinActivate,%activeTitle%
   WinWaitActive,%activeTitle%,,1
   IfWinNotActive,%activeTitle%
   return
   Send,{home}{ShiftDown}{End}
   if(isDigitFirst && firstQoute == "")
   varName :=  "d_" . varName
   part1=%firstQoute%%varName%%firstQoute%
   if(delimiter==":=")
   value:=varFIRST
   else
   value:=varFIRST
   
   valueOriginal := value
   valueEncode := RegExReplace(value, "([!+^#{}]+)", "{$1}")
   
   valueDiffLen := StrLen(valueEncode) - StrLen(valueOriginal)
   
   part2=%delimiter% %secQoute%%valueEncode%%secQoute%
   
   strLen_walk_left := StrLen(part2) - valueDiffLen ; 
   
   part1:=convert123To_NumPad123(part1)
   part2:=convert123To_NumPad123(part2)
   
   ;1+2lll(A_LineNumber, "keys_SL5_AHK_Refactor_engine.ahk",Last_A_This)Ll@ewqerwqe@@
   WinActivate,%activeTitle%
   WinWaitActive,%activeTitle%,,1
   IfWinNotActive,%activeTitle%
   return
   Send, %part1% %part2%
   ;~ %_% := +%
   ;~ %{numpad}_{numpad}% := {numpad}+{numpad}%
   Send,{Blind}
   Sleep,10  
   WinActivate,%activeTitle%
   WinWaitActive,%activeTitle%,,1
   IfWinNotActive,%activeTitle%
   return
   Send,{end}{ShiftDown}{Left %strLen_walk_left%}{ShiftUp}
   Send,{Blind}
   ;~ Send,{home}{Right %strLen_varName%}
   ;~ Sleep,20
   ;~ asdfs
   
   Suspend,off
   Sleep,1000
   return
   ;~ so_ein_tag := so ein tag
   ;~ aaaa := aaaa
   ;~ huhu := huhu
   return ;~ huhu := huhu
 
}

return  ; probably redundant. its more secure if we do that.
;~ #Include functions.inc.ahk
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ subroutinen beispielsweise m�sen ans Dateiende
#Include functions_dateiende.inc.ahk
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#Include UPDATEDSCRIPT_global.inc.ahk
