import gab.opencv.*;
import java.awt.Rectangle;
import processing.video.*;
//Requires processing video library and opencv library for processing
Capture video;
OpenCV opencv;
int h=0;
//tracks the number of loop iterations which have not seen a face
int vc=0;
//face time, the number of times a face it detected
float ft=0; 
//length of time before the camera displays again
//int t=0;
//int tm[]={50,40,30,15,6};

void setup() {
  size(640, 480);
  video = new Capture(this, 640, 480);
  opencv = new OpenCV(this, 640, 480);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  video.start();    
  }

void draw() {
  
  if ( vc <= 5){
    image(video, 0, 0);
    opencv.loadImage(video); 
    Rectangle[] faces = opencv.detect();
    noFill();
    stroke(0, 255, 0);
    strokeWeight(3);
    for (int i = 0; i < faces.length; i++) {
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
        if (faces.length >.7) {
          background(0);
          vc=vc+1;
         }
        }   
//    if (ft > 0){
//      ft=ft-.2;
//    }
       println(vc);
       println("inital loop"); 
       println("opencv");
       print(faces.length); 
   }
     
  if (vc >= 30) {
    image(video, 0, 0);
    opencv.loadImage(video); 
    Rectangle[] faces = opencv.detect();
    noFill();
    stroke(0, 255, 0);
    strokeWeight(3);
    for (int i = 0; i < faces.length; i++) {
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
        if (faces.length >.7) {
          vc=5;
        }
    }  
     vc=0;
     expand(faces,0);
     println(vc);
     println("no face detected in 10 iterations");
     println("face length");
     print(faces.length);
   }
// A face has been detected but is no longer seen
// starting to monitor room, if no faces are seen in 50 cycles the
// display turns on again
   if ((vc > 5) && ( vc < 30)) {
    image(video, 0, 0);
    opencv.loadImage(video); 
    background(0); 
    Rectangle[] faces = opencv.detect();
    noFill();
    stroke(0, 255, 0);
    strokeWeight(3);
    for (int i = 0; i < faces.length; i++) {
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
        if (faces.length >.7) {
          vc=6;
          //ft=ft+1;
         }
    }
      vc=vc+1;
      println(vc);
      println("Initial Face Detected, Looking for More");
    
   }
}
  void captureEvent(Capture c) {
  c.read();
  
}
