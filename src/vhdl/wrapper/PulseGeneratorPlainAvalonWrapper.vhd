library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

use work.PulseGeneratorPlainIfcAvalonPackage.all;

entity PulseGeneratorPlainIfcAvalonWrapper is
	generic (
		CLOCKS_UNTIL_CYCLE_TIMEOUT : integer := 1023
	);
	port (
		S_AVLN_0_ACLK : in std_logic;
		S_AVLN_0_ARESETN : in std_logic;
		S_AVLN_0_ADDRESS : in std_logic_vector(15 downto 0);
		S_AVLN_0_BYTEENABLE : in std_logic_vector(3 downto 0);
		S_AVLN_0_WRITE : in std_logic;
		S_AVLN_0_WRITEDATA : in std_logic_vector(31 downto 0);
        S_AVLN_0_READ : in std_logic;
        S_AVLN_0_READDATA : out std_logic_vector(31 downto 0);
		S_AVLN_0_WAITREQUEST : out std_logic;
		HXS_TRACE_S_AVLN_0_DOWN_ADDRESS : out std_logic_vector(15 downto 0);
		HXS_TRACE_S_AVLN_0_DOWN_BYTEENABLE : out std_logic_vector(3 downto 0);
		HXS_TRACE_S_AVLN_0_DOWN_WRITE : out std_logic;
		HXS_TRACE_S_AVLN_0_DOWN_WRITEDATA : out std_logic_vector(31 downto 0);
		HXS_TRACE_S_AVLN_0_DOWN_READ : out std_logic;
		HXS_TRACE_S_AVLN_0_UP_READDATA : out std_logic_vector(31 downto 0);
		HXS_TRACE_S_AVLN_0_UP_WAITREQUEST : out std_logic;
		HXS_TRACE_S_AVLN_0_UP_HXS_EXTRA_UNOCCUPIEDACK : out std_logic;
		HXS_TRACE_S_AVLN_0_UP_HXS_EXTRA_TIMEOUTACK : out std_logic;
		HXS_TRACE_S_AVLN_0_DOWN_HXS_EXTRA_SELECTS: out std_logic_vector(31 downto 0);
        Pulse : out std_logic;
        Failure : out std_logic
	);
end;

architecture Behavioural of PulseGeneratorPlainIfcAvalonWrapper is

	signal PulseGeneratorPlainAvalonDown : T_PulseGeneratorPlainIfcAvalonDown;
	signal PulseGeneratorPlainAvalonUp : T_PulseGeneratorPlainIfcAvalonUp;
	signal PulseGeneratorPlainAvalonTrace : T_PulseGeneratorPlainIfcAvalonTrace;

    signal Clk : std_logic;
    signal Rst : std_logic;
	
begin

    Clk <= S_AVLN_0_ACLK;
    Rst <= not S_AVLN_0_ARESETN;

	i_PulseGeneratorPlainAvalonHxs : entity work.PulseGeneratorPlainAvalonHxs
	generic map (
		CLOCKS_UNTIL_CYCLE_TIMEOUT => 1023
	)
	port map (
		Clk => Clk,
		Rst => Rst,
		PulseGeneratorPlainAvalonDown => PulseGeneratorPlainAvalonDown,
		PulseGeneratorPlainAvalonUp => PulseGeneratorPlainAvalonUp,
		Pulse => Pulse,
		Failure => Failure
	);
	
	AvalonDown.Address <= S_AVLN_0_ADDRESS;
	AvalonDown.ByteEnable <= S_AVLN_0_BYTEENABLE;
	AvalonDown.Write <= S_AVLN_0_WRITE;
	AvalonDown.WriteData <= S_AVLN_0_WRITEDATA;
	AvalonDown.Read <= S_AVLN_0_READ;
	
	S_AVLN_0_READDATA <= AvalonUp.ReadData;
	S_AVLN_0_WAITREQUEST <= AvalonUp.WaitRequest;
	
	HXS_TRACE_S_AVLN_0_DOWN_ADDRESS <= PulseGeneratorPlainAvalonTrace.AvalonDown.Address;
	HXS_TRACE_S_AVLN_0_DOWN_BYTEENABLE <= PulseGeneratorPlainAvalonTrace.AvalonDown.ByteEnable;
	HXS_TRACE_S_AVLN_0_DOWN_WRITE <= PulseGeneratorPlainAvalonTrace.AvalonDown.Write;
	HXS_TRACE_S_AVLN_0_DOWN_WRITEDATA <= PulseGeneratorPlainAvalonTrace.AvalonDown.WriteData;
	HXS_TRACE_S_AVLN_0_DOWN_READ <= PulseGeneratorPlainAvalonTrace.AvalonDown.Read;	
	HXS_TRACE_S_AVLN_0_UP_READDATA <= PulseGeneratorPlainAvalonTrace.AvalonUp.ReadData;
	HXS_TRACE_S_AVLN_0_UP_WAITREQUEST <= PulseGeneratorPlainAvalonTrace.AvalonUp.WaitRequest;
	HXS_TRACE_S_AVLN_0_UP_HXS_EXTRA_UNOCCUPIEDACK <= PulseGeneratorPlainAvalonTrace.UnoccupiedAck;
	HXS_TRACE_S_AVLN_0_UP_HXS_EXTRA_TIMEOUTACK <= PulseGeneratorPlainAvalonTrace.TimeoutAck;
	
	HXS_TRACE_S_AVLN_0_DOWN_HXS_EXTRA_SELECTS <= (others => '0');

end;
