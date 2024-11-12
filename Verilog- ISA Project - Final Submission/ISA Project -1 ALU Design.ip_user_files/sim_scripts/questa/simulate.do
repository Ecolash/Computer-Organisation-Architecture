onbreak {quit -f}
onerror {quit -f}

vsim  -lib xil_defaultlib test_processor_tb_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {test_processor_tb.udo}

run 1000ns

quit -force
