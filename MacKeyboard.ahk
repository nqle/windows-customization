#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Policies\System, DisableLockWorkstation, 1

;-----------------------------------------
; Mac keyboard to Windows Key Mappings
;=========================================

; --------------------------------------------------------------
; NOTES
; --------------------------------------------------------------
; ! = ALT
; ^ = CTRL
; + = SHIFT
; # = WIN
;
; Debug action snippet: MsgBox You pressed Control-A while Notepad is active.

#InstallKeybdHook
#SingleInstance force
SetTitleMatchMode 2
SendMode Input


; --------------------------------------------------------------
; media/function keys all mapped to the right option key
; --------------------------------------------------------------

RAlt & F7::SendInput {Media_Prev}
RAlt & F8::SendInput {Media_Play_Pause}
RAlt & F9::SendInput {Media_Next}
;F10::SendInput {Volume_Mute} ;
;F11::SendInput {Volume_Down} ;
;F12::SendInput {Volume_Up} ;

; swap left command/windows key with left alt
;LWin::LAlt
;LAlt::LWin ; add a semicolon in front of this line if you want to disable the windows key

; Eject Key
;F20::SendInput {Insert} ; F20 doesn't show up on AHK anymore, see #3

; F13-15, standard windows mapping
F13::SendInput {PrintScreen}
F14::SendInput {ScrollLock}
F15::SendInput {Pause}

Home::SendInput {PrintScreen}
!Home::SendInput !{PrintScreen}

;F16-19 custom app launchers, see http://www.autohotkey.com/docs/Tutorial.htm for usage info
F16::Run http://twitter.com
F17::Run http://tumblr.com
F18::Run http://www.reddit.com
F19::Run https://facebook.com

; --------------------------------------------------------------
; OS X system shortcuts
; --------------------------------------------------------------

#a::^a
#b::^b ; Used for VSCode side bar visibility
$#c::send {ctrl down}c{ctrl up}
#d::Send ^d 
#e::^e
#f::Send ^f
#g::^g
#h::^h
#i::^i
#j::^j	
#k::^k
#l::
  keywait, Rwin
  Send {ctrl down}l{ctrl up}
return
LWin & m::WinMinimize, A
RWin & m::WinMinimize, A
#n::Send ^n
#+n::Send ^+n
#o::^o
#p::^p
#q::Send !{F4}
#r::Send {F5}
#s::SendInput {ctrl down}{s}{ctrl up}
#t::SendInput {ctrl down}{t}{ctrl up}
#+t::SendInput {ctrl down}{shift down}{t}{shift up}{ctrl up}
#u::^u
#v::send {ctrl down}v{ctrl up}
#w::Send ^{F4}
#x::SendInput ^x
#y::^y
LWin & z::^z
RWin & z::^z
;#1::^1
;#2::^2
;#3::^3
;#4::^4
;#5::^5
;#6::^6
;#7::^7
;#8::^8
;#9::^9
;#0::^0

; --------------------------------------------------------------
; OS X keyboard mappings for special chars
; --------------------------------------------------------------

; Map Alt + L to @
!l::SendInput {@}
RAlt & l::SendInput {@}

; Map Alt + Shift + 7 to \
+!7::SendInput {\}

; Map Alt + N to ©
;!g::SendInput {©} ; don't use this shortcut
;RAlt & g::SendInput {©} ; don't use this shortcut

; Map Alt + o to ø
!o::SendInput {ø}
RAlt & o::SendInput {ø}

; Map Alt + 5 to [
!5::SendInput {[}
RAlt & 5::SendInput {[}

; Map Alt + 6 to ]
!6::SendInput {]}
RAlt & 6::SendInput {]}

; Map Alt + E to €
!e::SendInput {€}
RAlt & e::SendInput {€}

; Map Alt + - to –
!-::SendInput {–}
RAlt & -::SendInput {–}

; Map Alt + 8 to {
!8::SendInput {{}
RAlt & 8::SendInput {{}

; Map Alt + 9 to }
!9::SendInput {}}
RAlt & 9::SendInput {}}

; Map Alt + - to ±
!+::SendInput {±}
RAlt & +::SendInput {±}

; Map Alt + R to ®
;!r::SendInput {®} ; no use for this. instead use this shortcut for word

; Map Alt + N to |
!7::SendInput {|}
RAlt & 7::SendInput {|}

; Map Alt + W to ∑
!w::SendInput {∑}
RAlt & w::SendInput {∑}

; Map Alt + N to ~
!n::SendInput {~}
RAlt & n::SendInput {~}

; Map Alt + 3 to #
!3::SendInput {#}
RAlt & 3::SendInput {#}


; --------------------------------------------------------------
; Custom mappings for special chars
; --------------------------------------------------------------

;#ö::SendInput {[} 
;#ä::SendInput {]} 

;^ö::SendInput {{} 
;^ä::SendInput {}} 

; Cmd alt enter
#!Enter::Send ^!{Enter}

; --------------------------------------------------------------
; Application specific
; --------------------------------------------------------------

; Google Chrome
#IfWinActive, ahk_class Chrome_WidgetWin_1

; Show Web Developer Tools with cmd + alt + i
#!i::Send {F12}

; Show source code with cmd + alt + u
#!u::Send ^u

#[::Send !{Left}
#]::Send !{Right}

#IfWinActive

; --------------------------------------------------------------
; Custom Quy
; --------------------------------------------------------------

; Explorer Navigation
#IfWinActive ahk_class CabinetWClass

XButton1::Send !{UP}

; Consider different behavior when text is selected / caret is active 

Enter::
   if ( A_CaretX="" or A_CaretY="") { ; Wenn KEIN Text eingetippt werden kann
      Send {F2}
   } else {
      Send {Enter}
   }
return
Right::
   if ( A_CaretX="" or A_CaretY="") { ; Wenn KEIN Text eingetippt werden kann
      Send {Enter}
   } else {
      Send {Right}
   }
return
Left::
   if ( A_CaretX="" or A_CaretY="") { ; Wenn KEIN Text eingetippt werden kann
      Send !{UP}
   } else {
      Send {Left}
   }
return
#Down::
   if ( A_CaretX="" or A_CaretY="") { ; Wenn KEIN Text eingetippt werden kann
      Send {Enter}
   } else {
      Send {PgDn}
   }
return
#Up::
   if ( A_CaretX="" or A_CaretY="") { ; Wenn KEIN Text eingetippt werden kann
      Send !{UP}
   } else {
      Send {PgUp}
   }
return

; Preview with Space
Space::
   if ( A_CaretX="" or A_CaretY="") { ; Wenn KEIN Text eingetippt werden kann
      Send !P
   } else {
      Send {Space}
   }
return


; Mac folder shortcuts
; Open Downloads
#!L::
  Send !d
  Send Downloads
  Send {Enter}
;  Send {Home}
  Send ^f
  return

; Open Documents
#+O::
  Send !d
  Send Documents
  Send {Enter}
;  Send !{TAB} ; Issue with only this shortcut
;  Send {Home}
  Send ^f
  return

; Open This PC
#+C::
  Send !d
  Send This PC
  Send {Enter}
;  Send {Home}
  Send ^f
  return

; Open User Folder
#+H::
  Send !d
  Send C:\Users\quyle
  Send {Enter}
;  Send {Home}
  Send ^f
  return

; Open Desktop
#+D::
  Send !d
  Send Desktop
  Send {Enter}
;  Send {Home}
  Send ^f
  return

; Open Application
#+A::
  Send !d
  Send C:\Program Files
  Send {Enter}
;  Send {Home}
  Send ^f
  return

#IfWinActive


; Screenshot
#+5::Send {PrintScreen}

#Left::Send {Home}
#Right::Send {End}
#Up::Send {PgUp}
#Down::Send {PgDn}

^+Right::Send ^{Tab}
^+Left::Send ^+{Tab}

#+Right::send {shift down}{end}
#+Left::send {shift down}{home}
#+Up::send {shift down}{PgUp}
#+Down::send {shift down}{PgDn}

; Lenovo T560 specific: pgup pgdn to left and right
;PgUp::Send {Left}
;PgDn::Send {Right}
;+#PgUp::Send {Lwin down}{shift down}{home}{Lwin up}
;+#PgDn::Send {Lwin down}{shift down}{end}{Lwin up}
;+PgUp::Send {shift down}{Left}
;+PgDn::Send {shift down}{Right}


!Left::Send ^{Left}
!Right::Send {ctrl down}{Right}{ctrl up}
!Up::Send ^{Up}
!Down::Send ^{Down}


<!+Left::Send {shift down}^{Left}
<!+Right::Send {shift down}{ctrl down}{Right}{ctrl up}

;#IfWinNotActive, Microsoft Visual Studio ; This shortcut is needed for column selection in VS
;{
;  <!+Up::Send {shift down}^{Up}
;  <!+Down::Send {shift down}^{Down}
;}
;#IfWinNotActive
;#IfWinNotActive ahk_class Notepad++ ; This shortcut is needed for column selection in notepad++
;{
;  <!+Up::Send {shift down}^{Up}
;  <!+Down::Send {shift down}^{Down}
;}
;#IfWinNotActive

; Capslock with Shift+Capslock; Capslock becomes Modifier
+Capslock::Capslock
Capslock::return

; Exception because of external Mac Keyboard
;^::<
;<::^

; Move windows left and right / maximize / minimize
^!Left::Send {LwinDown}{Left}{LwinUp}
^!Right::Send {LwinDown}{Right}{LwinUp}
^!Up::Send {LwinDown}{Up}{LwinUp}
^!Down::Send {LwinDown}{Down}{LwinUp}

; Mission Control / Show Desktop / Move spaces left and right
^Up::Send #{Tab}
^Down::Send #d
^Left::Send {Ctrl down}{Lwin down}{Left}{Lwin up}{Ctrl up}
^Right::Send {Ctrl down}{Lwin down}{Right}{Lwin up}{Ctrl up}
Rwin & 1::
  Send {rwin down}{ctrl down}{Left}{ctrl up}{rwin up}
  ;Send {lalt down}{tab down}{tab up}{lalt up}
return
Rwin & 2::
  Send {rwin down}{ctrl down}{Right}{ctrl up}{rwin up}
  ;Send {lalt down}{tab down}{tab up}{lalt up}
return
; Cycle through windows of same app
Capslock & 1::Send #1
Capslock & 2::Send #2
Capslock & 3::Send #3
Capslock & 4::Send #4
Capslock & 5::Send #5
Capslock & 6::Send #6

; Visual Studio Debugging
#IfWinActive, Microsoft Visual Studio
; toggle breakpoint
Capslock & w::Send {ctrl down}{F9}{ctrl up}
Capslock & y::Send {F11}
Capslock & x::Send {F10}
Capslock & c::Send {shift down}{F11}{shift up}

; Find previous element with cmd+f
+Enter::Send +{F3}

; Stop Building
F4::Send !#-

; Visual Assist - Open Find Window
#+F::Send ^+F

; Visual Assist - Open VA
Lwin & Capslock::Send !+q

; Visual Assist open file window
Capslock & f::Send !+O

; Visual Assist - Find References
#<::Send !+f

; Visual Studio Navigation
!Y::Send {alt down}{F7 down}{F7 up}

; Delete with Capslock Shortcut
Capslock & d::Send {Backspace}
Capslock & alt::Send {Backspace}

; Insert
Capslock & F4::Send {Insert}

#IfWinActive

; disable windows key and set spotlight shortcut
LWin::return
RWin::return ; can't disable right windows key as other shortcuts would not work
#!Space::send !{F12} ; Changed to wox Shortcut
#Space::SendInput !{F12}

; remap ctrl left click to cmd
LWIN & LBUTTON::send {ctrl down}{LButton}{ctrl up}
RWIN & LBUTTON::send {ctrl down}{LButton}{ctrl up}

; Minimizing Window is not needed 
;#m::WinMinimize,a

; Context menu shortcut
#.::AppsKey

; Double Space for dot point, if text can be entered
;~Space::
;   if ( A_CaretX="" or A_CaretY="") { ; Wenn KEIN Text eingetippt werden kann
;      ;Send {Space}
;   } else {
;      KeyWait, Space
;      KeyWait, Space, D, T0.15
;      If ErrorLevel = 1
;          Return
;      Else
;        SendInput, {BS}
;        SendInput, {BS}
;        Send, .
;        SendInput, {Space}
;      Return
;   }
;return

; VSCode mosaiq logging function, make it easier to printout ::One::Mosaiq::Runtime::Logger::trace("","");
;~ü::
;      KeyWait, ü
;      KeyWait, ü, D, T0.15
;      If ErrorLevel = 1
;          Return
;      Else
;        SendInput, {BS}
;        SendInput, {BS}
;        SendInput ::One::Mosaiq::Runtime::Logger::trace("","");
;        SendInput, {Left}
;        SendInput, {Left}
;        SendInput, {Left}
;        SendInput, {Left}
;        SendInput, {Left}
;        SendInput, {Left}
;        Return
;return

; text replacement for vscode
::omr::
(
`One`::Mosaiq`::Runtime`::
)

; text replacement for vscode
::omrl::
(
`::One`::Mosaiq`::Runtime`::Logger`::
)

; text replacement for vscode
::sstring::
(
std`::string
)

; text replacement for vscode
::sstr::
(
std`::string
)

; text replacement for vscode
::sptr::
(
std`::shared_ptr
)

; text replacement for vscode
::omrc::
(
`::One`::Mosaiq`::Runtime`::CyclicSystem`::
)

; Make Window to be always on top
^+!#Enter::  Winset, Alwaysontop, , A

; Jump to Desktop 1/2/3
;#!1::
;   Send, #{TAB}
;   Send, #D1
;return
;#!2::
;   Send, #{TAB}
;   Send, #D2
;return
;#!3::
;   Send, #{TAB}
;   Send, #D3
;return
	
; Media/Music control
F7::Send   {Media_Prev}
F8::Send   {Media_Play_Pause}
F9::Send   {Media_Next}

; Move mouse to caret
Capslock & e::MouseMove, % A_CaretX, % A_CaretY

; Arrow keys
#If GetKeyState("Capslock", "P")
i::Up
k::Down
j::Left
l::Right
!i::send ^{Up}
!k::send ^{Down}
!j::send ^{Left}
!l::send ^{Right}
!+i::send {shift down}^{Up}
!+k::send {shift down}^{Down}
!+j::send {shift down}^{Left}
!+l::send {shift down}^{Right}
#If


; Middle Mouse click simulator
;~LButton & RButton::MouseClick, Middle
;~RButton & LButton::MouseClick, Middle

; Word change move line up/down shortcut
#IfWinActive, ahk_class OpusApp
^+Up::send !+{Up}
^+Down::send !+{Down}
#IfWinActive

; Outlook receive new mails
#IfWinActive, ahk_class rctrl_renwnd32
#+N::
  Send {alt down}s{alt up}
  Send s
  Send {alt down}h{alt up}
return
#IfWinActive

^#c::return

; Disable menu upon pressing alt
~LAlt Up:: return
~+LAlt Up:: return

; Task switcher alttab 
; Remap Windows + Tab to Alt + Tab.
Rwin & Tab::AltTab 
;    AltTabMenu := true
    
;    If GetKeyState("Shift","P")
;        Send {Alt Down}{Shift Down}{Tab}{Shift Up}
;    else
;        Send {Alt Down}{Tab}	
;return
#If (AltTabMenu)
{
    1::
        Send {Left}
    return
}
F6::Send !{TAB}
!Tab::send #{TAB}
