library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

use work.PulseGeneratorPlainIfcAvalonPackage.all;

entity PulseGeneratorPlainIfcAvalonWrapper is
	generic (
		CLOCKS_UNTIL_CYCLE_TIMEOUT : integer := 1023
	);
	port (
		Clk : in std_logic;
		Rst : in std_logic;
		Address : in std_logic_vector(15 downto 0);
		ByteEnable : in std_logic_vector(3 downto 0);
		Read : in std_logic;
		ReadData : out std_logic_vector(31 downto 0);
		Write : in std_logic;
		WriteData : in std_logic_vector(31 downto 0);
		WaitRequest : out std_logic;
		Trace_AvalonDown_Address : out std_logic_vector(15 downto 0);
		Trace_AvalonDown_ByteEnable : out std_logic_vector(3 downto 0);
		Trace_AvalonDown_Write : out std_logic;
		Trace_AvalonDown_WriteData : out std_logic_vector(31 downto 0);
		Trace_AvalonDown_Read : out std_logic;
		Trace_AvalonUp_ReadData : out std_logic_vector(31 downto 0);
		Trace_AvalonUp_WaitRequest : out std_logic;
		Trace_UnoccupiedAck : out std_logic;
		Trace_TimeoutAck : out std_logic;
        Pulse : out std_logic;
        Failure : out std_logic
	);
end;

architecture Behavioural of PulseGeneratorPlainIfcAvalonWrapper is

	signal PulseGeneratorPlainAvalonDown : T_PulseGeneratorPlainIfcAvalonDown;
	signal PulseGeneratorPlainAvalonUp : T_PulseGeneratorPlainIfcAvalonUp;
	signal PulseGeneratorPlainAvalonTrace : T_PulseGeneratorPlainIfcAvalonTrace;
	
begin

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
	
	AvalonDown.Address <= Address;
	AvalonDown.ByteEnable <= ByteEnable;
	AvalonDown.Write <= Write;
	AvalonDown.WriteData <= WriteData;
	AvalonDown.Read <= Read;
	
	ReadData <= AvalonUp.ReadData;
	WaitRequest <= AvalonUp.WaitRequest;
	
	Trace_AvalonDown_Address <= PulseGeneratorPlainAvalonTrace.AvalonDown.Address;
	Trace_AvalonDown_ByteEnable <= PulseGeneratorPlainAvalonTrace.AvalonDown.ByteEnable;
	Trace_AvalonDown_Write <= PulseGeneratorPlainAvalonTrace.AvalonDown.Write;
	Trace_AvalonDown_WriteData <= PulseGeneratorPlainAvalonTrace.AvalonDown.WriteData;
	Trace_AvalonDown_Read <= PulseGeneratorPlainAvalonTrace.AvalonDown.Read;	
	Trace_AvalonUp_ReadData <= PulseGeneratorPlainAvalonTrace.AvalonUp.ReadData;
	Trace_AvalonUp_WaitRequest <= PulseGeneratorPlainAvalonTrace.AvalonUp.WaitRequest;
	Trace_UnoccupiedAck <= PulseGeneratorPlainAvalonTrace.UnoccupiedAck;
	Trace_TimeoutAck <= PulseGeneratorPlainAvalonTrace.TimeoutAck;

end;
