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
        CLOCKS_UNTIL_CYCLE_TIMEOUT : integer := 1023;
        bustype : string := "wishbone"
    );
    port (
        Clk : in std_logic;
        Rst : in std_logic;
        BusDown : in t_bus_down;
        BusUp : out t_bus_up;
        Trace : out T_PulseGeneratorPlainIfcTrace;
        PulseGeneratorPlainBlkDown : out T_PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown
    );
end;

architecture behavioural of tb_top is

    signal PulseGeneratorPlainIfcWishboneDown : T_PulseGeneratorPlainIfcWishboneDown;
    signal PulseGeneratorPlainIfcWishboneUp : T_PulseGeneratorPlainIfcWishboneUp;
    signal PulseGeneratorPlainIfcTrace : T_PulseGeneratorPlainIfcTrace;
    
    signal PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown : T_PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown;
       
begin

    i_PulseGeneratorPlainIfcIfcWishbone : entity work.PulseGeneratorPlainIfcIfcWishbone
        port map(
            Clk => Clk,
            Rst => Rst,
            WishboneDown => PulseGeneratorPlainIfcWishboneDown,
            WishboneUp => PulseGeneratorPlainIfcWishboneUp,
            Trace => PulseGeneratorPlainIfcTrace,
            PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown => PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown
        );
               
        PulseGeneratorPlainIfcWishboneDown.Adr <= bus_down.wishbone.adr;
        PulseGeneratorPlainIfcWishboneDown.Sel <= bus_down.wishbone.sel;
        PulseGeneratorPlainIfcWishboneDown.DatIn <= bus_down.wishbone.data;
        PulseGeneratorPlainIfcWishboneDown.We <= bus_down.wishbone.we;
        PulseGeneratorPlainIfcWishboneDown.Stb <= bus_down.wishbone.stb;
        PulseGeneratorPlainIfcWishboneDown.Cyc <= bus_down.wishbone.cyc;   
        
        bus_up.wishbone.data <= PulseGeneratorPlainIfcWishboneUp.DatOut;
        bus_up.wishbone.ack <= PulseGeneratorPlainIfcWishboneUp.Ack;  
        
        bus_up.avalon.readdata <= (others => '0');
        bus_up.avalon.waitrequest <= '1';
        
        bus_up.axi4lite.awready <= '0';
        bus_up.axi4lite.wready <= '0';
        bus_up.axi4lite.bvalid <= '0';
        bus_up.axi4lite.bresp <= (others => '0');
        bus_up.axi4lite.arready <= '0';
        bus_up.axi4lite.rvalid <= '0';
        bus_up.axi4lite.rdata <= (others => '0');
        bus_up.axi4lite.rresp <= (others => '0');
                                  
end architecture;