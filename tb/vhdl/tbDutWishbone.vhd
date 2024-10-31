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

architecture behavioural of tbDutWishbone is

    signal PulseGeneratorPlainWishboneDown : T_PulseGeneratorPlainIfcWishboneDown;
    signal PulseGeneratorPlainWishboneUp : T_PulseGeneratorPlainIfcWishboneUp;
    signal PulseGeneratorPlainWishboneTrace : T_PulseGeneratorPlainIfcWishboneTrace;
           
begin

    i_PulseGeneratorPlainWishboneHxs : entity work.PulseGeneratorPlainWishboneHxs
        generic map (
            NsPerClk => NsPerClk
        )
        port map(
            Clk => Clk,
            Rst => Rst,
            PulseGeneratorPlainWishboneDown => PulseGeneratorPlainWishboneDown,
            PulseGeneratorPlainWishboneUp => PulseGeneratorPlainWishboneUp,
            PulseGeneratorPlainWishboneTrace => PulseGeneratorPlainWishboneTrace,
            Pulse => Pulse,
            Failure => Failure
        );
               
        -- wishbone connected to dut
        PulseGeneratorPlainWishboneDown.Adr <= bus_down.wishbone.adr(15 downto 0);
        PulseGeneratorPlainWishboneDown.Sel <= bus_down.wishbone.sel;
        PulseGeneratorPlainWishboneDown.DatIn <= bus_down.wishbone.data;
        PulseGeneratorPlainWishboneDown.We <= bus_down.wishbone.we;
        PulseGeneratorPlainWishboneDown.Stb <= bus_down.wishbone.stb;
        PulseGeneratorPlainWishboneDown.Cyc <= bus_down.wishbone.cyc;
        bus_up.wishbone.clk <= Clk;      
        bus_up.wishbone.data <= PulseGeneratorPlainWishboneUp.DatOut;
        bus_up.wishbone.ack <= PulseGeneratorPlainWishboneUp.Ack;  
        
        bus_trace.wishbone_trace.wishbone_down.adr(15 downto 0) <= PulseGeneratorPlainWishboneTrace.WishboneDown.Adr;
        bus_trace.wishbone_trace.wishbone_down.adr(31 downto 16) <= (others => '0');
        bus_trace.wishbone_trace.wishbone_down.sel <= PulseGeneratorPlainWishboneTrace.WishboneDown.Sel;
        bus_trace.wishbone_trace.wishbone_down.data <= PulseGeneratorPlainWishboneTrace.WishboneDown.DatIn;
        bus_trace.wishbone_trace.wishbone_down.we <= PulseGeneratorPlainWishboneTrace.WishboneDown.We;
        bus_trace.wishbone_trace.wishbone_down.stb <= PulseGeneratorPlainWishboneTrace.WishboneDown.Stb;
        bus_trace.wishbone_trace.wishbone_down.cyc <= PulseGeneratorPlainWishboneTrace.WishboneDown.Cyc;
        bus_trace.wishbone_trace.wishbone_up.clk <= Clk;             
        bus_trace.wishbone_trace.wishbone_up.data <= PulseGeneratorPlainWishboneTrace.WishboneUp.DatOut;
        bus_trace.wishbone_trace.wishbone_up.ack <= PulseGeneratorPlainWishboneTrace.WishboneUp.Ack;        
        bus_trace.wishbone_trace.hxs_unoccupied_access <= PulseGeneratorPlainWishboneTrace.UnoccupiedAck;
        bus_trace.wishbone_trace.hxs_timeout_access <= PulseGeneratorPlainWishboneTrace.TimeoutAck;
                
        -- avalon unused
        bus_up.avalonmm.clk <= '0';
        bus_up.avalonmm.readdata <= (others => '0');
        bus_up.avalonmm.waitrequest <= '1';
        
        bus_trace.avalonmm_trace.avalonmm_down.address <= (others => '0');
        bus_trace.avalonmm_trace.avalonmm_down.byteenable <= (others => '0');
        bus_trace.avalonmm_trace.avalonmm_down.writedata <= (others => '0');
        bus_trace.avalonmm_trace.avalonmm_down.read <= '0';
        bus_trace.avalonmm_trace.avalonmm_down.write <= '0';
        bus_trace.avalonmm_trace.avalonmm_up.clk <= '0';
        bus_trace.avalonmm_trace.avalonmm_up.readdata <= (others => '0');
        bus_trace.avalonmm_trace.avalonmm_up.waitrequest <= '1';     
        bus_trace.avalonmm_trace.hxs_unoccupied_access <= '0';
        bus_trace.avalonmm_trace.hxs_timeout_access <= '0';
        
        -- axi4lite unused
        bus_up.axi4lite.clk <= '0';
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
        bus_trace.axi4lite_trace.axi4lite_up.clk <= '0';
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