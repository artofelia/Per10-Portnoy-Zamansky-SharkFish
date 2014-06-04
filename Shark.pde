public class Shark extends Critter{
  
  public Shark(Node pos){
   super(pos); 
  }
  
  public ArrayList<Node> breadth(Node pos, Node finish){
    ArrayList<Node> path = new ArrayList<Node>();
    path.add(pos);
    while(path.size()>0){
      Node last=path.get(path.size()-1);
      Node next=path.remove(0);
      if(next.equals(last))return path;
      for(Node n:node.getNeighboors()){
       ArrayList<Node>newPath=path;
       newPath.add(n);
       for(Node o:newPath){
        path.add(o); 
       }
      }
    }
    
  }
  
  public void move(Node goal){
    ArrayList<Node>path=breadth(pos,goal);
    steps++;
    if(steps%(10-speed)==0){
      pos.removeTenant(this);
      pos.addTenant(this);
    }
  }
}
