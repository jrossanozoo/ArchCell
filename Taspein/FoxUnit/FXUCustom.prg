define class FxuCustom as custom

	#IF .f.
		LOCAL this as FxuCustom OF FxuCustom.prg
	#ENDIF
	
	ioLastError = .NULL.
	icLastErrorMessage = ''
	
enddefine
