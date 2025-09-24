
define class Din_DetallePICKINGDetallepreparacionmercaderia as detalle of detalle.prg


	nCantidadItems = 999
	cNombre = 'Detallepreparacionmercaderia'
	cEtiqueta = 'Unidades en preparación'
	cMensajeErrorUnicidad = 'La columna  no admite valores repetidos.'
	cNombreVisual = 'Unidades en preparación'

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
			
				.NroItem = this.Item[ tnItem ].NroItem
			
				.Articulo_PK = this.Item[ tnItem ].Articulo_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Articulo_PK', .Articulo_PK )
			
				.Color_PK = this.Item[ tnItem ].Color_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Color_PK', .Color_PK )
			
				.Talle = this.Item[ tnItem ].Talle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Talle', .Talle )
			
				.CantidadAfectada = this.Item[ tnItem ].CantidadAfectada
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CantidadAfectada', .CantidadAfectada )
			
				.Equivalencia_PK = this.Item[ tnItem ].Equivalencia_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Equivalencia_PK', .Equivalencia_PK )
			
				.CodigoOri_PK = this.Item[ tnItem ].CodigoOri_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodigoOri_PK', .CodigoOri_PK )
			
				.IdItemArticulos = this.Item[ tnItem ].IdItemArticulos
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'IdItemArticulos', .IdItemArticulos )
			
				.CantidadOriginal = this.Item[ tnItem ].CantidadOriginal
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CantidadOriginal', .CantidadOriginal )
			
				.CantidadDisponible = this.Item[ tnItem ].CantidadDisponible
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CantidadDisponible', .CantidadDisponible )
			
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
			.NroItem = this.oItem.NroItem
			.Articulo_PK = this.oItem.Articulo_PK
			.Color_PK = this.oItem.Color_PK
			.Talle = this.oItem.Talle
			.CantidadAfectada = this.oItem.CantidadAfectada
			.Equivalencia_PK = this.oItem.Equivalencia_PK
			.CodigoOri_PK = this.oItem.CodigoOri_PK
			.IdItemArticulos = this.oItem.IdItemArticulos
			.CantidadOriginal = this.oItem.CantidadOriginal
			.CantidadDisponible = this.oItem.CantidadDisponible
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
			.Item[ lnItem ].NroItem = .oItem.NroItem
			.Item[ lnItem ].Articulo_PK = .oItem.Articulo_PK
			.Item[ lnItem ].Color_PK = .oItem.Color_PK
			.Item[ lnItem ].Talle = .oItem.Talle
			.Item[ lnItem ].CantidadAfectada = .oItem.CantidadAfectada
			.Item[ lnItem ].Equivalencia_PK = .oItem.Equivalencia_PK
			.Item[ lnItem ].CodigoOri_PK = .oItem.CodigoOri_PK
			.Item[ lnItem ].IdItemArticulos = .oItem.IdItemArticulos
			.Item[ lnItem ].CantidadOriginal = .oItem.CantidadOriginal
			.Item[ lnItem ].CantidadDisponible = .oItem.CantidadDisponible
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemPICKINGDetallepreparacionmercaderia' )
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

		select c_Detallepreparacionmercaderia
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Codigo = c_Detallepreparacionmercaderia.Codigo
			loItem.NroItem = c_Detallepreparacionmercaderia.NroItem
			loItem.Articulo_PK = c_Detallepreparacionmercaderia.Articulo
			loItem.Color_PK = c_Detallepreparacionmercaderia.Color
			loItem.Talle = c_Detallepreparacionmercaderia.Talle
			loItem.CantidadAfectada = c_Detallepreparacionmercaderia.CantidadAfectada
			loItem.Equivalencia_PK = c_Detallepreparacionmercaderia.Equivalencia
			loItem.CodigoOri_PK = c_Detallepreparacionmercaderia.CodigoOri
			loItem.IdItemArticulos = c_Detallepreparacionmercaderia.IdItemArticulos
			loItem.CantidadOriginal = c_Detallepreparacionmercaderia.CantidadOriginal
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
			
			if vartype( this.Item[lni].ARTICULO_PK) = 'C'
				if len( alltrim( this.Item[lni].ARTICULO_PK )) <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo ARTICULO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].ARTICULO_PK ))) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ARTICULO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].COLOR_PK) = 'C'
				if len( alltrim( this.Item[lni].COLOR_PK )) <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo COLOR del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].COLOR_PK ))) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo COLOR del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TALLE) = 'C'
				if len( alltrim( this.Item[lni].TALLE )) <= 3
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TALLE ))) + ' Máxima:3), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CANTIDADAFECTADA) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].CANTIDADAFECTADA ) ) ) 
				lnValorDelDecimal = this.Item[lni].CANTIDADAFECTADA - int( this.Item[lni].CANTIDADAFECTADA )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 8
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo CANTIDADAFECTADA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:8), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CANTIDADAFECTADA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].EQUIVALENCIA_PK) = 'C'
				if len( alltrim( this.Item[lni].EQUIVALENCIA_PK )) <= 14
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo EQUIVALENCIA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].EQUIVALENCIA_PK ))) + ' Máxima:14), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo EQUIVALENCIA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CODIGOORI_PK) = 'C'
				if len( alltrim( this.Item[lni].CODIGOORI_PK )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGOORI del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGOORI_PK ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGOORI del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].IDITEMARTICULOS) = 'C'
				if len( alltrim( this.Item[lni].IDITEMARTICULOS )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo IDITEMARTICULOS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].IDITEMARTICULOS ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo IDITEMARTICULOS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CANTIDADORIGINAL) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].CANTIDADORIGINAL ) ) ) 
				lnValorDelDecimal = this.Item[lni].CANTIDADORIGINAL - int( this.Item[lni].CANTIDADORIGINAL )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 6
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo CANTIDADORIGINAL del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:6), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CANTIDADORIGINAL del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Articulo_PK = toItemOrigen.Articulo_PK
		toItemDestino.Color_PK = toItemOrigen.Color_PK
		toItemDestino.Talle = toItemOrigen.Talle
		toItemDestino.Cantidadafectada = toItemOrigen.Cantidadafectada
		toItemDestino.Equivalencia_PK = toItemOrigen.Equivalencia_PK
		toItemDestino.Codigoori_PK = toItemOrigen.Codigoori_PK
		toItemDestino.Iditemarticulos = toItemOrigen.Iditemarticulos
		toItemDestino.Cantidadoriginal = toItemOrigen.Cantidadoriginal
		toItemDestino.Cantidaddisponible = toItemOrigen.Cantidaddisponible
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
	Articulo_PK = []
	Color_PK = []
	Talle = []
	Cantidadafectada = 0
	Equivalencia_PK = []
	Codigoori_PK = []
	Iditemarticulos = []
	Cantidadoriginal = 0
	Cantidaddisponible = 0
	NroItem = 0

enddefine