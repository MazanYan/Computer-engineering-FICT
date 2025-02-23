entity MyEntity is
	port (
		X1 : in bit;
		X2 : in bit;
		X3 : in bit;
		Y3 : out bit;
		Y4 : out bit;
		Y1 : out bit;
		Y8 : out bit;
		y5 : out bit;
		T1 : out bit;
		Q1 : in bit;
		T2 : out bit;
		Q2 : in bit;
		T3 : out bit;
		Q3 : in bit
	);
end entity MyEntity;


architecture MyArchitecture of MyEntity is
	signal temp_0,temp_1,temp_2,temp_3,temp_5,temp_6,temp_7,temp_8,temp_9,temp_10,temp_12,temp_13,temp_14,temp_15,temp_17,temp_18,temp_19,temp_20,temp_21,temp_22,temp_24,temp_25,temp_27,temp_28,temp_29,temp_30,temp_33,temp_34,temp_36,temp_37,temp_38,temp_40,temp_42,temp_43,temp_44,temp_45,temp_46,temp_48,temp_49,temp_50,temp_52,temp_53,temp_54,temp_55,temp_57,temp_58,temp_59,temp_60,temp_61,temp_62,temp_64,temp_65,temp_66,temp_67,temp_69,temp_70,temp_72,temp_73,temp_74,temp_75,temp_76,temp_77 : bit;
begin
	P_0: process(Q3,Q2,Q1)
	begin
		temp_0 <= (not Q3 and not Q2 and not Q1 );
	end process P_0;

	P_1: process(X1,X2)
	begin
		temp_1 <= (X1 and X2 );
	end process P_1;

	P_2: process(temp_0,temp_1)
	begin
		temp_2 <= not (temp_0 and temp_1 );
	end process P_2;

	P_3: process(Q3,Q2,Q1)
	begin
		temp_3 <= (not Q3 and not Q2 and not Q1 );
	end process P_3;

	P_5: process(temp_3,X1)
	begin
		temp_5 <= not (temp_3 and not X1 );
	end process P_5;

	P_6: process(Q3,Q2,Q1)
	begin
		temp_6 <= not (not Q3 and Q2 and not Q1 );
	end process P_6;

	P_7: process(Q2,Q1)
	begin
		temp_7 <= not (not Q2 and Q1 );
	end process P_7;

	P_8: process(Q3,Q2)
	begin
		temp_8 <= not (Q3 and not Q2 );
	end process P_8;

	P_9: process(temp_2,temp_5,temp_6)
	begin
		temp_9 <= (temp_2 and temp_5 and temp_6 );
	end process P_9;

	P_10: process(temp_7,temp_8)
	begin
		temp_10 <= (temp_7 and temp_8 );
	end process P_10;

	P_11: process(temp_9,temp_10)
	begin
		Y3 <= (temp_9 and temp_10 );
	end process P_11;

	P_12: process(Q3,Q2,Q1)
	begin
		temp_12 <= (not Q3 and not Q2 and not Q1 );
	end process P_12;

	P_13: process(X1,X2)
	begin
		temp_13 <= (X1 and not X2 );
	end process P_13;

	P_14: process(temp_12,temp_13)
	begin
		temp_14 <= not (temp_12 and temp_13 );
	end process P_14;

	P_15: process(Q3,Q2,Q1)
	begin
		temp_15 <= (not Q3 and not Q2 and not Q1 );
	end process P_15;

	P_17: process(temp_15,X1)
	begin
		temp_17 <= not (temp_15 and not X1 );
	end process P_17;

	P_18: process(Q3,Q2,Q1)
	begin
		temp_18 <= not (not Q3 and Q2 and not Q1 );
	end process P_18;

	P_19: process(Q2,Q1)
	begin
		temp_19 <= not (not Q2 and Q1 );
	end process P_19;

	P_20: process(Q3,Q2)
	begin
		temp_20 <= not (Q3 and not Q2 );
	end process P_20;

	P_21: process(temp_14,temp_17,temp_18)
	begin
		temp_21 <= (temp_14 and temp_17 and temp_18 );
	end process P_21;

	P_22: process(temp_19,temp_20)
	begin
		temp_22 <= (temp_19 and temp_20 );
	end process P_22;

	P_23: process(temp_21,temp_22)
	begin
		Y4 <= (temp_21 and temp_22 );
	end process P_23;

	P_24: process(Q3,Q2,Q1)
	begin
		temp_24 <= not (not Q3 and Q2 and not Q1 );
	end process P_24;

	P_25: process(Q3,Q2,Q1)
	begin
		temp_25 <= (not Q3 and not Q2 and not Q1 );
	end process P_25;

	P_27: process(temp_25,X1)
	begin
		temp_27 <= not (temp_25 and X1 );
	end process P_27;

	P_28: process(Q2,Q1)
	begin
		temp_28 <= not (not Q2 and Q1 );
	end process P_28;

	P_29: process(Q3,Q2)
	begin
		temp_29 <= not (Q3 and not Q2 );
	end process P_29;

	P_30: process(temp_24,temp_27,temp_28)
	begin
		temp_30 <= (temp_24 and temp_27 and temp_28 );
	end process P_30;

	P_32: process(temp_30,temp_29)
	begin
		Y1 <= (temp_30 and temp_29 );
	end process P_32;

	P_33: process(Q3,Q2)
	begin
		temp_33 <= not (Q3 and not Q2 );
	end process P_33;

	P_34: process(Q3,Q1)
	begin
		temp_34 <= not (not Q3 and not Q1 );
	end process P_34;

	P_35: process(temp_33,temp_34)
	begin
		Y8 <= (temp_33 and temp_34 );
	end process P_35;

	P_36: process(Q3,Q2,Q1)
	begin
		temp_36 <= not (not Q3 and not Q2 and not Q1 );
	end process P_36;

	P_37: process(Q2,Q1)
	begin
		temp_37 <= not (not Q2 and Q1 );
	end process P_37;

	P_38: process(Q3,Q2)
	begin
		temp_38 <= not (Q3 and not Q2 );
	end process P_38;

	P_39: process(temp_36,temp_37,temp_38)
	begin
		y5 <= (temp_36 and temp_37 and temp_38 );
	end process P_39;

	P_40: process(Q3,Q2,Q1)
	begin
		temp_40 <= (Q3 and not Q2 and Q1 );
	end process P_40;

	P_42: process(temp_40,X3)
	begin
		temp_42 <= not (temp_40 and not X3 );
	end process P_42;

	P_43: process(Q3,Q2,Q1)
	begin
		temp_43 <= not (not Q3 and not Q2 and Q1 );
	end process P_43;

	P_44: process(Q3,Q2,Q1)
	begin
		temp_44 <= not (not Q3 and Q2 and not Q1 );
	end process P_44;

	P_45: process(Q3,Q2,Q1)
	begin
		temp_45 <= not (Q3 and not Q2 and not Q1 );
	end process P_45;

	P_46: process(Q3,Q2,Q1)
	begin
		temp_46 <= (not Q3 and not Q2 and not Q1 );
	end process P_46;

	P_48: process(temp_46,X1)
	begin
		temp_48 <= not (temp_46 and X1 );
	end process P_48;

	P_49: process(temp_42,temp_43,temp_44)
	begin
		temp_49 <= (temp_42 and temp_43 and temp_44 );
	end process P_49;

	P_50: process(temp_45,temp_48)
	begin
		temp_50 <= (temp_45 and temp_48 );
	end process P_50;

	P_51: process(temp_49,temp_50)
	begin
		T1 <= (temp_49 and temp_50 );
	end process P_51;

	P_52: process(Q3,Q2,Q1)
	begin
		temp_52 <= (not Q3 and not Q2 and not Q1 );
	end process P_52;

	P_53: process(X1,X2)
	begin
		temp_53 <= (X1 and not X2 );
	end process P_53;

	P_54: process(temp_52,temp_53)
	begin
		temp_54 <= not (temp_52 and temp_53 );
	end process P_54;

	P_55: process(Q3,Q2,Q1)
	begin
		temp_55 <= (not Q3 and not Q2 and not Q1 );
	end process P_55;

	P_57: process(temp_55,X1)
	begin
		temp_57 <= not (temp_55 and not X1 );
	end process P_57;

	P_58: process(Q3,Q2,Q1)
	begin
		temp_58 <= not (not Q3 and Q2 and not Q1 );
	end process P_58;

	P_59: process(Q2,Q1)
	begin
		temp_59 <= not (not Q2 and Q1 );
	end process P_59;

	P_60: process(Q3,Q2)
	begin
		temp_60 <= not (Q3 and not Q2 );
	end process P_60;

	P_61: process(temp_54,temp_57,temp_58)
	begin
		temp_61 <= (temp_54 and temp_57 and temp_58 );
	end process P_61;

	P_62: process(temp_59,temp_60)
	begin
		temp_62 <= (temp_59 and temp_60 );
	end process P_62;

	P_63: process(temp_61,temp_62)
	begin
		T2 <= (temp_61 and temp_62 );
	end process P_63;

	P_64: process(Q3,Q2,Q1)
	begin
		temp_64 <= (not Q3 and not Q2 and not Q1 );
	end process P_64;

	P_65: process(X1,X2)
	begin
		temp_65 <= (X1 and X2 );
	end process P_65;

	P_66: process(temp_64,temp_65)
	begin
		temp_66 <= not (temp_64 and temp_65 );
	end process P_66;

	P_67: process(Q3,Q2,Q1)
	begin
		temp_67 <= (not Q3 and not Q2 and not Q1 );
	end process P_67;

	P_69: process(temp_67,X1)
	begin
		temp_69 <= not (temp_67 and not X1 );
	end process P_69;

	P_70: process(Q3,Q2,Q1)
	begin
		temp_70 <= (Q3 and not Q2 and Q1 );
	end process P_70;

	P_72: process(temp_70,X3)
	begin
		temp_72 <= not (temp_70 and X3 );
	end process P_72;

	P_73: process(Q3,Q2,Q1)
	begin
		temp_73 <= not (not Q3 and not Q2 and Q1 );
	end process P_73;

	P_74: process(Q3,Q2,Q1)
	begin
		temp_74 <= not (not Q3 and Q2 and not Q1 );
	end process P_74;

	P_75: process(Q3,Q2,Q1)
	begin
		temp_75 <= not (Q3 and not Q2 and not Q1 );
	end process P_75;

	P_76: process(temp_66,temp_69,temp_72)
	begin
		temp_76 <= (temp_66 and temp_69 and temp_72 );
	end process P_76;

	P_77: process(temp_73,temp_74,temp_75)
	begin
		temp_77 <= (temp_73 and temp_74 and temp_75 );
	end process P_77;

	P_78: process(temp_76,temp_77)
	begin
		T3 <= (temp_76 and temp_77 );
	end process P_78;

end architecture MyArchitecture;
