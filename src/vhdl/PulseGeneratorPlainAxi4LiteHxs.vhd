library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.basic.all;
use work.PulseGeneratorPlainIfcAxi4LitePackage.all;
use work.PulseGeneratorPlainIfcUserPackage.all;

entity PulseGeneratorPlainAxi4LiteHxs is
	generic(
        NsPerClk : natural := 1
	);
	port(
        Clk : in std_logic;
        Rst : in std_logic;
        PulseGeneratorPlainAxi4LiteDown : in T_PulseGeneratorPlainIfcAxi4LiteDown;    
        PulseGeneratorPlainAxi4LiteUp : out T_PulseGeneratorPlainIfcAxi4LiteUp;
        PulseGeneratorPlainAxi4LiteTrace : out T_PulseGeneratorPlainIfcAxi4LiteTrace;
        Pulse : out std_logic;
        Failure : out std_logic
	);
end entity;

architecture Behavioural of PulseGeneratorPlainAxi4LiteHxs is

    signal PulseGeneratorPlainBlkDown : T_PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown;

begin

    i_PulseGeneratorPlainIfcAxi4Lite : entity work.PulseGeneratorPlainIfcAxi4Lite
        port map(
            Clk => Clk,
            Rst => Rst,
            Axi4LiteDown => PulseGeneratorPlainAxi4LiteDown,
            Axi4LiteUp => PulseGeneratorPlainAxi4LiteUp,
            Axi4LiteAccess => open,
            Trace => PulseGeneratorPlainAxi4LiteTrace,
            PulseGeneratorPlainBlkDown => PulseGeneratorPlainBlkDown
        ); 
                        
    i_PulseGeneratorPlainUserLogic : entity work.PulseGeneratorPlainUserLogic
        generic map (
            NsPerClk => NsPerClk
        )
        port map (
            Clk => Clk,
            Rst => Rst,
            PulseGeneratorPlainBlkDown => PulseGeneratorPlainBlkDown,
            Pulse => Pulse,
            Failure => Failure
        );

end;
