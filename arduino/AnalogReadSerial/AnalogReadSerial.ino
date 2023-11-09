int valButton = 9999;
int valPotard = 0;

// the setup routine runs once when you press reset:
void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
  pinMode(2,INPUT);
}

// the loop routine runs over and over again forever:
void loop() {
  valButton = digitalRead(2);
  valPotard = analogRead(A0);

  Serial.println(String(valPotard) + " " + String(valButton) + " _");
  delay(16);  // delay in between reads for stability
}