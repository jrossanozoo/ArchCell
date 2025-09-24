
define class Mock_PARAMETROSRZPUESTO as MockBase of MockBase.prg

	cClase = 'PARAMETROSRZPUESTO'

	
	CodigoPostalDeLaEmpresa = ""                                                                                                                                                                                                                              
	Cuit = ""                                                                                                                                                                                                                                                 
	DireccionDeLaEmpresa = ""                                                                                                                                                                                                                                 
	Email = ""                                                                                                                                                                                                                                                
	Ib = ""                                                                                                                                                                                                                                                   
	InicioDeActividades = {//}                                                                                                                                                                                                                                
	LocalidadDeLaEmpresa = ""                                                                                                                                                                                                                                 
	LogoDeLaEmpresa = ""                                                                                                                                                                                                                                      
	NombreDeLaEmpresa = ""                                                                                                                                                                                                                                    
	PaginaWeb = ""                                                                                                                                                                                                                                            
	ProvinciaDeLaEmpresa = ""                                                                                                                                                                                                                                 
	RazonSocialDeLaEmpresa = ""                                                                                                                                                                                                                               
	SituacionFiscal = 0                                                                                                                                                                                                                                       
	TelefonoDeLaEmpresa = ""                                                                                                                                                                                                                                  
	
	*-----------------------------------------------------------------------------------------
	function Release() as Void
		dodefault()
		release this
	endfunc

	*-----------------------------------------------------------------------------------------
	function init() as void                                                                                                                                                                                                                                   
	EndFunc


enddefine