library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

use work.PulseGeneratorPlainIfcBusRecordsPackage.all;

entity PulseGeneratorPlainAxi4LiteWrapper is
    generic (
        CLOCKS_UNTIL_CYCLE_TIMEOUT : integer := 1023
    );
    port (
        S_AXI_0_ACLK : in std_logic;
        S_AXI_0_ARESETN : in std_logic;
        S_AXI_0_AWVALID : in std_logic;
        S_AXI_0_AWADDR : in std_logic_vector(15 downto 0);
        S_AXI_0_AWPROT : in std_logic_vector(2 downto 0);
        S_AXI_0_WVALID : in std_logic;
        S_AXI_0_WDATA : in std_logic_vector(31 downto 0);
        S_AXI_0_WSTRB : in std_logic_vector(3 downto 0);
        S_AXI_0_BREADY : in std_logic;
        S_AXI_0_ARVALID : in std_logic;
        S_AXI_0_ARADDR : in std_logic_vector(15 downto 0);
        S_AXI_0_ARPROT : in std_logic_vector(2 downto 0);
        S_AXI_0_RREADY : in std_logic;
        S_AXI_0_AWREADY : out std_logic;
        S_AXI_0_WREADY : out std_logic;
        S_AXI_0_BVALID : out std_logic;
        S_AXI_0_BRESP : out std_logic_vector(1 downto 0);
        S_AXI_0_ARREADY : out std_logic;
        S_AXI_0_RVALID : out std_logic;
        S_AXI_0_RDATA : out std_logic_vector(31 downto 0);
        S_AXI_0_RRESP : out std_logic_vector(1 downto 0);
        S_AXI_0_WritePrivileged : out std_logic;
        S_AXI_0_WriteSecure : out std_logic;
        S_AXI_0_WriteInstruction : out std_logic;
        S_AXI_0_ReadPrivileged : out std_logic;
        S_AXI_0_ReadSecure : out std_logic;
        S_AXI_0_ReadInstruction : out std_logic;
        HXS_TRACE_S_AXI_0_DOWN_AWVALID : out std_logic;
        HXS_TRACE_S_AXI_0_DOWN_AWADDR : out std_logic_vector(15 downto 0);
        HXS_TRACE_S_AXI_0_DOWN_AWPROT : out std_logic_vector(2 downto 0);
        HXS_TRACE_S_AXI_0_DOWN_WVALID : out std_logic;
        HXS_TRACE_S_AXI_0_DOWN_WDATA : out std_logic_vector(31 downto 0);
        HXS_TRACE_S_AXI_0_DOWN_WSTRB : out std_logic_vector(3 downto 0);
        HXS_TRACE_S_AXI_0_DOWN_BREADY : out std_logic;
        HXS_TRACE_S_AXI_0_DOWN_ARVALID : out std_logic;
        HXS_TRACE_S_AXI_0_DOWN_ARADDR : out std_logic_vector(15 downto 0);
        HXS_TRACE_S_AXI_0_DOWN_ARPROT : out std_logic_vector(2 downto 0);
        HXS_TRACE_S_AXI_0_DOWN_RREADY : out std_logic;
        HXS_TRACE_S_AXI_0_UP_AWREADY : out std_logic;
        HXS_TRACE_S_AXI_0_UP_WREADY : out std_logic;
        HXS_TRACE_S_AXI_0_UP_BVALID : out std_logic;
        HXS_TRACE_S_AXI_0_UP_BRESP : out std_logic_vector(1 downto 0);
        HXS_TRACE_S_AXI_0_UP_ARREADY : out std_logic;
        HXS_TRACE_S_AXI_0_UP_RVALID : out std_logic;
        HXS_TRACE_S_AXI_0_UP_RDATA : out std_logic_vector(31 downto 0);
        HXS_TRACE_S_AXI_0_UP_RRESP : out std_logic_vector(1 downto 0);
        HXS_TRACE_S_AXI_0_ACCESS_DOWN_WRITEPRIVILEGED : out std_logic;
        HXS_TRACE_S_AXI_0_ACCESS_DOWN_WRITESECURE : out std_logic;
        HXS_TRACE_S_AXI_0_ACCESS_DOWN_WRITEINSTRUCTION : out std_logic;
        HXS_TRACE_S_AXI_0_ACCESS_DOWN_READPRIVILEGED : out std_logic;
        HXS_TRACE_S_AXI_0_ACCESS_DOWN_READSECURE : out std_logic;
        HXS_TRACE_S_AXI_0_ACCESS_DOWN_READINSTRUCTION : out std_logic;
        HXS_TRACE_S_AXI_0_HXS_EXTRA_UP_UNOCCUPIEDACK : out std_logic;
        HXS_TRACE_S_AXI_0_HXS_EXTRA_UP_TIMEOUTACK : out std_logic;
        HXS_TRACE_S_AXI_0_HXS_EXTRA_DOWN_SELECTS : out std_logic_vector(31 downto 0);
        Pulse : out std_logic;
        Failure : out std_logic
    );
end;

architecture Behavioural of PulseGeneratorPlainIfcAxi4LiteWrapper is

    signal Axi4LiteDown : T_PulseGeneratorPlainIfcAxi4LiteDown;
    signal Axi4LiteUp : T_PulseGeneratorPlainIfcAxi4LiteUp;
    signal Trace : T_PulseGeneratorPlainIfcAxi4LiteTrace;
    signal PulseGeneratorPlainBlkDown : T_PulseGeneratorPlainIfcPulseGeneratorPlainBlkDown;
    signal Axi4LiteAccess : T_PulseGeneratorPlainIfcAxi4LiteAccess;
    
    signal Clk : std_logic;
    signal Rst : std_logic;

begin

    Clk <= S_AXI_0_ACLK;
    Rst <= not S_AXI_0_ARESETN;

    i_PulseGeneratorPlainAxi4LiteHxs : entity work.PulseGeneratorPlainAxi4LiteHxs
    generic map (
        CLOCKS_UNTIL_CYCLE_TIMEOUT => 1023
    )
    port map (
        Clk => Clk,
        Rst => Rst,
        PulseGeneratorPlainAxi4LiteDown => PulseGeneratorPlainAxi4LiteDown,
        PulseGeneratorPlainAxi4LiteUp => PulseGeneratorPlainAxi4LiteUp,
        Pulse => Pulse,
        Failure => Failure
    );
    
    Axi4LiteDown.AWVALID <= S_AXI_0_AWVALID;
    Axi4LiteDown.AWADDR <= S_AXI_0_AWADDR;
    Axi4LiteDown.AWPROT <= S_AXI_0_AWPROT;
    Axi4LiteDown.WVALID <= S_AXI_0_WVALID;
    Axi4LiteDown.WDATA <= S_AXI_0_WDATA;
    Axi4LiteDown.WSTRB <= S_AXI_0_WSTRB;
    Axi4LiteDown.BREADY <= S_AXI_0_BREADY;
    Axi4LiteDown.ARVALID <= S_AXI_0_ARVALID;
    Axi4LiteDown.ARADDR <= S_AXI_0_ARADDR;
    Axi4LiteDown.ARPROT <= S_AXI_0_ARPROT;
    Axi4LiteDown.RREADY <= S_AXI_0_RREADY;
    
    S_AXI_0_AWREADY <= Axi4LiteUp.AWREADY;
    S_AXI_0_WREADY <= Axi4LiteUp.WREADY;
    S_AXI_0_BVALID <= Axi4LiteUp.BVALID;
    S_AXI_0_BRESP <= Axi4LiteUp.BRESP;
    S_AXI_0_ARREADY <= Axi4LiteUp.ARREADY;
    S_AXI_0_RVALID <= Axi4LiteUp.RVALID;
    S_AXI_0_RDATA <= Axi4LiteUp.RDATA;
    S_AXI_0_RRESP <= Axi4LiteUp.RRESP;
    
    WritePrivileged <= Axi4LiteAccess.WritePrivileged;
    WriteSecure <= Axi4LiteAccess.WriteSecure;
    WriteInstruction <= Axi4LiteAccess.WriteInstruction;
    ReadPrivileged<= Axi4LiteAccess.ReadPrivileged;
    ReadSecure <= Axi4LiteAccess.ReadPrivileged;
    ReadInstruction <= Axi4LiteAccess.ReadInstruction;
    
    HXS_TRACE_S_AXI_0_DOWN_AWVALID <= Trace.Axi4LiteDown.AWVALID;
    HXS_TRACE_S_AXI_0_DOWN_AWADDR <= Trace.Axi4LiteDown.AWADDR;
    HXS_TRACE_S_AXI_0_DOWN_AWPROT <= Trace.Axi4LiteDown.AWPROT;
    HXS_TRACE_S_AXI_0_DOWN_WVALID <= Trace.Axi4LiteDown.WVALID;
    HXS_TRACE_S_AXI_0_DOWN_WDATA <= Trace.Axi4LiteDown.WDATA;
    HXS_TRACE_S_AXI_0_DOWN_WSTRB <= Trace.Axi4LiteDown.WSTRB;
    HXS_TRACE_S_AXI_0_DOWN_BREADY <= Trace.Axi4LiteDown.BREADY;
    HXS_TRACE_S_AXI_0_DOWN_ARVALID <= Trace.Axi4LiteDown.ARVALID;
    HXS_TRACE_S_AXI_0_DOWN_ARADDR <= Trace.Axi4LiteDown.ARADDR;
    HXS_TRACE_S_AXI_0_DOWN_ARPROT <= Trace.Axi4LiteDown.ARPROT;
    HXS_TRACE_S_AXI_0_DOWN_RREADY <= Trace.Axi4LiteDown.RREADY;
    
    HXS_TRACE_S_AXI_0_UP_AWREADY <= Trace.Axi4LiteUp.AWREADY;
    HXS_TRACE_S_AXI_0_UP_WREADY <= Trace.Axi4LiteUp.WREADY;
    HXS_TRACE_S_AXI_0_UP_BVALID <= Trace.Axi4LiteUp.BVALID;
    HXS_TRACE_S_AXI_0_UP_BRESP <= Trace.Axi4LiteUp.BRESP;
    HXS_TRACE_S_AXI_0_UP_ARREADY <= Trace.Axi4LiteUp.ARREADY;
    HXS_TRACE_S_AXI_0_UP_RVALID <= Trace.Axi4LiteUp.RVALID;
    HXS_TRACE_S_AXI_0_UP_RDATA <= Trace.Axi4LiteUp.RDATA;
    HXS_TRACE_S_AXI_0_UP_RRESP <= Trace.Axi4LiteUp.RRESP;
    
    HXS_TRACE_S_AXI_0_ACCESS_DOWN_WRITEPRIVILEGED <= Trace.Axi4LiteAccess.WritePrivileged;
    HXS_TRACE_S_AXI_0_ACCESS_DOWN_WRITESECURE <= Trace.Axi4LiteAccess.WriteSecure;
    HXS_TRACE_S_AXI_0_ACCESS_DOWN_WRITEINSTRUCTION <= Trace.Axi4LiteAccess.WriteInstruction;
    HXS_TRACE_S_AXI_0_ACCESS_DOWN_READPRIVILEGED<= Trace.Axi4LiteAccess.ReadPrivileged;
    HXS_TRACE_S_AXI_0_ACCESS_DOWN_READSECURE <= Trace.Axi4LiteAccess.ReadPrivileged;
    HXS_TRACE_S_AXI_0_ACCESS_DOWN_READINSTRUCTION <= Trace.Axi4LiteAccess.ReadInstruction;
    HXS_TRACE_S_AXI_0_HXS_EXTRA_UP_UNOCCUPIEDACK <= Trace.UnoccupiedAck;
    HXS_TRACE_S_AXI_0_HXS_EXTRA_UP_TIMEOUTACK <= Trace.TimeoutAck;
    
    HXS_TRACE_S_AXI_0_HXS_EXTRA_DOWN_SELECTS <= (others => '0');
    
    PulseGeneratorPlainBlkDown_PulseWidthNs <= PulseGeneratorPlainBlkDown.PulseWidthNs;
    PulseGeneratorPlainBlkDown_Operation <= PulseGeneratorPlainBlkDown.Operation;
    PulseGeneratorPlainBlkDown_PulsePeriodNs <= PulseGeneratorPlainBlkDown.PulsePeriodNs;

end;
