#include <SoftwareSerial.h>

int rxPin = 7;
int txPin = 8;
SoftwareSerial hc05(rxPin,txPin);
int outputPin = 3;    
int FRAME_LENGTH = 2;
char START_BYTE = '*';

void setup() {
  pinMode(outputPin, OUTPUT);
  hc05.begin(9600);
}

void loop() {
  if (hc05.available() >= FRAME_LENGTH) {
    if(hc05.read() == START_BYTE) {
      int brightness = hc05.read();
      analogWrite(outputPin, brightness);
    }
  }
}



