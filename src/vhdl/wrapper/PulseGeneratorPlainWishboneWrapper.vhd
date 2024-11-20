1library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

use work.PulseGeneratorPlainIfcWishbonePackage.all;

entity PulseGeneratorPlainIfcWishboneWrapper is
	generic (
		CLOCKS_UNTIL_CYCLE_TIMEOUT : integer := 1023
	);
	port (
		S_WSHBN_0_ACLK : in std_logic;
		S_WSHBN_0_ARESETN : in std_logic;
		S_WSHBN_0_ADR : in std_logic_vector(15 downto 0);
		S_WSHBN_0_SEL : in std_logic_vector(3 downto 0);
		S_WSHBN_0_DATW : in std_logic_vector(31 downto 0);
		S_WSHBN_0_WE : in std_logic;
		S_WSHBN_0_STB : in std_logic;
		S_WSHBN_0_CYC : in  std_logic;
		S_WSHBN_0_DATR : out std_logic_vector(31 downto 0);
		S_WSHBN_0_ACK : out std_logic;
		HXS_TRACE_S_WSHBN_0_DOWN_ADR : out std_logic_vector(15 downto 0);
		HXS_TRACE_S_WSHBN_0_DOWN_SEL : out std_logic_vector(3 downto 0);
		HXS_TRACE_S_WSHBN_0_DOWN_DATW : out std_logic_vector(31 downto 0);
		HXS_TRACE_S_WSHBN_0_DOWN_WE : out std_logic;
		HXS_TRACE_S_WSHBN_0_DOWN_STB : out std_logic;
		HXS_TRACE_S_WSHBN_0_DOWN_CYC : out std_logic;
		HXS_TRACE_S_WSHBN_0_UP_DATR : out std_logic_vector(31 downto 0);
		HXS_TRACE_S_WSHBN_0_UP_ACK : out std_logic;
		HXS_TRACE_S_WSHBN_0_HXS_EXTRA_UP_UNOCCUPIEDACK : out std_logic;
		HXS_TRACE_S_WSHBN_0_HXS_EXTRA_UP_TIMEOUTACK: out std_logic;
		HXS_TRACE_S_WSHBN_0_HXS_EXTRA_DOWN_SELECTS: out std_logic_vector(31 downto 0);
        Pulse : out std_logic;
        Failure : out std_logic
	);
end;

architecture Behavioural of PulseGeneratorPlainIfcWishboneWrapper is

	signal WishboneDown : T_PulseGeneratorPlainIfcWishboneDown;
	signal WishboneUp : T_PulseGeneratorPlainIfcWishboneUp;
	signal Trace : T_PulseGeneratorPlainIfcWishboneTrace;
	
    signal Clk : std_logic;
    signal Rst : std_logic;

begin
    
    Clk <= S_WSHBN_0_ACLK;
    Rst <= not S_WSHBN_0_ARESETN;

    i_PulseGeneratorPlainWishboneHxs : entity work.PulseGeneratorPlainWishboneHxs
    generic map (
        CLOCKS_UNTIL_CYCLE_TIMEOUT => 1023
    )
    port map (
        Clk => Clk,
        Rst => Rst,
        PulseGeneratorPlainWishboneDown => PulseGeneratorPlainWishboneDown,
        PulseGeneratorPlainWishboneUp => PulseGeneratorPlainWishboneUp,
        Pulse => Pulse,
        Failure => Failure
    );

	
	WishboneDown.Adr <= S_WSHBN_0_ADR;
	WishboneDown.Sel <= S_WSHBN_0_SEL;
	WishboneDown.DatIn <= S_WSHBN_0_DATW;
	WishboneDown.We <= S_WSHBN_0_WE;
	WishboneDown.Stb <= S_WSHBN_0_STB;
	WishboneDown.Cyc <= S_WSHBN_0_CYC;
	
	S_WSHBN_0_DATR <= WishboneUp.DatOut;
	S_WSHBN_0_ACK <= WishboneUp.Ack;
	
	HXS_TRACE_S_WSHBN_0_DOWN_ADR <= Trace.WishboneDown.Adr;
	HXS_TRACE_S_WSHBN_0_DOWN_SEL <= Trace.WishboneDown.Sel;
	HXS_TRACE_S_WSHBN_0_DOWN_DATW <= Trace.WishboneDown.DatIn;
	HXS_TRACE_S_WSHBN_0_DOWN_WE <= Trace.WishboneDown.We;
	HXS_TRACE_S_WSHBN_0_DOWN_STB <= Trace.WishboneDown.Stb;
	HXS_TRACE_S_WSHBN_0_DOWN_CYC <= Trace.WishboneDown.Cyc;
	
	HXS_TRACE_S_WSHBN_0_UP_DATR <= Trace.WishboneUp.DatOut;
	HXS_TRACE_S_WSHBN_0_UP_ACK <= Trace.WishboneUp.Ack;
	HXS_TRACE_S_WSHBN_0_HXS_EXTRA_UP_UNOCCUPIEDACK <= Trace.UnoccupiedAck;
	HXS_TRACE_S_WSHBN_0_HXS_EXTRA_UP_TIMEOUTACK <= Trace.TimeoutAck;
	
	HXS_TRACE_S_WSHBN_0_HXS_EXTRA_DOWN_SELECTS <= (others => '0');
	
	PulseGeneratorPlainBlkDown_PulseWidthNs <= PulseGeneratorPlainBlkDown.PulseWidthNs;
	PulseGeneratorPlainBlkDown_Operation <= PulseGeneratorPlainBlkDown.Operation;
	PulseGeneratorPlainBlkDown_PulsePeriodNs <= PulseGeneratorPlainBlkDown.PulsePeriodNs;

end;
