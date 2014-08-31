#include <functional>

namespace ParticleSystem {

struct Point;
class Curve{
public:
  std::function<float (const float)> x;
  std::function<float (const float)> y;

  Curve(
        std::function<float (const float)> funcx,
        std::function<float (const float)> funcy
        );

const Point position(const float t);

};
}
