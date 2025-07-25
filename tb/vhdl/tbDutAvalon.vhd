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
        NsPerClk : natural := 1
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
        generic map (
            NsPerClk => NsPerClk
        )
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
        bus_up.wishbone32.clk <= '0';     
        bus_up.wishbone32.data <= (others => '0');
        bus_up.wishbone32.ack <= '0';
        
        bus_trace.wishbone32_trace.wishbone_down.adr <= (others => '0');
        bus_trace.wishbone32_trace.wishbone_down.sel <= (others => '0');
        bus_trace.wishbone32_trace.wishbone_down.data <= (others => '0');
        bus_trace.wishbone32_trace.wishbone_down.we <= '0';
        bus_trace.wishbone32_trace.wishbone_down.stb <= '0';
        bus_trace.wishbone32_trace.wishbone_down.cyc <= '0';
        bus_trace.wishbone32_trace.wishbone_up.clk <= '0';           
        bus_trace.wishbone32_trace.wishbone_up.data <= (others => '0');
        bus_trace.wishbone32_trace.wishbone_up.ack <= '0';

        -- avalon connected to dut
        PulseGeneratorPlainAvalonDown.Address <= bus_down.avalonmm32.address(15 downto 0);
        PulseGeneratorPlainAvalonDown.ByteEnable <= bus_down.avalonmm32.byteenable;
        PulseGeneratorPlainAvalonDown.WriteData <= bus_down.avalonmm32.writedata;
        PulseGeneratorPlainAvalonDown.Read <= bus_down.avalonmm32.read;
        PulseGeneratorPlainAvalonDown.Write <= bus_down.avalonmm32.write;
        bus_up.avalonmm32.clk <= Clk;
        bus_up.avalonmm32.readdata <= PulseGeneratorPlainAvalonUp.ReadData;
        bus_up.avalonmm32.waitrequest <= PulseGeneratorPlainAvalonUp.WaitRequest;
        
        bus_trace.avalonmm32_trace.avalonmm_down.address(15 downto 0) <= PulseGeneratorPlainAvalonTrace.AvalonDown.Address;
        bus_trace.avalonmm32_trace.avalonmm_down.address(31 downto 16) <= (others => '0');
        bus_trace.avalonmm32_trace.avalonmm_down.byteenable <= PulseGeneratorPlainAvalonTrace.AvalonDown.ByteEnable;
        bus_trace.avalonmm32_trace.avalonmm_down.writedata <= PulseGeneratorPlainAvalonTrace.AvalonDown.WriteData;
        bus_trace.avalonmm32_trace.avalonmm_down.read <= PulseGeneratorPlainAvalonTrace.AvalonDown.Read;
        bus_trace.avalonmm32_trace.avalonmm_down.write <= PulseGeneratorPlainAvalonTrace.AvalonDown.Write;
        bus_trace.avalonmm32_trace.avalonmm_up.clk <= Clk;
        bus_trace.avalonmm32_trace.avalonmm_up.readdata <= PulseGeneratorPlainAvalonTrace.AvalonUp.ReadData;
        bus_trace.avalonmm32_trace.avalonmm_up.waitrequest <= PulseGeneratorPlainAvalonTrace.AvalonUp.WaitRequest;        
        bus_trace.avalonmm32_trace.hxs_unoccupied_access <= PulseGeneratorPlainAvalonTrace.UnoccupiedAck;
        bus_trace.avalonmm32_trace.hxs_timeout_access <= PulseGeneratorPlainAvalonTrace.TimeoutAck;
       
        -- axi4lite unused 
        bus_up.axi4lite32.clk <= '0';
        bus_up.axi4lite32.awready <= '0';
        bus_up.axi4lite32.wready <= '0';
        bus_up.axi4lite32.bvalid <= '0';
        bus_up.axi4lite32.bresp <= (others => '0');
        bus_up.axi4lite32.arready <= '0';
        bus_up.axi4lite32.rvalid <= '0';
        bus_up.axi4lite32.rdata <= (others => '0');
        bus_up.axi4lite32.rresp <= (others => '0');
        
        bus_trace.axi4lite32_trace.axi4lite_down_32.awvalid <= '0';
        bus_trace.axi4lite32_trace.axi4lite_down_32.awaddr <= (others => '0');
        bus_trace.axi4lite32_trace.axi4lite_down_32.awprot <= (others => '0');
        bus_trace.axi4lite32_trace.axi4lite_down_32.wvalid <= '0';
        bus_trace.axi4lite32_trace.axi4lite_down_32.wdata <= (others => '0');
        bus_trace.axi4lite32_trace.axi4lite_down_32.wstrb <= (others => '0');
        bus_trace.axi4lite32_trace.axi4lite_down_32.bready <= '0';
        bus_trace.axi4lite32_trace.axi4lite_down_32.arvalid <= '0';
        bus_trace.axi4lite32_trace.axi4lite_down_32.araddr <= (others => '0');
        bus_trace.axi4lite32_trace.axi4lite_down_32.arprot <= (others => '0');
        bus_trace.axi4lite32_trace.axi4lite_down_32.rready <= '0';
        bus_trace.axi4lite32_trace.axi4lite_up_32.clk <= '0';
        bus_trace.axi4lite32_trace.axi4lite_up_32.awready <= '0';
        bus_trace.axi4lite32_trace.axi4lite_up_32.wready <= '0';       
        bus_trace.axi4lite32_trace.axi4lite_up_32.bvalid <= '0';
        bus_trace.axi4lite32_trace.axi4lite_up_32.bresp <= (others => '0'); 
        bus_trace.axi4lite32_trace.axi4lite_up_32.arready <= '0';
        bus_trace.axi4lite32_trace.axi4lite_up_32.rvalid <= '0';
        bus_trace.axi4lite32_trace.axi4lite_up_32.rdata <= (others => '0');
        bus_trace.axi4lite32_trace.axi4lite_up_32.rresp <= (others => '0');
        bus_trace.axi4lite32_trace.hxs_unoccupied_access <= '0';
        bus_trace.axi4lite32_trace.hxs_timeout_access <= '0';
                
end architecture;