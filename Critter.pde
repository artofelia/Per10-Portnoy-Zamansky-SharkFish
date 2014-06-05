public class Critter{

  Node pos;
  int dir; //0-up,1-right,2-down,3-left
  
  int steps;//moving
  int max_steps;
  int speed; //max = 10;
  
  int sight;
  
  int season;
  boolean seasoned;
  
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
    season=0;
    seasoned=false;
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
  
  public void move(){
    steps++;
    if(steps%(10-speed)==0){
      pos.removeTenant(this);
      pos = pos.getRandomNeighboor();
      pos.addTenant(this);
    }
  }
  
}
