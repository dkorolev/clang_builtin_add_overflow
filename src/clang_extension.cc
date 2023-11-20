#include <iostream>

int main() {
  uint64_t value;
  std::cin >> value;
  uint64_t step = uint64_t(1e6);
  int iteration = 0;
  while (true) {
    ++iteration;
    step = (step / 8) + step;
    if (__builtin_add_overflow(value, step, &value)) {
      break;
    }
  }
  std::cout << "Overflow reached after " << iteration << " iterations." << std::endl;
}
