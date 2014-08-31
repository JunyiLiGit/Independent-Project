#include "point.h"

namespace ParticleSystem{

  std::ostream& operator<<(std::ostream& out, const Point& p)
  {
      return out <<"x: "<< p.x <<"  y: "<< p.y<<std::endl;
  }

}
