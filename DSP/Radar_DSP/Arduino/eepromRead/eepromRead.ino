/*
   Serialize Output via UART starting from address 0 to address 2047
*/
#include <EEPROM.h>

#ifndef MAX_SAMPLE
  #define MAX_SAMPLE 2048
#endif

//Write initial padding to make sure data will not be written during establishing serial connection
#ifndef NUM_PADDING
  #define NUM_PADDING 1600000
#endif

#ifndef PADDING
  #define PADDING 0xFF
#endif

#ifndef HEAD
  #define HEAD 0xCC
#endif

#ifndef DELAY
  #define DELAY 0
#endif

void serialize(int, byte*);

unsigned int n;

void setup() {
  // put your setup code here, to run once:
  n = 0;
  Serial.begin(9600); // For USB
  
  //Write padding bytes
  for(int i = 0; i < NUM_PADDING; i++){
    Serial.write(PADDING);
    delay(DELAY);
  }

  Serial.write(HEAD);
  Serial.flush();
}

void loop() {
  // put your main code here, to run repeatedly:
  if (n < MAX_SAMPLE) {
    byte sample[2];
    serialize(n, sample);
    Serial.write(sample, 2);
    Serial.flush();
    n++;
  } else {
    Serial.flush();
    Serial.end();
  }
  delay(DELAY);
}

/**
   Serializes data in BigEndian format.
*/
void serialize(int n, byte* sample) {
  unsigned int addrH = (n << 1);
  unsigned int addrL = addrH + 1;
  byte valH = EEPROM.read(addrH);
  byte valL = EEPROM.read(addrL);
  sample[0] = valH;
  sample[1] = valL;
}

