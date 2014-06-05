import java.util.*;

public class Shark extends Critter{
  
  int sight;
  int hunger;
  
  public boolean dead;
  
  public Shark(Node pos){
   super(pos); 
   sight = 20;
   hunger=0;
   dead=false;
  }
  
  public Shark(Node pos,int hunger, int season){
    super(pos);
    sight=20;
    this.hunger=hunger;
    dead=false;
    this.season=season;
    this.seasoned=true;
  }
/*  
  public ArrayList<Node> depth(Node st, Node finish){
    ArrayList<Node> path = new ArrayList<Node>();
    path.add(st);
    return depth(finish, path);
  }
  public ArrayList<Node> depth(Node finish, ArrayList<Node> path){
    if(path.size()>sight) return null;
    Node l = path.get(path.size()-1);
    if(l.equals(finish)) return path;
    Node s = path.get(0);
    
    for(Node n: s.getNeighboors()){
      if(!path.contains(n)){
        ArrayList<Node> newPath = path;
        newPath.add(n);
        return depth(finish, newPath);
      }
    }
    return null;
  }
  */
  
  public String stringList(ArrayList<Node> list){
    String s = "";
   for(Node n: list){
      s+=n.toString();
    }
    return s;
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
  
  public Fish returnClosestFish(ArrayList<Fish> f){
    int mdist = sight+1;
    Fish fin = null;
    
    for(Fish fs: f){
      if((this.pos).dist(fs.getPos()) < mdist){
        mdist = (this.pos).dist(fs.getPos());
        fin = fs;
      }
    }
    if(mdist < sight){
      return fin;
    }
    return null;
  }
  
    public Node findClosestShark(ArrayList<Shark> s){
    int mdist = sight+1;
    Node fin = new Node();
    
    for(Shark sk: s){
      if((this.pos).dist(sk.getPos()) < mdist){
        mdist = (this.pos).dist(sk.getPos());
        fin = sk.getPos();
      }
    }
    if(mdist < sight){
      return fin;
    }
    return null;
    
  }
  
  
  
  public void move(ArrayList<Fish> f,ArrayList<Shark> s){
    String target="";
    Node goal=null;
    if(season>=2000){
      season=0;
      seasoned=false;
    }
    if(1500<=season && season<=2000 && !seasoned){
      goal=findClosestShark(s);
      target="shark";
      println(season);
    }
    if(hunger>1000){
      goal = findClosestFish(f);
      target="fish";
    }
    if(hunger>2000){
     dead=true; 
    }
    steps++;
    if(steps%(10-speed)==0){
      pos.removeTenant(this);
      if(goal!=null){
        ArrayList<Node>path=breadth(pos, goal);
        if(pos.dist(goal)<=1){
          if(target.equals("fish"))returnClosestFish(f).eaten=true;
          if(target.equals("shark"))s.add(new Shark(pos,hunger+50,season));
          seasoned=true;
          hunger=0;
        }
        pos = path.get(0);
      }else{
        pos = pos.getRandomNeighboor();
      }
      pos.addTenant(this);
    }
    hunger++;
    season++;
  }
}
