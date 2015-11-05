PImage bg1,bg2,start1,start2,enemy,fighter,hp,treasure;
int health,bgX,bgY,fighterX,fighterY,treasureX,treasureY,GAMEMODE=1,ENEMYTEAM=0;
float enemy1LeaderY,enemy2LeaderY,enemy3LeaderY,enemy3BackY;                      //leader y
float enemy1LeaderX,enemy2LeaderX,enemy3LeaderX,enemy3BackX;                      //leader x
float enemy2Angle,enemy3AnglePos,enemy3AngleNeg;                                  //diagonal value
boolean upPressed=false,downPressed=false,leftPressed=false,rightPressed=false;   //key movement


void setup () {
  size(640, 480) ;
  bg1=loadImage("img/bg1.png");
  bg2=loadImage("img/bg2.png");
  start1=loadImage("img/start1.png");
  start2=loadImage("img/start2.png");  
  enemy=loadImage("img/enemy.png");
  fighter=loadImage("img/fighter.png");
  hp=loadImage("img/hp.png");
  treasure=loadImage("img/treasure.png"); 
  health= floor(random(420,606));
  treasureX=floor(random(30,610));
  treasureY=floor(random(30,450));
  bgX=0;
  bgY=-640;
  fighterX=540;                       
  fighterY=240;
  treasureX=floor(random(30,610));
  treasureY=floor(random(30,450));
  enemy1LeaderY=floor(random(0,419));                              //start waypoint set
  enemy2LeaderY=floor(random(0,419));
  enemy3LeaderY=floor(random(0,419));
  enemy1LeaderX=-61;
  enemy2LeaderX=-61;
  enemy3LeaderX=-61;
  enemy2Angle=random(enemy2LeaderY/(-5),(480-enemy2LeaderY-61)/5);

  
  if(enemy3LeaderY<=209.5){                                          //detecting team 3 symmetry
  enemy3AngleNeg=random(enemy3LeaderY/3,0);
  enemy3AnglePos=enemy3AngleNeg*(-1);
}else{
  enemy3AnglePos=random((419-enemy3LeaderY)/3);
  enemy3AngleNeg=enemy3AnglePos*(-1);
 }
}





void draw() {

  switch(GAMEMODE){
 
    
    
    
    case 1:                        //title screen
    image(start2,0,0);
  if ((mouseX<444 && mouseX>202)&&(mouseY<422 && mouseY>380)){    //detecting mouse area
    image(start1,0,0);
  if(mousePressed){
    ENEMYTEAM=1;
    GAMEMODE=2;
 } 
}
 break;



    case 2:                             //playing
    
      image(bg2,bgY,0);                    //background scrolling
      image(bg1,bgX,0);           
      bgX+=4;
      bgY+=4;
      if(bgX==640){                        //bg1 reset
        bgX=-640;
      }
      if(bgY==640){                        //bg2 reset
        bgY=-640;
      }

      image(fighter,fighterX,fighterY);     //fighter moving
      if(upPressed && fighterY>0){
        fighterY-=4;
      }
      if(downPressed && fighterY<429){
        fighterY+=4;
      }
      if(leftPressed && fighterX>0 ){
        fighterX-=4;
      }
      if(rightPressed && fighterX<589){
        fighterX+=4;
      }  

      rectMode(CORNERS);                    //hp gauge
      fill(255,0,0);
      rect(410,50,450,30);               
      noStroke();
      image(hp,405,28);  

      image(treasure,treasureX,treasureY);  //treasure  
  
switch(ENEMYTEAM){

  
  case 1:
  
    for(int team1Count=0;team1Count<5;team1Count++){
     image(enemy,enemy1LeaderX-61*team1Count*1.3,enemy1LeaderY);
    }
    enemy1LeaderX+=6;
    if(enemy1LeaderX>=1000){
      enemy1LeaderX=-61;
      enemy1LeaderY=floor(random(0,419));           //reset for next cycle
      ENEMYTEAM=2;
    }
    break;

 
  case 2:
  
  
    for(int team2Count=0;team2Count<5;team2Count++){
     image(enemy,enemy2LeaderX-61*team2Count*1.3,enemy2LeaderY+team2Count*enemy2Angle);
    }
    enemy2LeaderX+=6;
    if(enemy2LeaderX>=1000){
      enemy2LeaderX=-61;
      enemy2LeaderY=(random(0,419));           
      enemy2Angle=(random(enemy2LeaderY/(-5),(480-enemy2LeaderY-61)/4));      //angle reset
      ENEMYTEAM=3;
      
    }
    break;


  case 3:
  
      
    for(int team3Count=0;team3Count<3;team3Count++){                                                 //front enemy
     image(enemy,enemy3LeaderX-61*team3Count*1.3,enemy3LeaderY+team3Count*enemy3AnglePos);      
    }
    for(int team3Count2=0;team3Count2<3;team3Count2++){
     image(enemy,enemy3LeaderX-61*team3Count2*1.3,enemy3LeaderY+team3Count2*enemy3AngleNeg);
    }
    for(int team3CountBack1=0;team3CountBack1<3;team3CountBack1++)
     image(enemy,enemy3LeaderX-317.2+61*team3CountBack1*1.3,enemy3LeaderY+team3CountBack1*enemy3AnglePos);    //back enemy
    for(int team3CountBack2=0;team3CountBack2<3;team3CountBack2++)
     image(enemy,enemy3LeaderX-317.2+61*team3CountBack2*1.3,enemy3LeaderY+team3CountBack2*enemy3AngleNeg);
     
          
     enemy3LeaderX+=6;   
      
      if(enemy3LeaderX>=1000){                                                 //angle reset
        enemy3LeaderX=-61;
        enemy3LeaderY=(random(0,419)); 
        
        if(enemy3LeaderY<=208.5){ 
      enemy3AngleNeg=random(enemy3LeaderY/3,0);
      enemy3AnglePos=enemy3AngleNeg*(-1);
        }else{
      enemy3AnglePos=random((419-enemy3LeaderY)/3);
      enemy3AngleNeg=enemy3AnglePos*(-1);
    }
        
        
        
        
        
     ENEMYTEAM=1;
      }    
    break;    
    
    
    
    
    
    
    
    
    }                      
   break;               
  }
}


void keyPressed(){                    //key detection
    if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed=true;
      break;        
      case DOWN:
        downPressed=true;
      break;        
      case LEFT:
        leftPressed=true;
      break;
      case RIGHT:
        rightPressed=true;
      break;
    }
  }

}


void keyReleased(){
      if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed=false;
        break;
      case DOWN:
        downPressed=false;
        break;
      case LEFT:
        leftPressed=false;
        break;
      case RIGHT:
        rightPressed=false;
        break;
    }
  }

}
