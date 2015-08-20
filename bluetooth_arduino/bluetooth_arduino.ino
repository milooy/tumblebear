/*
버튼을 누르는 동안 LED가 켜지며 물카운트가 올라간다.
그동안 북극곰은 물을 마신다.
물 지수는 계속 아두이노 변수에 추가가 된다. 현재까지 먹은양: 3.4L
목마름: 24시간동안 물을 안마시면 곰이 쓰러짐. LED는 빤짝빤짝.
*/
const int ledPin =  13;
const int buttonPin = 2;
int buttonState = 0;
int buttonFlag = 0;

void setup()
{ 
  pinMode(ledPin, OUTPUT); //led는 OUTPUT(프로세싱>아두이노)
  pinMode(buttonPin, INPUT); //버튼은 INPUT(아두이노>프로세싱)
  Serial.begin(9600); //시리얼포트 시작
}

void loop() //자동으로 루프 돈다
{ 
  if (digitalRead(buttonPin) == HIGH) //버튼이 켜지면
  {
    digitalWrite(ledPin, HIGH); //LED를 켠다
    buttonFlag = 1;
    Serial.println(buttonFlag); //버튼상태 표시(0/1)
    delay(20);
  } 
  else {
    digitalWrite(ledPin, LOW); //LED끈다
    buttonFlag = 0;
    Serial.println(buttonFlag); //버튼상태 표시(0/1)
    delay(20);
  }
  
   if( Serial.available() > 0 ) //시리얼을 통해 수신한 데이터가 있을때 true
   {
     char inByte = Serial.read(); //수신한 데이터를 1byte씩 읽어옴
     if( inByte == 'A' )
     {
       digitalWrite(ledPin, HIGH); //LED를 켠다
       delay(20);
     }  
   }
   else { //데이터 수신 없으면
     digitalWrite(ledPin, LOW); //LED끈다.
     delay(20);
   }
}

               
