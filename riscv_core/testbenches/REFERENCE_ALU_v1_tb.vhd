-- Bohdan Purtell
-- University of Florida
-- VHDL testbench for ALU
-- STATUS: Verified & Working

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_tb is
end entity;

architecture tb of alu_tb is
    component alu_v1 is
        port (
            OP_CODE : in std_logic_vector(5 downto 0);
            -- function code fed by the ALU CU 

            SHAMT_IN : in std_logic_vector(4 downto 0);
            -- IR[10:6] -> when this is a sll or srl command, this will be read as the shift amount

            A, B : in std_logic_vector(31 downto 0);
            -- inputs qui sont utiliser avec les registres

            RESULT_OUT, RESULT_HI_OUT : out std_logic_vector(31 downto 0);
            -- set des sorties de faire les réferences

            BRANCH_TAKEN : out std_logic;
            -- quand on utiliser subtraction mode pour les comparisons, branch_taken indicate que les trucs sont égales

            ALU_ERROR_VECTOR : out std_logic_vector(7 downto 0)
            -- standard erreur vector utilisants
            -- 1A non_standard natural mode written
            -- 1B unfamiliar ALU function code (in R-type mode)
        );
    end component;

    signal tb_clk : std_logic := '0';
    signal tb_rst : std_logic;
    signal clk_en : std_logic := '1';
    signal tb_opcode : std_logic_vector(5 downto 0);
    signal tb_shamt : std_logic_vector(4 downto 0);
    signal tb_A, tb_B : std_logic_vector(31 downto 0);
    signal tb_result_lo, tb_result_hi, tb_result : std_logic_vector(31 downto 0);
    signal tb_br : std_logic;

    function vectorize32(x : integer) return std_logic_vector is
    begin
        return std_logic_vector(to_unsigned(x, 32));
    end function;

    function vectorize6(x : integer) return std_logic_vector is
    begin
        return std_logic_vector(to_unsigned(x, 6));
    end function;

begin
    DUT : alu_v1
        port map(
            OP_CODE => tb_opcode,
            SHAMT_IN => tb_shamt,
            A => tb_A,
            B => tb_B,
            RESULT_OUT => tb_result,
            RESULT_HI_OUT => tb_result_hi,
            BRANCH_TAKEN => tb_br 
    );

    -- clk proc
    tb_clk <= clk_en and not tb_clk after 5 ns;

    stim_proc : process
    begin
        report "testing addu";
        clk_en <= '1';
        tb_A <= vectorize32(10);
        tb_B <= vectorize32(15);
        tb_opcode <= vectorize6(33);
        wait for 10 ns;

        report "testing srl 2";
        tb_A <= vectorize32(8);
        --report "testing addu 2";
        --tb_A <= vectorize32(11);
        --tb_B <= vectorize32(12);
        --tb_opcode <= vectorize6(33);
        --wait for 10 ns;

        --report "testing subu";
        --tb_A <= vectorize32(25);
        --tb_B <= vectorize32(10);
        --tb_opcode <= vectorize6(35);
        --wait for 10 ns;

        --report "testing signed mult";
        --tb_A <= vectorize32(10);
        --tb_B <= std_logic_vector(to_signed(-4, 32));
        --tb_opcode <= vectorize6(24);
        --wait for 10 ns;

        --report "testing unsigned mult";
        --tb_A <= vectorize32(65536);
        --tb_B <= vectorize32(131072);
        --tb_opcode <= vectorize6(25);
        --wait for 10 ns;

        --report "testing logical AND";
        --tb_A <= x"0000FFFF";
        --tb_B <= x"FFFF1234";
        --tb_opcode <= vectorize6(36);
        --wait for 10 ns;

        --report "testing srl 2";
        --tb_A <= x"0000000F";
        --tb_A <= vectorize32(15);
        --tb_shamt <= "00010";
        --tb_opcode <= vectorize6(2);
        --wait for 10 ns;

        --report "testing sra 1";
        --tb_A <= x"F0000008";
        ---- tb_A <= vectorize32(15);
        --tb_shamt <= "00001";
        --tb_opcode <= vectorize6(3);

        --report "testing sra 2";
        --tb_A <= x"00000008";
        ---- tb_A <= vectorize32(15);
        --tb_shamt <= "00001";
        --tb_opcode <= vectorize6(3);
        --wait for 10 ns;

        --report "testing compare AB 1";
        --tb_A <= vectorize32(10);
        --tb_B <= vectorize32(15);
        --tb_opcode <= vectorize6(170);
        --wait for 10 ns;

        --report "testing compare AB 2";
        --tb_A <= vectorize32(15);
        --tb_B <= vectorize32(10);
        --tb_opcode <= vectorize6(170);
        --wait for 10 ns;

        --report "testing for blez";
        --tb_A <= vectorize32(5);
        --tb_opcode <= vectorize6(6);
        --wait for 10 ns;

        --report "testing for bgtz";
        --tb_A <= vectorize32(5);
        --tb_opcode <= vectorize6(7);
        --wait for 10 ns;

        clk_en <= '0';
        wait;
    end process;
    
end architecture tb;

