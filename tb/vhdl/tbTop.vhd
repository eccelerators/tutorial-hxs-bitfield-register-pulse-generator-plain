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

use work.basic.all;
use work.tb_base_pkg.all;    
use work.tb_bus_pkg.all;
use work.tb_signals_pkg.all;
use work.PulseGeneratorPlainIfcUserPackage.all;

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

    constant NsPerClk : natural := 10;

    signal Clk : std_logic := '0';
    signal Rst : std_logic := '1';
    
    signal executing_line : integer := 0;
    signal executing_file : text_line;
    signal marker : std_logic_vector(15 downto 0) := (others => '0');
    signal standard_test_error_count : std_logic_vector(31 downto 0);
     
    signal signals_in : t_signals_in;
    signal signals_out : t_signals_out;
    signal bus_down : t_bus_down;
    signal bus_up : t_bus_up;
    signal bus_trace : t_bus_trace;
                  
    signal InitPulseGeneratorPlain : std_logic;
    
    signal PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown : T_PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown;    
    signal Pulse : std_logic;
    signal Failure : std_logic;
    
    signal PulseRisingEdgeTimestampRecorderRestart : std_logic := '0';
    signal PulseRisingEdgeTimestamps : array_of_unsigned(3 downto 0)(31 downto 0) := (others => (others => '0'));
    signal PulseRisingEdgeRecordedNumberOfTimestamps: unsigned(31 downto 0) := (others => '0');
    
    signal PulseFallingEdgeTimestampRecorderRestart : std_logic := '0';
    signal PulseFallingEdgeTimestamps : array_of_unsigned(3 downto 0)(31 downto 0) := (others => (others => '0'));
    signal PulseFallingEdgeRecordedNumberOfTimestamps: unsigned(31 downto 0) := (others => '0');
    
begin
   
    Clk <= transport (not Clk) after 10 ns / 2; -- 100MHz

    -- standard inputs
    -- signals_in.in_signal_0 actual simulation time already supplied by package
    signals_in.in_signal_1 <= std_logic_vector(to_unsigned(stimulus_test_suite_index, 32));
    -- signals_in.in_signal_2 constant 0 already supplied by package
    signals_in.in_signal_3 <= standard_test_error_count;
    
    -- interrupts
    signals_in.in_signal_1000 <= '0';
    signals_in.in_signal_1001 <= '0';
  
    signals_in.in_signal_2000 <= std_logic_vector(to_unsigned(tutorial_flavour, 32));
    signals_in.in_signal_2001 <= std_logic_vector(to_unsigned(tutorial_bustype, 32));
    signals_in.in_signal_2002 <= Pulse;
    signals_in.in_signal_2003 <= Failure;
    
    signals_in.in_signal_2004 <= std_logic_vector(PulseRisingEdgeTimestamps(0));
    signals_in.in_signal_2005 <= std_logic_vector(PulseRisingEdgeTimestamps(1));
    signals_in.in_signal_2006 <= std_logic_vector(PulseRisingEdgeTimestamps(2));
    signals_in.in_signal_2007 <= std_logic_vector(PulseRisingEdgeTimestamps(3));
    signals_in.in_signal_2008 <= std_logic_vector(PulseRisingEdgeRecordedNumberOfTimestamps);
    
    signals_in.in_signal_2009 <= std_logic_vector(PulseFallingEdgeTimestamps(0));
    signals_in.in_signal_2010 <= std_logic_vector(PulseFallingEdgeTimestamps(1));
    signals_in.in_signal_2011 <= std_logic_vector(PulseFallingEdgeTimestamps(2));
    signals_in.in_signal_2012 <= std_logic_vector(PulseFallingEdgeTimestamps(3));
    signals_in.in_signal_2013 <= std_logic_vector(PulseFallingEdgeRecordedNumberOfTimestamps);
        
    InitPulseGeneratorPlain <= signals_out.out_signal_3000;
    PulseRisingEdgeTimestampRecorderRestart <= signals_out.out_signal_3001;
    PulseFallingEdgeTimestampRecorderRestart <= signals_out.out_signal_3002;
    
    Rst <= InitPulseGeneratorPlain;
    
    
    p_record_pulse_rising_edge_timestamps: process (Pulse, PulseRisingEdgeTimestampRecorderRestart) is
    begin
        if rising_edge(PulseRisingEdgeTimestampRecorderRestart) then
            PulseRisingEdgeRecordedNumberOfTimestamps <= (others => '0');
        elsif rising_edge(Pulse) then
            for i in 0 to 3 loop
                if PulseRisingEdgeRecordedNumberOfTimestamps = i then
                    if rising_edge(Pulse) then
                        PulseRisingEdgeTimestamps(i) <= to_unsigned((now / 1 ns), 32);
                        PulseRisingEdgeRecordedNumberOfTimestamps <= PulseRisingEdgeRecordedNumberOfTimestamps + 1;
                    end if;
                end if;
            end loop;
        end if;
    end process;
    
    p_record_pulse_falling_edge_timestamps: process (Pulse, PulseFallingEdgeTimestampRecorderRestart) is
    begin
        if Falling_edge(PulseFallingEdgeTimestampRecorderRestart) then
            PulseFallingEdgeRecordedNumberOfTimestamps <= (others => '0');
        elsif Falling_edge(Pulse) then
            for i in 0 to 3 loop
                if PulseFallingEdgeRecordedNumberOfTimestamps = i then
                    if Falling_edge(Pulse) then
                        PulseFallingEdgeTimestamps(i) <= to_unsigned((now / 1 ns), 32);
                        PulseFallingEdgeRecordedNumberOfTimestamps <= PulseFallingEdgeRecordedNumberOfTimestamps + 1;
                    end if;
                end if;
            end loop;
        end if;
    end process;
    
    

    i_tb_simstm : entity work.tb_simstm
        generic map (
            stimulus_path => stimulus_path,
            stimulus_file => stimulus_file          
        )
        port map (
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
        i_tbDutWishbone : entity work.tbDutWishbone
        generic map (
            NsPerClk => NsPerClk
        )
        port map(
            Clk => Clk,
            Rst => Rst,
            bus_down => bus_down,
            bus_up => bus_up,
            bus_trace => bus_trace,
            Pulse => Pulse,
            Failure => Failure
        );    
    end generate; 
    
    g_tb_DutAvalon : if tutorial_bustype = 1 generate 
        i_tbDutAvalon : entity work.tbDutAvalon
        generic map (
            NsPerClk => NsPerClk
        )
        port map(
            Clk => Clk,
            Rst => Rst,
            bus_down => bus_down,
            bus_up => bus_up,
            bus_trace => bus_trace,
            Pulse => Pulse,
            Failure => Failure
        );    
    end generate;
    
    g_tb_DutAxi4Lite : if tutorial_bustype = 2 generate 
        i_tbDutAxi4Lite : entity work.tbDutAxi4Lite
        generic map (
            NsPerClk => NsPerClk
        )
        port map(
            Clk => Clk,
            Rst => Rst,
            bus_down => bus_down,
            bus_up => bus_up,
            bus_trace => bus_trace,
            Pulse => Pulse,
            Failure => Failure
        );    
    end generate;         
                                                                  
end architecture;