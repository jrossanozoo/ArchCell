
define class Din_DetalleREMITOELECTRONICODetallederemitos as detalle of detalle.prg

	Sum_Cantidad = 0
	Sum_Importeneto = 0
	Sum_Importetotal = 0

	cAtributosUnicidad = 'Remito'
	nCantidadItems = 999
	cNombre = 'Detallederemitos'
	cEtiqueta = 'Remitos'
	cMensajeErrorUnicidad = 'La columna Remito no admite valores repetidos.'
	cNombreVisual = 'Comprobantes'

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
				.Codigo = this.Item[ tnItem ].Codigo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Codigo', .Codigo )
			
				.Comprobante_PK = this.Item[ tnItem ].Comprobante_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Comprobante_PK', .Comprobante_PK )
			
				.ImporteNeto = this.Item[ tnItem ].ImporteNeto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ImporteNeto', .ImporteNeto )
			
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.Remito = this.Item[ tnItem ].Remito
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Remito', .Remito )
			
				.Cliente_PK = this.Item[ tnItem ].Cliente_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Cliente_PK', .Cliente_PK )
			
				.ClienteDetalle = this.Item[ tnItem ].ClienteDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ClienteDetalle', .ClienteDetalle )
			
				.Direccion = this.Item[ tnItem ].Direccion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Direccion', .Direccion )
			
				.Cantidad = this.Item[ tnItem ].Cantidad
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Cantidad', .Cantidad )
			
				.NoTerminadoDevuelto = this.Item[ tnItem ].NoTerminadoDevuelto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NoTerminadoDevuelto', .NoTerminadoDevuelto )
			
				.ImporteTotal = this.Item[ tnItem ].ImporteTotal
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ImporteTotal', .ImporteTotal )
			
				.Procesado = this.Item[ tnItem ].Procesado
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Procesado', .Procesado )
			
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
			.Comprobante_PK = this.oItem.Comprobante_PK
			.ImporteNeto = this.oItem.ImporteNeto
			.NROITEM = this.oItem.NROITEM
			.Remito = this.oItem.Remito
			.Cliente_PK = this.oItem.Cliente_PK
			.ClienteDetalle = this.oItem.ClienteDetalle
			.Direccion = this.oItem.Direccion
			.Cantidad = this.oItem.Cantidad
			.NoTerminadoDevuelto = this.oItem.NoTerminadoDevuelto
			.ImporteTotal = this.oItem.ImporteTotal
			.Procesado = this.oItem.Procesado
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
			.Item[ lnItem ].Comprobante_PK = .oItem.Comprobante_PK
			.Item[ lnItem ].ImporteNeto = .oItem.ImporteNeto
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].Remito = .oItem.Remito
			.Item[ lnItem ].Cliente_PK = .oItem.Cliente_PK
			.Item[ lnItem ].ClienteDetalle = .oItem.ClienteDetalle
			.Item[ lnItem ].Direccion = .oItem.Direccion
			.Item[ lnItem ].Cantidad = .oItem.Cantidad
			.Item[ lnItem ].NoTerminadoDevuelto = .oItem.NoTerminadoDevuelto
			.Item[ lnItem ].ImporteTotal = .oItem.ImporteTotal
			.Item[ lnItem ].Procesado = .oItem.Procesado
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Sumarizar() as boolean
		local lnItem as integer, loItem as Object, lnSum_Cantidad as Number, lnSum_Importeneto as Number, lnSum_Importetotal as Number

		with this
			lnSum_Cantidad = 0
			lnSum_Importeneto = 0
			lnSum_Importetotal = 0
			if this.lEsNavegacion
				if select( 'c_Detallederemitos' ) > 0 and reccount( 'c_Detallederemitos' ) > 0
					sum Cantidad, Importeneto, Importetotal;
						 to ;
						 lnSum_Cantidad, lnSum_Importeneto, lnSum_Importetotal
				endif
				this.lEsNavegacion = .f.
			else
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							lnSum_Cantidad = lnSum_Cantidad + .Cantidad
							lnSum_Importeneto = lnSum_Importeneto + .Importeneto
							lnSum_Importetotal = lnSum_Importetotal + .Importetotal
						endwith
					endif
				endfor

				if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
					loItem = .oItem
					with loItem 
						lnSum_Cantidad = lnSum_Cantidad + .Cantidad
						lnSum_Importeneto = lnSum_Importeneto + .Importeneto
						lnSum_Importetotal = lnSum_Importetotal + .Importetotal
					endwith
				endif
			endif

			if .Sum_Cantidad != lnSum_Cantidad
				.Sum_Cantidad = lnSum_Cantidad
				.EventoCambioSum_Cantidad()
			endif
			if .Sum_Importeneto != lnSum_Importeneto
				.Sum_Importeneto = lnSum_Importeneto
				.EventoCambioSum_Importeneto()
			endif
			if .Sum_Importetotal != lnSum_Importetotal
				.Sum_Importetotal = lnSum_Importetotal
				.EventoCambioSum_Importetotal()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Cantidad() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Importeneto() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Importetotal() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalizar( toItem as Object ) as Void
		local lnItem as integer, loItem as Object, lnSum_Cantidad as Number, lnSum_Importeneto as Number, lnSum_Importetotal as Number

		with this
			lnSum_Cantidad = 0
			lnSum_Importeneto = 0
			lnSum_Importetotal = 0
			if !this.lEsNavegacion
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							lnSum_Cantidad = lnSum_Cantidad + .Cantidad
							lnSum_Importeneto = lnSum_Importeneto + .Importeneto
							lnSum_Importetotal = lnSum_Importetotal + .Importetotal
						endwith
					endif
				endfor

			endif
			if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
				loItem = .oItem
				with loItem 
					lnSum_Cantidad = lnSum_Cantidad + .Cantidad
					lnSum_Importeneto = lnSum_Importeneto + .Importeneto
					lnSum_Importetotal = lnSum_Importetotal + .Importetotal
				endwith
			endif

			if .Sum_Cantidad != lnSum_Cantidad
				.Sum_Cantidad = lnSum_Cantidad
				.EventoCambioSum_Cantidad()
			endif
			if .Sum_Importeneto != lnSum_Importeneto
				.Sum_Importeneto = lnSum_Importeneto
				.EventoCambioSum_Importeneto()
			endif
			if .Sum_Importetotal != lnSum_Importetotal
				.Sum_Importetotal = lnSum_Importetotal
				.EventoCambioSum_Importetotal()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Acumular( tlForzar as Boolean, tcAtributo as String, tnValor as Decimal, tnValorAnt as Decimal ) as Void
		local lnItem as integer, loItem as Object, lnSum_Cantidad as Number, lnSum_Importeneto as Number, lnSum_Importetotal as Number

		do case
		case tnValor = tnValorAnt
		case tcAtributo == 'Cantidad'
			this.Sum_Cantidad = this.Sum_Cantidad - tnValorAnt + tnValor
			this.EventoCambioSum_Cantidad()
		case tcAtributo == 'Importeneto'
			this.Sum_Importeneto = this.Sum_Importeneto - tnValorAnt + tnValor
			this.EventoCambioSum_Importeneto()
		case tcAtributo == 'Importetotal'
			this.Sum_Importetotal = this.Sum_Importetotal - tnValorAnt + tnValor
			this.EventoCambioSum_Importetotal()

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
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemREMITOELECTRONICODetallederemitos' )
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

		select c_Detallederemitos
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Codigo = c_Detallederemitos.Codigo
			loItem.Comprobante_PK = c_Detallederemitos.Comprobante
			loItem.ImporteNeto = c_Detallederemitos.ImporteNeto
			loItem.NROITEM = c_Detallederemitos.NROITEM
			loItem.Remito = c_Detallederemitos.Remito
			loItem.Cliente_PK = c_Detallederemitos.Cliente
			loItem.ClienteDetalle = c_Detallederemitos.ClienteDetalle
			loItem.Direccion = c_Detallederemitos.Direccion
			loItem.Cantidad = c_Detallederemitos.Cantidad
			loItem.NoTerminadoDevuelto = c_Detallederemitos.NoTerminadoDevuelto
			loItem.ImporteTotal = c_Detallederemitos.ImporteTotal
			loItem.Procesado = c_Detallederemitos.Procesado
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

		if  empty( this.item[ tnItem ].Remito ) 
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
					this.AgregarInformacion( 'La longitud entera del valor del atributo CODIGO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' M�xima:8), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].COMPROBANTE_PK) = 'C'
				if len( alltrim( this.Item[lni].COMPROBANTE_PK )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo COMPROBANTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].COMPROBANTE_PK ))) + ' M�xima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo COMPROBANTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].IMPORTENETO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].IMPORTENETO ) ) ) 
				lnValorDelDecimal = this.Item[lni].IMPORTENETO - int( this.Item[lni].IMPORTENETO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo IMPORTENETO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' M�xima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo IMPORTENETO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
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
			
			if vartype( this.Item[lni].REMITO) = 'C'
				if len( alltrim( this.Item[lni].REMITO )) <= 20
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo REMITO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].REMITO ))) + ' M�xima:20), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo REMITO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CLIENTE_PK) = 'C'
				if len( alltrim( this.Item[lni].CLIENTE_PK )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CLIENTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CLIENTE_PK ))) + ' M�xima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CLIENTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CLIENTEDETALLE) = 'C'
				if len( alltrim( this.Item[lni].CLIENTEDETALLE )) <= 185
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CLIENTEDETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CLIENTEDETALLE ))) + ' M�xima:185), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CLIENTEDETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].DIRECCION) = 'C'
				if len( alltrim( this.Item[lni].DIRECCION )) <= 220
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo DIRECCION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].DIRECCION ))) + ' M�xima:220), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo DIRECCION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CANTIDAD) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].CANTIDAD ) ) ) 
				lnValorDelDecimal = this.Item[lni].CANTIDAD - int( this.Item[lni].CANTIDAD )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo CANTIDAD del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' M�xima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CANTIDAD del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NOTERMINADODEVUELTO) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NOTERMINADODEVUELTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].IMPORTETOTAL) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].IMPORTETOTAL ) ) ) 
				lnValorDelDecimal = this.Item[lni].IMPORTETOTAL - int( this.Item[lni].IMPORTETOTAL )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo IMPORTETOTAL del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' M�xima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo IMPORTETOTAL del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PROCESADO) = 'C'
				if len( alltrim( this.Item[lni].PROCESADO )) <= 15
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo PROCESADO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].PROCESADO ))) + ' M�xima:15), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PROCESADO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Comprobante_PK = toItemOrigen.Comprobante_PK
		toItemDestino.Importeneto = toItemOrigen.Importeneto
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Remito = toItemOrigen.Remito
		toItemDestino.Cliente_PK = toItemOrigen.Cliente_PK
		toItemDestino.Clientedetalle = toItemOrigen.Clientedetalle
		toItemDestino.Direccion = toItemOrigen.Direccion
		toItemDestino.Cantidad = toItemOrigen.Cantidad
		toItemDestino.Noterminadodevuelto = toItemOrigen.Noterminadodevuelto
		toItemDestino.Importetotal = toItemOrigen.Importetotal
		toItemDestino.Procesado = toItemOrigen.Procesado
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
		lcRetorno = 'Remito'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Codigo = 0
	Comprobante_PK = []
	Importeneto = 0
	Nroitem = 0
	Remito = []
	Cliente_PK = []
	Clientedetalle = []
	Direccion = []
	Cantidad = 0
	Noterminadodevuelto = .F.
	Importetotal = 0
	Procesado = []
	NroItem = 0

enddefine