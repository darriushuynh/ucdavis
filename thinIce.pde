import processing.sound.*;
final static float SPRITE_SCALE = 1.5;
final static float  SPRITE_SIZE = 36;
float move_x, move_y,startX, startY;
SoundFile file;
int introIndex=1;
Sprite player, test;
PImage border, finish, floor, outside, wave,reset, doubleFloor, introImg1,introImg2,
introImg3,introImg4, keyTile, door, endScreen;
int [][] matrixMap = new int [16][19];
Sprite [][] spriteMap= new Sprite [16][19];


int xCoord, yCoord, level, currentLevelPoints, floorTileTotal, totalPoints;
boolean hasKey=false;
void setup()
{
    size (19*36, 16*36+96);// (684, 672)
    imageMode(CENTER);

    level =1;
    introImg1= loadImage("intro1.PNG");
    introImg2= loadImage("intro2.PNG");
    introImg3= loadImage("intro3.PNG");
    introImg4= loadImage("intro4.PNG");
    border = loadImage("border.png");
    finish = loadImage("finish.png");
    outside = loadImage("outside.png");
    wave= loadImage("wave.png");
    floor = loadImage("floor.png");
    reset= loadImage("reset.jpg");
    doubleFloor= loadImage("doubleFloor.PNG");
    keyTile= loadImage("key.PNG");
    door=loadImage("door.PNG");
    endScreen=loadImage("endScreen.png");

    createPlatforms("map"+level+".csv");
    player = new Sprite("puffle.png", SPRITE_SCALE,startX,startY);
  //  PFont font;
   // font =createFont(8-BIT WONDER.ttf,12);
//textFont(font, 128);
}

void draw()
{
    background(224,244,252);
   if(level<=12)
   {
    Sprite resetButton = new Sprite(reset, 1);
    resetButton.center_x = 75;
    resetButton.center_y = 18*36;

    for (int row=0; row<spriteMap.length;row++)
    {
        for (int col=0; col<spriteMap[0].length;col++)
            spriteMap[row][col]. display();
    }
    player.display();
    resetButton.display();
    if (mousePressed && mouseX<144 && mouseX>6 && mouseY>633 && mouseY<663)
    {
      totalPoints=totalPoints-currentLevelPoints;
        nextLevel(level);
    }
intro();
pointsLevel();
   }
   else
   {
   Sprite outro =new Sprite(endScreen,1);
        outro.setLeft(0);
        outro.setTop(0);
        spriteMap=null;
        outro.display();
        textAlign(CENTER);
        textSize(50);//684, 672
        text("Total Points: "+totalPoints, 684/2, 500);
   }
   
}
void intro()
{
  Sprite intro;
  if (introIndex<=4)
  {
        intro =new Sprite("intro"+introIndex+".PNG",1);
        intro.setLeft(0);
        intro.setTop(48);
        intro.display();
  }
  else
  intro=null;
}
void mouseReleased()
{
  if(introIndex==1 && mouseX<413 && mouseX>267 && mouseY>535+48 && mouseY<579+48)
     introIndex++;
    else if (introIndex>1 &&introIndex<10 && mouseX>19 && mouseX<167 && mouseY>535+48 && mouseY<577+48)//playbutton
   introIndex=15;
   else if (introIndex>1 &&introIndex<4 && mouseX>523 && mouseX<670 && mouseY>535+48 && mouseY<577+48)//next
     introIndex++;
   else if (introIndex>2 &&introIndex<10 && mouseX>376 && mouseX<520 && mouseY>535+48 && mouseY<577+48)//back
     introIndex--;
    //print ("\nmouseX:" +mouseX+ "\tmouseY:"+ mouseY+"\n");
 }
 
 void pointsLevel()
 {
   if(introIndex>4)
   {
   int solved=level-1;
   textAlign(LEFT);
   textSize(30);
   fill(25, 146, 239);
   text("Level: "+level, 10, 35);
   text(currentLevelPoints+"/"+floorTileTotal, 290,35);
   text("Solved: "+solved, 550,35);
   text("Points: "+totalPoints, 525,660);
   }
 }
void createPlatforms(String filename){
    String[] lines = loadStrings(filename);
    for(int row = 0; row < lines.length; row++){
        String[] values = split(lines[row], ",");
        for(int col = 0; col < values.length; col++){
            if(values[col].equals("1")){
                matrixMap[row][col]=1;
                Sprite s = new Sprite(outside, SPRITE_SCALE);
                s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
                s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE+48;
                spriteMap[row][col]=s;
            }
            else if(values[col].equals("2")){
                matrixMap[row][col]=2;
                Sprite s = new Sprite(border, SPRITE_SCALE);
                s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
                s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE+48;
                spriteMap[row][col]=s;
            }
            else if(values[col].equals("3")|| values[col].equals("-1")){
                matrixMap[row][col]=3;
                floorTileTotal++;
                Sprite s = new Sprite(floor, SPRITE_SCALE);
                s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
                s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE+48;
                spriteMap[row][col]=s;
                if(values[col].equals("-1"))
                {
                    startX= col*24*1.5+18;
                    startY= row *24*1.5+18+48;
                    xCoord=row;
                    yCoord=col;
                }
            }
            else if(values[col].equals("4")){
                matrixMap[row][col]=4;
                Sprite s = new Sprite(finish, SPRITE_SCALE);
                s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
                s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE+48;
                spriteMap[row][col]=s;
            }
            else if(values[col].equals("5")){
                matrixMap[row][col]=5;
                Sprite s = new Sprite(doubleFloor, 36/35);
                s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
                s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE+48;
                spriteMap[row][col]=s;
                floorTileTotal+=2;
            }
            else if(values[col].equals("6")){
                matrixMap[row][col]=6;
                Sprite s = new Sprite(keyTile, 0.65);//555);//36/55);
                s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
                s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE+48;
                spriteMap[row][col]=s;
                floorTileTotal++;
            }
            else if(values[col].equals("7")){
                matrixMap[row][col]=7;
                Sprite s = new Sprite(door, 0.65);///55);
                s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
                s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE+48;
                spriteMap[row][col]=s;
                floorTileTotal++;
            }
        }
    }
}

void keyPressed(){
    int prevX= xCoord;
    int prevY= yCoord;
    boolean moved=false;
   // boolean wasIce = false;
   
    if (keyCode== RIGHT && matrixMap[xCoord][yCoord+1] >= 3)
    {
      if (matrixMap[xCoord][yCoord+1] <= 5|| (matrixMap[xCoord][yCoord+1] == 7 && hasKey)
      ||(matrixMap[xCoord][yCoord+1]==6))
      {
        if (matrixMap[xCoord][yCoord+1]==6)
        hasKey=true;
        player.center_x+= 36;
        yCoord++;
        currentLevelPoints++;
        totalPoints++;
        moved=true;
      }
    }
    else if (keyCode== LEFT && matrixMap[xCoord][yCoord-1] >= 3)
    {
      if (matrixMap[xCoord][yCoord-1] <= 5|| (matrixMap[xCoord][yCoord-1] == 7 && hasKey)
      ||(matrixMap[xCoord][yCoord-1]==6))
      {
        if (matrixMap[xCoord][yCoord-1]==6)
        hasKey=true;
        player.center_x-= 36;
        yCoord--;
        currentLevelPoints++;
        totalPoints++;
       moved=true;
      }
    }
    else if (keyCode== UP && matrixMap[xCoord-1][yCoord] >= 3)
    {
      if (matrixMap[xCoord-1][yCoord] <= 5|| (matrixMap[xCoord-1][yCoord] == 7 && hasKey)
      ||(matrixMap[xCoord-1][yCoord]==6))
      {
        if (matrixMap[xCoord-1][yCoord]==6)
        hasKey=true;
        player.center_y-= 36;
        xCoord--;
        currentLevelPoints++;
        totalPoints++;
        moved=true;
      }
    }
    else if (keyCode== DOWN && matrixMap[xCoord+1][yCoord] >= 3)
    {
      if (matrixMap[xCoord+1][yCoord] <= 5|| (matrixMap[xCoord+1][yCoord] == 7 && hasKey)
      ||(matrixMap[xCoord+1][yCoord]==6))
      {
        if (matrixMap[xCoord+1][yCoord]==6)
        hasKey=true;
        player.center_y+= 36;
        xCoord++;
        currentLevelPoints++;
        totalPoints++;
        moved=true;
      }
    }
    if(matrixMap[prevX][prevY]==5 && moved)
    {
        matrixMap[prevX][prevY]=3;
        spriteMap[prevX][prevY]= new Sprite(floor, SPRITE_SCALE);
        Sprite s= spriteMap[prevX][prevY];
        s.center_x = SPRITE_SIZE/2 + prevY * SPRITE_SIZE;
        s.center_y = SPRITE_SIZE/2 + prevX * SPRITE_SIZE+48;
       
    }
    else if((matrixMap[prevX][prevY]==3 ||matrixMap[prevX][prevY]==6
    ||matrixMap[prevX][prevY]==7)&& moved)
    {
          matrixMap[prevX][prevY]=0;
          Sprite s = new Sprite(wave, SPRITE_SCALE);
          s.center_x = SPRITE_SIZE/2 + prevY * SPRITE_SIZE;
          s.center_y = SPRITE_SIZE/2 + prevX * SPRITE_SIZE+48;
          spriteMap[prevX][prevY]=s;
    }
    if (matrixMap[xCoord][yCoord]==4 && moved)
    {
        level++;
        nextLevel(level);
    }
   
}

void nextLevel(int yuh)
{
  if (yuh<=12)
  {
  floorTileTotal=0;
    currentLevelPoints=0;
    matrixMap = new int [16][19];
    spriteMap= new Sprite [16][19];
    createPlatforms("map"+yuh+".csv");
    player = new Sprite("puffle.png", SPRITE_SCALE,startX,startY);
   hasKey=false;
  }
}


void keyReleased(){
    /*if (keyCode== RIGHT)
        move_x=1;
    else if (keyCode== LEFT)
        move_x=-1;
    else if (keyCode== UP)
        move_y=-1;
    else if (keyCode== DOWN)
        move_y=1;
        */
}
