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
    
use work.PulseGeneratorPlainIfcAvalonPackage.all;
use work.tb_bus_pkg.all;

entity tbDutAvalon is
    generic (
        CLOCKS_UNTIL_CYCLE_TIMEOUT : integer := 1023
    );
    port (
        Clk : in std_logic;
        Rst : in std_logic;
        bus_down : in t_bus_down;
        bus_up : out t_bus_up;
        bus_trace : out t_bus_trace;
        Pulse : out std_logic;
        Failure : out std_logic
    );
end;

architecture behavioural of tbDutAvalon is

    signal PulseGeneratorPlainAvalonDown : T_PulseGeneratorPlainIfcAvalonDown;
    signal PulseGeneratorPlainAvalonUp : T_PulseGeneratorPlainIfcAvalonUp;
    signal PulseGeneratorPlainAvalonTrace : T_PulseGeneratorPlainIfcAvalonTrace;
           
begin

    i_PulseGeneratorPlainAvalonHxs : entity work.PulseGeneratorPlainAvalonHxs
        port map(
            Clk => Clk,
            Rst => Rst,
            PulseGeneratorPlainAvalonDown => PulseGeneratorPlainAvalonDown,
            PulseGeneratorPlainAvalonUp => PulseGeneratorPlainAvalonUp,
            PulseGeneratorPlainAvalonTrace => PulseGeneratorPlainAvalonTrace,
            Pulse => Pulse,
            Failure => Failure
        );
          
        -- wishbone unused     
        bus_up.wishbone.data <= (others => '0');
        bus_up.wishbone.ack <= '0';
        
        bus_trace.wishbone_trace.wishbone_down.adr <= (others => '0');
        bus_trace.wishbone_trace.wishbone_down.sel <= (others => '0');
        bus_trace.wishbone_trace.wishbone_down.data <= (others => '0');
        bus_trace.wishbone_trace.wishbone_down.we <= '0';
        bus_trace.wishbone_trace.wishbone_down.stb <= '0';
        bus_trace.wishbone_trace.wishbone_down.cyc <= '0';          
        bus_trace.wishbone_trace.wishbone_up.data <= (others => '0');
        bus_trace.wishbone_trace.wishbone_up.ack <= '0';

        -- avalon connected to dut
        PulseGeneratorPlainAvalonDown.Address <= bus_down.avalonmm.address(15 downto 0);
        PulseGeneratorPlainAvalonDown.ByteEnable <= bus_down.avalonmm.byteenable;
        PulseGeneratorPlainAvalonDown.WriteData <= bus_down.avalonmm.writedata;
        PulseGeneratorPlainAvalonDown.Read <= bus_down.avalonmm.read;
        PulseGeneratorPlainAvalonDown.Write <= bus_down.avalonmm.write;
        bus_up.avalonmm.readdata <= PulseGeneratorPlainAvalonUp.ReadData;
        bus_up.avalonmm.waitrequest <= PulseGeneratorPlainAvalonUp.WaitRequest;
        
        bus_trace.avalonmm_trace.avalonmm_down.address(15 downto 0) <= PulseGeneratorPlainAvalonTrace.AvalonDown.Address;
        bus_trace.avalonmm_trace.avalonmm_down.address(31 downto 16) <= (others => '0');
        bus_trace.avalonmm_trace.avalonmm_down.byteenable <= PulseGeneratorPlainAvalonTrace.AvalonDown.ByteEnable;
        bus_trace.avalonmm_trace.avalonmm_down.writedata <= PulseGeneratorPlainAvalonTrace.AvalonDown.WriteData;
        bus_trace.avalonmm_trace.avalonmm_down.read <= PulseGeneratorPlainAvalonTrace.AvalonDown.Read;
        bus_trace.avalonmm_trace.avalonmm_down.write <= PulseGeneratorPlainAvalonTrace.AvalonDown.Write;
        bus_trace.avalonmm_trace.avalonmm_up.readdata <= PulseGeneratorPlainAvalonTrace.AvalonUp.ReadData;
        bus_trace.avalonmm_trace.avalonmm_up.waitrequest <= PulseGeneratorPlainAvalonTrace.AvalonUp.WaitRequest;        
        bus_trace.avalonmm_trace.hxs_unoccupied_access <= PulseGeneratorPlainAvalonTrace.UnoccupiedAck;
        bus_trace.avalonmm_trace.hxs_timeout_access <= PulseGeneratorPlainAvalonTrace.TimeoutAck;
       
        -- axi4lite unused 
        bus_up.axi4lite.awready <= '0';
        bus_up.axi4lite.wready <= '0';
        bus_up.axi4lite.bvalid <= '0';
        bus_up.axi4lite.bresp <= (others => '0');
        bus_up.axi4lite.arready <= '0';
        bus_up.axi4lite.rvalid <= '0';
        bus_up.axi4lite.rdata <= (others => '0');
        bus_up.axi4lite.rresp <= (others => '0');
        
        bus_trace.axi4lite_trace.axi4lite_down.awvalid <= '0';
        bus_trace.axi4lite_trace.axi4lite_down.awaddr <= (others => '0');
        bus_trace.axi4lite_trace.axi4lite_down.awprot <= (others => '0');
        bus_trace.axi4lite_trace.axi4lite_down.wvalid <= '0';
        bus_trace.axi4lite_trace.axi4lite_down.wdata <= (others => '0');
        bus_trace.axi4lite_trace.axi4lite_down.wstrb <= (others => '0');
        bus_trace.axi4lite_trace.axi4lite_down.bready <= '0';
        bus_trace.axi4lite_trace.axi4lite_down.arvalid <= '0';
        bus_trace.axi4lite_trace.axi4lite_down.araddr <= (others => '0');
        bus_trace.axi4lite_trace.axi4lite_down.arprot <= (others => '0');
        bus_trace.axi4lite_trace.axi4lite_down.rready <= '0';
        bus_trace.axi4lite_trace.axi4lite_up.awready <= '0';
        bus_trace.axi4lite_trace.axi4lite_up.wready <= '0';       
        bus_trace.axi4lite_trace.axi4lite_up.bvalid <= '0';
        bus_trace.axi4lite_trace.axi4lite_up.bresp <= (others => '0'); 
        bus_trace.axi4lite_trace.axi4lite_up.arready <= '0';
        bus_trace.axi4lite_trace.axi4lite_up.rvalid <= '0';
        bus_trace.axi4lite_trace.axi4lite_up.rdata <= (others => '0');
        bus_trace.axi4lite_trace.axi4lite_up.rresp <= (others => '0');
        bus_trace.axi4lite_trace.hxs_unoccupied_access <= '0';
        bus_trace.axi4lite_trace.hxs_timeout_access <= '0';
                
end architecture;