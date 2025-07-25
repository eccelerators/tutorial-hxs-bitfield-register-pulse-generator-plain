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
    
use work.PulseGeneratorPlainIfcAxi4LitePackage.all;
use work.tb_bus_pkg.all;

entity tbDutAxi4Lite is
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

architecture behavioural of tbDutAxi4Lite is

    signal PulseGeneratorPlainAxi4LiteDown : T_PulseGeneratorPlainIfcAxi4LiteDown;
    signal PulseGeneratorPlainAxi4LiteUp : T_PulseGeneratorPlainIfcAxi4LiteUp;
    signal PulseGeneratorPlainAxi4LiteTrace : T_PulseGeneratorPlainIfcAxi4LiteTrace;
           
begin

   i_PulseGeneratorPlainAxi4LiteHxs : entity work.PulseGeneratorPlainAxi4LiteHxs
        generic map (
            NsPerClk => NsPerClk
        )
        port map(
            Clk => Clk,
            Rst => Rst,
            PulseGeneratorPlainAxi4LiteDown => PulseGeneratorPlainAxi4LiteDown,  
            PulseGeneratorPlainAxi4LiteUp => PulseGeneratorPlainAxi4LiteUp,
            PulseGeneratorPlainAxi4LiteTrace => PulseGeneratorPlainAxi4LiteTrace,
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
        
        -- avalon unused
        bus_up.avalonmm32.clk <= '0';
        bus_up.avalonmm32.readdata <= (others => '0');
        bus_up.avalonmm32.waitrequest <= '1';
        
        bus_trace.avalonmm32_trace.avalonmm_down.address <= (others => '0');
        bus_trace.avalonmm32_trace.avalonmm_down.byteenable <= (others => '0');
        bus_trace.avalonmm32_trace.avalonmm_down.writedata <= (others => '0');
        bus_trace.avalonmm32_trace.avalonmm_down.read <= '0';
        bus_trace.avalonmm32_trace.avalonmm_down.write <= '0';
        bus_trace.avalonmm32_trace.avalonmm_up.clk <= '0';   
        bus_trace.avalonmm32_trace.avalonmm_up.readdata <= (others => '0');
        bus_trace.avalonmm32_trace.avalonmm_up.waitrequest <= '1';     
        bus_trace.avalonmm32_trace.hxs_unoccupied_access <= '0';
        bus_trace.avalonmm32_trace.hxs_timeout_access <= '0';

        -- axi4lite connected to dut            
        PulseGeneratorPlainAxi4LiteDown.AWVALID <= bus_down.axi4lite32.awvalid;
        PulseGeneratorPlainAxi4LiteDown.AWADDR <= bus_down.axi4lite32.awaddr(15 downto 0);
        PulseGeneratorPlainAxi4LiteDown.AWPROT <= bus_down.axi4lite32.awprot;
        PulseGeneratorPlainAxi4LiteDown.WVALID <= bus_down.axi4lite32.wvalid;
        PulseGeneratorPlainAxi4LiteDown.WDATA <= bus_down.axi4lite32.wdata;
        PulseGeneratorPlainAxi4LiteDown.WSTRB <= bus_down.axi4lite32.wstrb;
        PulseGeneratorPlainAxi4LiteDown.BREADY <= bus_down.axi4lite32.bready;
        PulseGeneratorPlainAxi4LiteDown.ARVALID <= bus_down.axi4lite32.arvalid;
        PulseGeneratorPlainAxi4LiteDown.ARADDR <= bus_down.axi4lite32.araddr(15 downto 0);
        PulseGeneratorPlainAxi4LiteDown.ARPROT <= bus_down.axi4lite32.arprot;
        PulseGeneratorPlainAxi4LiteDown.RREADY <= bus_down.axi4lite32.rready;
        bus_up.axi4lite32.clk <= Clk;            
        bus_up.axi4lite32.awready <= PulseGeneratorPlainAxi4LiteUp.AWREADY;
        bus_up.axi4lite32.wready <= PulseGeneratorPlainAxi4LiteUp.WREADY;
        bus_up.axi4lite32.bvalid <= PulseGeneratorPlainAxi4LiteUp.BVALID;
        bus_up.axi4lite32.bresp <= PulseGeneratorPlainAxi4LiteUp.BRESP;
        bus_up.axi4lite32.arready <= PulseGeneratorPlainAxi4LiteUp.ARREADY;
        bus_up.axi4lite32.rvalid <= PulseGeneratorPlainAxi4LiteUp.RVALID;
        bus_up.axi4lite32.rdata <= PulseGeneratorPlainAxi4LiteUp.RDATA;
        bus_up.axi4lite32.rresp <= PulseGeneratorPlainAxi4LiteUp.RRESP;  
            
        bus_trace.axi4lite32_trace.axi4lite_down_32.awvalid <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteDown.AWVALID;
        bus_trace.axi4lite32_trace.axi4lite_down_32.awaddr(15 downto 0) <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteDown.AWADDR;
        bus_trace.axi4lite32_trace.axi4lite_down_32.awaddr(31 downto 16) <= (others => '0');
        bus_trace.axi4lite32_trace.axi4lite_down_32.awprot <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteDown.AWPROT;
        bus_trace.axi4lite32_trace.axi4lite_down_32.wvalid <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteDown.WVALID;
        bus_trace.axi4lite32_trace.axi4lite_down_32.wdata <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteDown.WDATA;
        bus_trace.axi4lite32_trace.axi4lite_down_32.wstrb <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteDown.WSTRB;
        bus_trace.axi4lite32_trace.axi4lite_down_32.bready <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteDown.BREADY;
        bus_trace.axi4lite32_trace.axi4lite_down_32.arvalid <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteDown.ARVALID;
        bus_trace.axi4lite32_trace.axi4lite_down_32.araddr(15 downto 0) <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteDown.ARADDR;
        bus_trace.axi4lite32_trace.axi4lite_down_32.araddr(31 downto 16) <= (others => '0');
        bus_trace.axi4lite32_trace.axi4lite_down_32.arprot <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteDown.ARPROT;
        bus_trace.axi4lite32_trace.axi4lite_down_32.rready <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteDown.RREADY;        
        bus_trace.axi4lite32_trace.axi4lite_up_32.clk <= Clk;
        bus_trace.axi4lite32_trace.axi4lite_up_32.awready <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteUp.AWREADY;
        bus_trace.axi4lite32_trace.axi4lite_up_32.wready <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteUp.WREADY;        
        bus_trace.axi4lite32_trace.axi4lite_up_32.bvalid <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteUp.BVALID;
        bus_trace.axi4lite32_trace.axi4lite_up_32.bresp <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteUp.BRESP;  
        bus_trace.axi4lite32_trace.axi4lite_up_32.arready <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteUp.ARREADY;
        bus_trace.axi4lite32_trace.axi4lite_up_32.rvalid <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteUp.RVALID; 
        bus_trace.axi4lite32_trace.axi4lite_up_32.rdata <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteUp.RDATA;
        bus_trace.axi4lite32_trace.axi4lite_up_32.rresp <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteUp.RRESP;         
        bus_trace.axi4lite32_trace.hxs_unoccupied_access <= PulseGeneratorPlainAxi4LiteTrace.UnoccupiedAck;
        bus_trace.axi4lite32_trace.hxs_timeout_access <= PulseGeneratorPlainAxi4LiteTrace.TimeoutAck;      
                                                   
end architecture;