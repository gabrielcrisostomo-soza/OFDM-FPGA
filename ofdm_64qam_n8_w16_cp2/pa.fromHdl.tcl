
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name ofdm_64qam_n8_w16_cp2 -dir "D:/Desktop/tcc/ofdm_64qam_n8_w16_cp2/planAhead_run_1" -part xc6slx16csg324-3
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "ofdm_top_module.ucf" [current_fileset -constrset]
add_files [list {ipcore_dir/xfft_v8_0.ngc}]
set hdlfile [add_files [list {ipcore_dir/xfft_v8_0.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {spi_16.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {source_gen1.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {qam_mapper.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {master_clk_divisor.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ifft_manager.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ofdm_top_module.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top ofdm_top_module $srcset
add_files [list {ofdm_top_module.ucf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/xfft_v8_0.ncf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc6slx16csg324-3
