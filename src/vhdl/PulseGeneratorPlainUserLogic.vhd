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

entity PulseGeneratorPlainUserLogic is
    port (
        UserClk : in std_logic;
        UserRst : in std_logic;
        PulseGeneratorBlkDown : in T_PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown;
        Pulse : out std_logic;
        Failure : out std_logic
    );
end entity;

architecture RTL of PulseGeneratorPlainUserLogic is
    
    signal CountNs : unsigned(PULSEPERIODNS_WIDTH'high downto 0);
    
begin
     
    prcCountNs : process (UserClk, UserRst) is
    begin
        if UserRst then
        
            CountNs <= (others => '0');
            Pulse <= '0';
            Failure <= '0';    
                    
        elsif rising_edge(UserClk) then
        
            Pulse <= '0'; -- default assignment
 
            if CountNs < PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown.PulseWidthNs then
                Pulse <= '1';
            end if;
        
            case PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown.Operation is
                when STOPPED =>
                    null;               
                when CLEARED => 
                    CountNs <= to_unsigned(0, CountNs'length);
                when RUNNING_LIST(0) | RUNNING_LIST(1) =>
                    if unsigned(PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown.PulsePeriodNs) = 0 then
                        CountNs <= to_unsigned(0, CountNs'length); 
                    elsif CountNs = unsigned(PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown.PulsePeriodNs) - 1 then
                        CountNs <= to_unsigned(0, CountNs'length);                  
                    else
                        CountNs <= Count + 1;
                    end if;
            end case;
            
            if CountNs >= PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown.PulsePeriodNs then
                Failure <= '1';
            end if;
                       
        end if;  
    end process; 
          
end architecture;
