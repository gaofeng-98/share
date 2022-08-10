#include <iostream>
#include "hls_stream.h"

using namespace std;

struct __cosim_T_4__ {char data[4];};
extern "C" void fpga_fifo_push_4(__cosim_T_4__* val, hls::stream<__cosim_T_4__>* fifo) {
  fifo->write(*val);
}
extern "C" void fpga_fifo_pop_4(__cosim_T_4__* val, hls::stream<__cosim_T_4__>* fifo) {
  *val = fifo->read();
}
extern "C" bool fpga_fifo_not_empty_4(hls::stream<__cosim_T_4__>* fifo) {
  return !fifo->empty();
}
extern "C" bool fpga_fifo_exist_4(hls::stream<__cosim_T_4__>* fifo) {
  return fifo->exist();
}
struct __cosim_T_36__ {char data[36];};
extern "C" void fpga_fifo_push_36(__cosim_T_36__* val, hls::stream<__cosim_T_36__>* fifo) {
  fifo->write(*val);
}
extern "C" void fpga_fifo_pop_36(__cosim_T_36__* val, hls::stream<__cosim_T_36__>* fifo) {
  *val = fifo->read();
}
extern "C" bool fpga_fifo_not_empty_36(hls::stream<__cosim_T_36__>* fifo) {
  return !fifo->empty();
}
extern "C" bool fpga_fifo_exist_36(hls::stream<__cosim_T_36__>* fifo) {
  return fifo->exist();
}
