#include <SPI.h>
#include <Adafruit_DotStar.h>
#include <Ethernet.h>                         
#include <EthernetUdp.h> 
#define DATAPIN    11
#define CLOCKPIN   13
#define NUMLEDS 72 

Adafruit_DotStar strip = Adafruit_DotStar(NUMLEDS, DOTSTAR_BRG) ;

char* Art_msg; 
byte    led_frame[NUMLEDS];
uint8_t ArtNet_frame[513]; 
uint8_t Mac[6]           = {0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED}; 
uint8_t IP [4]           = {192,168,137,27}; 
int     Udp_port         = 6454;
int     artnet_L         = 0;

EthernetUDP ARTNET;

byte UNIVERSE  = 0x00;



void setup() {

  Ethernet.begin(Mac,IP);
  int success = ARTNET.begin(Udp_port);
  Serial.begin(115200); 
}

void loop() {
 getArtnet();
 printColors();

  for(int i = 0; i < NUMLEDS; i++){
    int index = i*3; 
    strip.setPixelColor(i, strip.Color(ArtNet_frame[index+1],ArtNet_frame[index+0],ArtNet_frame[index+2]));      
    strip.show();  
     }
}

void getArtnet(){
  int size = ARTNET.parsePacket();
    if(size > 0){
      while((size = ARTNET.available())>0){
        Art_msg = (char*)malloc(size+1); //malloc is allocation site
        artnet_L= ARTNET.read(Art_msg,size+1);
        Art_msg[artnet_L]=0;
        }
        if(Art_msg[14]==UNIVERSE){
          for(int i=0;i<512;i++){
            ArtNet_frame[i] = Art_msg[i+18];
            }
          }
          free(Art_msg);
          ARTNET.flush();
      }
  }
  void printColors()
{
  Serial.print(" R:");
  Serial.print(ArtNet_frame[0], DEC);
  Serial.print(" G:");
  Serial.print(ArtNet_frame[1], DEC);
  Serial.print(" B:");
  Serial.print(ArtNet_frame[2], DEC); 
  Serial.println("");
  

}
