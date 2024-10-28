-- Copyright (C) 2024 Eccelerators GmbH
-- 
-- This code was generated by:
--
-- HxS Compiler v0.0.0-0000000
-- VHDL Extension for HxS v0.0.0-0000000
-- 
-- Further information at https://eccelerators.com/hxs
-- 
-- Changes to this file may cause incorrect behavior and will be lost if the
-- code is regenerated.
library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;


package PulseGeneratorPlainIfcWishbonePackage is

	type T_PulseGeneratorPlainIfcWishboneDown is
	record
		Adr : std_logic_vector(15 downto 0);
		Sel : std_logic_vector(3 downto 0);
		DatIn : std_logic_vector(31 downto 0);
		We : std_logic;
		Stb : std_logic;
		Cyc : std_logic;
	end record;
	
	type T_PulseGeneratorPlainIfcWishboneUp is
	record
		DatOut : std_logic_vector(31 downto 0);
		Ack : std_logic;
	end record;
	
end;
