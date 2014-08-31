#include "curve.h"
#include "particle.h"
#include <vector>

namespace ParticleSystem{


class ParticlePath{
public:
  ParticlePath(const Curve &particleCurve, unsigned int particleNumber);
  void moveParticles(float time);
  void printParticles();
  std::vector<Particle> getParticles();


private:
  Curve curve;
  std::vector<Particle> particles;
  unsigned int number;

};

}
