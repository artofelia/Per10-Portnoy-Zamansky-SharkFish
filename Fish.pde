public class Fish extends Critter{
  
  public boolean eaten;
  
  public Fish(Node pos){
   super(pos); 
   eaten=false;
   sight=10;
   season=0;
   seasoned=false;
  }
 
 public Node findClosestFish(ArrayList<Fish> f){
    int mdist = sight+1;
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
  
  public void move(ArrayList<Fish> f){
    Node goal=null;
    if(season>=1000){
      season=0;
      seasoned=false;
    }
    if(750<=season && season<=1000 && !seasoned){
      goal=findClosestFish(f);
      println(season);
    }
    steps++;
    if(steps%(10-speed)==0){
      pos.removeTenant(this);
      if(goal!=null){
        ArrayList<Node>path=breadth(pos, goal);
        if(pos.dist(goal)<=1){
          f.add(new Fish(pos));
          seasoned=true;
        }
        pos = path.get(0);
      }else{
        pos = pos.getRandomNeighboor();
      }
      pos.addTenant(this);
    }
    season++;
  }
}
