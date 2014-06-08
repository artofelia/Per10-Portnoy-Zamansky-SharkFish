public class Fish extends Critter{
  
  public Fish(){
    super();
  }
  
  public Fish(Node pos){
   super(pos);
   speed=10;
   sight=10;
  }
  
  public Fish(Node pos, int speed, int sex, float sight, float max_age, float max_hunger){
    super(pos, speed, sex, sight, max_age, max_hunger);
  }
  
   public void repro(){
    if(sexDrive<10 || age<50) return;
    
    if(sex==1) {
      sexDrive = 0;
      return;
    }
     
    sexDrive = 0;
    int nspeed = speed + (int) (random(4)-2);
    if(nspeed < 1){
      nspeed = 1;
    }else if(nspeed > max_speed){
      nspeed = max_speed;
    }
    
    Fish fs = new Fish(
    pos,
    nspeed, 
    -1,
    max_age + mutation(max_age),
    max_hunger + mutation(max_hunger),
    sight + mutation(sight)
    );
    
    fs.hunger=hunger+10;
    
    hunger+=5;
  
    Driver.f.add(fs);
  }
  
  public void die(){
    pos.removeTenant(this);
    Driver.f.remove(this);
  }
  
  public Node findFood(ArrayList<Algae> a){
    int mdist = (int)sight+1;
    Node fin = new Node();
    
    for(Algae ag: a){
        if((this.pos).dist(ag.getPos()) < mdist){
          mdist = (this.pos).dist(ag.getPos());
          fin = ag.getPos();
        }
    }
    if(mdist < sight){
      return fin;
    }
    return null;
  }
  
  public Node findShark(ArrayList<Shark> s){
    int mdist = (int)sight+1;
    Node fin = new Node();
    for(Shark sh: s){
        if((this.pos).dist(sh.getPos()) < mdist){
          mdist = (this.pos).dist(sh.getPos());
          fin = sh.getPos();
        }
    }
    if(mdist < sight){
      return fin;
    }
    return null;
  }
  
  public void checkFood(){
     Algae at = new Algae();
     Algae ag = (Algae)(pos.getTenantType(at));
     if(ag!=null){
       ag.die();
       hunger-=50;
     }
  }
  
  public Node findMate(ArrayList<Fish> f){
    int mdist = (int)sight+1;
    Node fin = new Node();
    
    for(Fish fs: f){
      if(fs.getSex() != getSex()){
        if((this.pos).dist(fs.getPos()) < mdist){
          mdist = (this.pos).dist(fs.getPos());
          fin = fs.getPos();
        }
      }
    }
    if(mdist < sight){
      return fin;
    }
    return null;
  }
  
  public Node flee(Node danger){
          if(danger==null) return null;
          int dist = danger.dist(pos);
          Node fleeTo=null;
          ArrayList<Node> poses = (ArrayList<Node>)pos.getNeighboors().clone();
          for(Node n:poses){
            if(danger.dist(n) > dist){
              fleeTo=n;
              dist=danger.dist(n);
            }
          }
          if(fleeTo==null) {
            return pos.getRandomNeighboor();
          }else{
            return fleeTo;
          }
  }
  
  public void move(ArrayList<Fish> f, ArrayList<Algae> a, ArrayList<Shark> s){
    updateCharacteristics();
    steps++;
      if(steps%(max_speed+1-speed)==0){
        //Driver.pause = true;
        Node nxt = flee(findShark(s));
        if(nxt!=null){
          moveTo(nxt);
        }else if(hunger > 20){
            moveOnPath(breadth(pos, findFood(a)));
            checkFood();
        }else if(sexDrive > 20){
            moveOnPath(breadth(pos, findMate(f)));
        }else{
          moveTo(pos.getRandomNeighboor());
        }
      
      }
        
  }
  
  public ArrayList<Node> uniqueNeighboors(ArrayList<Node> nn, ArrayList<Node> path){
    for(int i = 0; i < nn.size(); i++){
      Node n = nn.get(i);
      if(path.contains(n)){
        nn.remove(n);
        i--;
      }
    }
    return nn;
  }
  
  
  public ArrayList<Node> pathFood(ArrayList<Algae> a){
    boolean found = false;
    ArrayList<Node> fpath = new ArrayList<Node>();
    ArrayList<Node> path = new ArrayList<Node>();
    ArrayList<Integer> org = new ArrayList<Integer>();
   
    int frindgeCt = 0;
    int cuFr = 1;
    int nextFr = 1;
    int nextFrCt = 0;
    int ct = 0;
    Algae ta = new Algae();
    
    path.add(pos);
    org.add(-1);
    ArrayList<Node> nn = (path.get(0)).getNeighboors();

    outerloop:
    while(ct < Driver.g.getSize()){
      if(path.size()<=ct){
        println(path.size());
        println("bWTF");
        return null;
      }
      
      //println(path);
      //println(cuFr + " " + nextFr + " " + nextFrCt);
      if(cuFr >= nextFr) {
        frindgeCt++;
        if(frindgeCt > sight) break outerloop;
        nextFr = nextFrCt;
        nextFrCt = 0;
        cuFr=0;
      }
      nn = (ArrayList<Node>) ((path.get(ct)).getNeighboors().clone());
      nn = uniqueNeighboors(nn, path);
      Collections.shuffle(nn);
      nextFrCt+=nn.size();
      
      for(int i=0; i < nn.size(); i++){
       Node n = nn.get(i);
       n.visit();
       path.add(n);
       org.add(ct);
       if(n.hasTenantType(ta.getClass())){
         found = true;
         break outerloop;
       }
      }
      cuFr++;
      
      ct++;
    }
    
    if(found){
      int bct = path.size()-1;
      
      while(bct>0){
        fpath.add(0, path.get(bct));
        bct = org.get(bct);
      }
      return fpath;
    }
    return null;
  }
  
  
  public void draw(){
     if(sex==1){
       fill(150,150,255);
     }else{
       fill(100,100,200);
     }
     ellipse(pos.getXPix()+Driver.spx/2, pos.getYPix()+Driver.spy/2, Driver.spx, Driver.spy);
     //printInfo();
  }
  
  void printInfo(){
     fill(255, 255, 255);
     text("hunger: " + hunger + 
     "\nage: " + age, pos.getXPix(),pos.getYPix()+Driver.spy/2);
  }
  
}
