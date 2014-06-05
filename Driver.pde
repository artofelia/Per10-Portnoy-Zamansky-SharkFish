

static Grid g;
static int w,h;
static float spx, spy;

static ArrayList<Fish> f;
static ArrayList<Shark> s;

static Node test;


void setup() {
  size(1000, 1000);
  w = 100;
  h = 100;
  spx = width/w;
  spy = height/h;
  g = new Grid(w,h);
  carveGrid(100);
  
  f = new ArrayList<Fish>();
  s = new ArrayList<Shark>();
  
  test = g.getSpot(50,50);
  
//  Shark st = new Shark(g.getSpot(0,0));
//  ArrayList<Node> path = st.breadth(st.getPos(), test);
//  println("path");
//  if(path!=null){
//    for(Node n: path){
//      println(n);
//    }
//  }
  
  for(int i = 0; i < 50; i++){
    f.add(new Fish(
    g.getSpot((int)random(g.getSize()))
    ));
  }
  for(int i=0; i< 51; i++){
   s.add(new Shark(g.getSpot((int)random(g.getSize())))); 
  }
}

public void carveGrid(int max){
  for(int i = 0; i < max; i++){
    int x = (int)random(w);
    int y = (int)random(h);
    g.carve(x,y,50,5);
  }
}

void draw() {
  background(255,255,255);
  
  //draw grid
  strokeWeight(1);
  stroke(0,0,0);
  for(int i = 0; i < g.getSize(); i++){
    fill(200,200,200);
    rect(g.getSpotXPix(i), g.getSpotYPix(i), spx, spy);
    //fill(0); 
    //text(g.getSpotX(i) + ", "+  g.getSpotY(i), x+spx/2,y+spy/2);
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
  
  //draw critter
  fill(255,0,0);
  for(int i = 0; i < f.size(); i++){
     float x = f.get(i).getX()*spx+spx/2;
     float y = f.get(i).getY()*spy+spy/2;
     ellipse(x,y,spx,spy);
     f.get(i).move();  
  }
  fill(0,0,255);
  for(int i=0; i<s.size(); i++){
   float x=s.get(i).getX()*spx+spx/2;
   float y=s.get(i).getY()*spy+spy/2;
   ellipse(x,y,spx,spy);
   s.get(i).move(f);
  }
  
  
}
