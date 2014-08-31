#include "Vector.h"
struct SimData {
  static SimData* Instance();
  ~SimData();
  double t;
  double m;
  double deltaT;
  double fps;
  Vector3d X0;
  Vector3d V0;
  Vector3d G;
  bool collision_flag;
  char *paramFile;
  double cof;
  double cor;

private:
  SimData();
  SimData(SimData const&);
  SimData& operator=(SimData const&);
  static SimData* instance;

};
