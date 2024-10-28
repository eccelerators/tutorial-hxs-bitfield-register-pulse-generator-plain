library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

use work.PulseGeneratorPlainIfcPackage.all;

entity PulseGeneratorPlainIfcWishboneWrapper is
	generic (
		CLOCKS_UNTIL_CYCLE_TIMEOUT : integer := 1023
	);
	port (
		Clk : in std_logic;
		Rst : in std_logic;
		Adr : in std_logic_vector(15 downto 0);
		Sel : in std_logic_vector(3 downto 0);
		DatIn : in std_logic_vector(31 downto 0);
		We : in std_logic;
		Stb : in std_logic;
		Cyc : in  std_logic;
		DatOut : out std_logic_vector(31 downto 0);
		Ack : out std_logic;
		Trace_WishboneDown_Adr : out std_logic_vector(15 downto 0);
		Trace_WishboneDown_Sel : out std_logic_vector(3 downto 0);
		Trace_WishboneDown_DatIn : out std_logic_vector(31 downto 0);
		Trace_WishboneDown_We : out std_logic;
		Trace_WishboneDown_Stb : out std_logic;
		Trace_WishboneDown_Cyc : out std_logic;
		Trace_WishboneUp_DatOut : out std_logic_vector(31 downto 0);
		Trace_WishboneUp_Ack : out std_logic;
		Trace_UnoccupiedAck : out std_logic;
		Trace_TimeoutAck : out std_logic;
        Pulse : out std_logic;
        Failure : out std_logic
	);
end;

architecture Behavioural of PulseGeneratorPlainIfcWishboneWrapper is

	signal PulseGeneratorPlainIfcWishboneDown : T_PulseGeneratorPlainIfcWishboneDown;
	signal PulseGeneratorPlainIfcWishboneUp : T_PulseGeneratorPlainIfcWishboneUp;
	signal PulseGeneratorPlainIfcWishboneTrace : T_PulseGeneratorPlainIfcWishboneTrace;

begin

	i_PulseGeneratorPlainIfcWishboneHxs : entity work.PulseGeneratorPlainIfcWishboneHxs
	generic map (
		CLOCKS_UNTIL_CYCLE_TIMEOUT => 1023
	)
	port map (
		Clk => Clk,
		Rst => Rst,
		WishboneDown => PulseGeneratorPlainIfcWishboneDown,
		WishboneUp => PulseGeneratorPlainIfcWishboneUp,
		Trace => Trace,
		PulseGeneratorPlainBlkDown => PulseGeneratorPlainBlkDown
	);
	
	PulseGeneratorPlainIfcWishboneDown.Adr <= Adr;
	PulseGeneratorPlainIfcWishboneDown.Sel <= Sel;
	PulseGeneratorPlainIfcWishboneDown.DatIn <= DatIn;
	PulseGeneratorPlainIfcWishboneDown.We <= We;
	PulseGeneratorPlainIfcWishboneDown.Stb <= Stb;
	PulseGeneratorPlainIfcWishboneDown.Cyc <= Cyc;
	
	DatOut <= PulseGeneratorPlainIfcWishboneUp.DatOut;
	Ack <= PulseGeneratorPlainIfcWishboneUp.Ack;
	
	Trace_WishboneDown_Adr <= PulseGeneratorPlainIfcWishboneTrace.WishboneDown.Adr;
	Trace_WishboneDown_Sel <= PulseGeneratorPlainIfcWishboneTrace.WishboneDown.Sel;
	Trace_WishboneDown_DatIn <= PulseGeneratorPlainIfcWishboneTrace.WishboneDown.DatIn;
	Trace_WishboneDown_We <= PulseGeneratorPlainIfcWishboneTrace.WishboneDown.We;
	Trace_WishboneDown_Stb <= PulseGeneratorPlainIfcWishboneTrace.WishboneDown.Stb;
	Trace_WishboneDown_Cyc <= PulseGeneratorPlainIfcWishboneTrace.WishboneDown.Cyc;
	
	Trace_WishboneUp_DatOut <= PulseGeneratorPlainIfcWishboneTrace.WishboneUp.DatOut;
	Trace_WishboneUp_Ack <= PulseGeneratorPlainIfcWishboneTrace.WishboneUp.Ack;
	Trace_UnoccupiedAck <= PulseGeneratorPlainIfcWishboneTrace.UnoccupiedAck;
	Trace_TimeoutAck <= PulseGeneratorPlainIfcWishboneTrace.TimeoutAck;

end;
