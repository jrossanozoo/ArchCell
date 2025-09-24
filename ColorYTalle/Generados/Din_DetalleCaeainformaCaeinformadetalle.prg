
define class Din_DetalleCAEAINFORMACaeinformadetalle as detalle of detalle.prg


	nCantidadItems = 999
	cNombre = 'Caeinformadetalle'
	cEtiqueta = 'Información CAEA'
	cMensajeErrorUnicidad = 'La columna  no admite valores repetidos.'
	cNombreVisual = ''

	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function _CargarItem( tnItem as integer )
		Local loEx as Excepcion, llVacio as Boolean
		if tnItem <= 0
			loEx = Newobject( 'ZooException', 'ZooException.prg' )
			With loEx
				.Message = 'El item está fuera del rango'
				.Grabar()
				.Throw()
			EndWith
		EndIf
		With this.oItem
			Try
				.lCargando = .t.
				.NroItem = tnItem
				llVacio = .t.
				.Codigo = this.Item[ tnItem ].Codigo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Codigo', .Codigo )
			
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.Fecha = this.Item[ tnItem ].Fecha
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Fecha', .Fecha )
			
				.TipoComp = this.Item[ tnItem ].TipoComp
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TipoComp', .TipoComp )
			
				.CodigoComp = this.Item[ tnItem ].CodigoComp
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodigoComp', .CodigoComp )
			
				.TotalComp = this.Item[ tnItem ].TotalComp
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TotalComp', .TotalComp )
			
				.Resultado = this.Item[ tnItem ].Resultado
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Resultado', .Resultado )
			
				.FechaProceso = this.Item[ tnItem ].FechaProceso
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'FechaProceso', .FechaProceso )
			
				.ComentariosAFIP = this.Item[ tnItem ].ComentariosAFIP
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ComentariosAFIP', .ComentariosAFIP )
			
				.lCargando = .f.
				if llVacio
					this.oItem.SetearValoresSugeridos()
				endif
			Finally
				.lCargando = .f.
			EndTry
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function AplanarItem() as Object
		local loRetorno as object
		loRetorno = createobject('ItemAuxiliar')

		with loRetorno
			.Codigo = this.oItem.Codigo
			.NROITEM = this.oItem.NROITEM
			.Fecha = this.oItem.Fecha
			.TipoComp = this.oItem.TipoComp
			.CodigoComp = this.oItem.CodigoComp
			.TotalComp = this.oItem.TotalComp
			.Resultado = this.oItem.Resultado
			.FechaProceso = this.oItem.FechaProceso
			.ComentariosAFIP = this.oItem.ComentariosAFIP
			.NroItem = iif( this.oItem.NroItem = 0, this.Count + 1, this.oItem.NroItem )
		endwith

		return loRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function Modificar() as void
	local lnItem as integer, loEx as Exception

	with this
		if .ValidarItem()
			lnItem = .oItem.NroItem
			if lnItem <= 0
				.AgregarInformacion( 'Debe cargar un item para poder modificar' )
				goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
			endif

			if .oItem.ValidarExistenciaCamposFijos()
			else
				.oItem.Limpiar( .t. )
			endif

			.oItem.NroItem = lnItem
			.Item[ lnItem ].Codigo = .oItem.Codigo
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].Fecha = .oItem.Fecha
			.Item[ lnItem ].TipoComp = .oItem.TipoComp
			.Item[ lnItem ].CodigoComp = .oItem.CodigoComp
			.Item[ lnItem ].TotalComp = .oItem.TotalComp
			.Item[ lnItem ].Resultado = .oItem.Resultado
			.Item[ lnItem ].FechaProceso = .oItem.FechaProceso
			.Item[ lnItem ].ComentariosAFIP = .oItem.ComentariosAFIP
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemCAEAINFORMACaeinformadetalle' )
			this.enlazar( 'oItem.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oItem.EventoObtenerInformacion', 'inyectarInformacion' )
			this.oItem.inicializar()
			bindevent( this.oItem, 'EventoDespuesDeSetear', this, 'ValidarCantidadDeItemsEnDetalle' )
		endif
		return this.oItem
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Cargar() as Void
		local loItem as object, lnI as integer, lcClave as string, lcFiltro as String 
		lnI = 1

		select c_Caeinformadetalle
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Codigo = c_Caeinformadetalle.Codigo
			loItem.NROITEM = c_Caeinformadetalle.NROITEM
			loItem.Fecha = goLibrerias.ObtenerFechaFormateada( c_Caeinformadetalle.Fecha )
			loItem.TipoComp = c_Caeinformadetalle.TipoComp
			loItem.CodigoComp = c_Caeinformadetalle.CodigoComp
			loItem.TotalComp = c_Caeinformadetalle.TotalComp
			loItem.Resultado = c_Caeinformadetalle.Resultado
			loItem.FechaProceso = goLibrerias.ObtenerFechaFormateada( c_Caeinformadetalle.FechaProceso )
			loItem.ComentariosAFIP = c_Caeinformadetalle.ComentariosAFIP
			loItem.NroItem = lnI 
			this.AgregarItemPlano( loItem )
			lnI = lnI + 1
		endscan

		this.CambioSumarizado()

	endfunc


	*--------------------------------------------------------------------------------------------------------
	function ValidarExistenciaCamposFijosItemPlano( tnItem as integer ) as Boolean
		Local llRetorno as boolean
		llRetorno = .t.

		return llRetorno

	endfunc


	*-----------------------------------------------------------------------------------------
	Function ValidarFormatoAtributos() as boolean
	local lnLargoEntero as integer, lnValorDelDecimal as integer, lnLargoDecimal as integer, llRetorno as boolean, lnI as Integer

		llRetorno = dodefault()
		for lni = 1 to this.Count
			
			if vartype( this.Item[lni].CODIGO) = 'C'
				if len( alltrim( this.Item[lni].CODIGO )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGO ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NROITEM) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].NROITEM ) ) ) 
				lnValorDelDecimal = this.Item[lni].NROITEM - int( this.Item[lni].NROITEM )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 5
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo NROITEM del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:5), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NROITEM del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if inlist(vartype( this.Item[lni].FECHA),'D','T')
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo FECHA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TIPOCOMP) = 'C'
				if len( alltrim( this.Item[lni].TIPOCOMP )) <= 50
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TIPOCOMP del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TIPOCOMP ))) + ' Máxima:50), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TIPOCOMP del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CODIGOCOMP) = 'C'
				if len( alltrim( this.Item[lni].CODIGOCOMP )) <= 50
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGOCOMP del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGOCOMP ))) + ' Máxima:50), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGOCOMP del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TOTALCOMP) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].TOTALCOMP ) ) ) 
				lnValorDelDecimal = this.Item[lni].TOTALCOMP - int( this.Item[lni].TOTALCOMP )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo TOTALCOMP del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TOTALCOMP del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].RESULTADO) = 'C'
				if len( alltrim( this.Item[lni].RESULTADO )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo RESULTADO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].RESULTADO ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo RESULTADO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if inlist(vartype( this.Item[lni].FECHAPROCESO),'D','T')
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo FECHAPROCESO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].COMENTARIOSAFIP) = 'C'
				if len( alltrim( this.Item[lni].COMENTARIOSAFIP )) <= 250
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo COMENTARIOSAFIP del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].COMENTARIOSAFIP ))) + ' Máxima:250), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo COMENTARIOSAFIP del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
		EndFor
		Return llRetorno 
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function CrearItemAuxiliar() as Object
		return createobject( 'itemAuxiliar' )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ClonarItemAuxiliar( tnItem as Integer ) as Object
		loItemOrigen = this.Item[tnItem]
		loRetorno = createobject( 'itemAuxiliar' )
		this.CopiarItemaItem( loItemOrigen, loRetorno ) 

		return loRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function CopiarItemaItem( toItemOrigen as Object, toItemDestino as Object ) as Object
		toItemDestino.Codigo = toItemOrigen.Codigo
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Fecha = toItemOrigen.Fecha
		toItemDestino.Tipocomp = toItemOrigen.Tipocomp
		toItemDestino.Codigocomp = toItemOrigen.Codigocomp
		toItemDestino.Totalcomp = toItemOrigen.Totalcomp
		toItemDestino.Resultado = toItemOrigen.Resultado
		toItemDestino.Fechaproceso = toItemOrigen.Fechaproceso
		toItemDestino.Comentariosafip = toItemOrigen.Comentariosafip
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function VerificarSiElAtributoEstaVacio( tcAtributo as String, txValor as Variant ) as Boolean
		local llRetorno as boolean
		llRetorno = .t.
		if this.ElAtributoEsVerificableComoVacio( tcAtributo )
			llRetorno = empty( txValor )
		endif
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ElAtributoEsVerificableComoVacio( tcAtributo as String ) as Boolean
		Return dodefault( tcAtributo ) 
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerFiltro( ) as String
		local lcRetorno as String
		lcRetorno = '.T.'
		return lcRetorno
	endfunc


enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Codigo = []
	Nroitem = 0
	Fecha = ctod( '  /  /    ' )
	Tipocomp = []
	Codigocomp = []
	Totalcomp = 0
	Resultado = []
	Fechaproceso = ctod( '  /  /    ' )
	Comentariosafip = []
	NroItem = 0

enddefine