import processing.serial.*;     // import the Processing serial library
Serial myPort;
char val;

PImage bgr;
PImage bear;
PImage bear1;
PImage bear2;
PImage bear3;
PImage bear4;
PImage bear5;
PImage bear6;

int bearAni = 0;

int waterPoint = 1;
int thirstPoint = 1;
int moveBear = 0;

String thirst;

void setup() {
  size(771, 800);
  
  bgr = loadImage("tumblebear.png");
  bear = loadImage("bear1.png");
  bear1 = loadImage("bear1.png");
  bear2 = loadImage("bear2.png");
  bear3 = loadImage("bear3.png");
  bear4 = loadImage("bear4.png");
  bear5 = loadImage("bear5.png");
  bear6 = loadImage("bear6.png");

  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}

void draw() {
  background(bgr);
  image(bear, 275, 400);
  textSize(30);
  text("WATER: " + waterPoint + "ml", 280, 300);
  text("THIRST: " + thirst, 280, 350);
  
  if ( myPort.available() > 0) { 
    String buffer = myPort.readStringUntil('\n');
    println(buffer); 
    thirstPoint = thirstPoint + 1;
    
    if(thirstPoint<200) {
      thirst = "GOOD";
    } else if (thirstPoint<400) {
      thirst = "SOSO";
    } else if (thirstPoint>401) {
      thirst = "BAD";
      myPort.write('A');
    } 
   
    if (buffer != null) {
     String [] values = split(buffer,'\n');
     int value = parseInt(values[0].trim());
     if(value == 0) {      
       moveBear = moveBear + 1;
       if(moveBear >= 30) {
         if(bearAni == 0) {
           if(thirst=="BAD"){
             bear = bear5;
           } else {
             bear = bear2;  
           }
           bearAni = 1;
         } else if (bearAni == 1) {
           if(thirst=="BAD"){
             bear = bear6;
           } else {
             bear = bear1;  
           }
           bearAni = 0;
         }
         moveBear = 0;
       }
      } else if (value == 1) {
        thirstPoint = 0;
        waterPoint = waterPoint+1;
        moveBear = moveBear + 1;
        if(moveBear >= 30) {
         if(bearAni == 0) {
           bear = bear3;
           bearAni = 1;
          } else if (bearAni == 1) {
           bear = bear4;
           bearAni = 0;
          }
           moveBear = 0;
         }
      } 
    }
  } 
}
