void GraphDistance() {
  if (Distance<50 && Distance>0) {
    int ypos = floor(716-(Distance*11.46));
    textSize(20);
    fill(0, 0, 0);
    rect(1200, 100, 300, 800, 10);
    fill(100, 100, 100);
    rect(1300, 100, 100, 800);
    fill(200, 200, 200);
    rect(1310, 780, 80, 80);
    fill(255, 180, 0);
    rect(1315, 780, 3, 40);
    rect(1315, 820, 30, 3);
    rect(1345, 820, 3, 10);
    fill(50, 100, 200);
    rect(1310, 830, 40, 25);
    rect(1315, 750, 15, 30);
    rect(1375, 750, 15, 30);
    fill(0, 0, 255);
    rect(1320, 780, 3, 50);
    fill(255, 0, 0);
    rect(1325, 780, 3, 50);
    fill(255, 180, 0);
    rect(1375, 780, 3, 40);
    rect(1338, 820, 40, 3);
    fill(255, 0, 0);
    rect(1385, 780, 3, 78);
    rect(1340, 855, 50, 3);
    fill(0, 0, 255);
    rect(1380, 780, 3, 10);
    rect(1320, 790, 63, 3);
    fill(255, 255, 0);
    rect(1307, 782, 3, 40);
    rect(1390, 782, 3, 40);
    fill(255, 255, 255);
    text("0", 1210, 716);
    text("5", 1210, 659);
    text("10", 1210, 602);
    text("15", 1210, 545);
    text("20", 1210, 488);
    text("25", 1210, 431);
    text("30", 1210, 374);
    text("35", 1210, 317);
    text("40", 1210, 260);
    text("45", 1210, 203);
    text("50", 1210, 145);
    fill(255, 0, 0);
    rect(1310, ypos, 80, 20);
  } else {
    textSize(20);
    fill(0, 0, 0);
    rect(1200, 100, 300, 800, 10);
    fill(100, 100, 100);
    rect(1300, 100, 100, 800);
    fill(200, 200, 200);
    rect(1310, 780, 80, 80);
    fill(255, 180, 0);
    rect(1315, 780, 3, 40);
    rect(1315, 820, 30, 3);
    rect(1345, 820, 3, 10);
    fill(50, 100, 200);
    rect(1310, 830, 40, 25);
    rect(1315, 750, 15, 30);
    rect(1375, 750, 15, 30);
    fill(0, 0, 255);
    rect(1320, 780, 3, 50);
    fill(255, 0, 0);
    rect(1325, 780, 3, 50);
    fill(255, 180, 0);
    rect(1375, 780, 3, 40);
    rect(1338, 820, 40, 3);
    fill(255, 0, 0);
    rect(1385, 780, 3, 78);
    rect(1340, 855, 50, 3);
    fill(0, 0, 255);
    rect(1380, 780, 3, 10);
    rect(1320, 790, 63, 3);
    fill(255, 255, 0);
    rect(1307, 782, 3, 40);
    rect(1390, 782, 3, 40);
    fill(255, 255, 255);
    text("0", 1210, 716);
    text("5", 1210, 659);
    text("10", 1210, 602);
    text("15", 1210, 545);
    text("20", 1210, 488);
    text("25", 1210, 431);
    text("30", 1210, 374);
    text("35", 1210, 317);
    text("40", 1210, 260);
    text("45", 1210, 203);
    text("50", 1210, 145);
  }
}