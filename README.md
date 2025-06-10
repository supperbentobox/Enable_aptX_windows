# Enable_aptX_windows
autohotkey script ahk v2 to Enable and Disable (there's a reason why) bluetooth audio codec aptX on Windows 11 with a checkbox program to enable or disable it.

The default codec for bluetooth audio in Windows 11 is AAC so far (june 2025) but it can be switched from AAC to aptX.

When you enable aptX you leave no place for another bluetooth audio codec, so if you connect an audio device without that aptX capability it will not work, so in that case you need to disable aptX support.

In short, the AHK script just switch the registry REG_DWORD from 1 (AAC) to 0 (aptX)

Registry route =    HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BthA2dp\Parameters

REG_DWORD      =    BluetoothAacEnable
