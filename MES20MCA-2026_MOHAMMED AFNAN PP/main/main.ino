#include <WiFi.h>
#include "ThingSpeak.h"
#include "DHT.h"
#include <NewPing.h>

#define TRIGGER_PIN  18  // Arduino pin tied to trigger pin on the ultrasonic sensor.
#define ECHO_PIN     19  // Arduino pin tied to echo pin on the ultrasonic sensor.
#define MAX_DISTANCE 200 // Maximum distance we want to ping for (in centimeters). Maximum sensor distance is rated at 400-500cm


#define DHTPIN 5
#define DHTTYPE DHT11

unsigned long int avgValue;  //Store the average value of the sensor feedback
float b;
int buf[10], temp;

float phValue;

DHT dht(DHTPIN, DHTTYPE);
NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE); // NewPing setup of pins and maximum distance.

const char* ssid = "Jiopp112";   // your network SSID (name)
const char* password = "sus4gnripg";   // your network password

WiFiClient  client;

unsigned long myChannelNumber = 1742469;
const char * myWriteAPIKey = "5XWKBFHXE72DXBTO";

// Timer variables
unsigned long lastTime = 0;
unsigned long timerDelay = 30000;


void phSens() {
  for (int i = 0; i < 10; i++) //Get 10 sample value from the sensor for smooth the value
  {
    buf[i] = analogRead(34);
    delay(10);
  }
  for (int i = 0; i < 9; i++) //sort the analog from small to large
  {
    for (int j = i + 1; j < 10; j++)
    {
      if (buf[i] > buf[j])
      {
        temp = buf[i];
        buf[i] = buf[j];
        buf[j] = temp;
      }
    }
  }
  avgValue = 0;
  for (int i = 2; i < 8; i++)               //take the average value of 6 center sample
    avgValue += buf[i];
  phValue = (float)avgValue * 5.0 / 6286 / 6; //convert the analog into millivolt
  phValue = 3.5 * phValue;                  //convert the millivolt into pH value
  Serial.print("    pH:");
  Serial.print(phValue, 2);
  Serial.println(" ");
  
}

void setup() {
  Serial.begin(115200);  //Initialize serial
  WiFi.mode(WIFI_STA);

  ThingSpeak.begin(client);  // Initialize ThingSpeak
  dht.begin();
}

void loop() {
  if ((millis() - lastTime) > timerDelay) {

    // Connect or reconnect to WiFi
    if (WiFi.status() != WL_CONNECTED) {
      Serial.print("Attempting to connect");
      while (WiFi.status() != WL_CONNECTED) {
        WiFi.begin(ssid, password);
        delay(5000);
      }
      Serial.println("\nConnected.");
    }


    //    ThingSpeak.setField(3, number3);
    //    ThingSpeak.setField(4, number4);
    float humidity = dht.readHumidity();
    float temperature = dht.readTemperature();
    delay(100);
    int turbidityvalue = analogRead(35);
    int turbidity = map(turbidityvalue, 0, 6286, 0, 100);
    delay(100);
    int distance = sonar.ping_cm();
    int waterlevel = map(distance, 0, 100, 100, 0);
    delay(100);
    phSens();



    Serial.print(F("Humidity: "));
    Serial.print(humidity);
    Serial.print(F("%  Temperature: "));
    Serial.print(temperature);
    Serial.println(F("°C "));
    Serial.print("Turbidity: ");
    Serial.print(turbidity);
    Serial.print("%  ph Value: ");
    Serial.println(phValue);
    Serial.print("Water Level: ");
    Serial.println(waterlevel);



    ThingSpeak.setField(1, temperature);
    ThingSpeak.setField(2, humidity);
    ThingSpeak.setField(3, phValue);
    ThingSpeak.setField(4, turbidity);
    ThingSpeak.setField(5, waterlevel);
    // Write to ThingSpeak. There are up to 8 fields in a channel, allowing you to store up to 8 different
    // pieces of information in a channel.  Here, we write to field 1.
    int x = ThingSpeak.writeFields(myChannelNumber, myWriteAPIKey);

    //uncomment if you want to get temperature in Fahrenheit
    //int x = ThingSpeak.writeField(myChannelNumber, 1, temperatureF, myWriteAPIKey);

    if (x == 200) {
      Serial.println("Channel update successful.");
    }
    else {
      Serial.println("Problem updating channel. HTTP error code " + String(x));
    }
    lastTime = millis();
  }
}
