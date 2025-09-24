
define class Din_DetalleGTINDetrangos as detalle of detalle.prg


	nCantidadItems = 999
	cNombre = 'Detrangos'
	cEtiqueta = 'Detalle'
	cMensajeErrorUnicidad = 'La columna  no admite valores repetidos.'
	cNombreVisual = '-'

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
				.ClaveForanea = this.Item[ tnItem ].ClaveForanea
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ClaveForanea', .ClaveForanea )
			
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.Codigo = this.Item[ tnItem ].Codigo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Codigo', .Codigo )
			
				.Atributo = this.Item[ tnItem ].Atributo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Atributo', .Atributo )
			
				.Desde = this.Item[ tnItem ].Desde
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Desde', .Desde )
			
				.Hasta = this.Item[ tnItem ].Hasta
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Hasta', .Hasta )
			
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
			.ClaveForanea = this.oItem.ClaveForanea
			.NROITEM = this.oItem.NROITEM
			.Codigo = this.oItem.Codigo
			.Atributo = this.oItem.Atributo
			.Desde = this.oItem.Desde
			.Hasta = this.oItem.Hasta
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
			.Item[ lnItem ].ClaveForanea = .oItem.ClaveForanea
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].Codigo = .oItem.Codigo
			.Item[ lnItem ].Atributo = .oItem.Atributo
			.Item[ lnItem ].Desde = .oItem.Desde
			.Item[ lnItem ].Hasta = .oItem.Hasta
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'ItemGTINDetrangos' )
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

		select c_Detrangos
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.ClaveForanea = c_Detrangos.ClaveForanea
			loItem.NROITEM = c_Detrangos.NROITEM
			loItem.Codigo = c_Detrangos.Codigo
			loItem.Atributo = c_Detrangos.Atributo
			loItem.Desde = c_Detrangos.Desde
			loItem.Hasta = c_Detrangos.Hasta
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

		if  empty( this.item[ tnItem ].Atributo ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc


	*-----------------------------------------------------------------------------------------
	Function ValidarFormatoAtributos() as boolean
	local lnLargoEntero as integer, lnValorDelDecimal as integer, lnLargoDecimal as integer, llRetorno as boolean, lnI as Integer

		llRetorno = dodefault()
		for lni = 1 to this.Count
			
			if vartype( this.Item[lni].CLAVEFORANEA) = 'C'
				if len( alltrim( this.Item[lni].CLAVEFORANEA )) <= 40
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CLAVEFORANEA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CLAVEFORANEA ))) + ' Máxima:40), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CLAVEFORANEA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].CODIGO) = 'C'
				if len( alltrim( this.Item[lni].CODIGO )) <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGO ))) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ATRIBUTO) = 'C'
				if len( alltrim( this.Item[lni].ATRIBUTO )) <= 40
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo ATRIBUTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].ATRIBUTO ))) + ' Máxima:40), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ATRIBUTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].DESDE) = 'C'
				if len( alltrim( this.Item[lni].DESDE )) <= 40
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo DESDE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].DESDE ))) + ' Máxima:40), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo DESDE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].HASTA) = 'C'
				if len( alltrim( this.Item[lni].HASTA )) <= 40
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo HASTA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].HASTA ))) + ' Máxima:40), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo HASTA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Claveforanea = toItemOrigen.Claveforanea
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Codigo = toItemOrigen.Codigo
		toItemDestino.Atributo = toItemOrigen.Atributo
		toItemDestino.Desde = toItemOrigen.Desde
		toItemDestino.Hasta = toItemOrigen.Hasta
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
		lcRetorno = 'Atributo'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Claveforanea = []
	Nroitem = 0
	Codigo = []
	Atributo = []
	Desde = []
	Hasta = []
	NroItem = 0

enddefine