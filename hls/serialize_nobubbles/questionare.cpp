    // questionare.cpp
     
    #include "questionare.h"

    
     
    void MultipleToSerial(
        hls::stream<MultipleElements> &input,
        hls::stream<int> &output
    ){
    #pragma HLS DATAFLOW
    #pragma HLS INTERFACE mode=axis register_mode=both port=input register
    #pragma HLS INTERFACE mode=axis register_mode=both port=output register
        MultipleElements tmp;
     
        tmp = input.read();
        assert(tmp.elements_num < MAX_ELEMENTS_NUM);
        for(int i=0; i<tmp.elements_num; i++){
            #pragma HLS pipeline rewind
            output.write(tmp.elements[i]);
        }
    }