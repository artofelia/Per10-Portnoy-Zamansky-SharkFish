import java.util.*;



public class Algae extends Critter{

  float probRepro;
  int distRepro;
  
  public Algae(){
    super();
  }
  
  
  public Algae(Node pos){
    super(pos, -1, -1, -1, Integer.MAX_VALUE, Integer.MAX_VALUE);
    probRepro = 1;
    distRepro = 1;
    sexDrive=0;
  }
  
  public Node newPosition(Node p, int dist){
    if(dist<=0){
      if(!p.hasTenantType(this.getClass())){
        return p;
      }
      return null;
    }
    Node np = p.getRandomNeighboor();
    if(np==null) return null;
    return newPosition(np, dist-(int)random(3)-1);
  }
  
  public void repro(){
    if(sexDrive<100) return;
    sexDrive = 0;
    Node np = newPosition(pos, distRepro);
    if(np==null) return;
    Algae ag = new Algae(np);
  
    Driver.a.add(ag);
  }
  
  public void checkRepro(){
     if(random(100) < probRepro){
       this.repro();
     }
  }
  
  public void move(){
    updateCharacteristics();
    pos.addTenant(this);
  }
  
   public void die(){
    pos.removeTenant(this);
    Driver.a.remove(this);
  }
  
  public void draw(){
     fill(40,160,60);
     ellipse(pos.getXPix()+Driver.spx/2, pos.getYPix()+Driver.spy/2, Driver.spx, Driver.spy);
  }
  
  
}

