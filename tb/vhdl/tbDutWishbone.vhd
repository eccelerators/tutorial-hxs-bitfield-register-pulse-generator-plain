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
    
use work.PulseGeneratorPlainIfcWishbonePackage.all;
use work.tb_bus_pkg.all;

entity tbDutWishbone is
    generic (
        CLOCKS_UNTIL_CYCLE_TIMEOUT : integer := 1023
    );
    port (
        Clk : in std_logic;
        Rst : in std_logic;
        bus_down : in t_bus_down;
        bus_up : out t_bus_up;
        bus_trace : out t_wishbone_trace;
        Pulse : out std_logic;
        Failure : out std_logic
    );
end;

architecture behavioural of tbDutWishbone is

    signal PulseGeneratorPlainWishboneDown : T_PulseGeneratorPlainIfcWishboneDown;
    signal PulseGeneratorPlainWishboneUp : T_PulseGeneratorPlainIfcWishboneUp;
    signal PulseGeneratorPlainWishboneTrace : T_PulseGeneratorPlainIfcWishboneTrace;
           
begin

    i_PulseGeneratorPlainWishboneHxs : entity work.PulseGeneratorPlainWishboneHxs
        port map(
            Clk => Clk,
            Rst => Rst,
            PulseGeneratorPlainWishboneDown => PulseGeneratorPlainWishboneDown,
            PulseGeneratorPlainIfcWishboneUp => PulseGeneratorPlainWishboneUp,
            PulseGeneratorPlainIfcWishboneTrace => PulseGeneratorPlainWishboneTrace,
            Pulse => Pulse,
            Failure => Failure
        );
               
        -- wishbone connected to dut
        PulseGeneratorPlainIfcWishboneDown.Adr <= bus_down.wishbone.adr;
        PulseGeneratorPlainIfcWishboneDown.Sel <= bus_down.wishbone.sel;
        PulseGeneratorPlainIfcWishboneDown.DatIn <= bus_down.wishbone.data;
        PulseGeneratorPlainIfcWishboneDown.We <= bus_down.wishbone.we;
        PulseGeneratorPlainIfcWishboneDown.Stb <= bus_down.wishbone.stb;
        PulseGeneratorPlainIfcWishboneDown.Cyc <= bus_down.wishbone.cyc;           
        bus_up.wishbone.data <= PulseGeneratorPlainIfcWishboneUp.DatOut;
        bus_up.wishbone.ack <= PulseGeneratorPlainIfcWishboneUp.Ack;  
        
        bus_trace.wishbone_down.adr <= PulseGeneratorPlainIfcWishboneTrace.WishboneDown.Adr;
        bus_trace.wishbone_down.sel <= PulseGeneratorPlainIfcWishboneTrace.WishboneDown.Sel;
        bus_trace.wishbone_down.data <= PulseGeneratorPlainIfcWishboneTrace.WishboneDown.DatIn;
        bus_trace.wishbone_down.we <= PulseGeneratorPlainIfcWishboneTrace.WishboneDown.We;
        bus_trace.wishbone_down.stb <= PulseGeneratorPlainIfcWishboneTrace.WishboneDown.Stb;
        bus_trace.wishbone_down.cyc <= PulseGeneratorPlainIfcWishboneTrace.WishboneDown.Cyc;           
        bus_trace.wishbone_up.data <= PulseGeneratorPlainIfcWishboneTrace.WishboneUp.DatOut;
        bus_trace.wishbone_up.ack <= PulseGeneratorPlainIfcWishboneTrace.WishboneUp.Ack;        
        bus_trace.hxs_unoccupied_access <= PulseGeneratorPlainAxi4LiteTrace.UnoccupiedAck;
        bus_trace.hxs_timeout_access <= PulseGeneratorPlainAxi4LiteTrace.TimeoutAck;
                
        -- avalon unused 
        bus_up.avalon.readdata <= (others => '0');
        bus_up.avalon.waitrequest <= '1';
        
        bus_trace.avalonmm_down.adr <= (others => '0');
        bus_trace.avalonmm_down.byteenable <= (others => '0');
        bus_trace.avalonmm_down.writedata <= (others => '0');
        bus_trace.avalonmm_down.read <= '0';
        bus_trace.avalonmm_down.write <= '0';
        bus_trace.avalonmm_up.readdata <= (others => '0');
        bus_trace.avalonmm_up.waitrequest <= '1';     
        bus_trace.hxs_unoccupied_access <= '0';
        bus_trace.hxs_timeout_access <= '0';
        
        -- axi4lite unused 
        bus_up.axi4lite.awready <= '0';
        bus_up.axi4lite.wready <= '0';
        bus_up.axi4lite.bvalid <= '0';
        bus_up.axi4lite.bresp <= (others => '0');
        bus_up.axi4lite.arready <= '0';
        bus_up.axi4lite.rvalid <= '0';
        bus_up.axi4lite.rdata <= (others => '0');
        bus_up.axi4lite.rresp <= (others => '0');
        
        bus_trace.axi4lite_down.awvalid <= '0';
        bus_trace.axi4lite_down.awaddr <= (others => '0');
        bus_trace.axi4lite_down.awprot <= (others => '0');
        bus_trace.axi4lite_down.wvalid <= '0';
        bus_trace.axi4lite_down.wdata <= (others => '0');
        bus_trace.axi4lite_down.wstrb <= (others => '0');
        bus_trace.axi4lite_down.bready <= '0';
        bus_trace.axi4lite_down.arvalid <= '0';
        bus_trace.axi4lite_down.araddr <= (others => '0');
        bus_trace.axi4lite_down.arprot <= (others => '0');
        bus_trace.axi4lite_down.rready <= '0';
        bus_trace.axi4lite_up.awready <= '0';
        bus_trace.axi4lite_up.wready <= '0';       
        bus_trace.axi4lite_up.bvalid <= '0';
        bus_trace.axi4lite_up.bresp <= (others => '0'); 
        bus_trace.axi4lite_up.arready <= '0';
        bus_trace.axi4lite_up.rvalid <= '0';
        bus_trace.axi4lite_up.rdata <= (others => '0');
        bus_trace.axi4lite_up.rresp <= (others => '0');
        bus_trace.hxs_unoccupied_access <= '0';
        bus_trace.hxs_timeout_access <= '0';
        
end architecture;