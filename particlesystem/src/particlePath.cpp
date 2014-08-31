#include "particlePath.h"
#include <iostream>
#include <stdlib.h>



namespace ParticleSystem{
ParticlePath::ParticlePath(const Curve &particleCurve, unsigned int particleNumber):
                           curve(particleCurve), number(particleNumber)
                           {
                             particles.reserve(number);
                             srand (1);
                             for(int i=0; i<number; ++i){
                                  Particle particle((rand()%100+i*0.05));
                                  particles.push_back(particle);

                              }
                           }

std::vector<Particle> ParticlePath::getParticles(){
  return particles;
}

void ParticlePath::moveParticles(float time)
{
  for(auto iter=particles.begin(); iter != particles.end(); ++iter){

      (*iter).time = (*iter).time + time;
      (*iter).position = curve.position((*iter).time);
  }
}

void ParticlePath::printParticles()
{
  for(auto iter=particles.begin(); iter != particles.end(); ++iter){

    std::cout<< (*iter).position <<std::endl;

  }

}



}
