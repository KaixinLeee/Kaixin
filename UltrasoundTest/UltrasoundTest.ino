#include "Ultrasonic.h"

Ultrasonic ultrasonic(7);
void setup()
{
	Serial.begin(115200);
}
void loop()
{
	byte RangeInCentimeters = constrain (ultrasonic.MeasureInCentimeters(),10,255); // two measurements should keep an interval
	Serial.write ( (RangeInCentimeters));//0~255cm
	delay(250);
}
