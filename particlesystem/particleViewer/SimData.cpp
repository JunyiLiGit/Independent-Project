#include "SimData.h"
SimData* SimData::instance = NULL;
SimData* SimData::Instance() {
    if (!instance)
      instance = new SimData;
      return instance;
  }
  SimData::~SimData() {
    delete instance;
  }
  SimData::SimData() {}
