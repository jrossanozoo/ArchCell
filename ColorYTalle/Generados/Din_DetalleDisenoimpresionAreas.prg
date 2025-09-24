
define class Din_DetalleDISENOIMPRESIONAreas as detalle of detalle.prg


	cAtributosUnicidad = 'Area'
	nCantidadItems = 999
	cNombre = 'Areas'
	cEtiqueta = 'Áreas'
	cMensajeErrorUnicidad = 'La columna Área no admite valores repetidos.'
	cNombreVisual = 'Areas'

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
			
				.BLOQUEARREGISTRO = this.Item[ tnItem ].BLOQUEARREGISTRO
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'BLOQUEARREGISTRO', .BLOQUEARREGISTRO )
			
				.Area = this.Item[ tnItem ].Area
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Area', .Area )
			
				.Tipo_PK = this.Item[ tnItem ].Tipo_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Tipo_PK', .Tipo_PK )
			
				.y = this.Item[ tnItem ].y
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'y', .y )
			
				.x = this.Item[ tnItem ].x
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'x', .x )
			
				.Ancho = this.Item[ tnItem ].Ancho
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Ancho', .Ancho )
			
				.Alto = this.Item[ tnItem ].Alto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Alto', .Alto )
			
				.Estilo_PK = this.Item[ tnItem ].Estilo_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Estilo_PK', .Estilo_PK )
			
				.EsDet = this.Item[ tnItem ].EsDet
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'EsDet', .EsDet )
			
				.Condicion = this.Item[ tnItem ].Condicion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Condicion', .Condicion )
			
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
			.BLOQUEARREGISTRO = this.oItem.BLOQUEARREGISTRO
			.Area = this.oItem.Area
			.Tipo_PK = this.oItem.Tipo_PK
			.y = this.oItem.y
			.x = this.oItem.x
			.Ancho = this.oItem.Ancho
			.Alto = this.oItem.Alto
			.Estilo_PK = this.oItem.Estilo_PK
			.EsDet = this.oItem.EsDet
			.Condicion = this.oItem.Condicion
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
			.Item[ lnItem ].BLOQUEARREGISTRO = .oItem.BLOQUEARREGISTRO
			.Item[ lnItem ].Area = .oItem.Area
			.Item[ lnItem ].Tipo_PK = .oItem.Tipo_PK
			.Item[ lnItem ].y = .oItem.y
			.Item[ lnItem ].x = .oItem.x
			.Item[ lnItem ].Ancho = .oItem.Ancho
			.Item[ lnItem ].Alto = .oItem.Alto
			.Item[ lnItem ].Estilo_PK = .oItem.Estilo_PK
			.Item[ lnItem ].EsDet = .oItem.EsDet
			.Item[ lnItem ].Condicion = .oItem.Condicion
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'ItemDISENOIMPRESIONAreas' )
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

		select c_Areas
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Codigo = c_Areas.Codigo
			loItem.NROITEM = c_Areas.NROITEM
			loItem.BLOQUEARREGISTRO = c_Areas.BLOQUEARREGISTRO
			loItem.Area = c_Areas.Area
			loItem.Tipo_PK = c_Areas.Tipo
			loItem.y = c_Areas.y
			loItem.x = c_Areas.x
			loItem.Ancho = c_Areas.Ancho
			loItem.Alto = c_Areas.Alto
			loItem.Estilo_PK = c_Areas.Estilo
			loItem.EsDet = c_Areas.EsDet
			loItem.Condicion = c_Areas.Condicion
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

		if  empty( this.item[ tnItem ].Area ) 
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
				if len( alltrim( this.Item[lni].CODIGO )) <= 40
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGO ))) + ' Máxima:40), en el detalle ' + this.cEtiqueta + '.' )
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
			
			if vartype( this.Item[lni].BLOQUEARREGISTRO) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo BLOQUEARREGISTRO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].AREA) = 'C'
				if len( alltrim( this.Item[lni].AREA )) <= 20
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo AREA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].AREA ))) + ' Máxima:20), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo AREA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TIPO_PK) = 'C'
				if len( alltrim( this.Item[lni].TIPO_PK )) <= 20
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TIPO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TIPO_PK ))) + ' Máxima:20), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TIPO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].Y) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].Y ) ) ) 
				lnValorDelDecimal = this.Item[lni].Y - int( this.Item[lni].Y )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 7
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo Y del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:7), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo Y del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].X) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].X ) ) ) 
				lnValorDelDecimal = this.Item[lni].X - int( this.Item[lni].X )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 7
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo X del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:7), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo X del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ANCHO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].ANCHO ) ) ) 
				lnValorDelDecimal = this.Item[lni].ANCHO - int( this.Item[lni].ANCHO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 7
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo ANCHO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:7), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ANCHO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ALTO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].ALTO ) ) ) 
				lnValorDelDecimal = this.Item[lni].ALTO - int( this.Item[lni].ALTO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 7
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo ALTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:7), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ALTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ESTILO_PK) = 'C'
				if len( alltrim( this.Item[lni].ESTILO_PK )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo ESTILO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].ESTILO_PK ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ESTILO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ESDET) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ESDET del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CONDICION) = 'C'
				if len( alltrim( this.Item[lni].CONDICION )) <= 254
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CONDICION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CONDICION ))) + ' Máxima:254), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CONDICION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Bloquearregistro = toItemOrigen.Bloquearregistro
		toItemDestino.Area = toItemOrigen.Area
		toItemDestino.Tipo_PK = toItemOrigen.Tipo_PK
		toItemDestino.Y = toItemOrigen.Y
		toItemDestino.X = toItemOrigen.X
		toItemDestino.Ancho = toItemOrigen.Ancho
		toItemDestino.Alto = toItemOrigen.Alto
		toItemDestino.Estilo_PK = toItemOrigen.Estilo_PK
		toItemDestino.Esdet = toItemOrigen.Esdet
		toItemDestino.Condicion = toItemOrigen.Condicion
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
		lcRetorno = 'Area'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Codigo = []
	Nroitem = 0
	Bloquearregistro = .F.
	Area = []
	Tipo_PK = []
	Y = 0
	X = 0
	Ancho = 0
	Alto = 0
	Estilo_PK = []
	Esdet = .F.
	Condicion = []
	NroItem = 0

enddefine