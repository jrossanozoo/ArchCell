
define class Din_Logueos as zoocoleccion of zoocoleccion.prg
	function Init()
		dodefault()
		Local loItem as itemLogueo
		
		loItem = newobject( 'itemLogueo' )
		loItem.cClave = 'ENTIDAD'
		this.agregar( loItem, 'ENTIDAD' )
		
		loItem = newobject( 'itemLogueo' )
		loItem.cClave = 'ENTIDADCOMPROBANTEDEVENTA'
		this.agregar( loItem, 'ENTIDADCOMPROBANTEDEVENTA' )
		
		loItem = newobject( 'itemLogueo' )
		loItem.cClave = 'IMPORTACION04974'
		this.agregar( loItem, 'IMPORTACION04974' )
		
		loItem = newobject( 'itemLogueo' )
		loItem.cClave = 'KONTROLER'
		this.agregar( loItem, 'KONTROLER' )
		
		loItem = newobject( 'itemLogueo' )
		loItem.cClave = 'LOG.ERR'
		this.agregar( loItem, 'LOG.ERR' )
		
		loItem = newobject( 'itemLogueo' )
		loItem.cClave = 'MANAGEREXPORTACIONES'
		this.agregar( loItem, 'MANAGEREXPORTACIONES' )
		
		loItem = newobject( 'itemLogueo' )
		loItem.cClave = 'MANAGERLOGUEOARBA'
		this.agregar( loItem, 'MANAGERLOGUEOARBA' )
		
		loItem = newobject( 'itemLogueo' )
		loItem.cClave = 'MANAGERTRANSFERENCIAABASEDEDATOS'
		this.agregar( loItem, 'MANAGERTRANSFERENCIAABASEDEDATOS' )
		
		loItem = newobject( 'itemLogueo' )
		loItem.cClave = 'MANAGERTRANSFERENCIAS'
		this.agregar( loItem, 'MANAGERTRANSFERENCIAS' )
		
		loItem = newobject( 'itemLogueo' )
		loItem.cClave = 'MENSAJESMODOSILENCIOSO'
		this.agregar( loItem, 'MENSAJESMODOSILENCIOSO' )
		
		loItem = newobject( 'itemLogueo' )
		loItem.cClave = 'PLANTILLAIMPOEXPO'
		this.agregar( loItem, 'PLANTILLAIMPOEXPO' )
		
		loItem = newobject( 'itemLogueo' )
		loItem.cClave = 'PREPARACIONIMPOEXPO'
		this.agregar( loItem, 'PREPARACIONIMPOEXPO' )
		
		loItem = newobject( 'itemLogueo' )
		loItem.cClave = 'PROCESOIMPORTACION'
		this.agregar( loItem, 'PROCESOIMPORTACION' )
		
		loItem = newobject( 'itemLogueo' )
		loItem.cClave = 'RECEPCIONTRANSFERENCIAS'
		this.agregar( loItem, 'RECEPCIONTRANSFERENCIAS' )
		
		loItem = newobject( 'itemLogueo' )
		loItem.cClave = 'SEGURIDAD'
		this.agregar( loItem, 'SEGURIDAD' )
		
		loItem = newobject( 'itemLogueo' )
		loItem.cClave = 'ZOOSESSION'
		this.agregar( loItem, 'ZOOSESSION' )
		
	endfunc

enddefine
*-----------------------------------------------------------------------------------------
Define class itemLogueo as custom
	 cClave = ''
enddefine