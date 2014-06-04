public class Critter{

  Node pos;
  int dir; //0-up,1-right,2-down,3-left
  
  int steps;//moving
  int max_steps;
  int speed; //max = 10;
  
  public Node getPos(){
    return pos;
  }
  public int getX(){
    return pos.x;
  }
  public int getY(){
    return pos.y;
  }
  
  /*
  public Critter(int x, int y){
    pos = Driver.g.getSpot(x,y);
    steps = 0;
    max_steps = 50;
    speed = 5;
  }
  */
  
  public Critter(Node pos){
    this.pos = pos;
    //pos.addTenant(this);
    steps = 0;
    max_steps = 50;
    speed = 9;
  }
  
  public void move(){
    steps++;
    if(steps%(10-speed)==0){
      pos.removeTenant(this);
      pos = pos.getRandomNeighboor();
      pos.addTenant(this);
    }
  }
  
}
