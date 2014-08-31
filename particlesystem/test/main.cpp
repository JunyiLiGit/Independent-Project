#include "curve.h"
#include "point.h"
#include <iostream>
#include <math.h>

int main(){
  ParticleSystem::Curve curve([] (float t) -> float { return sin (t*M_PI/180); },
                              [] (float t) -> float { return cos(t*M_PI/180); });
  std::cout<<curve.position(0).x<<" "<<curve.position(0).y << std::endl;
}
