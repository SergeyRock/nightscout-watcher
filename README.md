# Nightscout Watcher
The main purpose of the application is to show glucose level on your monitor in background mode to control glucose level in more convenient way. It's especially convinent for office workers who spend a lot of time working on computer.

![N|Solid](https://raw.githubusercontent.com/SergeyRock/nightscout-watcher/master/screenshots/Main.jpg)

App receives TSV-data about blood sugar level by requesting url like this: http://oldexcom.herokuapp.com/api/v1/entries/sgv?count=3000&find[dateString][$gte]=2019-11-16T01:00:00

## Collaboration
You are allways welcome to connect to this open source project by helping of any kind (e.g. testing, programming, spelling and etc.). 
Don't be hesitating if you notice something that can help to improve this project. Just write me an issue.
PS. I'm not a native english speaker. I'll be gratefull if you paticipate in correction of [mistakes](https://github.com/SergeyRock/nightscout-watcher/issues).

## Prerequisites
1. The main prerequisite is availability of your own [nightscout site](https://github.com/nightscout/cgm-remote-monitor).
2. Blood sugar level data from your CGM must be sent to Nightscout site (for instance through [xDrip+](https://github.com/NightscoutFoundation/xDrip))

## Installation
1. Download [installer](https://github.com/SergeyRock/nightscout-watcher/releases) (only win32 version is available)
2. Install and start executable
3. Type in url of your Nightscout site and set Time Zone

## Main window
![N|Solid](https://raw.githubusercontent.com/SergeyRock/nightscout-watcher/master/screenshots/Main.2.jpg)
A lot of hot keys are available in then main window.

## Alarms
When glucose level is going to be high or data from site is stale the alarms appeare.
Last glucose level and stale indicator start blinking.
Deppending on settings it can also be blinking tray icon with ballon hint or blinking icon on Taskbar.
Sound alarms are the same as in the nightscout (disabled by default).
You can snooze all alarms by popup menu and click snooze alarms or just hit Z key.

![N|Solid](https://raw.githubusercontent.com/SergeyRock/nightscout-watcher/master/screenshots/TrayIconAlert.jpg)
![N|Solid](https://raw.githubusercontent.com/SergeyRock/nightscout-watcher/master/screenshots/TaskbarIcon.jpg)

## Main settings
After start the application you must type in the url of your Nightscout site.
All available settings are placed on settings window (F9) and through popup menu.

![N|Solid](https://raw.githubusercontent.com/SergeyRock/nightscout-watcher/master/screenshots/Settings.Main.jpg)

The main settings are:
- Nightscout site URL (required field)
- Unit of measure (mmol/l or mg/dl). Mg/dl is used by default.
- Time interval to check new data (in seconds)
- Hours to receive data
- Time-zone correction in hours

## Diagram settings
![N|Solid](https://raw.githubusercontent.com/SergeyRock/nightscout-watcher/master/screenshots/Settings.Diagram.jpg)

It allows to set up different glucose data to show on diagram such as:
- Last glucose level
- Glucose slope
- Glucose lines
- Glucose extreme points
- Glucose level points
- Glucose level
- Alert lines
- Last glucose level retreived time
- Glucose level delta
- Glucose average
- Vertical guide lines
- Wallpaper (jpeg only)

You can change *Scale* of diagram elements by Mouse Wheel.

## Window settings
- Show icon in Tray (Y)
- Show icon on Taskbar (R)
- Stay window on top (T)
- Show window border (B)
- Make window full screen (F11)
- Show new data checking progress bar ( P )
- Windows opacity

## Alert options
![N|Solid](https://raw.githubusercontent.com/SergeyRock/nightscout-watcher/master/screenshots/Settings.Alerts.jpg)

## Hot keys
- LEFT/RIGHT/UP/DOWN – Move window on the screen
- SHIFT + LEFT/RIGHT/UP/DOWN/MouseWheel – Resize window
- ALT + UP/DOWN/MouseWheel – Increase/Decrease window opacity
- CTRL + UP/DOWN or MouseWheel – Increase/Decrease scale
- RightClick – Show popup menu

- S – Set Nightscout site URL
- M – Set unit of measure to mmol/l
- C – Set hours to receive data from site
- I – Set time interval of new data checking
- F9 - Show settings window

- 1 – Draw latest glucose level value
- 2 – Draw glucose slope
- 3 – Draw glucose level delta
- 4 – Draw glucose lines
- 5 – Draw glucose extreme points
- 6 – Draw glucose level points
- 7 – Draw alert lines
- 8 – Draw spent time since last glucose level data was received
- 9 – Draw glucose level values
- W – Draw wallpaper
- A – Draw average glucose level
- L – Draw vertical guidelines
- T – Stay window on top
- B – Show window border
- P – Show new data checking progress bar
- F11 – Show in full screen
- Z - Snooze alarms for 10 minutes

- V/DoubleClick – Visit your Nightscout site
- F1 - This help

- X - Exit

## Sources
It is written on [Lazarus](https://en.wikipedia.org/wiki/Lazarus_(IDE)) and can be compiled on Windows, Linux, OS X, Android operating systems.

## Gallery
![N|Solid](https://raw.githubusercontent.com/SergeyRock/nightscout-watcher/master/screenshots/gallery/11.08-15615.jpg) 

![N|Solid](https://raw.githubusercontent.com/SergeyRock/nightscout-watcher/master/screenshots/gallery/11.08-28698.jpg)
![N|Solid](https://raw.githubusercontent.com/SergeyRock/nightscout-watcher/master/screenshots/gallery/11.08-27016.jpg)
![N|Solid](https://raw.githubusercontent.com/SergeyRock/nightscout-watcher/master/screenshots/gallery/11.08-27065.jpg)

![N|Solid](https://raw.githubusercontent.com/SergeyRock/nightscout-watcher/master/screenshots/gallery/11.09-21634.jpg)
![N|Solid](https://raw.githubusercontent.com/SergeyRock/nightscout-watcher/master/screenshots/gallery/11.08-27709.jpg)
![N|Solid](https://raw.githubusercontent.com/SergeyRock/nightscout-watcher/master/screenshots/gallery/11.09-20531.jpg)
![N|Solid](https://raw.githubusercontent.com/SergeyRock/nightscout-watcher/master/screenshots/gallery/11.09-20629.jpg)
