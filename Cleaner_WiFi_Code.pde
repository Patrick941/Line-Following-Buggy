import processing.serial.*;    // Importing the serial library to communicate with the Arduino
import processing.net.*;



int ServerNo = 119;
Serial myPort;      // Initializing a vairable named 'myPort' for serial communication  // Variable for changing the background color
Client c;
int Magnitude = 0;
int Velocity = 0;
int Distance = 0;
int Turning = 2;
char ButtonState = '2';
Boolean DataRead = false;

void setup ( ) {
  fullScreen();
  size(1920, 1080);
  SetupSequence();
  //myPort  =  new Serial (this, "COM7",  9600); // Set the com port and the baud rate according to the Arduino IDE
  //myPort.bufferUntil ( '\n' );   // Receiving the data from the Arduino IDE

  //c = new Client(this, "192.168.64.115", ServerNo);
  c = new Client(this, "192.168.162.115", ServerNo);
}



void ReadData1() {
  DataRead = false;
  if (c.available()>0) {
    DataRead = true;
    String DataString = c.readString();
    String[] Data = DataString.split("P");
    String[] DistanceString = Data[1].split("E");
    String[] TurningArray = DistanceString[1].split("G");
    String VelocityString = Data[0];
    Velocity = Integer.valueOf(VelocityString);
    //String[] DistanceString = DataString.split("E");
    Distance = Integer.valueOf(DistanceString[0]);
    Turning = Integer.valueOf(TurningArray[0]);
  }
}

void ReadData2() {
  DataRead = false;
  if (c.available()>0) {
    DataRead = true;
    String DataString = c.readString();
    String[] Data = DataString.split("E");
    String DistanceString = Data[0];
    Distance = Integer.valueOf(DistanceString);
  }
}

void draw ( ) {
  ReadData1();
  //ReadData2();
  if (DataRead = true) {
    WriteData();
    GraphDistance();
    GraphVelocity();
    BuggyRotation();
  }
}
