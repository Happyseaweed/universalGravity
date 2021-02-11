import java.util.*;
import java.lang.Math.*;

ArrayList<Planet> planets = new ArrayList<Planet>(100);
static float gconstant =  6.6743 * (float)(Math.pow(10, -11));
static int FRAME_RATE = 60;
static boolean paused = false;

class Planet{
  float mass;
  PVector vel;
  PVector acc;
  PVector pos;
  float radius;
  
  Planet(float mass, PVector vel, PVector acc, PVector pos, float radius){
    this.mass = mass;
    this.vel = vel;
    this.acc = acc;
    this.pos = pos; 
    this.radius = radius;
  }
  
  public void update_planet(){
    //System.out.println(this.pos.y+this.radius + " " + this.vel.y);
    this.pos.x += this.vel.x;
    this.pos.y += this.vel.y;
    this.vel.x += this.acc.x;
    this.vel.y += this.acc.y;
    this.acc.x = 0;
    this.acc.y = 0;
  }
  
}

void setup(){
  size(1080, 720);
  background(0);
  
  Planet p1 = new Planet(3000, new PVector(0,0.5), new PVector(0,0), new PVector(300,400), 30); 
  Planet p2 = new Planet(3000, new PVector(0,-0.5), new PVector(0,0), new PVector(780,560), 30); 
  Planet star = new Planet((float)Math.pow(10,38), new PVector(0,0), new PVector(0,0), new PVector(540,360), 90); 
  planets.add(p1);
  planets.add(p2);
  //planets.add(star);
  frameRate(FRAME_RATE);
}

void display_data(){
  System.out.println("\n\n\n\n\n\n\n");
  for (int i = 0; i < planets.size(); i++){
     System.out.println("Planet: " + i);
     System.out.println("X-Vel: " + planets.get(i).vel.x + " Y-Vel: " + planets.get(i).vel.y);
     circle(planets.get(i).pos.x, planets.get(i).pos.y, planets.get(i).radius);
     stroke(255);
     strokeWeight(3);
     line(planets.get(i).pos.x, planets.get(i).pos.y, planets.get(i).pos.x+100*planets.get(i).vel.x, planets.get(i).pos.y+100*planets.get(i).vel.y);
  }
}

void draw(){
  background(0);
  
  if (paused){
    display_data();
  }else{
    for (int i = 0; i < planets.size(); i++){
      for (int j = 0; j < planets.size(); j++){
        if (i==j)continue;
        
        float F = 0;
        float theta = 0;
        float dist = 0;
        float diffx = planets.get(i).pos.x-planets.get(j).pos.x;
        float diffy = planets.get(i).pos.y-planets.get(j).pos.y;
        dist = sqrt(diffx*diffx + diffy*diffy);
        
        //F = gconstant*planets.get(i).mass*planets.get(j).mass/(dist*dist)*100000000;
        F = planets.get(i).mass*planets.get(j).mass/(dist*dist)/4;
        if (dist > 600) F*=16;
        else if (dist > 300) F*=4;
        else if (dist > 150) F*=2;
        else if (dist < 75) F*=0.5; 
        else if (dist < 34.5) F*=0.25;
        
        
        if (diffx==0){
          if (diffy < 0) F *= -1;
          planets.get(i).acc.y = -F/planets.get(i).mass;
          planets.get(j).acc.y = F/planets.get(j).mass;
        }
        else if (diffy==0){
          if (diffx < 0) F *= -1;
          planets.get(i).acc.x = -F/planets.get(i).mass; 
          planets.get(j).acc.x = F/planets.get(j).mass;
        }else{
          theta = abs(atan(diffy/diffx));// from planet(i)'s perspective
          
          System.out.println("\n\n\n\n\n\n\n\nPlanet: " + i);
          System.out.println("Theta: " + theta*180/3.14159);
          System.out.println("X-Vel: " + planets.get(i).vel.x + " Y-Vel: " + planets.get(i).vel.y);
          System.out.println("Planet: " + j);
          System.out.println("X-Vel: " + planets.get(j).vel.x + " Y-Vel: " + planets.get(j).vel.y);
          System.out.println("Distance: " + dist ); 
          // planet1 x: positive; y: negative, tan: negative
          // planet
          float xs = -1;
          float ys = -1;
          if (diffx < 0) xs = 1;  // j is to the right of i
          if (diffy < 0) ys = 1; // j is below i
          planets.get(i).acc.x += xs*F*cos(theta)/planets.get(i).mass;
          planets.get(i).acc.y += ys*F*sin(theta)/planets.get(i).mass;
          
          planets.get(j).acc.x += -xs*F*cos(theta)/planets.get(j).mass;
          planets.get(j).acc.y += -ys*F*sin(theta)/planets.get(j).mass;
        }
        stroke(255);
        line(planets.get(i).pos.x, planets.get(i).pos.y, planets.get(i).pos.x+100*planets.get(i).vel.x, planets.get(i).pos.y+100*planets.get(i).vel.y);
        line(planets.get(j).pos.x, planets.get(j).pos.y, planets.get(j).pos.x+100*planets.get(j).vel.x, planets.get(j).pos.y+100*planets.get(j).vel.y);
        stroke(200,0,0);
        strokeWeight(3);
        line(planets.get(i).pos.x, planets.get(i).pos.y, planets.get(i).pos.x+10000*planets.get(i).acc.x, planets.get(i).pos.y+10000*planets.get(i).acc.y);
        line(planets.get(j).pos.x, planets.get(j).pos.y, planets.get(j).pos.x+10000*planets.get(j).acc.x, planets.get(j).pos.y+10000*planets.get(j).acc.y);
      
      }
      planets.get(i).update_planet();
      circle(planets.get(i).pos.x, planets.get(i).pos.y, planets.get(i).radius);
    }
  }
}

void keyPressed(){
  if (key=='p') paused = !paused;
}

void mouseClicked(){
  Planet p = new Planet(3000, new PVector(0,0), new PVector(0,0), new PVector(mouseX,mouseY), (float)30); 
  planets.add(p);
}
