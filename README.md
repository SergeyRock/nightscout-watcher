# Nightscout Watcher
The main purpose of the application is to show glucose level on your monitor in background mode to control glucose level in more convinient way. It`s especially usefull for office workers who spend a lot of time working on computer.
The main prerequisite is avalibility of your own nightscout site.
![N|Solid](https://www.uchitel-izd.ru/upload/files/clip2net/ol/2019/11.07-2355.png)

## Installation
1. Download appropriate release
2. Start executable
3. Type in url of your Nightscout site

## Main settings
After start the application you must type in the url of your Nightscout site.
All avalable settings are placed on settings window (F9) on throuпр popup menu.
The main settings are:
- Nightscout site URL (required field)
- Count of entries to recive
- Time interval to check new data (secs)
- Unit of measure (mmol/l or mg/dl). Mg/dl is used by default.
- Time-zone correction in hours
![N|Solid](https://www.uchitel-izd.ru/upload/files/clip2net/ol/2019/11.07-3348.png)

## Diagram options
It allows to set up diffrent glucose data to show on diagram such as:
- Current glucose level value
- Alert lines
- Glucose average
- Glucose extreme points
- Glucose level delta
- Glucose level points
- Glucose level
- Glucose lines
- Glucose slope
- Last glucose level date
- Last glucose level
- Vertical guide lines
- Scale

## Window options
- Make window full screen (F11)
- Show window border (B)
- Show new data checking progress bar (P)
- Show settings window

## Hot keys

LEFT/RIGHT/UP/DOWN – Move window on the screen
SHIFT + LEFT/RIGHT/UP/DOWN/MouseWheel – Resize window
ALT + UP/DOWN/MouseWheel – Increase/Decrease window opacity
CTRL + UP/DOWN or MouseWheel – Increase/Decrease scale
RightClick – Show popup menu

S – Set Nightscout site URL
M – Set unit of measure to mmol/l
C – Set count of entries to recieve from site
I – Set time interval of new data checking
F9 - Show settings window

1 – Draw latest glucose level value
2 – Draw glucose slope
3 – Draw glucose level delta
4 – Draw glucose lines
5 – Draw glucose extreme points
6 – Draw glucose level points
7 – Draw alert lines
8 – Draw spended time since last glucose level data was recieved
9 – Draw glucose level values
A – Draw average glucose level
L – Draw vertical guidelines
B – Show window border
P – Show new data checking progress bar
F11 – Show in full screen

V/DoubleClick – Visit your Nightscout site
F1 - This help

X - Exit

## Sources
It is written on Lazarus and can be compile on Windows, Linux, OS X, Android operating systems.
