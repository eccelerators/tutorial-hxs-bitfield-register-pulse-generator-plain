library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

use work.PulseGeneratorPlainIfcAvalonPackage.all;
use work.PulseGeneratorPlainIfcUserPackage.all;

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
		PulseGeneratorPlainBlkDown_Operation : out std_logic_vector(1 downto 0);
		PulseGeneratorPlainBlkDown_PulsePeriodNs : out std_logic_vector(31 downto 0);
		PulseGeneratorPlainBlkDown_PulseWidthNs : out std_logic_vector(31 downto 0)
	);
end;

architecture Behavioural of PulseGeneratorPlainIfcAvalonWrapper is

	signal AvalonDown : T_PulseGeneratorPlainIfcAvalonDown;
	signal AvalonUp : T_PulseGeneratorPlainIfcAvalonUp;
	signal Trace : T_PulseGeneratorPlainIfcAvalonTrace;
	signal PulseGeneratorPlainBlkDown : T_PulseGeneratorPlainIfcAvalonPulseGeneratorPlainBlkDown;

begin

	PulseGeneratorPlainIfcAvalon_i : entity work.PulseGeneratorPlainIfcAvalon
	generic map (
		CLOCKS_UNTIL_CYCLE_TIMEOUT => 1023
	)
	port map (
		Clk => Clk,
		Rst => Rst,
		AvalonDown => AvalonDown,
		AvalonUp => AvalonUp,
		Trace => Trace,
		PulseGeneratorPlainBlkDown => PulseGeneratorPlainBlkDown
	);
	
	AvalonDown.Address <= Address;
	AvalonDown.ByteEnable <= ByteEnable;
	AvalonDown.Write <= Write;
	AvalonDown.WriteData <= WriteData;
	AvalonDown.Read <= Read;
	
	ReadData <= AvalonUp.ReadData;
	WaitRequest <= AvalonUp.WaitRequest;
	
	Trace_AvalonDown_Address <= Trace.AvalonDown.Address;
	Trace_AvalonDown_ByteEnable <= Trace.AvalonDown.ByteEnable;
	Trace_AvalonDown_Write <= Trace.AvalonDown.Write;
	Trace_AvalonDown_WriteData <= Trace.AvalonDown.WriteData;
	Trace_AvalonDown_Read <= Trace.AvalonDown.Read;
	
	Trace_AvalonUp_ReadData <= Trace.AvalonUp.ReadData;
	Trace_AvalonUp_WaitRequest <= Trace.AvalonUp.WaitRequest;
	Trace_UnoccupiedAck <= Trace.UnoccupiedAck;
	Trace_TimeoutAck <= Trace.TimeoutAck;
	
	PulseGeneratorPlainBlkDown_Operation <= PulseGeneratorPlainBlkDown.Operation;
	PulseGeneratorPlainBlkDown_PulsePeriodNs <= PulseGeneratorPlainBlkDown.PulsePeriodNs;
	PulseGeneratorPlainBlkDown_PulseWidthNs <= PulseGeneratorPlainBlkDown.PulseWidthNs;

end;
