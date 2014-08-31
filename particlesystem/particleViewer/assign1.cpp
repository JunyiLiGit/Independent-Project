//
// assign1.cpp
//
// Particle Viewer
//
// Kacey Coley July 2014
//
//
#include "Camera.h"
#include "Vector.h"

#include <string.h>
#include <cstdlib>
#include <cstdio>
#include <iostream>

#ifdef __APPLE__
#  include <GLUT/glut.h>
#else
#  include <GL/glut.h>
#endif
#include "SimData.h"
#include "particlePath.h"




// global variables
int WIDTH = 640;
int HEIGHT = 480;
static unsigned int NUMBER=1000;
static float TIMEGAP=90;

int persp_win;

Camera *camera;
ParticleSystem::Curve* curve;
ParticleSystem::ParticlePath* particlePath;


static int TimerDelay;
int TIMERMSECS;



void initSim() {

	SimData::Instance()->G.x = 0.0;
	SimData::Instance()->G.y = -9.8;
	SimData::Instance()->deltaT = 0.001;
	SimData::Instance()->fps = 120;
	SimData::Instance()->m = 10;
	SimData::Instance()->t = 1;
	SimData::Instance()->cof = 0.5;
	SimData::Instance()->cor = 0.5;
	SimData::Instance()->collision_flag = false;

}

void init() {


    // set up camera
    // parameters are eye point, aim point, up vector
    camera = new Camera(Vector3d(0, 0, 27), Vector3d(0, 0, 0),
                        Vector3d(0, 1, 0));


      curve= new ParticleSystem::Curve([] (float t) -> float { return pow(2*sin(t) , 3.0); },
																		[] (float t) -> float { return 3*cos(t)-1.2*cos(2*t)-0.6*cos(3*t)-0.2*cos(4*t); });
        particlePath = new ParticleSystem::ParticlePath((*curve),NUMBER);



    initSim();
    TIMERMSECS = 1000 * SimData::Instance()->deltaT;
    TimerDelay = int(0.5 * SimData::Instance()->deltaT * 1000);


}

void draw(){
	std::vector <ParticleSystem::Particle> particles = particlePath->getParticles();
	glBegin(GL_POINTS);
		for(auto iter = particles.begin(); iter!= particles.end(); ++iter){
			glVertex3f((*iter).position.x, (*iter).position.y, 1.0f);
		}

	glEnd();
}


void PerspDisplay() {

    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    // draw the camera created in perspective
    camera->PerspectiveDisplay(WIDTH, HEIGHT);

    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();


  static float time = 1;
  time = SimData::Instance()->deltaT*100000;

  // Add your API code here

   particlePath->moveParticles(time);

  glPointSize(2.0f);
	glPushMatrix();
  glColor3f(0,1,0); //Blue color
	draw();
  glPopMatrix();

	glPushMatrix();
	glTranslatef(-3,0,0);
	glColor3f(1,0,0); //Blue color
	draw();
  glPopMatrix();

  glPushMatrix();
	glTranslatef(-6,0,0);
	glColor3f(1,1,0); //Blue color
	draw();
	glPopMatrix();


    glutSwapBuffers();
}



void simulate() {


  PerspDisplay();

}


void mouseEventHandler(int button, int state, int x, int y) {
    // let the camera handle some specific mouse events (similar to maya)
    camera->HandleMouseEvent(button, state, x, y);
    glutPostRedisplay();
}

void motionEventHandler(int x, int y) {
    // let the camera handle some mouse motions if the camera is to be moved
    camera->HandleMouseMotion(x, y);
    glutPostRedisplay();
}

void keyboardEventHandler(unsigned char key, int x, int y) {
    switch (key) {

        case 'q': case 'Q':	// q or esc - quit
        case 27:		// esc
            exit(0);
    }

    glutPostRedisplay();
}


void idle(int value) {
    glutTimerFunc(TIMERMSECS, idle, 0);
	float time, simTime;
	float static lastIdleTime = 0, newTime = 1;
	time = glutGet(GLUT_ELAPSED_TIME)/1000;

    simulate();


}


int main(int argc, char *argv[]) {
    // set up opengl window
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_RGBA | GLUT_DEPTH | GLUT_DOUBLE);
    glutInitWindowSize(WIDTH, HEIGHT);
    glutInitWindowPosition(50, 50);
    persp_win = glutCreateWindow("ParticleViewer");


    init();
    glutTimerFunc(TimerDelay, idle, 0);


    // set up opengl callback functions
    glutDisplayFunc(PerspDisplay);
    glutMouseFunc(mouseEventHandler);
    glutMotionFunc(motionEventHandler);
    glutKeyboardFunc(keyboardEventHandler);

    glutMainLoop();
    return(0);
}
