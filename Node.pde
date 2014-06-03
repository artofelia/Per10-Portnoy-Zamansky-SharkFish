public class Node{

   ArrayList<Node> neighboors;
   int x,y;
   int h;
   
   public Node(){
     neighboors = new ArrayList<Node>();
     h = 0;
     x = -1;
     y = -1;
   }
   
   public Node(int x, int y){
     neighboors = new ArrayList<Node>();
     h = 0;
     this.x = x;
     this.y = y;
   }
   
   public Node(ArrayList<Node> neighboors){
     this.neighboors = neighboors;
     h = 0;
     x = -1;
     y = -1;
   }
   
   public Node(ArrayList<Node> neighboors, int h){
     this.neighboors = neighboors;
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
   
   public String toString(){
     return "Node: @- (" + x + "," + y + ") h- "+h;
   }


}
