define class FxuTest as FxuCustom OF FxuCustom.prg

	#IF .f.
		LOCAL this as FxuTest OF FxuTest.prg
	#ENDIF

	*-----------------------------------------------------------------------------------------
	function Run() as Void
	endfunc 
	
enddefine