
import processing.serial.*;
Serial bt_port;

color white = color(255, 255, 255);
color black = color(0,0,0);
color green = color(0, 255, 0);
color blue = color(0, 0, 255);
color red = color(255, 0, 0);
color sliderColor;

String oldBrightness = "";

boolean systemActivated = false;
int brightness = 0;

int circle1X = 300;
int circle1Y = 100;
int circle2X = 300;
int circle2Y = 170;
int circleDiameter = 50;   // Diameter of circle
boolean withinCircle1 = false;
boolean withinCircle2 = false;

int sliderX = 10;
int sliderY = 100;
int sliderWidth = 25;
int sliderHeight = 70;

int anchor = 0;
int dx = 0;
int prevX = sliderX;

void setup() {
  size(340, 250);
  bt_port = new Serial(this, Serial.list()[2], 9600);  
}

void draw() {
  if (mouseY < sliderY + sliderHeight && mouseY > sliderY && systemActivated && mousePressed && mouseX + 24 < 255 && sliderX + (mouseX - prevX)  > 10) {
    refreshGraphics();
    int dx = mouseX - prevX;
    sliderX += dx;
    prevX = mouseX;
    sliderColor = color(60,60,60);
    int x = sliderX;
    if (systemActivated && x >= sliderWidth && x + sliderWidth <= 256) {
       brightness = x < 128 ? x - sliderWidth : x + sliderWidth;
    }
    transmitWord(brightness);
  } else {
    refreshGraphics();
    sliderColor = color(30,30,30);
    transmitWord(brightness);
  }
}
 
 void refreshGraphics() {
   background(color(10,10,80));
   displayText();
   sliderGradient();
   checkOnOffButtons();
   displayOnOffText();
   drawSlider();
 }
 
 void displayText() {  
   PFont f = createFont("Calibri",10,false); // Arial, 16 point, anti-aliasing on
   textFont(f,18);
   fill(white);
   text("Bluetooth Controlled Light System",20,50);
   
   f = createFont("Calibri",8,false); // Arial, 16 point, anti-aliasing on
   textFont(f,12);
   fill(white);
   text("Your light is " + (systemActivated ? "on" : "off" + "."),20,80);
   
   f = createFont("Calibri",8,false); // Arial, 16 point, anti-aliasing on
   textFont(f,12);
   fill(white);
   float currentBrightness = ((float) brightness)/255;
   text("Brightness: " + round(((currentBrightness)*100)) + "%",20,185);
 }
 
 void sliderGradient() {
   for (int i = 10; i < 256; i++) {
    strokeWeight(8);
    strokeCap(ROUND);
    stroke(color(250,240,256-i));
    line(i, 110, i, 160);
   }
 }
 
 void checkOnOffButtons() {
   if (withinCircle(circle1X,circle1Y,circleDiameter/2)) {
    fill(color(128,255,128));
    withinCircle1 = true;
   } else {
    fill(green);
    withinCircle1 = false;
   } 
  
   strokeWeight(2);
   stroke(235);
   ellipse(circle1X, circle1Y,circleDiameter, circleDiameter);
  
   if (withinCircle(circle2X,circle2Y,circleDiameter/2)) {
    withinCircle2 = true;
    fill(color(255,128,128));
   } else {
    fill(red);
    withinCircle2 = false;
   }
  
   strokeWeight(2);
   stroke(235);
   ellipse(circle2X, circle2Y, circleDiameter, circleDiameter);
 }
 
 void displayOnOffText() {
   PFont f = createFont("Calibri Bold",8,false); // Arial, 16 point, anti-aliasing on
   textFont(f,12);
   fill(systemActivated ? white : black);
   text("ON",circle1X - 8,circle1Y + 5);
   
   f = createFont("Calibri Bold",8,false); // Arial, 16 point, anti-aliasing on
   textFont(f,12);
   fill(!systemActivated ? white : black);
   text("OFF",circle2X - 11,circle2Y + 5);
 }
 
 void drawSlider() {
   fill(sliderColor);
   stroke(80);
   rect(sliderX,sliderY,sliderWidth,sliderHeight,5);
 }
 
 void mouseClicked() {
  if (!systemActivated && withinCircle1) {
    brightness = 128;
    systemActivated = true;
    sliderX = 128;
    prevX = sliderX;
  }
  if (systemActivated && withinCircle2) {
    brightness = 0;
    systemActivated = false;
    sliderX = 10;
  }
}

void transmitWord(int brightness){
  String currentBrightness = "" + brightness;
  if (!currentBrightness.equals(oldBrightness)) {
    bt_port.write("*");
    bt_port.write(brightness);
    oldBrightness = currentBrightness;    
  }
}

private boolean withinCircle (int x, int y, int radius) {
  double distanceFromCenter = Math.sqrt((x - mouseX)*(x - mouseX) + (y - mouseY)*(y - mouseY));
  return distanceFromCenter < radius;
}
