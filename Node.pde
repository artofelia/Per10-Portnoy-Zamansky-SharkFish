public class Node{

   ArrayList<Node> neighboors;
   ArrayList<Critter> tenants;
   int x,y;
   int h;
   public boolean visited;
   
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
   
   public ArrayList<Node> getNeighboors(){
     return neighboors;
   }
   
   public Node getRandomNeighboor(){
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
     tenants.add(c);
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
   
   public int dist(Node n){
     return abs((x-n.x))+abs((y-n.y));
   }
   
   
   
   public String toString(){
     return "Node: @- (" + x + "," + y + ") h- "+h;
   }


}
