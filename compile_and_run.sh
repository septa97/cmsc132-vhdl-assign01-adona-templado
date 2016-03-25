#!/bin/bash

ghdl -a t5l-adona-templado.vhdl
ghdl -a t5l-adona-templado_tb.vhdl
ghdl -e buzzer_tb
ghdl -r buzzer_tb --vcd=buzzer.vcd
gtkwave buzzer.vcd