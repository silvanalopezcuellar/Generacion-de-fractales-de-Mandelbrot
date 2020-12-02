--------- Package: utils.vhd--------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;
----------------------------------------

---------------------------------------
------------ Funciones para Diseño FPGA
-- "+": suma dos std_logic_vector (del mismo tamaño)
-- mult: multiplica dos unsigned


package my_package is
        function "+" (a, b: std_logic_vector) return std_logic_vector;
        function mult (a, b : unsigned) return unsigned;
        function sfixmult (a:signed; b:signed; frac:natural) return signed;
        function sfixdiv (a:signed; b:signed; frac:natural) return signed;
        function to_sfix(a:unsigned; word_length:natural; frac:natural) return signed;
end package my_package;

-----------------------------------------

package body my_package is
------function body: -------------
    --==================================================================
    function "+"(a, b: std_logic_vector) return std_logic_vector is
        
        variable result: std_logic_vector(a'RANGE);
        variable carry    : std_logic;
    
    begin
        carry := '0';
        for i in a'reverse_range loop
            
            result(i)     :=a(i) xor b(i) xor carry;
            carry         :=(a(i) and b(i)) or (a(i) and carry) or (b(i) and carry);
        
        end loop;
        
        return result;
        
    end "+";
    
    --===================================================================
    function mult(a, b : unsigned) return unsigned is
            constant max    :    integer    := a'length + b'length - 1;
            variable aa        :    unsigned(max downto 0)     := (max downto a'length =>'0')& a(a'length-1 downto 0);
            variable prod    :    unsigned(max downto 0)    := (others => '0');
        begin
            for i in 0 to a'length-1 loop
                if (b(i)='1') then prod := prod + aa;
                end if;
                aa := aa(max-1 downto 0) & '0';
            end loop;
            return prod;
    end mult;    
    
    --===================================================================
    --multiplica dos numeros fixed point con [frac] decimales
    --ambos deben tener el mismo tamaño y número de decimales
    function sfixmult(a:signed; b:signed ;frac:natural) return signed is    
    
        variable tempresult     : signed (2*a'length-1 downto 0);
        variable result        : signed (a'length-1 downto 0);
        
        variable int : natural;
        
        begin
            int:=a'length-frac-1;
            tempresult:=a*b;
            
            --toma: valor del signo y valores cercanos al punto para ambos lados, segun el número de cifras enteras y decimales con la que venían los argumentos
            result:=tempresult(tempresult'left) & tempresult(tempresult'left-2-int downto tempresult'right+frac);
            return result;
        
    end sfixmult;
    
    --===================================================================
    function sfixdiv (a:signed; b:signed; frac:natural) return signed is
    
        variable a_ext,result_temp,b_ext            : signed(a'length-1+frac downto 0);
        variable frac_zeros    : signed(frac-1 downto 0);
        --variable result_temp    : signed(a'length-1 downto 0);
        
        begin
            frac_zeros:=(others=>'0');
            a_ext:= a & frac_zeros;
            --b_ext:=resize(b,b'length+frac);
            result_temp:=a_ext/b;
        return result_temp(a'length-1 downto 0);
        
    end sfixdiv;
    
    --===================================================================
    
    function to_sfix(a:unsigned; word_length:natural; frac:natural) return signed is
        variable frac_zeros    : std_logic_vector(frac-1 downto 0);
        variable int_zeros    : std_logic_vector(word_length-frac-a'length-1 downto 0);
        variable a_temp        : std_logic_vector(a'length-1 downto 0);
        begin
            int_zeros:=(others=>'0');
            frac_zeros:=(others=>'0');
            a_temp:=std_logic_vector(a);
            return signed(int_zeros & a_temp & frac_zeros);
    end to_sfix;
    
 
end my_package;
	 
	