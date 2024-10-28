-- ******************************************************************************
-- 
--                   /------o
--             eccelerators
--          o------/
-- 
--  This file is an Eccelerators GmbH sample project.
-- 
--  MIT License:
--  Copyright (c) 2023 Eccelerators GmbH
-- 
--  Permission is hereby granted, free of charge, to any person obtaining a copy
--  of this software and associated documentation files (the "Software"), to deal
--  in the Software without restriction, including without limitation the rights
--  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
--  copies of the Software, and to permit persons to whom the Software is
--  furnished to do so, subject to the following conditions:
-- 
--  The above copyright notice and this permission notice shall be included in all
--  copies or substantial portions of the Software.
-- 
--  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
--  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
--  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
--  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
--  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
--  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
--  SOFTWARE.
-- ******************************************************************************
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    
use work.PulseGeneratorPlainIfcPackage.all;
use work.tb_bus_pkg.all;

entity PulseGeneratorPlainIfc is
    generic (
        CLOCKS_UNTIL_CYCLE_TIMEOUT : integer := 1023
    );
    port (
        Clk : in std_logic;
        Rst : in std_logic;
        bus_down : in t_bus_down;
        bus_up : out t_bus_up;
        bus_trace : out t_avalon_trace;
        PulseGeneratorPlainBlkDown : out T_PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown
    );
end;

architecture behavioural of tb_top is

    signal PulseGeneratorPlainIfcAvalonDown : T_PulseGeneratorPlainIfcAvalonDown;
    signal PulseGeneratorPlainIfcAvalonUp : T_PulseGeneratorPlainIfcAvalonUp;
    signal PulseGeneratorPlainIfcTrace : T_PulseGeneratorPlainIfcTrace;
    
    signal PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown : T_PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown;
       
begin

    i_PulseGeneratorPlainIfcIfcAvalon : entity work.PulseGeneratorPlainIfcIfcAvalon
        port map(
            Clk => Clk,
            Rst => Rst,
            AvalonDown => PulseGeneratorPlainIfcAvalonDown,
            AvalonUp => PulseGeneratorPlainIfcAvalonUp,
            Trace => PulseGeneratorPlainIfcAvalonTrace,
            PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown => PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown
        );
               
        bus_up.wishbone.data <= (others => '0');
        bus_up.wishbone.ack <= '0';
        
        bus_trace.wishbone_down.adr <= (others => '0');
        bus_trace.wishbone_down.sel <= (others => '0');
        bus_trace.wishbone_down.data <= (others => '0');
        bus_trace.wishbone_down.we <= '0';
        bus_trace.wishbone_down.stb <= '0';
        bus_trace.wishbone_down.cyc <= '0';          
        bus_trace.wishbone_up.data <= (others => '0');
        bus_trace.wishbone_up.ack <= '0';
        
        bus_up.avalonmm.readdata <= PulseGeneratorPlainIfcAvalonUp.ReadData;
        bus_up.avalonmm.waitrequest <= PulseGeneratorPlainIfcAvalonUp.WaitRequest;
        
        PulseGeneratorPlainIfcAvalonDown.Address <= bus_down.avalonmm_down.address;
        PulseGeneratorPlainIfcAvalonDown.ByteEnable <= bus_down.avalonmm_down.byteenable;
        PulseGeneratorPlainIfcAvalonDown.WriteData <= bus_down.avalonmm_down.writedata;
        PulseGeneratorPlainIfcAvalonDown.Read <= bus_down.avalonmm_down.read;
        PulseGeneratorPlainIfcAvalonDown.Write <= bus_down.avalonmm_down.write;
        
               
                  
end architecture;