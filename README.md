Copyright © Daniel McGrath, All Rights Reserved | demcgrath2@gmail.com

# IoT-Light-System
These programs are used to interface with an HC-05 Bluetooth module and Arduino Uno.

The Processing GUI sends commands via Bluetooth connection to the HC-05, which then
serially transmits the data to the Arduino. The Arduino uses this data to set the 
voltage level of one of its output pins, which is connected to an LED or some other
type of light. 

---

#### To control the light:
    1) Download these source files, along with the Processing Development Environment (PDE).
    2) Set up the Arduino, HC-05, and light bulb. There are many YouTube videos that explain HC-05 setup.
    3) Once the Arduino and HC-05 are on, select the HC-05 from your tablet/computer's list of Bluetooth devices.
    4) Run the GUI in PDE and begin controlling the light from your computer!
    
---

## If you are in search of a solution for implementing a slider bar in Processing, then this repo will be very useful for you!

The GUI is shown below.

<img src="images/GUI_1.png" hspace="5">
<img src="images/GUI_2.png" hspace="5">
<img src="images/GUI_3.png" hspace="5">
