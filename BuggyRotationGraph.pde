void BuggyRotation() {
  pushMatrix();
  noStroke();
  translate(-2350,-1800);
  scale(3);
  translate(1350,820);
  fill(50);
  rect(-67,-900,600,1300);
  if(Turning==2){
  }
  if(Turning==3){
    rotate(PI/4);
  }
  if(Turning==1){
    rotate(-PI/4);
  }
  fill(200, 200, 200);
  rect(-40, -40, 80, 80);
  fill(255, 180, 0);
  rect(-35, -40, 3, 40);
  rect(-35, 0, 30, 3);
  rect(-5, 0, 3, 10);
  fill(50, 100, 200);
  rect(-40, 10, 40, 25);
  rect(-35, -70, 15, 30);
  rect(25, -70, 15, 30);
  fill(0, 0, 255);
  rect(-30,-40, 3, 50);
  fill(255, 0, 0);
  rect(-25, -40, 3, 50);
  fill(255, 180, 0);
  rect(25, -40, 3, 40);
  rect(-12, 0, 40, 3);
  fill(255, 0, 0);
  rect(35, -40, 3, 78);
  rect(-10, 35, 50, 3);
  fill(0, 0, 255);
  rect(30, -40, 3, 10);
  rect(-30, -30, 63, 3);
  fill(255, 255, 0);
  rect(-43, -38, 3, 40);
  rect(40, -38, 3, 40);
  popMatrix();
  stroke(0);
}
