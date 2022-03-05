#include <SPI.h>
#include <WiFiUdp.h>
#include <WiFiNINA.h>
#include <String.h>

int LED = 13;
int MotorPin1 = 9;
int MotorPin2 = 3;
int MotorPin3 = 10;
int MotorPin4 = 4;
int REYE = 8;
int LEYE = 2;
int trig = 11;
int echo = 12;
int Velocity = 0;
int Backspeed = 0;
int Gyro = 0;
int dela = 10;
int DELAY = 0;
char val = '0';
//char ssid[] = "2E10_TC01";
//char pass[] = "LindaDoyle";
//char ssid[] = "VODAFONE-3AC2";
//char pass[] = "842LZUCC625KTLCK";
char ssid[] = "TheHotspot";
char pass[] = "12345678";

int status = WL_IDLE_STATUS;
int ServerNo = 119;
int temp = 0;

WiFiServer server(ServerNo);

void Brake() {
  analogWrite(MotorPin1, 0);
  analogWrite(MotorPin2, 0);
  analogWrite(MotorPin3, 0);
  analogWrite(MotorPin4, 0);
}

void Forward(int speed) {
  analogWrite(MotorPin1, speed);
  analogWrite(MotorPin2, LOW);
  analogWrite(MotorPin3, LOW);
  analogWrite(MotorPin4, speed);
}

void Backwards(int speed) {
  analogWrite(MotorPin1, LOW);
  analogWrite(MotorPin2, speed);
  analogWrite(MotorPin3, speed);
  analogWrite(MotorPin4, LOW);
}

void LeftForward(int speed) {
  int partialspeed = ((4 * (speed) / 7));
  analogWrite(MotorPin1, partialspeed);
  analogWrite(MotorPin2, LOW);
  analogWrite(MotorPin3, LOW);
  analogWrite(MotorPin4, speed);
}

void RightForward(int speed) {
  int partialspeed = ((4 * (speed) / 7));
  analogWrite(MotorPin1, speed);
  analogWrite(MotorPin2, LOW);
  analogWrite(MotorPin3, LOW);
  analogWrite(MotorPin4, partialspeed);
}

void RightBack(int speed) {
  int partialspeed = ((4 * (speed) / 7));
  analogWrite(MotorPin1, LOW);
  analogWrite(MotorPin2, speed);
  analogWrite(MotorPin3, partialspeed);
  analogWrite(MotorPin4, LOW);
}

void LeftBack(int speed) {
  int partialspeed = ((4 * (speed) / 7));
  analogWrite(MotorPin1, LOW);
  analogWrite(MotorPin2, partialspeed);
  analogWrite(MotorPin3, speed);
  analogWrite(MotorPin4, LOW);
}

void RotateLeft(int speed) {
  analogWrite(MotorPin1, LOW);
  analogWrite(MotorPin2, LOW);
  analogWrite(MotorPin3, LOW);
  analogWrite(MotorPin4, speed);
}

void RotateRight(int speed) {
  analogWrite(MotorPin1, speed);
  analogWrite(MotorPin2, LOW);
  analogWrite(MotorPin3, LOW);
  analogWrite(MotorPin4, LOW);
}

bool Lefteye() {
  if ( digitalRead( LEYE ) == LOW) {
    return true;
  }
  else {
    return false;
  }
}

bool Righteye() {
  if ( digitalRead( REYE ) == LOW) {
    return true;
  }
  else {
    return false;
  }
}

void FollowTrack() {
  if (Righteye() == 1 && Lefteye() == 0) {
    RotateLeft(Velocity);
    return;
  }


  if (Righteye() == 0 && Lefteye() == 1) {
    RotateRight(Velocity);
    return;
  }

  if (Righteye() == 1 && Lefteye() == 1) {
    Forward(Velocity);
    return;
  }

  if (Righteye() == 0 && Lefteye() == 0) {
    Forward(Velocity);
    return;

  }
}

int objectdistance() {
  int distance;
  long duration;

  digitalWrite(trig, LOW);
  delayMicroseconds(2);

  digitalWrite(trig, HIGH);
  delayMicroseconds(10);
  digitalWrite(trig, LOW);

  duration = pulseIn(echo , HIGH);
  distance = duration / 58;
  //check that this distance is in metres
  //Serial.println (distance);
  return (distance);
}


void AutoBraking(int distance) {
  if (Velocity >= 255) {
    Velocity = 200;
  }
  if (Velocity <= 1) {
    Velocity = 1;
  }
  int x;
  x = objectdistance();
  if (distance > x) {
    Velocity = 0;
    Brake();
    return;
  }

  else if (distance <= x) {
    Velocity = 200;
    return;
  }
}

void TrackStopAndGo() {
  if (val == '1') {
    FollowTrack();
    AutoBraking(15);
  }
  if (val == '0') {
    Brake();
    Velocity = 0;
  }
}

void setup() {
  Serial.print("setup beginning");
  pinMode(MotorPin2 , OUTPUT);
  pinMode(MotorPin1 , OUTPUT);
  pinMode(MotorPin3 , OUTPUT);
  pinMode(MotorPin4 , OUTPUT);
  pinMode( LEYE, INPUT );
  pinMode( REYE, INPUT );
  pinMode(trig, OUTPUT);
  pinMode(echo, INPUT);
  while (status != WL_CONNECTED) {
    digitalWrite(LED, HIGH);
    delay(1000);
    digitalWrite(LED, LOW);
    delay(1000);
    status = WiFi.begin(ssid, pass);
    IPAddress ip = WiFi.localIP();
    Serial.print("IP Address:");
    Serial.println(ip);
  }
  server.begin();
  //Serial.print("setup complete");
}

void DataOut() {
  WiFiClient client = server.available();
  if (client) {
    if (client.connected()) {
      int Distance = objectdistance();
      //String VelocityString = String(Velocity);
      String DistanceString = String(Distance);
      //String FinalOutput = VelocityString + "P" + DistanceString + "E";
      String FinalOutput = DistanceString+ "E";
      client.print(FinalOutput);
    }
  }
}
void DataIn() {
  WiFiClient client = server.available();
  if (client) {
    if (client.connected()) {
      val = client.read();
    }
  }
}

void loop() {
  FollowTrack();
  AutoBraking(15);
}
