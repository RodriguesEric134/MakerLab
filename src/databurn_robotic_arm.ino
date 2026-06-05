#include <Servo.h>

// ===============================
// Projeto: DataBurn - SpaceFire Monitor
// Disciplina: Project-Based Maker Lab
// Função: Braço robótico simulado para coleta de amostras
// Controle: Monitor Serial Arduino
// Comandos:
// U = Up
// D = Down
// O = Open
// C = Close
// ===============================

// Objetos dos servos
Servo servoBraco;
Servo servoGarra;

// Pinos do circuito
const int PINO_SERVO_BRACO = 9;
const int PINO_SERVO_GARRA = 10;
const int PINO_LED_STATUS = 7;

// Ângulos do braço
const int ANGULO_BRACO_UP = 45;
const int ANGULO_BRACO_DOWN = 120;

// Ângulos da garra
const int ANGULO_GARRA_OPEN = 20;
const int ANGULO_GARRA_CLOSE = 80;

// Posição inicial dos servos
const int POSICAO_INICIAL_BRACO = 90;
const int POSICAO_INICIAL_GARRA = 50;

void setup() {
  Serial.begin(9600);

  servoBraco.attach(PINO_SERVO_BRACO);
  servoGarra.attach(PINO_SERVO_GARRA);

  pinMode(PINO_LED_STATUS, OUTPUT);

  servoBraco.write(POSICAO_INICIAL_BRACO);
  servoGarra.write(POSICAO_INICIAL_GARRA);

  digitalWrite(PINO_LED_STATUS, LOW);

  Serial.println("=================================");
  Serial.println("DataBurn - SpaceFire Monitor");
  Serial.println("Braco Robotico de Coleta");
  Serial.println("=================================");
  Serial.println("Comandos disponiveis:");
  Serial.println("U = Up / Subir braco");
  Serial.println("D = Down / Descer braco");
  Serial.println("O = Open / Abrir garra");
  Serial.println("C = Close / Fechar garra");
  Serial.println("Digite um comando e pressione Enter.");
  Serial.println("=================================");
}

void loop() {
  if (Serial.available() > 0) {
    char comando = Serial.read();

    if (comando == '\n' || comando == '\r') {
      return;
    }

    comando = toupper(comando);

    piscarLedStatus();

    switch (comando) {
      case 'U':
        moverBracoParaCima();
        break;

      case 'D':
        moverBracoParaBaixo();
        break;

      case 'O':
        abrirGarra();
        break;

      case 'C':
        fecharGarra();
        break;

      default:
        Serial.print("Comando invalido: ");
        Serial.println(comando);
        Serial.println("Use apenas U, D, O ou C.");
        break;
    }
  }
}

void moverBracoParaCima() {
  servoBraco.write(ANGULO_BRACO_UP);

  Serial.print("Comando U recebido: braco movido para cima em ");
  Serial.print(ANGULO_BRACO_UP);
  Serial.println(" graus.");
}

void moverBracoParaBaixo() {
  servoBraco.write(ANGULO_BRACO_DOWN);

  Serial.print("Comando D recebido: braco movido para baixo em ");
  Serial.print(ANGULO_BRACO_DOWN);
  Serial.println(" graus.");
}

void abrirGarra() {
  servoGarra.write(ANGULO_GARRA_OPEN);

  Serial.print("Comando O recebido: garra aberta em ");
  Serial.print(ANGULO_GARRA_OPEN);
  Serial.println(" graus.");
}

void fecharGarra() {
  servoGarra.write(ANGULO_GARRA_CLOSE);

  Serial.print("Comando C recebido: garra fechada em ");
  Serial.print(ANGULO_GARRA_CLOSE);
  Serial.println(" graus.");
}

void piscarLedStatus() {
  digitalWrite(PINO_LED_STATUS, HIGH);
  delay(150);
  digitalWrite(PINO_LED_STATUS, LOW);
}