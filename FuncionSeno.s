	AREA codigo,CODE, READONLY
	ENTRY
	EXPORT Start

Start ;Variables exadecimales se cargan a S
	VMOV.F32 S0, #-1 ; Valor para (-1)^n
	VMOV.F32 S1,S0
	VMOV.F32 S2, #1
	VMOV.F32 S3,S2
	VMOV.F32 S4, #30 ;n valores
	VMOV.F32 S7,S4
	VMOV.F32 S5, #2 ;valor de x
	VMOV.F32 S6, #1 ; Valor de (-1)^n
	VLDR.F32 S21, =0
	VLDR.F32 S13, =1 ;Resta para conteo de factorial
	VLDR.F32 S30, =-1 ;Resta para conteo de factorial
	B NCalculo


NCalculo ;Caluclo de (-1)^n
	VMUL.F32 S6,S0
	VCMP.F32 S7,S13
	VSUB.F32 S7, S3
	
	
	VMRS APSR_nzcv, FPSCR
	BNE NCalculo
	BEQ CalculoN0
	
CalculoN0

	VCMP.F32 S4,S21
	
	VMRS APSR_nzcv, FPSCR
	BNE Arreglo
	BEQ ValorN0

ValorN0

	VMOV.F32 S0, #1
	VMOV.F32 S1, #1
	VMOV.F32 S6, #1
	
	B Arreglo


Arreglo ;Calculo de (2n+1)

	VLDR.F32 S8, =2
	VMUL.F32 S9,S4,S8
	VADD.F32 S10,S2,S9 ; Valor de (2n+1)
	VMOV.F32 S11,S10 ;Guardamos el valor de S10 en S11
	VSUB.F32 S22,S10,S13
	VMOV.F32 S12, #1 ;Valor del factorial
	B Factorial
	
Factorial ;(2n+1)!
	VMUL.F32 S12,S11 ;Operando factorial
	VSUB.F32 S11,S13 ; Restando 1 a S11 por cada operacion
	VCMP.F32 S11,S21 ; Comparacion
	
	VMRS APSR_nzcv, FPSCR
	BNE Factorial
	BEQ Division
	
Division ;(-1)^n/(2n+1)
	VDIV.F32 S14,S6,S12 ;Valor de (-1)^n/(2n+1)
	VMOV.F32 S15,S5 ; Valor de x^(2n+1)
	VMOV.F32 S16,S2
	B Equis0
	
Equis0
	VCMP.F32 S10,S13
	
	VMRS APSR_nzcv, FPSCR
	BNE Equis
	BEQ ValorX0

ValorX0

	VMOV.F32 S15,S5
	
	B Multiplicacion

Equis ; x^(2n+1)
	VMUL.F32 S15,S5
	VSUB.F32 S22,S13
	VCMP.F32 S22,S21
	
	VMRS APSR_nzcv, FPSCR
	BNE Equis
	BEQ Multiplicacion

Multiplicacion
	VMUL.F32 S17,S14,S15
	VMOV.F32 S19,S17
	B Sumatoria
	
Sumatoria
	VADD.F32 S20,S19
	VCMP.F32 S4,S21
	
	VMRS APSR_nzcv, FPSCR
	BNE NNCalculo
	BEQ Stop
	
NNCalculo ;N-1
	VMOV.F32 S2, #1
	VMOV.F32 S6, #1
	VMOV.F32 S7, #1
	VMOV.F32 S8, #2
	VLDR.F32 S9, =0
	VLDR.F32 S10, =0
	VLDR.F32 S11, =0
	VMOV.F32 S12, #1
	VMOV.F32 S13, #1
	VMOV.F32 S14, #1
	VLDR.F32 S15, =0
	VLDR.F32 S16, =0
	VMOV.F32 S18, #1
	VLDR.F32 S17, =0
	VLDR.F32 S19, =0
	VSUB.F32 S4,S13
	VCMP.F32 S4,S0
	
	VMRS APSR_nzcv, FPSCR
	BNE NCalculo
	BEQ Stop
	
	
Stop B Stop 
	ALIGN
	END 
	