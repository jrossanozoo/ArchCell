***********************************************************************
*	FoxUnit is Copyright (c) 2004, Vision Data Solutions Inc.
*	All rights reserved.
*
*	Redistribution and use in source and binary forms, with or 
*	without modification, are permitted provided that the following 
*	conditions are met:
*
*		*	Redistributions of source code must retain the above
*			copyright notice, this list of conditions and the 
*			following disclaimer.
*
*		*	Redistributions in binary form must reproduce the above 
*			copyright notice, this list of conditions and the 
*			following disclaimer in the documentation and/or other 
*			materials provided with the distribution. 
*			
*		*	Neither the name of Vision Data Solutions Inc nor the
*			names of the FoxUnit contributors may be used to endorse
*			or promote products derived from this software without
*			specific prior written permission. 
*
*	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
*	"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
*	LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS 
*	FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE 
*	COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
*	INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
*	BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
*	LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
*	CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT 
*	LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN 
*	ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
*	POSSIBILITY OF SUCH DAMAGE.     
***********************************************************************

RETURN CREATEOBJECT("FxuTestSuite")

**********************************************************************
DEFINE CLASS FxuTestSuite as FxuTest OF FxuTest.prg
**********************************************************************

	#IF .f.
		LOCAL this as FxuTestSuite OF FxuTestSuite.prg
	#ENDIF
	
	DIMENSION iaTests[1,2]
	inTestCount = 0
	inTestsRun = 0
	inTestsSuccessfull = 0
	ioTestBroker = .f.
	ilAllowDebug = .f.
	ioTestResult = .f.
	ilNotifyListener = .f.
	ioListener = .f.

	********************************************************************
	FUNCTION Init
	********************************************************************
	
		this.iaTests[1,1] = ''
	
	********************************************************************
	ENDFUNC
	********************************************************************

	********************************************************************
	FUNCTION AddTest(tcTestClass,tcTestName)
	********************************************************************
		IF EMPTY(tcTestName)
			RETURN
		ENDIF
		
		IF UPPER(ALLTRIM(tcTestName)) == "(NONE)"
			RETURN
		ENDIF
		
		
		LOCAL lnTestCount, llAddOne
		
		lnTestCount = this.inTestcount + 1
			
		DIMENSION this.iaTests[lnTestCount,2]
		
		this.iaTests[lnTestCount,1] = tcTestClass
		this.iaTests[lnTestCount,2] = tcTestName
		
		this.inTestCount = lnTestCount
			
	********************************************************************
	ENDFUNC
	********************************************************************
	
	********************************************************************
	FUNCTION RunTest(tcTestClass, tcTestMethod)
	********************************************************************
		LOCAL loTestBroker as FxuTestBroker OF FxuTestBroker.prg
		
		this.Event_BeforeOneTest(tcTestClass, tcTestMethod)
		
		loTestBroker = FxuNewObject("FxuTestBroker")
		
		this.ioTestResult.NewResult(tcTestClass,tcTestMethod)
		loTestBroker.RunTest(tcTestClass,tcTestMethod,this.ioTestResult,this.ilAllowDebug)
			
		
	
	********************************************************************
	ENDFUNC
	********************************************************************
	
	********************************************************************
	FUNCTION RunTests
	********************************************************************
		
		LOCAL lnCurrentTest, lnStartSeconds
		LOCAL lcTestClass, lcTestMethod
		
		this.ioTestResult.inTotalTests = this.inTestCount
		this.ioTestResult.inRunTests = this.inTestsRun
		
		lnStartSeconds = SECONDS()
		
		FOR lnCurrentTest = 1 TO this.inTestCount
		
			lcTestClass = ALLTRIM(this.iaTests[lnCurrentTest,1])
			lcTestMethod = ALLTRIM(this.iaTests[lnCurrentTest,2])
			this.RunTest(lcTestClass,lcTestMethod)
			IF this.ioTestResult.ilCurrentResult
				this.inTestsSuccessfull = this.inTestsSuccessfull + 1
			ENDIF
			
			this.NotifyListener()
			
		
		ENDFOR
		
		
		this.NotifyListenerAllTestsComplete(SECONDS() - lnStartSeconds)
		
		
	
	********************************************************************
	ENDFUNC
	********************************************************************
	
	********************************************************************
	FUNCTION NotifyListener()
	********************************************************************

		this.Event_OneTestComplete(this.ioTestResult)		
	
	********************************************************************
	ENDFUNC
	********************************************************************
	
	********************************************************************
	FUNCTION NotifyListenerAllTestsComplete(tnSecondsElapsed)
	********************************************************************
		LOCAL lnTestsFailed, llTestSuiteSuccessfull

		lnTestsFailed = this.inTestCount - this.inTestsSuccessfull
		llTestSuiteSuccessfull = (this.inTestCount = this.inTestsSuccessfull)

		this.Event_AllTestsComplete(this.inTestCount, lnTestsFailed, llTestSuiteSuccessfull,tnSecondsElapsed)
		
	********************************************************************
	ENDFUNC
	********************************************************************
	
	
	********************************************************************
	FUNCTION Event_OneTestComplete(toTestResult)
	********************************************************************
	
		
	
	********************************************************************
	ENDFUNC
	********************************************************************
	
	********************************************************************
	FUNCTION Event_AllTestsComplete(tnTestCount, tnTestsFailed, tlSuccess, tnSecondsElapsed)
	********************************************************************
	
	
	
	********************************************************************
	endfunc

	********************************************************************
	FUNCTION Event_BeforeOneTest( tcTestClass, tcTestMethod )
	********************************************************************
	
	
	
	********************************************************************
	endfunc
	
	********************************************************************

**********************************************************************
ENDDEFINE && CLASS
**********************************************************************