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

use work.PulseGeneratorPlainIfcUserPackage.all;

entity PulseGeneratorPlainUserLogic is
    port (
        Clk : in std_logic;
        Rst : in std_logic;
        PulseGeneratorPlainBlkDown : in T_PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown;
        Pulse : out std_logic;
        Failure : out std_logic
    );
end entity;

architecture RTL of PulseGeneratorPlainUserLogic is

    signal CountNs : unsigned(PULSEPERIODNS_WIDTH-1 downto 0);
    signal PulsePeriodNs : unsigned(PULSEPERIODNS_WIDTH-1 downto 0);
    signal PulseWidthNs : unsigned(PULSEWIDTHNS_WIDTH-1 downto 0);
    
begin

    PulsePeriodNs <= unsigned(PulseGeneratorPlainBlkDown.PulsePeriodNs);
    PulseWidthNs <= unsigned(PulseGeneratorPlainBlkDown.PulseWidthNs);
        
    prcCountNs : process (Clk, Rst) is
    
        procedure zeroCountNs is
        begin
            CountNs <= to_unsigned(0, CountNs'length);
        end procedure;
        
        procedure incCountNs is
        begin
            CountNs <= CountNs + 1;
        end procedure;    
    
    begin
        if Rst then
        
            CountNs <= (others => '0');
            Pulse <= '0';
            Failure <= '0';    
                    
        elsif rising_edge(Clk) then
        
            Pulse <= '1'; -- default assignment
 
            if CountNs = PulseWidthNs then
                Pulse <= '0';
            end if;
                   
            case PulseGeneratorPlainBlkDown.Operation is
                when STOPPED =>
                    null;
                when CLEARED => 
                    zeroCountNs;
                when RUNNING_LIST(0) | RUNNING_LIST(1) =>
                    if PulsePeriodNs = 0 then
                        zeroCountNs;
                    elsif CountNs = PulsePeriodNs - 1 then
                        zeroCountNs;                  
                    else
                        incCountNs;
                    end if;
                when others => 
                    null;
            end case;
            
            if CountNs >= PulsePeriodNs then
                Failure <= '1';
            end if;
                       
        end if;  
    end process; 
    
end architecture;
