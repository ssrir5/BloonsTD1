transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlib bloonstd1_soc
vmap bloonstd1_soc bloonstd1_soc
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/bloonstd1_soc.v}
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/altera_reset_controller.v}
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/altera_reset_synchronizer.v}
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_mm_interconnect_0.v}
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_mm_interconnect_0_avalon_st_adapter_005.v}
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_mm_interconnect_0_avalon_st_adapter.v}
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/altera_avalon_sc_fifo.v}
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_x_disp.v}
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_usb_rst.v}
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_timer_0.v}
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_sysid_qsys_0.v}
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_spi_0.v}
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_sdram_pll.v}
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_sdram.v}
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_onchip_memory2_0.v}
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_nios2_gen2_0.v}
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_nios2_gen2_0_cpu.v}
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_nios2_gen2_0_cpu_debug_slave_sysclk.v}
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_nios2_gen2_0_cpu_debug_slave_tck.v}
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_nios2_gen2_0_cpu_debug_slave_wrapper.v}
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_nios2_gen2_0_cpu_test_bench.v}
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_leds_pio.v}
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_keycode.v}
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_key.v}
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_jtag_uart_0.v}
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_hex_digits_pio.v}
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_accumulator.v}
vlog -sv -work work +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/monkey {C:/Users/shrey/Documents/GitHub/BloonsTD1/monkey/monkey_rom.sv}
vlog -sv -work work +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/monkey {C:/Users/shrey/Documents/GitHub/BloonsTD1/monkey/monkey_palette.sv}
vlog -sv -work work +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/monkey {C:/Users/shrey/Documents/GitHub/BloonsTD1/monkey/monkey_example.sv}
vlog -sv -work work +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1 {C:/Users/shrey/Documents/GitHub/BloonsTD1/Color_Mapper.sv}
vlog -sv -work work +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1 {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1.sv}
vlog -sv -work work +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1 {C:/Users/shrey/Documents/GitHub/BloonsTD1/background_rom.sv}
vlog -sv -work work +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1 {C:/Users/shrey/Documents/GitHub/BloonsTD1/VGA_controller.sv}
vlog -sv -work work +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1 {C:/Users/shrey/Documents/GitHub/BloonsTD1/HexDriver.sv}
vlog -sv -work work +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1 {C:/Users/shrey/Documents/GitHub/BloonsTD1/mouse.sv}
vlog -sv -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_irq_mapper.sv}
vlog -sv -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_mm_interconnect_0_avalon_st_adapter_005_error_adapter_0.sv}
vlog -sv -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv}
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/altera_avalon_st_handshake_clock_crosser.v}
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/altera_avalon_st_clock_crosser.v}
vlog -vlog01compat -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/altera_std_synchronizer_nocut.v}
vlog -sv -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/altera_merlin_width_adapter.sv}
vlog -sv -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/altera_merlin_burst_uncompressor.sv}
vlog -sv -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_mm_interconnect_0_rsp_mux.sv}
vlog -sv -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/altera_merlin_arbitrator.sv}
vlog -sv -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_mm_interconnect_0_rsp_demux.sv}
vlog -sv -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_mm_interconnect_0_cmd_mux.sv}
vlog -sv -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_mm_interconnect_0_cmd_demux.sv}
vlog -sv -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/altera_merlin_burst_adapter.sv}
vlog -sv -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/altera_merlin_burst_adapter_uncmpr.sv}
vlog -sv -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_mm_interconnect_0_router_007.sv}
vlog -sv -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_mm_interconnect_0_router_002.sv}
vlog -sv -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/bloonstd1_soc_mm_interconnect_0_router.sv}
vlog -sv -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/altera_merlin_slave_agent.sv}
vlog -sv -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/altera_merlin_master_agent.sv}
vlog -sv -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/altera_merlin_slave_translator.sv}
vlog -sv -work bloonstd1_soc +incdir+C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules {C:/Users/shrey/Documents/GitHub/BloonsTD1/bloonstd1_soc/synthesis/submodules/altera_merlin_master_translator.sv}

