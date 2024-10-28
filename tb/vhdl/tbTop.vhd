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
    
use work.tb_bus_pkg.all;
use work.tb_signals_pkg.all;
use work.PulseGeneratorPlainIfcCommonPackage.vhd.all;

entity tbTop is
    generic (
        stimulus_path : string := "tb/simstm/";
        stimulus_file : string := "testMain.stm";
        stimulus_main_entry_label : string := "$testMain";
        stimulus_test_suite_index : integer := 255;
        tutorial_flavour : integer := 255;
        tutorial_bustype : integer := 255
    );
end;

architecture behavioural of tbTop is

    signal Clk : std_logic := '0';
    signal Rst : std_logic := '1';
    
    signal executing_line : integer := 0;
    signal executing_file : text_line;
    signal marker : std_logic_vector(15 downto 0) := (others => '0');
    signal standard_test_error_count : std_logic_vector(31 downto 0);
    signal standard_test_error_count : std_logic_vector(31 downto 0);
    
    signal signals_in : t_signals_in;
    signal signals_out : t_signals_out;
    signal bus_down : t_bus_down;
    signal bus_up : t_bus_up;
                  
    signal InitPulseGeneratorPlainLogic : std_logic;
    
    signal Clk : std_logic;
    signal Rst : std_logic;
    signal PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown : T_PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown;    
    signal Pulse : std_logic;
    signal Failure : std_logic;
    
begin

    Rst <= transport '0' after 100 ns;
    Clk <= transport (not Clk) after 10 ns / 2; -- 100MHz
  
    signals_in.in_signal_2000 <= to_unsigned(tutorial_flavour, 32);
    signals_in.in_signal_2001 <= to_unsigned(tutorial_bustype, 32);
    signals_in.in_signal_2002 <= Pulse;
    signals_in.in_signal_2003 <= Failure; 
        
    InitPulseGeneratorPlainLogic <= signals.out_signal_3000;
    
    Clk <= Clk;
    Rst <= Rst or InitPulseGeneratorPlainLogic;

    i_tb_simstm : entity work.tb_simstm
        generic map (
            stimulus_path => stimulus_path,
            stimulus_file => stimulus_file          
        )
        port map (
            clk => Clk,
            rst => Rst,    
            executing_line => executing_line,
            executing_file => executing_file,
            standard_test_error_count => standard_test_error_count,
            marker => marker,
            signals_in => signals_in,
            signals_out => signals_out,
            bus_down => bus_down,
            bus_up => bus_up
        ); 
 
    g_tb_DutWishbone : if tutorial_bustype = 0 generate 
        i_tb_DutWishbone : entity work.tb_DutWishbone
        port map(
            Clk => Clk,
            Rst => Rst,
            bus_down => bus_down,
            bus_up => bus_up,
            bus_trace => bus_trace,
            PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown => PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown,
            Pulse => Pulse,
            Failure => Failure
        );    
    end generate; 
    
    g_tb_DutAvalon : if tutorial_bustype = 0 generate 
        i_tb_DutAvalon : entity work.tb_DutAvalon
        port map(
            Clk => Clk,
            Rst => Rst,
            bus_down => bus_down,
            bus_up => bus_up,
            bus_trace => bus_trace,
            PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown => PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown,
            Pulse => Pulse,
            Failure => Failure
        );    
    end generate;
    
    g_tb_DutAxi4Lite : if tutorial_bustype = 0 generate 
        i_tb_DutAxi4Lite : entity work.tb_DutAxi4Lite
        port map(
            Clk => Clk,
            Rst => Rst,
            bus_down => bus_down,
            bus_up => bus_up,
            bus_trace => bus_trace,
            PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown => PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown,
            Pulse => Pulse,
            Failure => Failure
        );    
    end generate;         
                                                                  
end architecture;