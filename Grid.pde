public class Grid{
  
  ArrayList<Node> spots;
  int w,h;
  
  public ArrayList<Node> getSpots(){
    return spots;
  }
  
   public int getSize(){
    return spots.size();
  }
  
  public int getSpotX(int i){
    return getSpot(i).x;
  }
  public int getSpotY(int i){
    return getSpot(i).y;
  }
  public int getSpotInd(int x, int y){
    for(int i = 0; i < getSize(); i++){
      if(getSpotX(i)==x && getSpotY(i)==y){
        return i;
      }
    }
    return -1;  
  }
  
  public Node getSpot(int x, int y){
    int ind = getSpotInd(x, y);
    if(ind <0) return null;
    return getSpot(ind);
  }
  
  public Node getSpot(int i){
    return spots.get(i);
  }
  
  public void removeSpot(int i){
    Node n = getSpot(i);
    if(n==null) return;
    for(Node m: n.getNeighboors()){
      m.removeNeighboor(n);
    }
    spots.remove(n);
  }
  
  public void removeSpot(int x, int y){
    Node n = getSpot(x, y);
    if(n==null) return;
    for(Node m: n.getNeighboors()){
      m.removeNeighboor(n);
    }
    spots.remove(n);
  }
  
  public void cleanGrid(){
  int ct = 1;
  
  while(ct!=0){
    ct = 0;
    for(int i = 0; i < getSize(); i++){
      Node n = getSpot(i);
      if(n.getNeighboors().size()==0){
        removeSpot(i);
        ct++;
      }
    }
  
  }
}
  
  public Grid(int w, int h){
      this.w = w;
      this.h = h;
      spots = new ArrayList<Node>();
      
      for(int r = 0; r < h; r++){
        for(int c = 0; c < w; c++){
              Node n = new Node(c,r);
              spots.add(n);
              //println(n);
        }
      }
      for(int i = 0; i < getSize(); i++){
              Node n = getSpot(i);
              int c = n.x;
              int r = n.y;
              if(c==0){
                n.addNeighboor(getSpot(c+1,r));
              }else if(c==w-1){
                n.addNeighboor(getSpot(c-1,r));
              }else{
                n.addNeighboor(getSpot(c-1,r));
                n.addNeighboor(getSpot(c+1,r));
              }
              
              if(r==0){
                n.addNeighboor(getSpot(c,r+1));
              }else if(r==h-1){
                n.addNeighboor(getSpot(c,r-1));
              }else{
                n.addNeighboor(getSpot(c,r-1));
                n.addNeighboor(getSpot(c,r+1));
              }
      }
      
  }
  
  public void carve(int x, int y, float p, float ch){
    Node n = getSpot(x,y);
    if(n==null) return;
    ArrayList<Node> nn = n.getNeighboors();
    for(int i = 0; i < nn.size(); i++){
      Node m = nn.get(i);
      if(random(100) < p){
        carve(m.x, m.y, p-ch, ch);
      }
    }
    removeSpot(x, y);
  }
  
  
  

}
