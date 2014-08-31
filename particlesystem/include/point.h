#include <iostream>
namespace ParticleSystem {
struct Point {
  float x;
  float y;
};

std::ostream& operator<<(std::ostream& out, const Point& p);
}
