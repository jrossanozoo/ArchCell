
define class Din_DetalleCALCULODEPRECIOSModprecios as detalle of detalle.prg


	nCantidadItems = 999
	cNombre = 'Modprecios'
	cEtiqueta = 'Modprecios'
	cMensajeErrorUnicidad = 'La columna  no admite valores repetidos.'
	cNombreVisual = 'Listas de Precios'

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
			
				.LPrecio_PK = this.Item[ tnItem ].LPrecio_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'LPrecio_PK', .LPrecio_PK )
			
				.LPrecioDetalle = this.Item[ tnItem ].LPrecioDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'LPrecioDetalle', .LPrecioDetalle )
			
				.Accion = this.Item[ tnItem ].Accion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Accion', .Accion )
			
				.LPrecioA_PK = this.Item[ tnItem ].LPrecioA_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'LPrecioA_PK', .LPrecioA_PK )
			
				.Valor = this.Item[ tnItem ].Valor
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Valor', .Valor )
			
				.Formula_PK = this.Item[ tnItem ].Formula_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Formula_PK', .Formula_PK )
			
				.Redondeo_PK = this.Item[ tnItem ].Redondeo_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Redondeo_PK', .Redondeo_PK )
			
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
			.LPrecio_PK = this.oItem.LPrecio_PK
			.LPrecioDetalle = this.oItem.LPrecioDetalle
			.Accion = this.oItem.Accion
			.LPrecioA_PK = this.oItem.LPrecioA_PK
			.Valor = this.oItem.Valor
			.Formula_PK = this.oItem.Formula_PK
			.Redondeo_PK = this.oItem.Redondeo_PK
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
			.Item[ lnItem ].LPrecio_PK = .oItem.LPrecio_PK
			.Item[ lnItem ].LPrecioDetalle = .oItem.LPrecioDetalle
			.Item[ lnItem ].Accion = .oItem.Accion
			.Item[ lnItem ].LPrecioA_PK = .oItem.LPrecioA_PK
			.Item[ lnItem ].Valor = .oItem.Valor
			.Item[ lnItem ].Formula_PK = .oItem.Formula_PK
			.Item[ lnItem ].Redondeo_PK = .oItem.Redondeo_PK
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemCALCULODEPRECIOSModprecios' )
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

		select c_Modprecios
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Codigo = c_Modprecios.Codigo
			loItem.NROITEM = c_Modprecios.NROITEM
			loItem.LPrecio_PK = c_Modprecios.LPrecio
			loItem.LPrecioDetalle = c_Modprecios.LPrecioDetalle
			loItem.Accion = c_Modprecios.Accion
			loItem.LPrecioA_PK = c_Modprecios.LPrecioA
			loItem.Valor = c_Modprecios.Valor
			loItem.Formula_PK = c_Modprecios.Formula
			loItem.Redondeo_PK = c_Modprecios.Redondeo
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

		if  empty( this.item[ tnItem ].Lprecio_PK ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc


	*-----------------------------------------------------------------------------------------
	Function ValidarFormatoAtributos() as boolean
	local lnLargoEntero as integer, lnValorDelDecimal as integer, lnLargoDecimal as integer, llRetorno as boolean, lnI as Integer

		llRetorno = dodefault()
		for lni = 1 to this.Count
			
			if vartype( this.Item[lni].CODIGO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].CODIGO ) ) ) 
				lnValorDelDecimal = this.Item[lni].CODIGO - int( this.Item[lni].CODIGO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 8
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo CODIGO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:8), en el detalle ' + this.cEtiqueta + '.' )
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
			
			if vartype( this.Item[lni].LPRECIO_PK) = 'C'
				if len( alltrim( this.Item[lni].LPRECIO_PK )) <= 6
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo LPRECIO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].LPRECIO_PK ))) + ' Máxima:6), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo LPRECIO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].LPRECIODETALLE) = 'C'
				if len( alltrim( this.Item[lni].LPRECIODETALLE )) <= 30
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo LPRECIODETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].LPRECIODETALLE ))) + ' Máxima:30), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo LPRECIODETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ACCION) = 'C'
				if len( alltrim( this.Item[lni].ACCION )) <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo ACCION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].ACCION ))) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ACCION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].LPRECIOA_PK) = 'C'
				if len( alltrim( this.Item[lni].LPRECIOA_PK )) <= 6
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo LPRECIOA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].LPRECIOA_PK ))) + ' Máxima:6), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo LPRECIOA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].VALOR) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].VALOR ) ) ) 
				lnValorDelDecimal = this.Item[lni].VALOR - int( this.Item[lni].VALOR )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo VALOR del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo VALOR del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].FORMULA_PK) = 'C'
				if len( alltrim( this.Item[lni].FORMULA_PK )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo FORMULA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].FORMULA_PK ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo FORMULA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].REDONDEO_PK) = 'C'
				if len( alltrim( this.Item[lni].REDONDEO_PK )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo REDONDEO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].REDONDEO_PK ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo REDONDEO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Lprecio_PK = toItemOrigen.Lprecio_PK
		toItemDestino.Lpreciodetalle = toItemOrigen.Lpreciodetalle
		toItemDestino.Accion = toItemOrigen.Accion
		toItemDestino.Lprecioa_PK = toItemOrigen.Lprecioa_PK
		toItemDestino.Valor = toItemOrigen.Valor
		toItemDestino.Formula_PK = toItemOrigen.Formula_PK
		toItemDestino.Redondeo_PK = toItemOrigen.Redondeo_PK
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
		lcRetorno = 'LPrecio_pk'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Codigo = 0
	Nroitem = 0
	Lprecio_PK = []
	Lpreciodetalle = []
	Accion = []
	Lprecioa_PK = []
	Valor = 0
	Formula_PK = []
	Redondeo_PK = []
	NroItem = 0

enddefine