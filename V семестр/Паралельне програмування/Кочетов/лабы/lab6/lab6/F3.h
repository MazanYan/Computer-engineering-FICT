#pragma once
#include <iostream>
#include "Matrix.h"
using namespace std;

class F3 {
private:
	Vector* result;
	int N;
public:
	F3(int N);
	Vector* getResult();
	void run();
};
