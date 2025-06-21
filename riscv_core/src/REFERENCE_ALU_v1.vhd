-- Bohdan Purtell
-- University of Florida
-- Purpose: Beat Nathaniel Downes in a bet
-- Description: file code for the ALU
-- STATUS: Verified & Working

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.STD_LOGIC_UNSIGNED.all;

entity alu_v1 is
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
end alu_v1;

architecture RTL of alu_v1 is
    -- registers for intermediate between process updates
    --signal HI_register, LO_register : std_logic_vector(31 downto 0) := (others => '0');
begin
    process (OP_CODE, A, B, SHAMT_IN)
    -- intermediate varibles for the process
        variable prod_signed   : signed(63 downto 0);
        variable prod_unsigned : unsigned(63 downto 0);
        variable shamt         : integer;
        variable cheese_holder : std_logic_vector(32 downto 0);
        variable cheese_holder2 : std_logic_vector(30 downto 0);
    begin
        -- defaults
        RESULT_OUT <= (others => '0'); -- shouldn't have latching issues anyways
        RESULT_HI_OUT <= (others => '0');
        branch_taken <= '0'; -- necessary default

        case OP_CODE is
            when "000000" => -- done for deliverable
                -- 0x00
                -- sll
                RESULT_OUT <= std_logic_vector(shift_left(unsigned(B), to_integer(unsigned(SHAMT_IN))));

            when "000010" => -- done for deliverable
                -- 0x02
                -- srl
                -- shamt := TO_INTEGER(unsigned(SHAMT_IN(4 downto 0)));
                -- RESULT_OUT <= std_logic_vector(shift_right(unsigned(A), shamt));
                RESULT_OUT <= std_logic_vector(shift_right(unsigned(B), to_integer(unsigned(SHAMT_IN))));

            when "000011" => -- done for deliverable
                -- 0x03
                -- sra
                cheese_holder2 := B(30 downto 0);
                RESULT_OUT(30 downto 0) <= std_logic_vector(shift_right(unsigned(cheese_holder2), to_integer(unsigned(SHAMT_IN))));
                RESULT_OUT(31) <= B(31);


            when "011000" => -- done for deliverable
                -- 0x18
                -- mult - signed
                prod_signed := signed(A) * signed(B);
                RESULT_OUT    <= std_logic_vector(prod_signed(31 downto 0));
                RESULT_HI_OUT <= std_logic_vector(prod_signed(63 downto 32));

            when "011001" => -- done for deliverable
                -- 0x19
                -- multu
                prod_unsigned := unsigned(A) * unsigned(B);
                RESULT_OUT    <= std_logic_vector(prod_unsigned(31 downto 0));
                RESULT_HI_OUT <= std_logic_vector(prod_unsigned(63 downto 32));

            when "100001" => -- done for deliverable
                -- 0x21
                -- addu
                RESULT_OUT <= std_logic_vector(unsigned(A) + unsigned(B));

            when "100011" => -- done for deliverable
                -- 0x23
                -- subu
                cheese_holder := ("0" & A) - ("0" & B);
                RESULT_OUT <= cheese_holder(31 downto 0);

            when "100100" => -- done for deliverable
                -- 0x24
                -- and
                RESULT_OUT <= A and B;

            when "100101" => -- done
                -- 0x25
                -- or
                RESULT_OUT <= A or B;

            when "100110" => -- done
                -- 0x26 
                -- xor
                RESULT_OUT <= A xor B;

            when "101010" => -- done for deliverable
                -- 0x2A
                -- slt
                if signed(A) < signed(B) then
                  RESULT_OUT <= x"00000001";
                else
                  RESULT_OUT <= x"00000000";
                end if;

            when "101011" =>
                -- 0x2B
                -- sltu
                if unsigned(A) < unsigned(B) then
                  RESULT_OUT <= x"00000001";
                else
                  RESULT_OUT <= x"00000000";
                end if;

            when "000110" =>
                -- 0x06
                -- bltz
                if unsigned(A) < 0 then
                    BRANCH_TAKEN <= '1';
                end if;

            when "000111" => 
                -- 0x07
                -- bgtz
                if unsigned(A) > 0 then
                    BRANCH_TAKEN <= '1';
                end if;

            when "110000" => 
                -- custom pour beq
                if unsigned(A) = unsigned(B) then
                    BRANCH_TAKEN <= '1';
                end if;

            when "110001" => 
                -- custom pour bne
                if unsigned(A) /= unsigned(B)  then
                    BRANCH_TAKEN <= '1';
                end if;

            when "110010" => 
                -- custom pour blez
                if signed(A) = 0 then 
                    BRANCH_TAKEN <= '1';
                elsif signed(B) < 0 then
                    BRANCH_TAKEN <= '1';
                end if;

            when others => ALU_ERROR_VECTOR <= x"1B";
                -- jump raw command technically has an r-type encoding, but might use a separate jump sector for that, or just do it later

        end case;
    end process;
end RTL;

