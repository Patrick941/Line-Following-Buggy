void WriteData() {
  if ((mousePressed == true) && (mouseY < 450) && (mouseY > 30)&& (mouseX > 30) && (mouseX <740)) {
    ButtonState = '1';
  } else if ((mousePressed == true) && (mouseY < 970) && (mouseY > 530)&& (mouseX > 30) && (mouseX <740)) {
    ButtonState = '0';
  }
  if (ButtonState == '1') {
    textSize(250);
    fill(0, 155, 0);
    rect(30, 30, 740, 420, 200);
    fill(0);
    text("GO", 245, 310);
    fill(255, 0, 0);
    rect(30, 530, 740, 420, 200);
    fill(0);
    text("STOP", 115, 820);
  } else if (ButtonState == '0') {
    textSize(250);
    fill(155, 0, 0);
    rect(30, 530, 740, 420, 200);
    fill(0);
    text("STOP", 115, 820);
    fill(0, 255, 0);
    rect(30, 30, 740, 420, 200);
    fill(0);
    text("GO", 245, 310);
  }
  c.write(ButtonState);
}
