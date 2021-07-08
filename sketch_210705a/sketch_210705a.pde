import processing.serial.*; // Importar biblioteca para la comunicacion con el Serial
import java.awt.event.KeyEvent; // importar libreria para recibir la informacion recibida por el puerto serie
import java.io.IOException;
Serial myPort; // definiendo objeto serie
// definiendo variables
String angle="";
String distance="";
String data="";
String noObject;
float pixsDistance;
int iAngle, iDistance;
int index1=0;
int index2=0;
PFont orcFont;
void setup() {
size (1920, 1080);
smooth();
myPort = new Serial(this,"COM3", 9600); // comienza la comunicacion con el puerto serie
myPort.bufferUntil('.'); // lee los datos desde el puerto serie hasta el carácter '.'. Lee ángulo y distancia.
orcFont = loadFont("TheSans-Plain-12.vlw"); // Es importante que el archivo .vlw esté en el mismo directorio del proyecto
}
void draw() {
fill(98,245,31);
textFont(orcFont);
// simulando el movimiento y el desvanecimiento lento de la línea en movimiento
noStroke();
fill(0,4);
rect(0, 0, width, 1010);
fill(98,245,31); // color verde
// Llamando a las funciones creadas para mostrar el radar
drawRadar();
drawLine();
drawObject();
drawText();
}
void serialEvent (Serial myPort) { // comienza a leer la informacion del puerto serie
// lee los datos desde el puerto serie hasta el carácter '.' y lo coloca en la variable String "datos".
data = myPort.readStringUntil('.');
data = data.substring(0,data.length()-1);
index1 = data.indexOf(","); // busca el carácter ',' y lo coloca en la variable "index1"
angle= data.substring(0, index1); // lee los datos desde la posición "0" hasta la posición de la variable index1 o ese es el valor del ángulo que la placa Arduino envió al puerto serie
distance= data.substring(index1+1, data.length()); // lee los datos desde la posición "index1" hasta el final de los datos pr ese es el valor de la distancia
// Convierte la variable String en un Integer
iAngle = int(angle);
iDistance = int(distance);
}
void drawRadar() {
pushMatrix();
translate(960,1000); // mueve las coordenadas iniciales a una nueva ubicación
noFill();
strokeWeight(2);
stroke(98,245,31);
// dibuja las líneas del arco
arc(0,0,1800,1800,PI,TWO_PI);
arc(0,0,1400,1400,PI,TWO_PI);
arc(0,0,1000,1000,PI,TWO_PI);
arc(0,0,600,600,PI,TWO_PI);
// dibuja las lineas de ángulo
line(-960,0,960,0);
line(0,0,-960*cos(radians(30)),-960*sin(radians(30)));
line(0,0,-960*cos(radians(60)),-960*sin(radians(60)));
line(0,0,-960*cos(radians(90)),-960*sin(radians(90)));
line(0,0,-960*cos(radians(120)),-960*sin(radians(120)));
line(0,0,-960*cos(radians(150)),-960*sin(radians(150)));
line(-960*cos(radians(30)),0,960,0);
popMatrix();
}
void drawObject() {
pushMatrix();
translate(960,1000); // mueve las coordenadas iniciales a una nueva ubicación
strokeWeight(9);
stroke(255,10,10); // red color
pixsDistance = iDistance*22.5; // convierte la distancia desde el sensor de cm a píxeles
// El rango limite es 40cm
if(iDistance<40){
//dibuja el objeto según el ángulo y la distancia
line(pixsDistance*cos(radians(iAngle)),-pixsDistance*sin(radians(iAngle)),950*cos(radians(iAngle)),-950*sin(radians(iAngle)));
}
popMatrix();
}
void drawLine() {
pushMatrix();
strokeWeight(9);
stroke(30,250,60);
translate(960,1000); // mueve las coordenadas iniciales a una nueva ubicación
line(0,0,950*cos(radians(iAngle)),-950*sin(radians(iAngle))); // dibuja las lineas de acuerdo al ángulo
popMatrix();
}
void drawText() { // Dibuja el texto en pantalla
pushMatrix();
if(iDistance>40) {
noObject = "Out of Range";
}
else {
noObject = "In Range";
}
fill(0,0,0);
noStroke();
rect(0, 1010, width, 1080);
fill(98,245,31);
textSize(25);
text("10cm",1180,990);
text("20cm",1380,990);
text("30cm",1580,990);
text("40cm",1780,990);
textSize(40);
text("Object: " + noObject, 240, 1050);
text("Angle: " + iAngle +" °", 1050, 1050);
text("Distance: ", 1380, 1050);
if(iDistance<40) {
text(" " + iDistance +" cm", 1400, 1050);
}
textSize(25);
fill(98,245,60);
translate(961+960*cos(radians(30)),982-960*sin(radians(30)));
rotate(-radians(-60));
text("30°",0,0);
resetMatrix();
translate(954+960*cos(radians(60)),984-960*sin(radians(60)));
rotate(-radians(-30));
text("60°",0,0);
resetMatrix();
translate(945+960*cos(radians(90)),990-960*sin(radians(90)));
rotate(radians(0));
text("90°",0,0);
resetMatrix();
translate(935+960*cos(radians(120)),1003-960*sin(radians(120)));
rotate(radians(-30));
text("120°",0,0);
resetMatrix();
translate(940+960*cos(radians(150)),1018-960*sin(radians(150)));
rotate(radians(-60));
text("150°",0,0);
popMatrix();
}
