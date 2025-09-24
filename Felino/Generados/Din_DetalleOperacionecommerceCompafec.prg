
define class Din_DetalleOPERACIONECOMMERCECompafec as detalle of detalle.prg


	nCantidadItems = 999
	cNombre = 'Compafec'
	cEtiqueta = 'Compafec'
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
			
				.TipoComprobante = this.Item[ tnItem ].TipoComprobante
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TipoComprobante', .TipoComprobante )
			
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.TipoCompCaracter = this.Item[ tnItem ].TipoCompCaracter
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TipoCompCaracter', .TipoCompCaracter )
			
				.Letra = this.Item[ tnItem ].Letra
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Letra', .Letra )
			
				.PuntoDeVenta = this.Item[ tnItem ].PuntoDeVenta
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PuntoDeVenta', .PuntoDeVenta )
			
				.Numero = this.Item[ tnItem ].Numero
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Numero', .Numero )
			
				.Fecha = this.Item[ tnItem ].Fecha
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Fecha', .Fecha )
			
				.Total = this.Item[ tnItem ].Total
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Total', .Total )
			
				.Vendedor = this.Item[ tnItem ].Vendedor
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Vendedor', .Vendedor )
			
				.Tipo = this.Item[ tnItem ].Tipo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Tipo', .Tipo )
			
				.Afecta = this.Item[ tnItem ].Afecta
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Afecta', .Afecta )
			
				.Interviniente = this.Item[ tnItem ].Interviniente
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Interviniente', .Interviniente )
			
				.NombreEntidad = this.Item[ tnItem ].NombreEntidad
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NombreEntidad', .NombreEntidad )
			
				.CodigoEntidad = this.Item[ tnItem ].CodigoEntidad
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodigoEntidad', .CodigoEntidad )
			
				.Origen = this.Item[ tnItem ].Origen
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Origen', .Origen )
			
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
			.TipoComprobante = this.oItem.TipoComprobante
			.NROITEM = this.oItem.NROITEM
			.TipoCompCaracter = this.oItem.TipoCompCaracter
			.Letra = this.oItem.Letra
			.PuntoDeVenta = this.oItem.PuntoDeVenta
			.Numero = this.oItem.Numero
			.Fecha = this.oItem.Fecha
			.Total = this.oItem.Total
			.Vendedor = this.oItem.Vendedor
			.Tipo = this.oItem.Tipo
			.Afecta = this.oItem.Afecta
			.Interviniente = this.oItem.Interviniente
			.NombreEntidad = this.oItem.NombreEntidad
			.CodigoEntidad = this.oItem.CodigoEntidad
			.Origen = this.oItem.Origen
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
			.Item[ lnItem ].TipoComprobante = .oItem.TipoComprobante
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].TipoCompCaracter = .oItem.TipoCompCaracter
			.Item[ lnItem ].Letra = .oItem.Letra
			.Item[ lnItem ].PuntoDeVenta = .oItem.PuntoDeVenta
			.Item[ lnItem ].Numero = .oItem.Numero
			.Item[ lnItem ].Fecha = .oItem.Fecha
			.Item[ lnItem ].Total = .oItem.Total
			.Item[ lnItem ].Vendedor = .oItem.Vendedor
			.Item[ lnItem ].Tipo = .oItem.Tipo
			.Item[ lnItem ].Afecta = .oItem.Afecta
			.Item[ lnItem ].Interviniente = .oItem.Interviniente
			.Item[ lnItem ].NombreEntidad = .oItem.NombreEntidad
			.Item[ lnItem ].CodigoEntidad = .oItem.CodigoEntidad
			.Item[ lnItem ].Origen = .oItem.Origen
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemOPERACIONECOMMERCECompafec' )
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

		select c_Compafec
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Codigo = c_Compafec.Codigo
			loItem.TipoComprobante = c_Compafec.TipoComprobante
			loItem.NROITEM = c_Compafec.NROITEM
			loItem.TipoCompCaracter = c_Compafec.TipoCompCaracter
			loItem.Letra = c_Compafec.Letra
			loItem.PuntoDeVenta = c_Compafec.PuntoDeVenta
			loItem.Numero = c_Compafec.Numero
			loItem.Fecha = goLibrerias.ObtenerFechaFormateada( c_Compafec.Fecha )
			loItem.Total = c_Compafec.Total
			loItem.Vendedor = c_Compafec.Vendedor
			loItem.Tipo = c_Compafec.Tipo
			loItem.Afecta = c_Compafec.Afecta
			loItem.Interviniente = c_Compafec.Interviniente
			loItem.NombreEntidad = c_Compafec.NombreEntidad
			loItem.CodigoEntidad = c_Compafec.CodigoEntidad
			loItem.Origen = c_Compafec.Origen
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

		if  empty( this.item[ tnItem ].Tipocomprobante ) or ; 			 empty( this.item[ tnItem ].Tipocompcaracter ) or ; 			 empty( this.item[ tnItem ].Puntodeventa ) or ; 			 empty( this.item[ tnItem ].Numero ) or ; 			 empty( this.item[ tnItem ].Fecha ) or ; 			 empty( this.item[ tnItem ].Tipo ) 
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
			
			if vartype( this.Item[lni].TIPOCOMPROBANTE) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].TIPOCOMPROBANTE ) ) ) 
				lnValorDelDecimal = this.Item[lni].TIPOCOMPROBANTE - int( this.Item[lni].TIPOCOMPROBANTE )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo TIPOCOMPROBANTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TIPOCOMPROBANTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].TIPOCOMPCARACTER) = 'C'
				if len( alltrim( this.Item[lni].TIPOCOMPCARACTER )) <= 100
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TIPOCOMPCARACTER del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TIPOCOMPCARACTER ))) + ' Máxima:100), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TIPOCOMPCARACTER del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].LETRA) = 'C'
				if len( alltrim( this.Item[lni].LETRA )) <= 1
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo LETRA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].LETRA ))) + ' Máxima:1), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo LETRA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PUNTODEVENTA) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].PUNTODEVENTA ) ) ) 
				lnValorDelDecimal = this.Item[lni].PUNTODEVENTA - int( this.Item[lni].PUNTODEVENTA )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 4
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo PUNTODEVENTA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:4), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PUNTODEVENTA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NUMERO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].NUMERO ) ) ) 
				lnValorDelDecimal = this.Item[lni].NUMERO - int( this.Item[lni].NUMERO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 8
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo NUMERO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:8), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NUMERO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if inlist(vartype( this.Item[lni].FECHA),'D','T')
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo FECHA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TOTAL) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].TOTAL ) ) ) 
				lnValorDelDecimal = this.Item[lni].TOTAL - int( this.Item[lni].TOTAL )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 7
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo TOTAL del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:7), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TOTAL del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].VENDEDOR) = 'C'
				if len( alltrim( this.Item[lni].VENDEDOR )) <= 4
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo VENDEDOR del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].VENDEDOR ))) + ' Máxima:4), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo VENDEDOR del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TIPO) = 'C'
				if len( alltrim( this.Item[lni].TIPO )) <= 15
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TIPO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TIPO ))) + ' Máxima:15), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TIPO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].AFECTA) = 'C'
				if len( alltrim( this.Item[lni].AFECTA )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo AFECTA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].AFECTA ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo AFECTA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].INTERVINIENTE) = 'C'
				if len( alltrim( this.Item[lni].INTERVINIENTE )) <= 50
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo INTERVINIENTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].INTERVINIENTE ))) + ' Máxima:50), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo INTERVINIENTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NOMBREENTIDAD) = 'C'
				if len( alltrim( this.Item[lni].NOMBREENTIDAD )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo NOMBREENTIDAD del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].NOMBREENTIDAD ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NOMBREENTIDAD del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CODIGOENTIDAD) = 'C'
				if len( alltrim( this.Item[lni].CODIGOENTIDAD )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGOENTIDAD del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGOENTIDAD ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGOENTIDAD del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ORIGEN) = 'C'
				if len( alltrim( this.Item[lni].ORIGEN )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo ORIGEN del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].ORIGEN ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ORIGEN del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Tipocomprobante = toItemOrigen.Tipocomprobante
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Tipocompcaracter = toItemOrigen.Tipocompcaracter
		toItemDestino.Letra = toItemOrigen.Letra
		toItemDestino.Puntodeventa = toItemOrigen.Puntodeventa
		toItemDestino.Numero = toItemOrigen.Numero
		toItemDestino.Fecha = toItemOrigen.Fecha
		toItemDestino.Total = toItemOrigen.Total
		toItemDestino.Vendedor = toItemOrigen.Vendedor
		toItemDestino.Tipo = toItemOrigen.Tipo
		toItemDestino.Afecta = toItemOrigen.Afecta
		toItemDestino.Interviniente = toItemOrigen.Interviniente
		toItemDestino.Nombreentidad = toItemOrigen.Nombreentidad
		toItemDestino.Codigoentidad = toItemOrigen.Codigoentidad
		toItemDestino.Origen = toItemOrigen.Origen
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
		lcRetorno = 'TipoCompCaracter'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Codigo = []
	Tipocomprobante = 0
	Nroitem = 0
	Tipocompcaracter = []
	Letra = []
	Puntodeventa = 0
	Numero = 0
	Fecha = ctod( '  /  /    ' )
	Total = 0
	Vendedor = []
	Tipo = []
	Afecta = []
	Interviniente = []
	Nombreentidad = []
	Codigoentidad = []
	Origen = []
	NroItem = 0

enddefine