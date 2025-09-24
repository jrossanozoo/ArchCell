
define class Din_DetalleNUEVOENBASEADetallecomprobantes as detalle of detalle.prg


	cAtributosUnicidad = 'Numero'
	nCantidadItems = 999
	cNombre = 'Detallecomprobantes'
	cEtiqueta = 'Comprobantes'
	cMensajeErrorUnicidad = 'La columna Número no admite valores repetidos.'
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
			
				.TimestampComprobante = this.Item[ tnItem ].TimestampComprobante
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TimestampComprobante', .TimestampComprobante )
			
				.CodigoCompAfe = this.Item[ tnItem ].CodigoCompAfe
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodigoCompAfe', .CodigoCompAfe )
			
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.Numero = this.Item[ tnItem ].Numero
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Numero', .Numero )
			
				.Descripcion = this.Item[ tnItem ].Descripcion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Descripcion', .Descripcion )
			
				.Fecha = this.Item[ tnItem ].Fecha
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Fecha', .Fecha )
			
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
			.TimestampComprobante = this.oItem.TimestampComprobante
			.CodigoCompAfe = this.oItem.CodigoCompAfe
			.NROITEM = this.oItem.NROITEM
			.Numero = this.oItem.Numero
			.Descripcion = this.oItem.Descripcion
			.Fecha = this.oItem.Fecha
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
			.Item[ lnItem ].TimestampComprobante = .oItem.TimestampComprobante
			.Item[ lnItem ].CodigoCompAfe = .oItem.CodigoCompAfe
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].Numero = .oItem.Numero
			.Item[ lnItem ].Descripcion = .oItem.Descripcion
			.Item[ lnItem ].Fecha = .oItem.Fecha
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemNUEVOENBASEADetallecomprobantes' )
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

		select c_Detallecomprobantes
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Codigo = c_Detallecomprobantes.Codigo
			loItem.TimestampComprobante = c_Detallecomprobantes.TimestampComprobante
			loItem.CodigoCompAfe = c_Detallecomprobantes.CodigoCompAfe
			loItem.NROITEM = c_Detallecomprobantes.NROITEM
			loItem.Numero = c_Detallecomprobantes.Numero
			loItem.Descripcion = c_Detallecomprobantes.Descripcion
			loItem.Fecha = goLibrerias.ObtenerFechaFormateada( c_Detallecomprobantes.Fecha )
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

		if  empty( this.item[ tnItem ].Numero ) 
			llRetorno = .F.
		endif 
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
			
			if vartype( this.Item[lni].TIMESTAMPCOMPROBANTE) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].TIMESTAMPCOMPROBANTE ) ) ) 
				lnValorDelDecimal = this.Item[lni].TIMESTAMPCOMPROBANTE - int( this.Item[lni].TIMESTAMPCOMPROBANTE )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 15
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo TIMESTAMPCOMPROBANTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:15), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TIMESTAMPCOMPROBANTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CODIGOCOMPAFE) = 'C'
				if len( alltrim( this.Item[lni].CODIGOCOMPAFE )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGOCOMPAFE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGOCOMPAFE ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGOCOMPAFE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].NUMERO) = 'C'
				if len( alltrim( this.Item[lni].NUMERO )) <= 30
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo NUMERO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].NUMERO ))) + ' Máxima:30), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NUMERO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].DESCRIPCION) = 'C'
				if len( alltrim( this.Item[lni].DESCRIPCION )) <= 50
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo DESCRIPCION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].DESCRIPCION ))) + ' Máxima:50), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo DESCRIPCION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if inlist(vartype( this.Item[lni].FECHA),'D','T')
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo FECHA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Timestampcomprobante = toItemOrigen.Timestampcomprobante
		toItemDestino.Codigocompafe = toItemOrigen.Codigocompafe
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Numero = toItemOrigen.Numero
		toItemDestino.Descripcion = toItemOrigen.Descripcion
		toItemDestino.Fecha = toItemOrigen.Fecha
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

	*--------------------------------------------------------------------------------------------------------
	function ObtenerCampoInicialYOBligatorioDelDetalle() as String
	local lcRetorno as string
		lcRetorno = 'Numero'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Codigo = []
	Timestampcomprobante = 0
	Codigocompafe = []
	Nroitem = 0
	Numero = []
	Descripcion = []
	Fecha = ctod( '  /  /    ' )
	NroItem = 0

enddefine