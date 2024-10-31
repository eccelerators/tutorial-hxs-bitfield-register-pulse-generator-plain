library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.basic.all;
use work.PulseGeneratorPlainIfcWishbonePackage.all;
use work.PulseGeneratorPlainIfcUserPackage.all;

entity PulseGeneratorPlainWishboneHxs is
    generic(
        NsPerClk : natural := 1
    );
	port(
        Clk : in std_logic;
        Rst : in std_logic;
        PulseGeneratorPlainWishboneDown : in T_PulseGeneratorPlainIfcWishboneDown;    
        PulseGeneratorPlainWishboneUp : out T_PulseGeneratorPlainIfcWishboneUp;
        PulseGeneratorPlainWishboneTrace : out T_PulseGeneratorPlainIfcWishboneTrace;
        Pulse : out std_logic;
        Failure : out std_logic
	);
end entity;

architecture Behavioural of PulseGeneratorPlainWishboneHxs is

    signal PulseGeneratorPlainBlkDown : T_PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown;

begin

    PulseGeneratorPlainIfcWishbone_i : entity work.PulseGeneratorPlainIfcWishbone
    generic map (
        CLOCKS_UNTIL_CYCLE_TIMEOUT => 1023
    )
    port map (
        Clk => Clk,
        Rst => Rst,
        WishboneDown => PulseGeneratorPlainWishboneDown,
        WishboneUp => PulseGeneratorPlainWishboneUp,
        Trace => PulseGeneratorPlainWishboneTrace,
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
