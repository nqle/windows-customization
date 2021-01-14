demomode:=false    ;demonstration mode on/off. change to false when ready to use
mintrack=20       ;minimum length of registered track sector in pixels  
wheelguard:=true  ;if true, wheel and middle button click can't both be used in the same gesture (recommended)

#MaxHotkeysPerInterval 500  ;prevents problems with rapid wheel movements
winget,windesktop,id,ahk_class Progman   ;desktop id, useful for some macros
gosub cleanup

*mbutton::   ;list any mouse buttons that can be uniquely named by first letter here eg. *mbutton is "m"
*lbutton::   ;the asterisk allows for the use of modifier keys   
*rbutton::     
*xbutton1::
*xbutton2::
lastdown:=thishotkey()
if macrorunning or wheel
   return
if not buttonsdown
   {
   mousegetpos xpos1,ypos1,win1  ;win1 is the window underneath the current gesture
   modifier:=(getkeystate("alt","p") ? "!" : "") . (getkeystate("shift","p") ? "+" : "") . (getkeystate("ctrl","p") ? "^" : "")
   settimer,tracking,1 
   }
mouseclick:=buttonsdown.=(not buttonsdown and getkeystate("lbutton","p") ? "l" : "") . lastdown
winget,winactive,id,A          ;active window id, useful for some macros
sendinput {lbutton up}         ;prevents drag box appearing when left/right rocking and gesturing eg. m-lr(d):
hotkey,*lbutton,on             ;*lbutton only tracked when other mouse buttons start tracking
hotkey,*lbutton up,on
return

*mbutton up::
if wheel and wheelguard        ;middle button clicks ignored when using wheel (if wheelguard=true)
   return
*rbutton up::
*lbutton up::
*xbutton1 up::
*xbutton2 up::
lastup:=thishotkey()
stringreplace,buttonsdown,buttonsdown,%lastup%,,all
buttonsup:=true
settimer,tracking,off            ;no more gesture tracking once a mouse button has been released
if not wheel and (lastdown=lastup)
   gosub callmacro   
if not buttonsdown         
   gosub cleanup
return

*wheelup::
*wheeldown::
if (instr(buttonsdown,"m") and wheelguard) or macrorunning    ;prevents accidental use of mousewheel with middle button gestures   
   return 
if not buttonsdown and getkeystate("lbutton","p")
   {
   mouseclick:=buttonsdown:="l"
   hotkey,*lbutton up,on
   }
if (buttonsdown and not buttonsup) or modifier
   { 
   stringtrimleft,wheel,a_thishotkey,1     
   settimer,tracking,off   ;no more tracking once wheel used
   goto callmacro
   }
stringtrimleft,thishotkey,a_thishotkey,1
if not buttonsdown
   sendinput {%thishotkey%}
return
     
callmacro:
macrorunning:=true
macro:="m-" . modifier . mouseclick . (tracking ? "(" . tracking . ")" : "") . (wheel ? "-" . wheel : "")
if (demomode and macro<>"m-r" and macro<>"m-m")
   msgbox,,DEMO MODE,%macro% ,1   
else
   if islabel(macro)         
         gosub %macro%
macrorunning:=false
return

cleanup:
if (win1<>windesktop)     
   win2:=win1     ; used in some gestures, win2 is the window the previous macro acted on
hotkey,*lbutton,off             ; restore normal left mouse button function
hotkey,*lbutton up,off
wheel:="",tracking="",buttonsup="",buttonsdown="",mouseclick="",track2="",modifier=""
return

tracking:
mousegetpos xpos2,ypos2
angle:=abs((xpos1-xpos2)/(ypos1-ypos2+0.001))      ;+0.001 avoids divide by zero error
if (angle>0.7 and angle<1.428) or (abs(ypos1-ypos2)<5 and abs(xpos1-xpos2)<5)   ;ignores angles within 10 degrees of 45 degree diagonal
   return                                                                       ;ignores movement that is too slow
track1:=(abs(ypos1-ypos2)>abs(xpos1-xpos2)) ? (ypos1>ypos2 ? "u" : "d") : (xpos1>xpos2 ? "l" : "r")  ;determines up down left right
if (track1<>track2)            ;remembers mouse position when track direction changes
   xpos_tack:=xpos2,ypos_tack:=ypos2
if (track1<>SubStr(tracking, 0, 1)) and (track1=track2) and (abs(xpos_tack-xpos2)>=mintrack or abs(ypos_tack-ypos2)>=mintrack)
   tracking.=track1        ;track if x or y changing sufficient to register. track needs confirmation (2 tracks same direction)
xpos1:=xpos2,ypos1:=ypos2,track2:=track1
return

thishotkey()   ;eg reduces "xbutton1 up" to "x1"
{
stringreplace,thishotkey,a_thishotkey,*,,all
stringreplace,thishotkey,thishotkey,%a_space%up,,all
stringreplace,thishotkey,thishotkey,button,,all
return thishotkey
}

esc::exitapp

m-r:                     ;normal right click
sendinput {rbutton}
return

m-m:          		 ;normal middle click (optional)         
sendinput {mbutton}
return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;; Examples ;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;; wheel examples ;;;;;;;;;;

m-r-wheelup:      ;change tabs with wheel -  hold right button down and use wheel
Send ^+{Tab}
return

m-r-wheeldown:
Send ^{Tab}
return

;;;;;;;; rocker examples ;;;;;;;;;;

;close tab with right and middle click
m-rm:
Send ^w
return

m-rl:
;msgbox,,,if you keep right held down, clicking left will repeat action,5
Send ^+{Tab}
return

m-lr:                                           
;msgbox,,,rocker left then right.,5  ;left click will also fire so some macros not suitable
Send ^{Tab}			     ;can be used for browser forward if you don't click over hypertext
return


m-rl(l):
m-lr(l):
msgbox,,,you combined rocking and gesturing,5
return

;;;;;;;;;;;; gesture examples ;;;;;;;;;;

m-r(u):             ;; gesture up ;; maximize window under cursor. maximize last window if cursor over desktop
;if (win1=windesktop)
;   {
;   if (win2<>"")
;   winmaximize, ahk_id %win2%
;   }
;else
;   winmaximize ahk_id %win1%
Send #{Tab}
return

m-r(d):            ;minimize window under cursor
;if (win1<>windesktop)    ;don't minimize the desktop
;   winminimize, ahk_id %win1%
Send ^w
return

m-r(l):            ;browser back
winactivate ahk_id %win1%   
;sendinput {Browser_Back}
Send {Ctrl down}{Lwin down}{Left}{Lwin up}{Ctrl up}
return

m-r(r):            ;browser forward
winactivate ahk_id %win1%   
;sendinput {Browser_Forward}
Send {Ctrl down}{Lwin down}{Right}{Lwin up}{Ctrl up}
return

m-r(dr):            ;restore last window.
;winrestore ahk_id %win2%
return

m-r(ldr):            ;close window under cursor (draw a C)
;if (win1<>windesktop)
;   winclose ahk_id %win1%
Send ^w
return

; Navigate with mouse buttons
XButton1::Send !{Left}
XButton2::Send !{Right}

mbutton & rbutton::
Send ^w
return

mbutton & lbutton::
send {ctrl down}{LButton}{ctrl up}
return
