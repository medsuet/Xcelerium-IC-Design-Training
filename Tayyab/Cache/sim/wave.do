onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /cache_tb/clk
add wave -noupdate -radix hexadecimal /cache_tb/reset
add wave -noupdate -radix hexadecimal -childformat {{/cache_tb/processor2cache.operation -radix hexadecimal} {/cache_tb/processor2cache.address -radix hexadecimal} {/cache_tb/processor2cache.w_data -radix hexadecimal} {/cache_tb/processor2cache.valid -radix hexadecimal} {/cache_tb/processor2cache.ready -radix hexadecimal}} -subitemconfig {/cache_tb/processor2cache.operation {-height 21 -radix hexadecimal} /cache_tb/processor2cache.address {-height 21 -radix hexadecimal} /cache_tb/processor2cache.w_data {-height 21 -radix hexadecimal} /cache_tb/processor2cache.valid {-height 21 -radix hexadecimal} /cache_tb/processor2cache.ready {-height 21 -radix hexadecimal}} /cache_tb/processor2cache
add wave -noupdate -radix hexadecimal -childformat {{/cache_tb/cache2processor.valid -radix hexadecimal} {/cache_tb/cache2processor.ready -radix hexadecimal} {/cache_tb/cache2processor.r_data -radix hexadecimal}} -subitemconfig {/cache_tb/cache2processor.valid {-height 21 -radix hexadecimal} /cache_tb/cache2processor.ready {-height 21 -radix hexadecimal} /cache_tb/cache2processor.r_data {-height 21 -radix hexadecimal}} /cache_tb/cache2processor
add wave -noupdate -divider {Cache controller}
add wave -noupdate -radix hexadecimal /cache_tb/DUT/ctrl/current_state
add wave -noupdate -group {Local checks} -radix hexadecimal /cache_tb/DUT/ctrl/wr_req
add wave -noupdate -group {Local checks} -radix hexadecimal /cache_tb/DUT/ctrl/cache_hit
add wave -noupdate -group {Local checks} -radix hexadecimal /cache_tb/DUT/ctrl/is_valid
add wave -noupdate -group {Local checks} -radix hexadecimal /cache_tb/DUT/ctrl/is_dirty
add wave -noupdate -group {Local checks} -radix hexadecimal /cache_tb/DUT/ctrl/wr_en
add wave -noupdate -radix hexadecimal /cache_tb/DUT/ctrl/memory2cache
add wave -noupdate -radix hexadecimal -childformat {{/cache_tb/DUT/ctrl/cache2memory.aclk -radix hexadecimal} {/cache_tb/DUT/ctrl/cache2memory.aresetn -radix hexadecimal} {/cache_tb/DUT/ctrl/cache2memory.rac -radix hexadecimal} {/cache_tb/DUT/ctrl/cache2memory.rdc -radix hexadecimal} {/cache_tb/DUT/ctrl/cache2memory.wac -radix hexadecimal} {/cache_tb/DUT/ctrl/cache2memory.wdc -radix hexadecimal} {/cache_tb/DUT/ctrl/cache2memory.wrc -radix hexadecimal}} -expand -subitemconfig {/cache_tb/DUT/ctrl/cache2memory.aclk {-radix hexadecimal} /cache_tb/DUT/ctrl/cache2memory.aresetn {-radix hexadecimal} /cache_tb/DUT/ctrl/cache2memory.rac {-radix hexadecimal} /cache_tb/DUT/ctrl/cache2memory.rdc {-radix hexadecimal} /cache_tb/DUT/ctrl/cache2memory.wac {-radix hexadecimal} /cache_tb/DUT/ctrl/cache2memory.wdc {-radix hexadecimal} /cache_tb/DUT/ctrl/cache2memory.wrc {-radix hexadecimal}} /cache_tb/DUT/ctrl/cache2memory
add wave -noupdate -divider {Memory controller}
add wave -noupdate -radix hexadecimal /cache_tb/DUT/mem/mem_ctrl/current_state
add wave -noupdate -radix hexadecimal -childformat {{/cache_tb/DUT/mem/mem_ctrl/cache2memory.aclk -radix hexadecimal} {/cache_tb/DUT/mem/mem_ctrl/cache2memory.aresetn -radix hexadecimal} {/cache_tb/DUT/mem/mem_ctrl/cache2memory.rac -radix hexadecimal -childformat {{/cache_tb/DUT/mem/mem_ctrl/cache2memory.rac.araddr -radix hexadecimal} {/cache_tb/DUT/mem/mem_ctrl/cache2memory.rac.arcache -radix hexadecimal} {/cache_tb/DUT/mem/mem_ctrl/cache2memory.rac.arprot -radix hexadecimal} {/cache_tb/DUT/mem/mem_ctrl/cache2memory.rac.arvalid -radix hexadecimal}}} {/cache_tb/DUT/mem/mem_ctrl/cache2memory.rdc -radix hexadecimal} {/cache_tb/DUT/mem/mem_ctrl/cache2memory.wac -radix hexadecimal} {/cache_tb/DUT/mem/mem_ctrl/cache2memory.wdc -radix hexadecimal} {/cache_tb/DUT/mem/mem_ctrl/cache2memory.wrc -radix hexadecimal}} -expand -subitemconfig {/cache_tb/DUT/mem/mem_ctrl/cache2memory.aclk {-radix hexadecimal} /cache_tb/DUT/mem/mem_ctrl/cache2memory.aresetn {-radix hexadecimal} /cache_tb/DUT/mem/mem_ctrl/cache2memory.rac {-radix hexadecimal -childformat {{/cache_tb/DUT/mem/mem_ctrl/cache2memory.rac.araddr -radix hexadecimal} {/cache_tb/DUT/mem/mem_ctrl/cache2memory.rac.arcache -radix hexadecimal} {/cache_tb/DUT/mem/mem_ctrl/cache2memory.rac.arprot -radix hexadecimal} {/cache_tb/DUT/mem/mem_ctrl/cache2memory.rac.arvalid -radix hexadecimal}} -expand} /cache_tb/DUT/mem/mem_ctrl/cache2memory.rac.araddr {-radix hexadecimal} /cache_tb/DUT/mem/mem_ctrl/cache2memory.rac.arcache {-radix hexadecimal} /cache_tb/DUT/mem/mem_ctrl/cache2memory.rac.arprot {-radix hexadecimal} /cache_tb/DUT/mem/mem_ctrl/cache2memory.rac.arvalid {-radix hexadecimal} /cache_tb/DUT/mem/mem_ctrl/cache2memory.rdc {-radix hexadecimal} /cache_tb/DUT/mem/mem_ctrl/cache2memory.wac {-radix hexadecimal} /cache_tb/DUT/mem/mem_ctrl/cache2memory.wdc {-radix hexadecimal} /cache_tb/DUT/mem/mem_ctrl/cache2memory.wrc {-radix hexadecimal}} /cache_tb/DUT/mem/mem_ctrl/cache2memory
add wave -noupdate -radix hexadecimal /cache_tb/DUT/mem/mem_ctrl/memory2cache
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {54 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 266
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {227 ps}
