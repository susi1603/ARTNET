class UDPManager {
  //local variables
  UDP udp;
  String ip = "192.168.137.27";
  int port = 6454;
  int universes = 1;
  byte[] buffer = new byte[530];
  
  
  //Construction
  UDPManager(String cip, int cport){
    ip=cip;
    port=cport;
    
    udp = new UDP(this);
    udp.log(true); 
        
   //ID[8]
    buffer[0]= 'A';
    buffer[1]= 'r';
    buffer[2]= 't';
    buffer[3]= '-';
    buffer[4]= 'N';
    buffer[5]= 'e';
    buffer[6]= 't';
    buffer[7]= 0x00;
   //configuration protocol
    buffer[8]= 0x00;
    buffer[9]= 0x50;
    buffer[10]= 0x00;
    buffer[11]= 0x0E;
    buffer[12]= 0x00;
    buffer[13]=0x00;
    //universo
    buffer[14]=0x00; 
    buffer[15]= 0x00;
    //NUMERO DE LEDS
    buffer[16]= 0x01;
    buffer[17]= 0x20;
    
    //filling with ceros
    for (int i = 18; i< 530; i++){
      buffer[i] = 0x00;
    }
  }
  
  void setArtnet(int LED, byte R, byte G, byte B){
    int index=(LED*3)+18;
    buffer[index+0]=R;
    buffer[index+1]=G;
    buffer[index+2]=B;
  }  
  void offArtnet (){
   for (int i = 18; i< 530; i++){
      buffer[i] = 0x00;
    }
  }
  void displayArtnet (){
    println(buffer);
  }
  void sendArtnet(){
    udp.send(buffer, ip, port);
  }
}
