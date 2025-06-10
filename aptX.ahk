#Requires AutoHotkey v2
#SingleInstance Force
#Warn

RegKey := "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BthA2dp\Parameters"
RegValue := "BluetoothAacEnable"

xValue := 1

try
{
    xValue := RegRead(RegKey, RegValue)
}
catch
{
	RegWrite(1, "REG_DWORD", RegKey, RegValue)
	MsgBox " HKLM\SYSTEM\CurrentControlSet\Services\BthA2dp\Parameters -> BluetoothAacEnable"
}

enabledAPTX := false

if (xValue = 0) {
    enabledAPTX := true
}

make_gui()
make_gui() {
    ; Make a gui
    goo := Gui()
    ; Add a checkbox
	if ( enabledAPTX ){
		con := goo.AddCheckbox('xm ym w150 h40 Checked vcbenable', ' Enable/Disable APTX')
	}
	else
	{
		con := goo.AddCheckbox('xm ym w150 h40 vcbenable', ' Enable/Disable APTX')
	}
    ; Give it a function to run when clicked
    con.OnEvent('Click', on_checkbox_click)
    ; Add a button
    con := goo.AddButton('xm w150 h40 vbtnexit', 'Exit')
    ; Give it a function to run when clicked
    ; In this case, we can use an anonymous fat arrow function (something v1 can't do)
    ; This also eliminates the need to make another function as ExitApp is alredy a function
    con.OnEvent('Click', (*) => ExitApp())    
    ; Show it
    Goo.Show()
}

; Required function structure for v2 events is based on the event type.
; The majority of controls use a basic (control, info) parameter setup, where info is rarely used.
; Much easier than (CtrlHwnd, GuiEvent, EventInfo, ErrLevel:="")
; GuiEvent and EventInfo is handled by the event type
; ErrorLevel is no longer used (see the reply I wrote on your other post)
on_checkbox_click(control, *) {
    ; If the control's checkbox is checked
    if control.Value
    {
		RegWrite(0, "REG_DWORD", RegKey, RegValue)
	}
    else
	{
		RegWrite(1, "REG_DWORD", RegKey, RegValue)
	}
}

