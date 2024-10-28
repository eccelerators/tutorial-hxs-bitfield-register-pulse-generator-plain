library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

use work.PulseGeneratorPlainIfcPackage.all;

entity PulseGeneratorPlainIfcAxi4LiteWrapper is
	generic (
		CLOCKS_UNTIL_CYCLE_TIMEOUT : integer := 1023
	);
	port (
		Clk : in std_logic;
		Rst : in std_logic;
		AWVALID : in std_logic;
		AWADDR : in std_logic_vector(15 downto 0);
		AWPROT : in std_logic_vector(2 downto 0);
		WVALID : in std_logic;
		WDATA : in std_logic_vector(31 downto 0);
		WSTRB : in std_logic_vector(3 downto 0);
		BREADY : in std_logic;
		ARVALID : in std_logic;
		ARADDR : in std_logic_vector(15 downto 0);
		ARPROT : in std_logic_vector(2 downto 0);
		RREADY : in std_logic;
		AWREADY : out std_logic;
		WREADY : out std_logic;
		BVALID : out std_logic;
		BRESP : out std_logic_vector(1 downto 0);
		ARREADY : out std_logic;
		RVALID : out std_logic;
		RDATA : out std_logic_vector(31 downto 0);
		RRESP : out std_logic_vector(1 downto 0);
		WritePrivileged : out std_logic;
		WriteSecure : out std_logic;
		WriteInstruction : out std_logic;
		ReadPrivileged : out std_logic;
		ReadSecure : out std_logic;
		ReadInstruction : out std_logic;
		Trace_Axi4LiteDown_AWVALID : out std_logic;
		Trace_Axi4LiteDown_AWADDR : out std_logic_vector(15 downto 0);
		Trace_Axi4LiteDown_AWPROT : out std_logic_vector(2 downto 0);
		Trace_Axi4LiteDown_WVALID : out std_logic;
		Trace_Axi4LiteDown_WDATA : out std_logic_vector(31 downto 0);
		Trace_Axi4LiteDown_WSTRB : out std_logic_vector(3 downto 0);
		Trace_Axi4LiteDown_BREADY : out std_logic;
		Trace_Axi4LiteDown_ARVALID : out std_logic;
		Trace_Axi4LiteDown_ARADDR : out std_logic_vector(15 downto 0);
		Trace_Axi4LiteDown_ARPROT : out std_logic_vector(2 downto 0);
		Trace_Axi4LiteDown_RREADY : out std_logic;
		Trace_Axi4LiteUp_AWREADY : out std_logic;
		Trace_Axi4LiteUp_WREADY : out std_logic;
		Trace_Axi4LiteUp_BVALID : out std_logic;
		Trace_Axi4LiteUp_BRESP : out std_logic_vector(1 downto 0);
		Trace_Axi4LiteUp_ARREADY : out std_logic;
		Trace_Axi4LiteUp_RVALID : out std_logic;
		Trace_Axi4LiteUp_RDATA : out std_logic_vector(31 downto 0);
		Trace_Axi4LiteUp_RRESP : out std_logic_vector(1 downto 0);
		Trace_Axi4LiteAccess_WritePrivileged : out std_logic;
		Trace_Axi4LiteAccess_WriteSecure : out std_logic;
		Trace_Axi4LiteAccess_WriteInstruction : out std_logic;
		Trace_Axi4LiteAccess_ReadPrivileged : out std_logic;
		Trace_Axi4LiteAccess_ReadSecure : out std_logic;
		Trace_Axi4LiteAccess_ReadInstruction : out std_logic;
		Trace_UnoccupiedAck : out std_logic;
		Trace_TimeoutAck : out std_logic;
        Pulse : out std_logic;
        Failure : out std_logic
	);
end;

architecture Behavioural of PulseGeneratorPlainIfcAxi4LiteWrapper is

	signal PulseGeneratorPlainAxi4LiteDown : T_PulseGeneratorPlainIfcAxi4LiteDown;
	signal PulseGeneratorPlainAxi4LiteUp : T_PulseGeneratorPlainIfcAxi4LiteUp;
	signal PulseGeneratorPlainAxi4LiteTrace : T_PulseGeneratorPlainIfcAxi4LiteTrace;

begin

	i_PulseGeneratorPlainAxi4LiteHxs : entity work.PulseGeneratorPlainAxi4LiteHxs
	generic map (
		CLOCKS_UNTIL_CYCLE_TIMEOUT => 1023
	)
	port map (
		Clk => Clk,
		Rst => Rst,
		PulseGeneratorPlainAxi4LiteDown => PulseGeneratorPlainAxi4LiteDown,
		PulseGeneratorPlainAxi4LiteUp => PulseGeneratorPlainAxi4LiteUp,
		PulseGeneratorPlainAxi4LiteTrace => PulseGeneratorPlainAxi4LiteTrace,
        Pulse => Pulse,
        Failure => Failure
	);
	
	PulseGeneratorPlainAxi4LiteDown.AWVALID <= AWVALID;
	PulseGeneratorPlainAxi4LiteDown.AWADDR <= AWADDR;
	PulseGeneratorPlainAxi4LiteDown.AWPROT <= AWPROT;
	PulseGeneratorPlainAxi4LiteDown.WVALID <= WVALID;
	PulseGeneratorPlainAxi4LiteDown.WDATA <= WDATA;
	PulseGeneratorPlainAxi4LiteDown.WSTRB <= WSTRB;
	PulseGeneratorPlainAxi4LiteDown.BREADY <= BREADY;
	PulseGeneratorPlainAxi4LiteDown.ARVALID <= ARVALID;
	PulseGeneratorPlainAxi4LiteDown.ARADDR <= ARADDR;
	PulseGeneratorPlainAxi4LiteDown.ARPROT <= ARPROT;
	PulseGeneratorPlainAxi4LiteDown.RREADY <= RREADY;
	
	AWREADY <= PulseGeneratorPlainAxi4LiteUp.AWREADY;
	WREADY <= PulseGeneratorPlainAxi4LiteUp.WREADY;
	BVALID <= PulseGeneratorPlainAxi4LiteUp.BVALID;
	BRESP <= PulseGeneratorPlainAxi4LiteUp.BRESP;
	ARREADY <= PulseGeneratorPlainAxi4LiteUp.ARREADY;
	RVALID <= PulseGeneratorPlainAxi4LiteUp.RVALID;
	RDATA <= PulseGeneratorPlainAxi4LiteUp.RDATA;
	RRESP <= PulseGeneratorPlainAxi4LiteUp.RRESP;
		
	Trace_Axi4LiteDown_AWVALID <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteDown.AWVALID;
	Trace_Axi4LiteDown_AWADDR <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteDown.AWADDR;
	Trace_Axi4LiteDown_AWPROT <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteDown.AWPROT;
	Trace_Axi4LiteDown_WVALID <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteDown.WVALID;
	Trace_Axi4LiteDown_WDATA <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteDown.WDATA;
	Trace_Axi4LiteDown_WSTRB <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteDown.WSTRB;
	Trace_Axi4LiteDown_BREADY <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteDown.BREADY;
	Trace_Axi4LiteDown_ARVALID <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteDown.ARVALID;
	Trace_Axi4LiteDown_ARADDR <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteDown.ARADDR;
	Trace_Axi4LiteDown_ARPROT <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteDown.ARPROT;
	Trace_Axi4LiteDown_RREADY <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteDown.RREADY;
	
	Trace_Axi4LiteUp_AWREADY <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteUp.AWREADY;
	Trace_Axi4LiteUp_WREADY <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteUp.WREADY;
	Trace_Axi4LiteUp_BVALID <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteUp.BVALID;
	Trace_Axi4LiteUp_BRESP <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteUp.BRESP;
	Trace_Axi4LiteUp_ARREADY <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteUp.ARREADY;
	Trace_Axi4LiteUp_RVALID <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteUp.RVALID;
	Trace_Axi4LiteUp_RDATA <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteUp.RDATA;
	Trace_Axi4LiteUp_RRESP <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteUp.RRESP;
	
	Trace_Axi4LiteAccess_WritePrivileged <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteAccess.WritePrivileged;
	Trace_Axi4LiteAccess_WriteSecure <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteAccess.WriteSecure;
	Trace_Axi4LiteAccess_WriteInstruction <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteAccess.WriteInstruction;
	Trace_Axi4LiteAccess_ReadPrivileged<= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteAccess.ReadPrivileged;
	Trace_Axi4LiteAccess_ReadSecure <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteAccess.ReadPrivileged;
	Trace_Axi4LiteAccess_ReadInstruction <= PulseGeneratorPlainAxi4LiteTrace.Axi4LiteAccess.ReadInstruction;
	Trace_UnoccupiedAck <= PulseGeneratorPlainAxi4LiteTrace.UnoccupiedAck;
	Trace_TimeoutAck <= PulseGeneratorPlainAxi4LiteTrace.TimeoutAck;

end;
