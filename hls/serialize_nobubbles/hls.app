<AutoPilot:project xmlns:AutoPilot="com.autoesl.autopilot.project" projectType="C/C++" name="serialize_nobubbles" top="MultipleToSerial">
    <Simulation argv="">
        <SimFlow name="csim" setup="false" optimizeCompile="false" clean="true" ldflags="" mflags=""/>
    </Simulation>
    <files>
        <file name="../tb_questionare.cpp" sc="0" tb="1" cflags=" -I../../../libs/Vitis_Libraries/vision/L1/include  -std=c++0x -Wno-unknown-pragmas" csimflags=" -I../../../libs/Vitis_Libraries/vision/L1/include  -std=c++0x -Wno-unknown-pragmas" blackbox="false"/>
        <file name="serialize_nobubbles/questionare.cpp" sc="0" tb="false" cflags="-I../libs/Vitis_Libraries/vision/L1/include" csimflags="-I../libs/Vitis_Libraries/vision/L1/include -std=c++0x" blackbox="false"/>
    </files>
    <solutions>
        <solution name="solution1" status=""/>
    </solutions>
</AutoPilot:project>

