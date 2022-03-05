import processing.serial.*;    // Importing the serial library to communicate with the Arduino
import processing.net.*;



int ServerNo = 119;
Serial myPort;      // Initializing a vairable named 'myPort' for serial communication  // Variable for changing the background color
Client c;
int Magnitude = 0;
int Velocity = 0;
int Distance = 0;
char ButtonState = '2';
Boolean DataRead = false;

void setup ( ) {
  size(1600, 1000);
  background(50, 50, 50);
  textSize(250);
  fill(0, 255, 0);
  rect(30, 30, 740, 420, 200);
  fill(0);
  text("GO", 245, 310);
  fill(255, 0, 0);
  rect(30, 530, 740, 420, 200);
  fill(0);
  text("STOP", 115, 820);
  fill(200, 200, 200);
  rect(900, 100, 200, 800, 10);
  fill(150, 150, 150);
  rect(950, 120, 100, 760, 10);
  fill(50, 50, 50);
  rect(975, 125, 50, 750, 10);
  fill(0, 0, 0);
  textSize(20);
  text("-255", 910, 867);
  text("-200", 910, 790);
  text("-150", 910, 716);
  text("-100", 910, 642);
  text("-50", 910, 568);
  text("0", 915, 490);
  text("50", 915, 421);
  text("100", 915, 352);
  text("150", 915, 282);
  text("200", 915, 214);
  text("255", 915, 150);

  fill(255, 165, 0);
  rect(925, 465, 150, 40, 5);

  fill(0, 0, 0);
  rect(1200, 100, 300, 800, 10);
  fill(100, 100, 100);
  rect(1300, 100, 100, 800);
  fill(200, 200, 200);
  rect(1310, 780, 80, 80);
  fill(255, 180, 0);
  rect(1315, 780, 3, 40);
  rect(1315, 820, 30, 3);
  rect(1345, 820, 3, 10);
  fill(50, 100, 200);
  rect(1310, 830, 40, 25);
  rect(1315, 750, 15, 30);
  rect(1375, 750, 15, 30);
  fill(0, 0, 255);
  rect(1320, 780, 3, 50);
  fill(255, 0, 0);
  rect(1325, 780, 3, 50);
  fill(255, 180, 0);
  rect(1375, 780, 3, 40);
  rect(1338, 820, 40, 3);
  fill(255, 0, 0);
  rect(1385, 780, 3, 78);
  rect(1340, 855, 50, 3);
  fill(0, 0, 255);
  rect(1380, 780, 3, 10);
  rect(1320, 790, 63, 3);
  fill(255, 255, 0);
  rect(1307, 782, 3, 40);
  rect(1390, 782, 3, 40);
  fill(255, 255, 255);
  text("0", 1210, 716);
  text("5", 1210, 659);
  text("10", 1210, 602);
  text("15", 1210, 545);
  text("20", 1210, 488);
  text("25", 1210, 431);
  text("30", 1210, 374);
  text("35", 1210, 317);
  text("40", 1210, 260);
  text("45", 1210, 203);
  text("50", 1210, 145);


  //myPort  =  new Serial (this, "COM7",  9600); // Set the com port and the baud rate according to the Arduino IDE
  //myPort.bufferUntil ( '\n' );   // Receiving the data from the Arduino IDE

  c = new Client(this, "192.168.64.115", ServerNo);
  //c = new Client(this, "192.168.1.27", ServerNo);
}

void WriteData() {
  if ((mousePressed == true) && (mouseY < 450) && (mouseY > 30)&& (mouseX > 30) && (mouseX <740)) {
    ButtonState = '1';
  } else if ((mousePressed == true) && (mouseY < 970) && (mouseY > 530)&& (mouseX > 30) && (mouseX <740)) {
    ButtonState = '0';
  }
  if (ButtonState == '1') {
    textSize(250);
    fill(0, 155, 0);
    rect(30, 30, 740, 420, 200);
    fill(0);
    text("GO", 245, 310);
    fill(255, 0, 0);
    rect(30, 530, 740, 420, 200);
    fill(0);
    text("STOP", 115, 820);
  } else if (ButtonState == '0') {
    textSize(250);
    fill(155, 0, 0);
    rect(30, 530, 740, 420, 200);
    fill(0);
    text("STOP", 115, 820);
    fill(0, 255, 0);
    rect(30, 30, 740, 420, 200);
    fill(0);
    text("GO", 245, 310);
  }
  c.write(ButtonState);
}

void ReadData() {
  DataRead = false;
  if (c.available()>0) {
    DataRead = true;
    String DataString = c.readString();
    //String[] Data = DataString.split("P");
    //String[] DistanceString = Data[1].split("E");
    //String VelocityString = Data[0];
    //Velocity = Integer.valueOf(VelocityString);
    String[] DistanceString = DataString.split("E");
    Distance = Integer.valueOf(DistanceString[0]);
  }
}

void GraphDistance() {
  if (Distance<50 && Distance>0) {
    int ypos = floor(716-(Distance*11.46));
    textSize(20);
    fill(0, 0, 0);
    rect(1200, 100, 300, 800, 10);
    fill(100, 100, 100);
    rect(1300, 100, 100, 800);
    fill(200, 200, 200);
    rect(1310, 780, 80, 80);
    fill(255, 180, 0);
    rect(1315, 780, 3, 40);
    rect(1315, 820, 30, 3);
    rect(1345, 820, 3, 10);
    fill(50, 100, 200);
    rect(1310, 830, 40, 25);
    rect(1315, 750, 15, 30);
    rect(1375, 750, 15, 30);
    fill(0, 0, 255);
    rect(1320, 780, 3, 50);
    fill(255, 0, 0);
    rect(1325, 780, 3, 50);
    fill(255, 180, 0);
    rect(1375, 780, 3, 40);
    rect(1338, 820, 40, 3);
    fill(255, 0, 0);
    rect(1385, 780, 3, 78);
    rect(1340, 855, 50, 3);
    fill(0, 0, 255);
    rect(1380, 780, 3, 10);
    rect(1320, 790, 63, 3);
    fill(255, 255, 0);
    rect(1307, 782, 3, 40);
    rect(1390, 782, 3, 40);
    fill(255, 255, 255);
    text("0", 1210, 716);
    text("5", 1210, 659);
    text("10", 1210, 602);
    text("15", 1210, 545);
    text("20", 1210, 488);
    text("25", 1210, 431);
    text("30", 1210, 374);
    text("35", 1210, 317);
    text("40", 1210, 260);
    text("45", 1210, 203);
    text("50", 1210, 145);
    fill(255, 0, 0);
    rect(1310, ypos, 80, 20);
  } else {
    textSize(20);
    fill(0, 0, 0);
    rect(1200, 100, 300, 800, 10);
    fill(100, 100, 100);
    rect(1300, 100, 100, 800);
    fill(200, 200, 200);
    rect(1310, 780, 80, 80);
    fill(255, 180, 0);
    rect(1315, 780, 3, 40);
    rect(1315, 820, 30, 3);
    rect(1345, 820, 3, 10);
    fill(50, 100, 200);
    rect(1310, 830, 40, 25);
    rect(1315, 750, 15, 30);
    rect(1375, 750, 15, 30);
    fill(0, 0, 255);
    rect(1320, 780, 3, 50);
    fill(255, 0, 0);
    rect(1325, 780, 3, 50);
    fill(255, 180, 0);
    rect(1375, 780, 3, 40);
    rect(1338, 820, 40, 3);
    fill(255, 0, 0);
    rect(1385, 780, 3, 78);
    rect(1340, 855, 50, 3);
    fill(0, 0, 255);
    rect(1380, 780, 3, 10);
    rect(1320, 790, 63, 3);
    fill(255, 255, 0);
    rect(1307, 782, 3, 40);
    rect(1390, 782, 3, 40);
    fill(255, 255, 255);
    text("0", 1210, 716);
    text("5", 1210, 659);
    text("10", 1210, 602);
    text("15", 1210, 545);
    text("20", 1210, 488);
    text("25", 1210, 431);
    text("30", 1210, 374);
    text("35", 1210, 317);
    text("40", 1210, 260);
    text("45", 1210, 203);
    text("50", 1210, 145);
  }
}

void GraphVelocity() {
  fill(200, 200, 200);
  rect(900, 100, 200, 800, 10);
  fill(150, 150, 150);
  rect(950, 120, 100, 760, 10);
  fill(50, 50, 50);
  rect(975, 125, 50, 750, 10);
  fill(0, 0, 0);
  textSize(20);
  text("-255", 910, 867);
  text("-200", 910, 790);
  text("-150", 910, 716);
  text("-100", 910, 642);
  text("-50", 910, 568);
  text("0", 915, 490);
  text("50", 915, 421);
  text("100", 915, 352);
  text("150", 915, 282);
  text("200", 915, 214);
  text("255", 915, 150);
  int position = 0;
  position = (460-floor((Velocity*(1.3333))));
  println(position);
  fill(255, 165, 0);
  rect(925, position, 150, 40, 5);
}

void draw ( ) {
  WriteData();
  ReadData();
  if (DataRead = true) {
    GraphDistance();
    GraphVelocity();
  }
}
