#include <iostream>

int resets(int days) {
  if (days == 6) {
    return 1;
  }
  else {
    return resets(days - 6) + resets(days - 8);
  }
}

int main() {
  std::cout << std::pow(2, 256) << std::endl;
  return 0;
}