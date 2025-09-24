
define class Din_DetallePICKINGDetallecomprobantes as detalle of detalle.prg

	Sum_Cantidad = 0

	cAtributosUnicidad = 'Numero'
	nCantidadItems = 999
	cNombre = 'Detallecomprobantes'
	cEtiqueta = 'Comprobantes a controlar'
	cMensajeErrorUnicidad = 'La columna Identificador no admite valores repetidos.'
	cNombreVisual = 'Comprobantes a controlar'

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
			
				.Cliente = this.Item[ tnItem ].Cliente
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Cliente', .Cliente )
			
				.EntregaPosterior = this.Item[ tnItem ].EntregaPosterior
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'EntregaPosterior', .EntregaPosterior )
			
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.Numero = this.Item[ tnItem ].Numero
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Numero', .Numero )
			
				.Fecha = this.Item[ tnItem ].Fecha
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Fecha', .Fecha )
			
				.OrigenDestino_PK = this.Item[ tnItem ].OrigenDestino_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'OrigenDestino_PK', .OrigenDestino_PK )
			
				.Remito = this.Item[ tnItem ].Remito
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Remito', .Remito )
			
				.OrigenDestinoDetalle = this.Item[ tnItem ].OrigenDestinoDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'OrigenDestinoDetalle', .OrigenDestinoDetalle )
			
				.Cantidad = this.Item[ tnItem ].Cantidad
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Cantidad', .Cantidad )
			
				.IdDeCaja = this.Item[ tnItem ].IdDeCaja
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'IdDeCaja', .IdDeCaja )
			
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
			.Cliente = this.oItem.Cliente
			.EntregaPosterior = this.oItem.EntregaPosterior
			.NROITEM = this.oItem.NROITEM
			.Numero = this.oItem.Numero
			.Fecha = this.oItem.Fecha
			.OrigenDestino_PK = this.oItem.OrigenDestino_PK
			.Remito = this.oItem.Remito
			.OrigenDestinoDetalle = this.oItem.OrigenDestinoDetalle
			.Cantidad = this.oItem.Cantidad
			.IdDeCaja = this.oItem.IdDeCaja
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
			.Item[ lnItem ].Cliente = .oItem.Cliente
			.Item[ lnItem ].EntregaPosterior = .oItem.EntregaPosterior
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].Numero = .oItem.Numero
			.Item[ lnItem ].Fecha = .oItem.Fecha
			.Item[ lnItem ].OrigenDestino_PK = .oItem.OrigenDestino_PK
			.Item[ lnItem ].Remito = .oItem.Remito
			.Item[ lnItem ].OrigenDestinoDetalle = .oItem.OrigenDestinoDetalle
			.Item[ lnItem ].Cantidad = .oItem.Cantidad
			.Item[ lnItem ].IdDeCaja = .oItem.IdDeCaja
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Sumarizar() as boolean
		local lnItem as integer, loItem as Object, lnSum_Cantidad as Number

		with this
			lnSum_Cantidad = 0
			if this.lEsNavegacion
				if select( 'c_Detallecomprobantes' ) > 0 and reccount( 'c_Detallecomprobantes' ) > 0
					sum Cantidad;
						 to ;
						 lnSum_Cantidad
				endif
				this.lEsNavegacion = .f.
			else
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							lnSum_Cantidad = lnSum_Cantidad + .Cantidad
						endwith
					endif
				endfor

				if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
					loItem = .oItem
					with loItem 
						lnSum_Cantidad = lnSum_Cantidad + .Cantidad
					endwith
				endif
			endif

			if .Sum_Cantidad != lnSum_Cantidad
				.Sum_Cantidad = lnSum_Cantidad
				.EventoCambioSum_Cantidad()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Cantidad() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalizar( toItem as Object ) as Void
		local lnItem as integer, loItem as Object, lnSum_Cantidad as Number

		with this
			lnSum_Cantidad = 0
			if !this.lEsNavegacion
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							lnSum_Cantidad = lnSum_Cantidad + .Cantidad
						endwith
					endif
				endfor

			endif
			if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
				loItem = .oItem
				with loItem 
					lnSum_Cantidad = lnSum_Cantidad + .Cantidad
				endwith
			endif

			if .Sum_Cantidad != lnSum_Cantidad
				.Sum_Cantidad = lnSum_Cantidad
				.EventoCambioSum_Cantidad()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Acumular( tlForzar as Boolean, tcAtributo as String, tnValor as Decimal, tnValorAnt as Decimal ) as Void
		local lnItem as integer, loItem as Object, lnSum_Cantidad as Number

		do case
		case tnValor = tnValorAnt
		case tcAtributo == 'Cantidad'
			this.Sum_Cantidad = this.Sum_Cantidad - tnValorAnt + tnValor
			this.EventoCambioSum_Cantidad()

		endcase
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Limpiar() as boolean
		DoDefault()
		this.Sumarizar()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'ItemPICKINGDetallecomprobantes' )
			this.enlazar( 'oItem.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oItem.EventoObtenerInformacion', 'inyectarInformacion' )
			this.oItem.inicializar()
			bindevent( this.oItem, 'AcumularSumarizado', this, 'Acumular', 0) 
			bindevent( this.oItem, 'TotalizarSumarizado', this, 'Totalizar', 0) 
			bindevent( this.oItem, 'CambioSumarizado', this, 'Sumarizar', 0) 
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
			loItem.Cliente = c_Detallecomprobantes.Cliente
			loItem.EntregaPosterior = c_Detallecomprobantes.EntregaPosterior
			loItem.NROITEM = c_Detallecomprobantes.NROITEM
			loItem.Numero = c_Detallecomprobantes.Numero
			loItem.Fecha = goLibrerias.ObtenerFechaFormateada( c_Detallecomprobantes.Fecha )
			loItem.OrigenDestino_PK = c_Detallecomprobantes.OrigenDestino
			loItem.Remito = c_Detallecomprobantes.Remito
			loItem.OrigenDestinoDetalle = c_Detallecomprobantes.OrigenDestinoDetalle
			loItem.Cantidad = c_Detallecomprobantes.Cantidad
			loItem.IdDeCaja = c_Detallecomprobantes.IdDeCaja
			loItem.NroItem = lnI 
			this.AgregarItemPlano( loItem )
			lnI = lnI + 1
		endscan

		this.Sumarizar()

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
			
			if vartype( this.Item[lni].CLIENTE) = 'C'
				if len( alltrim( this.Item[lni].CLIENTE )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CLIENTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CLIENTE ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CLIENTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ENTREGAPOSTERIOR) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].ENTREGAPOSTERIOR ) ) ) 
				lnValorDelDecimal = this.Item[lni].ENTREGAPOSTERIOR - int( this.Item[lni].ENTREGAPOSTERIOR )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 1
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo ENTREGAPOSTERIOR del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:1), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ENTREGAPOSTERIOR del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if inlist(vartype( this.Item[lni].FECHA),'D','T')
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo FECHA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ORIGENDESTINO_PK) = 'C'
				if len( alltrim( this.Item[lni].ORIGENDESTINO_PK )) <= 8
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo ORIGENDESTINO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].ORIGENDESTINO_PK ))) + ' Máxima:8), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ORIGENDESTINO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].REMITO) = 'C'
				if len( alltrim( this.Item[lni].REMITO )) <= 15
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo REMITO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].REMITO ))) + ' Máxima:15), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo REMITO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ORIGENDESTINODETALLE) = 'C'
				if len( alltrim( this.Item[lni].ORIGENDESTINODETALLE )) <= 185
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo ORIGENDESTINODETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].ORIGENDESTINODETALLE ))) + ' Máxima:185), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ORIGENDESTINODETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CANTIDAD) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].CANTIDAD ) ) ) 
				lnValorDelDecimal = this.Item[lni].CANTIDAD - int( this.Item[lni].CANTIDAD )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 11
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo CANTIDAD del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:11), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CANTIDAD del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].IDDECAJA) = 'C'
				if len( alltrim( this.Item[lni].IDDECAJA )) <= 250
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo IDDECAJA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].IDDECAJA ))) + ' Máxima:250), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo IDDECAJA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Cliente = toItemOrigen.Cliente
		toItemDestino.Entregaposterior = toItemOrigen.Entregaposterior
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Numero = toItemOrigen.Numero
		toItemDestino.Fecha = toItemOrigen.Fecha
		toItemDestino.Origendestino_PK = toItemOrigen.Origendestino_PK
		toItemDestino.Remito = toItemOrigen.Remito
		toItemDestino.Origendestinodetalle = toItemOrigen.Origendestinodetalle
		toItemDestino.Cantidad = toItemOrigen.Cantidad
		toItemDestino.Iddecaja = toItemOrigen.Iddecaja
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Actualizar( tcClave as String ) as Void
		DoDefault( tcClave )
		this.Sumarizar()
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
	Cliente = []
	Entregaposterior = 0
	Nroitem = 0
	Numero = []
	Fecha = ctod( '  /  /    ' )
	Origendestino_PK = []
	Remito = []
	Origendestinodetalle = []
	Cantidad = 0
	Iddecaja = []
	NroItem = 0

enddefine