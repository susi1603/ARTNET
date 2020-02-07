
import controlP5.*;
import hypermedia.net.*;

ControlP5 cp5;
ColorPicker cp;
Slider abc;

UDPManager udp; //create object 

color c;

void setup() {
  
  size(800, 400);
  noStroke();
  String ip = "192.168.137.27";
  int port = 6454;
  
  udp= new UDPManager(ip, port);
  
  cp5 = new ControlP5(this);
  cp = cp5.addColorPicker("picker")
          .setPosition(60, 100)
          .setColorValue(color(255, 128, 0, 128))
          ;
          
  abc = cp5.addSlider("Position")
     .setPosition(100,370)
     .setWidth(400)
     .setRange(0,72) // values can range from big to small as well
     .setValue(128)
     .setNumberOfTickMarks(72)
     .setSliderMode(Slider.FIX)
     ;      
     
}
void draw() {
  c= cp.getColorValue();
  float val = abc.getValue();
  int value = int(val);
  //println(value);
 
  float r = red(c); // Get red in 'c' 
  int intred = int(r);
  byte R = byte(intred);
  
  float g = green(c);
  int intgreen = int(g);
  byte G = byte(intgreen)  ;
  
  float b= blue(c);
  int intblue = int(b);
  byte B = byte(intblue);
  
  background(c);
  fill(0, 80);
  rect(50, 90, 275, 80);
  
  //for (int LED = 0; LED< 72; LED++){
  //   udp.setArtnet(LED, R, G, B);
  //  }
  udp.offArtnet();
  int LED = value;
  udp.setArtnet(LED, R, G, B);
  udp.displayArtnet();
  udp.sendArtnet();
}

void keyPressed() {
  switch(key) {
    case('2'):
    cp.setColorValue(color(255, 0, 0, 255));
    break;
  }
}
