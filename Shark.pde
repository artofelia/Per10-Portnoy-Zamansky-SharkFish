import java.util.*;

public class Shark extends Critter{
  
  int sight;
  
  public Shark(Node pos){
   super(pos); 
   sight = 10;
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
  
   public ArrayList<Node> breadth(Node pos, Node finish){
    boolean found = false;
    ArrayList<Node> fpath = new ArrayList<Node>();
    ArrayList<Node> path = new ArrayList<Node>();
    ArrayList<Integer> org = new ArrayList<Integer>();
    path.add(pos);
    if(pos.equals(finish)) return path;
    org.add(-1);
    
    int ct = 0;
    
    outerloop:
    while(ct < Driver.g.getSize()){
      
      ArrayList<Node> nn = (path.get(ct)).getNeighboors();
      Collections.shuffle(nn);
      for(int i=0; i < nn.size(); i++){
       Node n = nn.get(i);
       if(!path.contains(n)){
          path.add(n);
          org.add(ct);
          if(n.equals(finish)){
            found = true;
            break outerloop;
          }
       }
       
      }
      
      ct++;
    }
    //println(stringList(path));
    if(found){
      int bct = path.size()-1;
      
      while(bct>0){
        //println(bct);
        fpath.add(0, path.get(bct));
        bct = org.get(bct);
      }
      
      
      return fpath;
      }
    return null;
  }
  
  
  public void move(ArrayList<Fish> f){
    Node goal = findClosestFish(f);
    steps++;
    if(steps%(10-speed)==0){
      pos.removeTenant(this);
      if(goal!=null){
        ArrayList<Node>path=breadth(pos, goal);
        pos = path.get(0);
      }else{
        pos = pos.getRandomNeighboor();
      }
      pos.addTenant(this);
    }
  }
}
