import java.util.*;

public class Shark extends Critter{
  
  
  public Shark(Node pos){
   super(pos); 
   sight = 50;
   hunger = 101;
   sexDrive = 201;
   speed = 8;
   println("init");
  }
  
  public Shark(Node pos, int speed, int sex, float sight, float max_age, float max_hunger){
   super(pos, speed, sex, sight, max_age, max_hunger);
   sight = 10;
  }

  public void repro(){
    if(sexDrive<50 || age<500 || random(100)<40) return;
    sexDrive=0;
    int nspeed = speed + (int) (random(4)-2);
    if(nspeed < 1) {nspeed = 1;}
    
    if(nspeed > max_speed) {nspeed = max_speed;}
    
    Shark sr = new Shark(
    pos,
    nspeed, 
    -1,
    max_age + mutation(max_age),
    max_hunger + mutation(max_hunger),
    sight + mutation(sight)
    );
    
    sr.hunger=mutation(hunger+20);
    hunger+=10;
    Driver.s.add(sr);
  }
  
  
  public Node findFood(ArrayList<Fish> f){
    int mdist = (int)sight+1;
    Node fin = new Node();
    
    for(Fish fs: f){
      if((this.pos).dist(fs.getPos()) < mdist){
        mdist = (this.pos).dist(fs.getPos());
        fin = fs.getPos();
      }
    }
    if(mdist < sight){
      return fin;
    }
    return null;
    
  }
  
   public void checkFood(){
     Fish ft = new Fish();
     Fish fs = (Fish)(pos.getTenantType(ft));
     if(fs!=null){
       fs.die();
       println("shark eat");
       hunger-=150;
     }
  }
  
  public Node findMate(ArrayList<Shark> s){
    int mdist = (int)sight+1;
    Node fin = new Node();
    
    for(Shark sk: s){
      if(sk.getSex() != getSex()){
        if((this.pos).dist(sk.getPos()) < mdist){
          mdist = (this.pos).dist(sk.getPos());
          fin = sk.getPos();
        }
      }
    }
    if(mdist < sight){
      return fin;
    }
    return null;
  }
  
   public void move(ArrayList<Fish> f, ArrayList<Shark> s){
    //println(hunger);
    updateCharacteristics();
    steps++;
    if((steps/10)%(max_speed+1-speed)==0){
        
        if(hunger > 100){
            path = (breadth(pos, findFood(f)));
            //println("hunting");
        }else if(sexDrive > 240 && age>500){
            path = (breadth(pos, findMate(s)));
            //println("i want sex");
        }else{
           path=null;
           //println("chillin");
        }
        checkFood();
    }
    if(steps%(max_speed+1-speed)==0){
      if(path!=null && path.size()>0){
        moveOnPath(path);
        path.remove(0);
      }
      else moveTo(pos.getRandomNeighboor());
    }
  }
  
  public void die(){
    pos.removeTenant(this);
    Driver.s.remove(this);
  }
  
  public void draw(){
     if(sex==1){
       fill(100);
     }else{
       fill(200);
     }
     rect(pos.getXPix(), pos.getYPix(), Driver.spx, Driver.spy);
     //printInfo();
  }
  
  void printInfo(){
     fill(255, 255, 255);
     text("hunger: " + hunger + 
     "\nage: " + age, pos.getXPix(),pos.getYPix()+Driver.spy/2);
  }
  
}

