    // tb_questionare.cpp
     
    #include "questionare.h"
     
    int main(){
        hls::stream<MultipleElements> input_stream;
        hls::stream<int> output_stream;
        MultipleElements tmp;
     
        // Test pattern 1
        tmp.elements_num = 4;
        int pattern_1[8] = {0,2,4,6,8,10,12,14};
        memcpy(tmp.elements, pattern_1, sizeof(int)*8);
        input_stream.write(tmp);
     
        // Test pattern 2
        tmp.elements_num = 5;
        int pattern_2[8] = {1,3,5,7,9,11,13,15};
        memcpy(tmp.elements, pattern_2, sizeof(int)*8);
        input_stream.write(tmp);
     
        // Execute function
        MultipleToSerial(input_stream, output_stream);
        MultipleToSerial(input_stream, output_stream);
     
        // Print result
        while(!output_stream.empty()){
            int out;
            output_stream.read(out);
            cout <<"out: " << out << endl;
        }
     
        return 0;
    }