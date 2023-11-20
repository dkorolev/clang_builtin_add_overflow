#include <iostream>

int main() {
  uint64_t value = uint64_t(1e9);
  uint64_t step = uint64_t(1e6);
  int iteration = 0;
  while (true) {
    ++iteration;
    step = (step / 8) + step;
    value += step;
    if (value < step) {
      break;
    }
  }
  std::cout << "Overflow reached after " << iteration << " iterations." << std::endl;
}
