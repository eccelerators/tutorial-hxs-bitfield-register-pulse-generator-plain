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
		PulseGeneratorPlainBlkDown_Operation : out std_logic_vector(1 downto 0);
		PulseGeneratorPlainBlkDown_PulseWidthNs : out std_logic_vector(23 downto 0);
		PulseGeneratorPlainBlkDown_PulsePeriodNs : out std_logic_vector(23 downto 0)
	);
end;

architecture Behavioural of PulseGeneratorPlainIfcWishboneWrapper is

	signal WishboneDown : T_PulseGeneratorPlainIfcWishboneDown;
	signal WishboneUp : T_PulseGeneratorPlainIfcWishboneUp;
	signal Trace : T_PulseGeneratorPlainIfcWishboneTrace;
	signal PulseGeneratorPlainBlkDown : T_PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown;

begin

	PulseGeneratorPlainIfcWishbone_i : entity work.PulseGeneratorPlainIfcWishbone
	generic map (
		CLOCKS_UNTIL_CYCLE_TIMEOUT => 1023
	)
	port map (
		Clk => Clk,
		Rst => Rst,
		WishboneDown => WishboneDown,
		WishboneUp => WishboneUp,
		Trace => Trace,
		PulseGeneratorPlainBlkDown => PulseGeneratorPlainBlkDown
	);
	
	WishboneDown.Adr <= Adr;
	WishboneDown.Sel <= Sel;
	WishboneDown.DatIn <= DatIn;
	WishboneDown.We <= We;
	WishboneDown.Stb <= Stb;
	WishboneDown.Cyc <= Cyc;
	
	DatOut <= WishboneUp.DatOut;
	Ack <= WishboneUp.Ack;
	
	Trace_WishboneDown_Adr <= Trace.WishboneDown.Adr;
	Trace_WishboneDown_Sel <= Trace.WishboneDown.Sel;
	Trace_WishboneDown_DatIn <= Trace.WishboneDown.DatIn;
	Trace_WishboneDown_We <= Trace.WishboneDown.We;
	Trace_WishboneDown_Stb <= Trace.WishboneDown.Stb;
	Trace_WishboneDown_Cyc <= Trace.WishboneDown.Cyc;
	
	Trace_WishboneUp_DatOut <= Trace.WishboneUp.DatOut;
	Trace_WishboneUp_Ack <= Trace.WishboneUp.Ack;
	Trace_UnoccupiedAck <= Trace.UnoccupiedAck;
	Trace_TimeoutAck <= Trace.TimeoutAck;
	PulseGeneratorPlainBlkDown_PulseWidthNs <= PulseGeneratorPlainBlkDown.PulseWidthNs;
	PulseGeneratorPlainBlkDown_Operation <= PulseGeneratorPlainBlkDown.Operation;
	PulseGeneratorPlainBlkDown_PulsePeriodNs <= PulseGeneratorPlainBlkDown.PulsePeriodNs;

end;
