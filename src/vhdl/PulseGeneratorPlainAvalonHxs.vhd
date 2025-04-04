library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.basic.all;
use work.PulseGeneratorPlainIfcAvalonPackage.all;
use work.PulseGeneratorPlainIfcUserPackage.all;

entity PulseGeneratorPlainAvalonHxs is
    generic(
        NsPerClk : natural := 1
    );
	port(
        Clk : in std_logic;
        Rst : in std_logic;
        PulseGeneratorPlainAvalonDown : in T_PulseGeneratorPlainIfcAvalonDown;    
        PulseGeneratorPlainAvalonUp : out T_PulseGeneratorPlainIfcAvalonUp;
        PulseGeneratorPlainAvalonTrace : out T_PulseGeneratorPlainIfcAvalonTrace;
        Pulse : out std_logic;
        Failure : out std_logic
	);
end entity;

architecture Behavioural of PulseGeneratorPlainAvalonHxs is

    signal PulseGeneratorPlainBlkDown : T_PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown;

begin

    i_PulseGeneratorPlainIfcAvalon : entity work.PulseGeneratorPlainIfcAvalon
    generic map (
        CLOCKS_UNTIL_CYCLE_TIMEOUT => 1023
    )
    port map (
        Clk => Clk,
        Rst => Rst,
        AvalonDown => PulseGeneratorPlainAvalonDown,
        AvalonUp => PulseGeneratorPlainAvalonUp,
        Trace => PulseGeneratorPlainAvalonTrace,
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
