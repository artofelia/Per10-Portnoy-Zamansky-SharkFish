

static Grid g;
static int w,h;
static float spx, spy;

static ArrayList<Critter> c;


void setup() {
  size(1000, 1000);
  w = 100;
  h = 100;
  spx = width/w;
  spy = height/h;
  g = new Grid(w,h);
  carveGrid(100);
  
  c = new ArrayList<Critter>();
  
  for(int i = 0; i < 10; i++){
    c.add(new Critter(
    g.getSpot((int)random(g.getSize()))
    ));
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
  for(int i = 0; i < c.size(); i++){
     float x = c.get(i).getX()*spx+spx/2;
     float y = c.get(i).getY()*spy+spy/2;
     ellipse(x,y,spx,spy);
     c.get(i).move();  
  }
  
}
