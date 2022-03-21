#include <SPI.h>
#include <WiFiUdp.h>
#include <WiFiNINA.h>
#include <Arduino_LSM6DS3.h>
#include <String.h>

int LED = 13;
int MotorPin1 = 9;
int MotorPin2 = 3;
int MotorPin3 = 10;
int MotorPin4 = 4;
int REYE = 5;
int LEYE = 8;
int trig = 11;
int echo = 12;
int Velocity = 0;
int Backspeed = 0;
int Dela = 10;
int DELAY = 0;
char val = '0';
char LastAngle = 's';
int Counter = 0;
int State = 1;
int Turning = 2;
//char ssid[] = "2E10_TC01";
//char pass[] = "LindaDoyle";
//char ssid[] = "VODAFONE-3AC2";
//char pass[] = "842LZUCC625KTLCK";
char ssid[] = "TheHotspot";
char pass[] = "12345678";

int status = WL_IDLE_STATUS;
int ServerNo = 119;
int temp = 0;

int LowerLimit = 70;
int HigherLimit = 255;
float Stabiliser = 0.93;
int ReverseVelocity = 120;
float Resistance = 1;
int CounterMax = 1000;
//Left is Motor 4
float NewPin1;
float NewPin4;
int PreviousError;
//Right is Motor 1
float BiasCorrection = 0.94;

WiFiServer server(ServerNo);


//remove bias

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
  analogWrite(MotorPin4, speed * BiasCorrection);
}

void Backwards(int speed) {
  analogWrite(MotorPin1, LOW);
  analogWrite(MotorPin2, speed * BiasCorrection);
  analogWrite(MotorPin3, speed);
  analogWrite(MotorPin4, LOW);
}

void RotateLeft(int speed) {
  analogWrite(MotorPin1, LOW);
  analogWrite(MotorPin2, speed * BiasCorrection);
  analogWrite(MotorPin3, LOW);
  analogWrite(MotorPin4, speed * BiasCorrection);
}

void RotateRight(int speed) {
  analogWrite(MotorPin1, speed);
  analogWrite(MotorPin2, LOW);
  analogWrite(MotorPin3, speed);
  analogWrite(MotorPin4, LOW);
}

bool Lefteye() {
  if ( digitalRead( LEYE ) == HIGH) {
    return true;
  }
  else {
    return false;
  }
}

bool Righteye() {
  if ( digitalRead( REYE ) == HIGH) {
    return true;
  }
  else {
    return false;
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
  //Serial.println (distance);
  return (distance);
}

float MorePreciseObjectDistance() {
  float distance;
  float duration;

  digitalWrite(trig, LOW);
  delayMicroseconds(2);

  digitalWrite(trig, HIGH);
  delayMicroseconds(20);
  digitalWrite(trig, LOW);

  duration = pulseIn(echo , HIGH);
  distance = duration / 58;
  return (distance);
}

void KeepAtDistance(int MatchAt) {
  float Distance = MorePreciseObjectDistance();
  float PercentMax = 1.3;
  int Change = 20;
  float Error = Distance - MatchAt;
  float RelativeVelocity = (PreviousError - Error);
  if (Error > 0) {
    if (RelativeVelocity <= (-2 * PercentMax)) {
      Velocity = Velocity + Change * 3;
    }
    else if (RelativeVelocity <= (-1 * PercentMax)) {
      Velocity = Velocity + Change;
    }

    else if (RelativeVelocity >= (PercentMax * -1) && RelativeVelocity < (PercentMax * 0)) {
      Velocity = Velocity + Change / 2;
    }
    else if ( Error < 10) {
      if (RelativeVelocity >= (0) && RelativeVelocity < 0.5 * PercentMax) {
        Velocity = Velocity - Change * 2;
      }
      else if (RelativeVelocity >= (0.5 * PercentMax) && RelativeVelocity < 1 * PercentMax) {
        Velocity = Velocity - Change * 4;
      }
      else if (RelativeVelocity >= 1 * PercentMax) {
        Velocity = Velocity - Change * 8;
      }
      else {
        Velocity = Velocity + 20;
      }
    }
    else if (Error >= 10) {
      if (RelativeVelocity >= (0) && RelativeVelocity < 0.5 * PercentMax) {
        Velocity = Velocity - Change;
      }
      else if (RelativeVelocity >= (0.5 * PercentMax) && RelativeVelocity < 1 * PercentMax) {
        Velocity = Velocity - Change * 2;
      }
      else if (RelativeVelocity >= 1 * PercentMax) {
        Velocity = Velocity - Change * 4;
      }
      else {
        Velocity = Velocity + 20;
      }
    }
  }
  else {
    Velocity = 0;
  }
  if (Distance > MatchAt + 20) {
    Velocity = 255;
    return;
  }
  PreviousError = Error;
  ExtraSafeZone(Velocity, 255);
  Serial.println("Relative Velocity:");
  Serial.println(RelativeVelocity);
}

void SafeTrackFollow() {
  if (Righteye() == 1 && Lefteye() == 0) {
    Turning = 1;
    RotateLeft(Velocity);
    return;
  }
  else if (Righteye() == 0 && Lefteye() == 1) {
    Turning = 3;
    RotateRight(Velocity);
    return;
  }
  if (Righteye() == 1 && Lefteye() == 1) {
    Turning = 2;
    Forward(Velocity);
    return;
  }

  if (Righteye() == 0 && Lefteye() == 0) {
    Turning = 2;
    Forward(Velocity);
    return;
  }
}

void SafeZone(int& Variable) {
  if (Variable >= 255) {
    Variable = 255;
  }
  else if (Variable <= 0) {
    Variable = 0;
  }
}

void ExtraSafeZone(int& Variable, int limit) {
  if (Variable >= limit) {
    Variable = limit;
  }
  if (Variable >= 255) {
    Variable = 255;
  }
  if (Variable <= 50) {
    Variable = 50;
  }
}

void TrackStopAndGo(int SafeDistance) {
  if (val == '1') {
    if (DELAY > 400) {
      KeepAtDistance(SafeDistance);
      DELAY = 0;
    }
    DELAY++;
    SafeTrackFollow();
  }
  else if (val == '0') {
    Brake();
    Velocity = 0;
  } else {
    Velocity = 0;
  }
}

void setup() {
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
    Serial.println(ip);
  }
  server.begin();
  if (!IMU.begin()) {
    Serial.println("Failed to reach IMU");
  }
  else {
    Serial.println("IMU can now be acessed");
  }
}

void ReadAcceleration(float & x, float & y, float & z) {
  //An accelaration value will be returned in the range of -4 to 4
  if (IMU.accelerationAvailable()) {
    IMU.readAcceleration(x, y, z);
    return;
  }
}

void ReadGyros(float & x, float & y, float & z) {
  //A gyro value will be returned in the range of -2000 to 2000
  if (IMU.gyroscopeAvailable()) {
    IMU.readGyroscope(x, y, z);
    x = x - 7.3;
    z = z - 5.6;
    return;
  }
}

void DataOut1() {
  WiFiClient client = server.available();
  if (client) {
    if (client.connected()) {
      int Distance = objectdistance();
      String VelocityString = String(Velocity);
      String DistanceString = String(Distance);
      String TurningString = String(Turning);
      String FinalOutput = VelocityString + "P" + DistanceString + "E" + TurningString + "G";
      //String FinalOutput = DistanceString + "E";
      client.print(FinalOutput);
    }
  }
}

void DataOut2() {
  WiFiClient client = server.available();
  if (client) {
    if (client.connected()) {
      int Distance = objectdistance();
      String DistanceString = String(Distance);
      String FinalOutput = DistanceString + "E";
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
  DataIn();
  if (Dela > 20) {
    DataOut1();
    Dela = 0;
  }
  Dela++;
  //DataOut2();
  TrackStopAndGo(15);
}
