
define class Din_DetallePOSTarjetasdetalle as detalle of detalle.prg


	nCantidadItems = 999
	cNombre = 'Tarjetasdetalle'
	cEtiqueta = 'Operadora'
	cMensajeErrorUnicidad = 'La columna  no admite valores repetidos.'
	cNombreVisual = 'Comercios por Operador de Tarjetas'

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
				.Message = 'El item est� fuera del rango'
				.Grabar()
				.Throw()
			EndWith
		EndIf
		With this.oItem
			Try
				.lCargando = .t.
				.NroItem = tnItem
				llVacio = .t.
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.Codigo = this.Item[ tnItem ].Codigo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Codigo', .Codigo )
			
				.OperadoraDeTarjeta_PK = this.Item[ tnItem ].OperadoraDeTarjeta_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'OperadoraDeTarjeta_PK', .OperadoraDeTarjeta_PK )
			
				.OperadoraDeTarjetaDetalle = this.Item[ tnItem ].OperadoraDeTarjetaDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'OperadoraDeTarjetaDetalle', .OperadoraDeTarjetaDetalle )
			
				.NumeroComercio = this.Item[ tnItem ].NumeroComercio
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumeroComercio', .NumeroComercio )
			
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
			.NROITEM = this.oItem.NROITEM
			.Codigo = this.oItem.Codigo
			.OperadoraDeTarjeta_PK = this.oItem.OperadoraDeTarjeta_PK
			.OperadoraDeTarjetaDetalle = this.oItem.OperadoraDeTarjetaDetalle
			.NumeroComercio = this.oItem.NumeroComercio
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
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].Codigo = .oItem.Codigo
			.Item[ lnItem ].OperadoraDeTarjeta_PK = .oItem.OperadoraDeTarjeta_PK
			.Item[ lnItem ].OperadoraDeTarjetaDetalle = .oItem.OperadoraDeTarjetaDetalle
			.Item[ lnItem ].NumeroComercio = .oItem.NumeroComercio
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemPOSTarjetasdetalle' )
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

		select c_Tarjetasdetalle
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.NROITEM = c_Tarjetasdetalle.NROITEM
			loItem.Codigo = c_Tarjetasdetalle.Codigo
			loItem.OperadoraDeTarjeta_PK = c_Tarjetasdetalle.OperadoraDeTarjeta
			loItem.OperadoraDeTarjetaDetalle = c_Tarjetasdetalle.OperadoraDeTarjetaDetalle
			loItem.NumeroComercio = c_Tarjetasdetalle.NumeroComercio
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

		if  empty( this.item[ tnItem ].Operadoradetarjeta_PK ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc


	*-----------------------------------------------------------------------------------------
	Function ValidarFormatoAtributos() as boolean
	local lnLargoEntero as integer, lnValorDelDecimal as integer, lnLargoDecimal as integer, llRetorno as boolean, lnI as Integer

		llRetorno = dodefault()
		for lni = 1 to this.Count
			
			if vartype( this.Item[lni].NROITEM) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].NROITEM ) ) ) 
				lnValorDelDecimal = this.Item[lni].NROITEM - int( this.Item[lni].NROITEM )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 5
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo NROITEM del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' M�xima:5), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NROITEM del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CODIGO) = 'C'
				if len( alltrim( this.Item[lni].CODIGO )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGO ))) + ' M�xima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].OPERADORADETARJETA_PK) = 'C'
				if len( alltrim( this.Item[lni].OPERADORADETARJETA_PK )) <= 15
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo OPERADORADETARJETA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].OPERADORADETARJETA_PK ))) + ' M�xima:15), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo OPERADORADETARJETA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].OPERADORADETARJETADETALLE) = 'C'
				if len( alltrim( this.Item[lni].OPERADORADETARJETADETALLE )) <= 100
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo OPERADORADETARJETADETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].OPERADORADETARJETADETALLE ))) + ' M�xima:100), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo OPERADORADETARJETADETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NUMEROCOMERCIO) = 'C'
				if len( alltrim( this.Item[lni].NUMEROCOMERCIO )) <= 15
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo NUMEROCOMERCIO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].NUMEROCOMERCIO ))) + ' M�xima:15), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NUMEROCOMERCIO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Codigo = toItemOrigen.Codigo
		toItemDestino.Operadoradetarjeta_PK = toItemOrigen.Operadoradetarjeta_PK
		toItemDestino.Operadoradetarjetadetalle = toItemOrigen.Operadoradetarjetadetalle
		toItemDestino.Numerocomercio = toItemOrigen.Numerocomercio
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
		lcRetorno = 'OperadoraDeTarjeta_pk'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Nroitem = 0
	Codigo = []
	Operadoradetarjeta_PK = []
	Operadoradetarjetadetalle = []
	Numerocomercio = []
	NroItem = 0

enddefine