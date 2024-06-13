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

use work.TutBitfieldRegisterIfcPackage.all;

entity TutBitfieldRegisterUserLogic is
    port (
        UserClk : in std_logic;
        UserRst : in std_logic;
        TutBlkDown : out T_TutBitfieldRegisterIfcTutBlkDown;
        Count: in std_logic_vector(COUNTERTHRESHOLD_WIDTH - 1 downto 0);
        CountAboveThreshold : out std_logic
    );
end entity;

architecture RTL of TutBitfieldRegisterUserLogic is
    
    signal Count : unsigned(COUNTERTHRESHOLD_WIDTH - 1 downto 0);
    
begin
     
    prcCounter : process (UserClk, UserRst) is
    begin
        if UserRst then
            Count <= (others => '0');
            CountAboveThreshold <= '0';            
        elsif rising_edge(UserClk) then
        
            case TutBlkDown.CounterOperation is
                when HALTED =>
                    null;               
                when STEPPINGUP =>
                    Count <= Count + 1;
                when STEPPINGDOWN => 
                    Count <= Count - 1;
                when others =>
                    null;
            end case;
            
            if Count > TutBlkDown.CounterThreshold then
                CountAboveThreshold <= '1';
            else 
                CountAboveThreshold <= '0';
            end if;
            
        end if;  
    end process; 
          
end architecture;
