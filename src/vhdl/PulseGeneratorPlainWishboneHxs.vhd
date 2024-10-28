library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.basic.all;
use work.PulseGeneratorPlainIfcWishbonePackage.all;
use work.PulseGeneratorPlainIfcUserPackage.all;

entity PulseGeneratorPlainWishboneHxs is
	generic(
		SimFast : boolean := false
	);
	port(
        Clk : in std_logic;
        Rst : in std_logic;
        PulseGeneratorPlainWishboneDown : in T_PulseGeneratorPlainIfcWishboneDown;    
        PulseGeneratorPlainWishboneUp : out T_PulseGeneratorPlainIfcWishboneUp;
        PulseGeneratorPlainWishboneTrace : out T_PulseGeneratorPlainIfcTrace;
        Pulse : out std_logic;
        Failure : out std_logic
	);
end entity;

architecture Behavioural of PulseGeneratorPlainWishboneHxs is

    signal PulseGeneratorBlkDown : T_PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown;

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
                        
    i_PulseGeneratorPlainLogic : entity work.PulseGeneratorPlainLogic
        port map (
            Clk => Clk,
            Rst => Rst,
            PulseGeneratorBlkDown => PulseGeneratorBlkDown,
            Pulse => Pulse,
            Failure => Failure
        );

end;
