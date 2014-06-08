import ddf.minim.*;

AudioPlayer player;
Minim minim;

static Grid g;
static int w,h;
static float spx, spy;

static ArrayList<Fish> f;
static ArrayList<Shark> s;
static ArrayList<Algae> a;

static Node test;
static int time;
static boolean pause;


void setup() {
  size(800, 800);
  frameRate(60);
  
  minim=new Minim(this);
  player=minim.loadFile("Fishy.mp3");
  player.loop();
  
  pause = false;
  time = 0;
  w = 100;
  h = 100;
  spx = width/w;
  spy = height/h;
  g = new Grid(w,h);
  carveGrid(30);
  g.cleanGrid();
  
  f = new ArrayList<Fish>();
  s = new ArrayList<Shark>();
  a = new ArrayList<Algae>();
  
  //test = g.getSpot(50,50);

  for(int i = 0; i < 100; i++){
    f.add(new Fish(g.getSpot((int)random(g.getSize()))
    ));
  }
  for(int i=0; i< 10; i++){
   s.add(new Shark(g.getSpot((int)random(g.getSize())))); 
  }
  for(int i=0; i< 1000; i++){
   a.add(new Algae(g.getSpot((int)random(g.getSize())))); 
  }
}



public void generateAlgae(){
  if(time%10==0){
    if(random(10)<10){
      a.add(new Algae(g.getSpot((int)random(g.getSize())))); 
    }
  }
}



public void carveGrid(int max){
  for(int i = 0; i < max; i++){
    int x = (int)random(w);
    int y = (int)random(h);
    g.carve(x,y,80,5);
  }
}

void keyPressed() {
  if(key=='p'){
     pause = !pause;
  }
}

void draw() {
  background(100,40,50);
  time++;
  if(!pause){
    //generateAlgae();
  }
  //draw grid
  strokeWeight(1);
  stroke(0,0,0);
  for(int i = 0; i < g.getSize(); i++){
    g.getSpot(i).draw();
    g.getSpot(i).update();
  }
  
  /*
  //connections
  stroke(0,0,255);
  for(int i = 0; i < g.getSize(); i++){
      float x1 = g.getSpotX(i)*spx;
      float y1 = g.getSpotY(i)*spy;
      for(Node m: g.getSpot(i).getNeighboors()){
        float x2 = m.x*spx;
        float y2 = m.y*spy;
        //strokeWeight((i+g.getSpotInd(m.x, m.y))/20);
        line( x1+spx/2, y1+spy/2,
              x2+spx/2, y2+spy/2);
      }
  }
  */
  
  for(int i=0; i<a.size(); i++){
   a.get(i).draw();
   
   if(!pause){
     a.get(i).move();
   }
  }
  
  for(int i = 0; i < f.size(); i++){
    f.get(i).draw();
    
    if(!pause){
      f.get(i).move(f, a, s); 
    }
  }
  
  for(int i=0; i<s.size(); i++){
   s.get(i).draw();
   
    if(!pause){
      s.get(i).move(f, s);
    }
  }
  
   fill(255); 
   textSize(11);
   text("Fish: "+  f.size() + "\nSharks: " + s.size() + "\nAlgae: " + a.size(), 15,15);
  
 
}
