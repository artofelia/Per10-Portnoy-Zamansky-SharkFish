public class Node{

   ArrayList<Node> neighboors;
   ArrayList<Critter> tenants;
   int x,y;
   int h;
   boolean visited;
   int ct;
   
   public void update(){
     ct++;
     if(ct>10) {
       visited = false;
     }
   }
   
   public void visit(){
     visited = true;
     ct = 0;
   }
   
   public Node(){
     neighboors = new ArrayList<Node>();
     tenants = new ArrayList<Critter>();
     h = 0;
     x = -1;
     y = -1;
   }
   
   public Node(int x, int y){
     neighboors = new ArrayList<Node>();
     tenants = new ArrayList<Critter>();
     h = 0;
     this.x = x;
     this.y = y;
   }
   
   public Node(ArrayList<Node> neighboors){
     this.neighboors = neighboors;
     tenants = new ArrayList<Critter>();
     h = 0;
     x = -1;
     y = -1;
   }
   
   public Node(ArrayList<Node> neighboors, int h){
     this.neighboors = neighboors;
     tenants = new ArrayList<Critter>();
     this.h = h;
     x = -1;
     y = -1;
   }
   
   public void setX(int x){
     this.x = x;
   }
   public void setY(int y){
     this.y = y;
   }
   
   public int getX(){
     return x;
   }
   public int getY(){
     return y;
   }
   
   public float getXPix(){
      return x*Driver.spx;
  }
  public float getYPix(){
      return y*Driver.spy;
  }
   
   public ArrayList<Node> getNeighboors(){
     return neighboors;
   }
   
   public Node getRandomNeighboor(){
     if(neighboors.size()==0) return this;
     return getNeighboor((int)random(neighboors.size()));
   }
   
   public Node getNeighboor(int i){
     return neighboors.get(i);
   }
   
   public boolean removeNeighboor(Node n){
      return neighboors.remove(n);
   }
   
   public void addNeighboor(Node n){
      neighboors.add(n);
   }
   
   public void addTenant(Critter c){
     if(!hasTenant(c)){
       tenants.add(c);
     }
   }
    public void removeTenant(Critter c){
     if(hasTenant(c)){
       tenants.remove(c);
     }
   }
   
   public ArrayList<Critter> getTenants(){
     return tenants;
   }
   
   public boolean hasTenant(Critter c){
     return tenants.contains(c);
   }
   
   public Critter getTenantType(Critter c){
     for(Critter c2: tenants){
       if(c2.getClass()==c.getClass()){
         return c2;
       }
     }
     return null;
   }
   
   public boolean hasTenantType(Class cl){
     for(Critter c: tenants){
       if(c.getClass()==cl){
         return true;
       }
     }
     return false;
   }
   
   public int dist(Node n){
     return abs((x-n.x))+abs((y-n.y));
   }
   
   public void draw(){
    if(visited){
     fill(50,50,100);
    }else{
     fill(50,50,150);
    }
    rect(getXPix(), getYPix(), Driver.spx, Driver.spy);
   }
   
   
   
   public String toString(){
     return "Node: @- (" + x + "," + y + ") h- "+h;
   }


}
