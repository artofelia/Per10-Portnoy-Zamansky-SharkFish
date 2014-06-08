public class Critter{

  Node pos;
  int dir; //0-up,1-right,2-down,3-left
  
  int steps;//moving
  int max_steps;
  int speed, max_speed; //max = 10;
  
  float sight;
  float age, max_age;
  float hunger, max_hunger;
  int sex; //1-male, 0-female
  float sexDrive;
  
  ArrayList<Node>path;
  
  public Node getPos(){
    return pos;
  }
  public int getX(){
    return pos.x;
  }
  public int getY(){
    return pos.y;
  }
  
  public int getSex(){
    return sex;
  }
  
  public void repro(){}
  public void die(){};
  
  public float mutation(float num){
    return random(num)-num/2;
  }
  
  public void checkRepro(){
    ArrayList<Critter> myTenants = pos.getTenants();
    ArrayList<Critter> toRepro = new ArrayList<Critter>();
    for(Critter c: myTenants){
          if(this.getClass()==c.getClass()){
             if(c.getSex()!=getSex()){
               toRepro.add(c);
          }
      }
    }
    for(Critter c: toRepro){
         c.repro();
    }
  }
  
  public void initCharacteristics(int nspeed, int nsex, float sight, float nmax_age, float nmax_hunger){
    max_speed = 10;
    if(nspeed==-1){
      speed = 5;
    }else{
      speed = nspeed; 
    }
    
    if(sight==-1){
      this.sight=15;
    }else{
      this.sight = sight;
    }
    
    age = 0;
    if(nmax_age==-1){
      max_age = 5000;
    }else{
      max_age = nmax_age;
    }
    
    hunger = 0;
     if(nmax_hunger==-1){
      max_hunger = 1000;
    }else{
      max_hunger = nmax_hunger;
    }
    if(nsex == -1){
      sex = (int)random(2);
    }else{
      sex = nsex;
    }
    sexDrive = 0;
  }
  
  public void checkCharacteristics(){
    if(age>max_age) {
      die();
    }
    if(hunger>max_hunger) {
      //println(this.getClass()+" died of hunger");
      die();
    }
  }
  
  public void updateCharacteristics(){
    age++;
    hunger++;
    sexDrive++;
    checkCharacteristics();
    checkRepro(); 
  }
  
   public Critter(){
     pos = null;
   }
  
  public Critter(Node pos){
    this.pos = pos;
    pos.addTenant(this);
    initCharacteristics(-1, -1, -1, -1, -1);
    steps = 0;
    max_steps = 50;
    path=new ArrayList<Node>();
  }
  
  public Critter(Node pos, int speed, int sex, float sight, float max_age, float max_hunger){
    this.pos = pos;
    pos.addTenant(this);
    initCharacteristics(speed, sex, sight, max_age, max_hunger);
    steps = 0;
    max_steps = 50;
    path=new ArrayList<Node>();
  }
  
  public void moveTo(Node npos){
      pos.removeTenant(this);
      pos = npos;
      pos.addTenant(this);
  }
  
  public void move(){
    updateCharacteristics();
    steps++;
      if(steps%(max_speed-speed)==0){
      moveTo(pos.getRandomNeighboor());
    }
  }
  
 public void moveOnPath(ArrayList<Node>path){
    if(path!=null && path.size()>0) {
      moveTo(path.get(0));
    }else{
      moveTo(pos.getRandomNeighboor());
    }
  }
  
  public ArrayList<Node> breadth(Node pos, Node finish){
    if(finish==null || pos==null) return null;
    
    if(pos.dist(finish)>sight)return null;
    
    boolean found = false;
    ArrayList<Node> fpath = new ArrayList<Node>();
    ArrayList<Node> path = new ArrayList<Node>();
    ArrayList<Integer> org = new ArrayList<Integer>();
    path.add(pos);
    org.add(-1);
    if(pos.equals(finish)) return path;
    
    int ct = 0;
    
    outerloop:
    while(ct < Driver.g.getSize()){
      if(ct>=path.size()) return null;
      ArrayList<Node> nn = (path.get(ct)).getNeighboors();
      Collections.shuffle(nn);
      for(int i=0; i<nn.size(); i++){
        int j=i;
        while(j>0 && pos.dist(nn.get(j))<pos.dist(nn.get(j-1))){
          Node tmp=nn.get(j);
          nn.set(j,nn.get(j-1));
          nn.set(j-1,tmp);
          j--;
        }
      }
      for(int i=0; i < nn.size(); i++){
       Node n = nn.get(i);
       if(!path.contains(n) && pos.dist(n)<sight){
          path.add(n);
          if(Driver.visit)n.visit();
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
        fpath.add(0, path.get(bct));
        bct = org.get(bct);
      }
      
      
      return fpath;
    }
    return null;
  }
  
  
  
  public String stringList(ArrayList<Node> list){
    String s = "";
   for(Node n: list){
      s+=n.toString();
    }
    return s;
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
  
}

