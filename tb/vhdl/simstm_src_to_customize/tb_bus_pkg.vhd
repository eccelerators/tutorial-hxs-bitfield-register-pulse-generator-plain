library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.tb_bus_avalon_32_pkg.all;
use work.tb_bus_axi4lite_32_pkg.all;
use work.tb_bus_wishbone_32_pkg.all;

package tb_bus_pkg is

    type t_bus_down is record
        wishbone32 : t_wishbone_down_32;
        avalonmm32 : t_avalonmm_down_32;
        axi4lite32 : t_axi4lite_down_32;
    end record;

    type t_bus_up is record
        wishbone32 : t_wishbone_up_32;
        avalonmm32 : t_avalonmm_up_32;
        axi4lite32 : t_axi4lite_up_32;
    end record;
    
    type t_bus_trace is record
        wishbone32_trace : t_wishbone_trace_32;
        avalonmm32_trace : t_avalonmm_trace_32;
        axi4lite32_trace : t_axi4lite_trace_32;
    end record;

    function bus_down_init return t_bus_down;
    function bus_up_init return t_bus_up;

    procedure bus_write(signal bus_down : out t_bus_down;
                        signal bus_up : in t_bus_up;
                        variable address : in unsigned;
                        variable data : in unsigned;
                        variable access_width : in integer;
                        variable bus_number : in integer;
                        variable valid : out integer;
                        variable successfull : out boolean;
                        variable timeout : in time);

    procedure bus_read(
                       signal bus_down : out t_bus_down;
                       signal bus_up : in t_bus_up;
                       variable address : in unsigned;
                       variable data : out unsigned;
                       variable access_width : in integer;
                       variable bus_number : in integer;
                       variable valid : out integer;
                       variable successfull : out boolean;
                       variable timeout : in time);
end;

package body tb_bus_pkg is
    function bus_up_init return t_bus_up is
        variable init : t_bus_up;
    begin
        init.wishbone32 := wishbone_up_32_init;
        init.avalonmm32 := avalonmm_up_32_init;
        init.axi4lite32 := axi4lite_up_32_init;
        return init;
    end;

    function bus_down_init return t_bus_down is
        variable init : t_bus_down;
    begin
        init.wishbone32 := wishbone_down_32_init;
        init.avalonmm32 := avalonmm_down_32_init;
        init.axi4lite32 := axi4lite_down_32_init;
        return init;
    end;

    procedure bus_write(signal bus_down : out t_bus_down;
                        signal bus_up : in t_bus_up;
                        variable address : in unsigned;
                        variable data : in unsigned;
                        variable access_width : in integer;
                        variable bus_number : in integer;
                        variable valid : out integer;
                        variable successfull : out boolean;
                        variable timeout : in time) is
    begin
        valid := 1;
        case bus_number is
            when 0 =>
                write_wishbone_32(
                               bus_down.wishbone32,
                               bus_up.wishbone32,
                               address,
                               data,
                               access_width,
                               successfull,
                               timeout);

            when 1 =>
                write_avalonmm_32(
                               bus_down.avalonmm32,
                               bus_up.avalonmm32,
                               address,
                               data,
                               access_width,
                               successfull,
                               timeout);

            when 2 =>
                write_axi4lite_32(
                               bus_down.axi4lite32,
                               bus_up.axi4lite32,
                               address,
                               data,
                               access_width,
                               successfull,
                               timeout);
            when others =>
                valid := 0;
        end case;

    end procedure;

    procedure bus_read(
                       signal bus_down : out t_bus_down;
                       signal bus_up : in t_bus_up;
                       variable address : in unsigned;
                       variable data : out unsigned;
                       variable access_width : in integer;
                       variable bus_number : in integer;
                       variable valid : out integer;
                       variable successfull : out boolean;
                       variable timeout : in time) is
    begin
        valid := 1;
        case bus_number is
            when 0 =>
                read_wishbone_32(
                              bus_down.wishbone32,
                              bus_up.wishbone32,
                              address,
                              data,
                              access_width,
                              successfull,
                              timeout);

            when 1 =>
                read_avalonmm_32(
                              bus_down.avalonmm32,
                              bus_up.avalonmm32,
                              address,
                              data,
                              access_width,
                              successfull,
                              timeout);

            when 2 =>
                read_axi4lite_32(
                              bus_down.axi4lite32,
                              bus_up.axi4lite32,
                              address,
                              data,
                              access_width,
                              successfull,
                              timeout);
            when others =>
                valid := 0;
        end case;

    end procedure;
end package body;
