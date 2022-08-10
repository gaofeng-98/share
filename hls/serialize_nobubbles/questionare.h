    // questionare.h
     
    #include <hls_stream.h>
    #include <common/xf_common.hpp>
    #include <common/xf_utility.hpp>
    #include <common/xf_infra.hpp>
    #include <stdio.h>
    using namespace std;
    #define MAX_ELEMENTS_NUM 8
     
    struct MultipleElements{
    	int elements[MAX_ELEMENTS_NUM];
    	int elements_num;
    };
     
    void MultipleToSerial(
        hls::stream<MultipleElements> &input,
        hls::stream<int> &output
    );