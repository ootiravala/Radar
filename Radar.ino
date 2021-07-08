// Inckuyendo libreria del Servo
#include <Servo.h> 

// Definiendo los pines del Ultrasonido
const int trigPin = 10;
const int echoPin = 11;
// Variables para la duración y distancia
long duration;
int distance;

Servo myServo; // Creamos un objeto para controlar el Servo

void setup() {
  pinMode(trigPin, OUTPUT); 
  pinMode(echoPin, INPUT); 
  Serial.begin(9600);
  myServo.attach(12); // Defines el pin del Servo
}
void loop() {
  // rRotar el servo motor desde 15 a 165 grados
  for(int i=15;i<=165;i++){  
  myServo.write(i);
  delay(30);
  distance = calculateDistance();// Llamamos a la función para calcular la distancia medida por el Ultrasonido en cada grado
  
  Serial.print(i); // Envía el grado actual al puerto serie
  Serial.print(","); // Envía un carácter de adición justo al lado del valor anterior necesario más adelante en el IDE de procesamiento para la indexación
  Serial.print(distance); //Envía el valor de la distancia al puerto serie
  Serial.print("."); // Envía un carácter de punto justo al lado del valor anterior necesario más adelante en el IDE de procesamiento para la indexación
  }
  // Repite las líneas anteriores de 165 a 15 grados
  for(int i=165;i>15;i--){  
  myServo.write(i);
  delay(20);
  distance = calculateDistance();
  Serial.print(i);
  Serial.print(",");
  Serial.print(distance);
  Serial.print(".");
  }
}
// Función para calcular la distancia medida por el sensor ultrasónico
int calculateDistance(){ 
  
  digitalWrite(trigPin, LOW); 
  delayMicroseconds(20);
  // Establece el trigPin en estado ALTO durante 10 microsegundos
  digitalWrite(trigPin, HIGH); 
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH); // Lee el echoPin, devuelve el tiempo de viaje de la onda de sonido en microsegundos
  distance= duration*0.034/2;
  return distance;
}
