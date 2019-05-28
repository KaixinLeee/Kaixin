#include "Ultrasonic.h"

Ultrasonic ultrasonic(7);

#include <NewPing.h>

#define TRIGGER_PIN  12  // Arduino pin tied to trigger pin on the ultrasonic sensor.
#define ECHO_PIN     11  // Arduino pin tied to echo pin on the ultrasonic sensor.
#define MAX_DISTANCE 250 // Maximum distance we want to ping for (in centimeters). Maximum sensor distance is rated at 400-500cm.

NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE); // NewPing setup of pins and maximum distance.

void setup()
{
	Serial.begin(115200);
}
void loop()
{
	byte RangeInCentimeters = constrain (ultrasonic.MeasureInCentimeters(),10,255); // two measurements should keep an interval
	
	  Serial.write(sonar.ping_cm()); // Send ping, get distance in cm and print result (0 = outside set distance range)
//Serial.write ( (RangeInCentimeters));//0~255cm
	delay(250);
}
