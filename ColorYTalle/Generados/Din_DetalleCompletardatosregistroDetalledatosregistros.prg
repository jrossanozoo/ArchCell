
define class Din_DetalleCOMPLETARDATOSREGISTRODetalledatosregistros as detalle of detalle.prg


	nCantidadItems = 999
	cNombre = 'Detalledatosregistros'
	cEtiqueta = 'Señas pendientes'
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
			
				.Registro_PK = this.Item[ tnItem ].Registro_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Registro_PK', .Registro_PK )
			
				.Valor_PK = this.Item[ tnItem ].Valor_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Valor_PK', .Valor_PK )
			
				.ValorDetalle = this.Item[ tnItem ].ValorDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ValorDetalle', .ValorDetalle )
			
				.Importe = this.Item[ tnItem ].Importe
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Importe', .Importe )
			
				.CuentaBancaria_PK = this.Item[ tnItem ].CuentaBancaria_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CuentaBancaria_PK', .CuentaBancaria_PK )
			
				.Fecha = this.Item[ tnItem ].Fecha
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Fecha', .Fecha )
			
				.Hora = this.Item[ tnItem ].Hora
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Hora', .Hora )
			
				.Identificador = this.Item[ tnItem ].Identificador
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Identificador', .Identificador )
			
				.CodigoBanco = this.Item[ tnItem ].CodigoBanco
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodigoBanco', .CodigoBanco )
			
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
			.Registro_PK = this.oItem.Registro_PK
			.Valor_PK = this.oItem.Valor_PK
			.ValorDetalle = this.oItem.ValorDetalle
			.Importe = this.oItem.Importe
			.CuentaBancaria_PK = this.oItem.CuentaBancaria_PK
			.Fecha = this.oItem.Fecha
			.Hora = this.oItem.Hora
			.Identificador = this.oItem.Identificador
			.CodigoBanco = this.oItem.CodigoBanco
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
			.Item[ lnItem ].Registro_PK = .oItem.Registro_PK
			.Item[ lnItem ].Valor_PK = .oItem.Valor_PK
			.Item[ lnItem ].ValorDetalle = .oItem.ValorDetalle
			.Item[ lnItem ].Importe = .oItem.Importe
			.Item[ lnItem ].CuentaBancaria_PK = .oItem.CuentaBancaria_PK
			.Item[ lnItem ].Fecha = .oItem.Fecha
			.Item[ lnItem ].Hora = .oItem.Hora
			.Item[ lnItem ].Identificador = .oItem.Identificador
			.Item[ lnItem ].CodigoBanco = .oItem.CodigoBanco
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemCOMPLETARDATOSREGISTRODetalledatosregistros' )
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

		select c_Detalledatosregistros
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Codigo = c_Detalledatosregistros.Codigo
			loItem.NROITEM = c_Detalledatosregistros.NROITEM
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

		if  empty( this.item[ tnItem ].Valor_PK ) or ; 			 empty( this.item[ tnItem ].Cuentabancaria_PK ) or ; 			 empty( this.item[ tnItem ].Fecha ) 
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
				if len( alltrim( this.Item[lni].CODIGO )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGO ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
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
		toItemDestino.Registro_PK = toItemOrigen.Registro_PK
		toItemDestino.Valor_PK = toItemOrigen.Valor_PK
		toItemDestino.Valordetalle = toItemOrigen.Valordetalle
		toItemDestino.Importe = toItemOrigen.Importe
		toItemDestino.Cuentabancaria_PK = toItemOrigen.Cuentabancaria_PK
		toItemDestino.Fecha = toItemOrigen.Fecha
		toItemDestino.Hora = toItemOrigen.Hora
		toItemDestino.Identificador = toItemOrigen.Identificador
		toItemDestino.Codigobanco = toItemOrigen.Codigobanco
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
		lcRetorno = 'Valor_pk'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Codigo = []
	Nroitem = 0
	Registro_PK = []
	Valor_PK = []
	Valordetalle = []
	Importe = 0
	Cuentabancaria_PK = []
	Fecha = ctod( '  /  /    ' )
	Hora = []
	Identificador = []
	Codigobanco = []
	NroItem = 0

enddefine