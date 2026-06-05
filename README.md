# SpaceFire Monitor — DataBurn Robotic Arm

## 1. Sobre o Projeto

Este repositório apresenta o simulador de um braço robótico de coleta de amostras desenvolvido para a disciplina **Project-Based Maker Lab (PBML)**, dentro da **Global Solution 2026 da FIAP**, com o tema **"Indústria Espacial: O Código que Move o Universo"**.

A solução faz parte da plataforma **DataBurn / SpaceFire Monitor**, uma proposta integrada de monitoramento e resposta a queimadas. Dentro desse contexto, o braço robótico representa uma operação de **Docking & Retrieval**, simulando a coleta de amostras de solo ou material ambiental em áreas afetadas por incêndios.

O projeto utiliza um circuito simulado com Arduino Uno, dois servomotores e um LED de status, controlado por comandos enviados pelo Monitor Serial.

---

## 2. Objetivo da Camada Maker

O objetivo desta etapa é construir um simulador funcional de braço robótico para manipulação de carga, representando uma operação de coleta em ambiente controlado.

O braço possui dois movimentos principais:

* Movimento do braço: subir e descer.
* Movimento da garra: abrir e fechar.

O controle é realizado por comandos simples enviados pelo Monitor Serial do Arduino.

---

## 3. Componentes Utilizados

| Componente                |          Quantidade | Função                                         |
| ------------------------- | ------------------: | ---------------------------------------------- |
| Arduino Uno               |                   1 | Controle lógico do sistema                     |
| Servomotor 9g             |                   2 | Simulação das articulações do braço e da garra |
| LED                       |                   1 | Indicação visual de comando recebido           |
| Resistor 220Ω ou 330Ω     |                   1 | Proteção do LED                                |
| Fonte de bancada 5V ou 6V |                   1 | Alimentação externa dos servomotores           |
| Jumpers                   | Conforme necessário | Conexões do circuito                           |

---

## 4. Pinagem do Circuito

| Componente      | Terminal | Ligação                               |
| --------------- | -------- | ------------------------------------- |
| Servo 1 — Braço | Sinal    | Pino digital 9 do Arduino             |
| Servo 1 — Braço | VCC      | Positivo da fonte externa 5V ou 6V    |
| Servo 1 — Braço | GND      | Negativo da fonte externa             |
| Servo 2 — Garra | Sinal    | Pino digital 10 do Arduino            |
| Servo 2 — Garra | VCC      | Positivo da fonte externa 5V ou 6V    |
| Servo 2 — Garra | GND      | Negativo da fonte externa             |
| LED de status   | Ânodo    | Pino digital 7 do Arduino             |
| LED de status   | Cátodo   | Resistor ligado ao GND                |
| Fonte externa   | Positivo | VCC dos servomotores                  |
| Fonte externa   | Negativo | GND dos servomotores e GND do Arduino |

---

## 5. Alimentação Externa

Os servomotores são alimentados por uma fonte externa configurada para **5V ou 6V**.

A alimentação segue esta lógica:

```text
Fonte externa +  → VCC dos servomotores
Fonte externa -  → GND dos servomotores
Fonte externa -  → GND do Arduino
```

O aterramento comum é obrigatório para que os sinais enviados pelo Arduino sejam interpretados corretamente pelos servomotores.

```text
Arduino GND, GND da fonte externa e GND dos servos devem estar interligados.
```

---

## 6. Comandos do Monitor Serial

O controle do braço robótico é feito pelo Monitor Serial do Arduino.

| Comando | Função               | Servo Acionado | Ângulo |
| ------- | -------------------- | -------------- | -----: |
| U       | Up / subir braço     | Servo 1        |    45° |
| D       | Down / descer braço  | Servo 1        |   120° |
| O       | Open / abrir garra   | Servo 2        |    20° |
| C       | Close / fechar garra | Servo 2        |    80° |

O Monitor Serial deve estar configurado com baud rate de **9600**.

---

## 7. Funcionamento do Código

O código principal está localizado em:

```text
/src/databurn_robotic_arm.ino
```

A lógica do firmware realiza as seguintes etapas:

1. Inicializa a comunicação serial em 9600 bps.
2. Configura os dois servomotores usando a biblioteca `Servo.h`.
3. Define o LED de status como saída.
4. Aguarda comandos enviados pelo Monitor Serial.
5. Executa os movimentos conforme o comando recebido.
6. Pisca o LED sempre que um comando é lido.
7. Exibe mensagens de confirmação ou erro no Monitor Serial.

---

## 8. Guia de Operação

Para utilizar o simulador:

1. Abrir o projeto no Tinkercad.
2. Verificar se a fonte externa está configurada para 5V ou 6V.
3. Iniciar a simulação.
4. Abrir o Monitor Serial.
5. Configurar o baud rate para 9600.
6. Enviar os comandos `U`, `D`, `O` ou `C`.

Exemplo de uso:

```text
U
D
O
C
```

Resultado esperado:

```text
U → braço sobe
D → braço desce
O → garra abre
C → garra fecha
```

---

## 9. Link do Simulador

https://www.tinkercad.com/things/bMW8OBkAYDF-gsml1sem4ano?sharecode=2i1wUoszvIagAzOrqicJ_F99U1ZFqHJ-FmFIPWGtjk0

---

## 10. Evidências do Projeto

As imagens de evidência estão armazenadas na pasta `/images`.

```text
/images/circuito_completo.png
/images/comando_C.png
/images/comando_D.png
/images/comando_O.png
/images/comando_U.png
```

---

## 11. Modelagem 3D

A pasta `/model` contém os arquivos relacionados à modelagem 3D da garra e do elo estrutural do braço robótico.

A modelagem foi desenvolvida de forma paramétrica, permitindo ajustes nas dimensões das peças, principalmente nas medidas relacionadas ao encaixe de micro servomotores 9g.

Principais parâmetros utilizados:

```text
comprimento_elo
largura_elo
espessura_elo
largura_servo
altura_servo
profundidade_servo
diametro_furo
folga_de_encaixe
```

Arquivos de modelagem:

```text
/model/grip_model.scad
/model/servo_link_model.scad
```

O arquivo `grip_model.scad` representa a garra do braço robótico, com formato de pinça para simular a coleta de amostras.

O arquivo `servo_link_model.scad` representa um elo estrutural do braço, com suporte para encaixe de micro servo 9g, furos de articulação e reforço central.

---

## 12. Estrutura do Repositório

```text
SpaceFire-Monitor-PBML/
│
├── src/
│   └── databurn_robotic_arm.ino
│
├── model/
│   ├── grip_model.scad
│   └── servo_link_model.scad
│
├── images/
│   ├── circuito_completo.png
│   ├── comando_C.png
│   ├── comando_D.png
│   ├── comando_O.png
│   └── comando_U.png
│
└── README.md
```

---

## 13. Integrantes

| Nome                | RM     |
| ------------------- | ------ |
| Eric Rodrigues      | 550249 |
| Bernardo Rocha      | 99209  |
| Manoella Waideman   | 98906  |
| Renato Ichikawa     | 99242  |
| Victor Hugo Andrade | 550996 |
