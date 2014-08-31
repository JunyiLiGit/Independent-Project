#include "curve.h"
#include "point.h"
#include <math.h>


namespace ParticleSystem{
Curve::Curve(
  std::function<float ( const float t)> funcx,
  std::function<float ( const float t)> funcy
  ) :
    x(funcx),
    y(funcy)
    {}

const Point Curve::position( const float t) {
  Point point;
  point.x = x(t);
  point.y = y(t);
  return point;
}

}
