
define class Din_DetalleFACTURAELECTRONICAImpuestosdetalle as DetalleImpuestos of DetalleImpuestos.Prg

	Sum_Montodeimpuestointerno = 0
	Sum_Montodeimpuestointernosindescuento = 0
	Sum_Montodeiva = 0
	Sum_Montodeivasindescuento = 0
	Sum_Montonogravado = 0
	Sum_Montonogravadosindescuento = 0

	nCantidadItems = 999
	cNombre = 'Impuestosdetalle'
	cEtiqueta = 'Impuestos'
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
			
				.PorcentajeDeIva = this.Item[ tnItem ].PorcentajeDeIva
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PorcentajeDeIva', .PorcentajeDeIva )
			
				.MontoDeIva = this.Item[ tnItem ].MontoDeIva
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoDeIva', .MontoDeIva )
			
				.MontoDeIvaSinDescuento = this.Item[ tnItem ].MontoDeIvaSinDescuento
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoDeIvaSinDescuento', .MontoDeIvaSinDescuento )
			
				.MontoNoGravado = this.Item[ tnItem ].MontoNoGravado
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoNoGravado', .MontoNoGravado )
			
				.MontoNoGravadoSinDescuento = this.Item[ tnItem ].MontoNoGravadoSinDescuento
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoNoGravadoSinDescuento', .MontoNoGravadoSinDescuento )
			
				.MontoDeImpuestoInterno = this.Item[ tnItem ].MontoDeImpuestoInterno
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoDeImpuestoInterno', .MontoDeImpuestoInterno )
			
				.MontoDeImpuestoInternoSinDescuento = this.Item[ tnItem ].MontoDeImpuestoInternoSinDescuento
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoDeImpuestoInternoSinDescuento', .MontoDeImpuestoInternoSinDescuento )
			
				.NROITEM = this.Item[ tnItem ].NROITEM
			
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
			.PorcentajeDeIva = this.oItem.PorcentajeDeIva
			.MontoDeIva = this.oItem.MontoDeIva
			.MontoDeIvaSinDescuento = this.oItem.MontoDeIvaSinDescuento
			.MontoNoGravado = this.oItem.MontoNoGravado
			.MontoNoGravadoSinDescuento = this.oItem.MontoNoGravadoSinDescuento
			.MontoDeImpuestoInterno = this.oItem.MontoDeImpuestoInterno
			.MontoDeImpuestoInternoSinDescuento = this.oItem.MontoDeImpuestoInternoSinDescuento
			.NROITEM = this.oItem.NROITEM
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
			.Item[ lnItem ].PorcentajeDeIva = .oItem.PorcentajeDeIva
			.Item[ lnItem ].MontoDeIva = .oItem.MontoDeIva
			.Item[ lnItem ].MontoDeIvaSinDescuento = .oItem.MontoDeIvaSinDescuento
			.Item[ lnItem ].MontoNoGravado = .oItem.MontoNoGravado
			.Item[ lnItem ].MontoNoGravadoSinDescuento = .oItem.MontoNoGravadoSinDescuento
			.Item[ lnItem ].MontoDeImpuestoInterno = .oItem.MontoDeImpuestoInterno
			.Item[ lnItem ].MontoDeImpuestoInternoSinDescuento = .oItem.MontoDeImpuestoInternoSinDescuento
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Sumarizar() as boolean
		local lnItem as integer, loItem as Object, lnSum_Montodeimpuestointerno as Number, lnSum_Montodeimpuestointernosindescuento as Number, lnSum_Montodeiva as Number, lnSum_Montodeivasindescuento as Number, lnSum_Montonogravado as Number, lnSum_Montonogravadosindescuento as Number

		with this
			lnSum_Montodeimpuestointerno = 0
			lnSum_Montodeimpuestointernosindescuento = 0
			lnSum_Montodeiva = 0
			lnSum_Montodeivasindescuento = 0
			lnSum_Montonogravado = 0
			lnSum_Montonogravadosindescuento = 0
			if this.lEsNavegacion
				if select( 'c_Impuestosdetalle' ) > 0 and reccount( 'c_Impuestosdetalle' ) > 0
					sum Montodeimpuestointerno, Montodeimpuestointernosindescuento, Montodeiva, Montodeivasindescuento, Montonogravado, Montonogravadosindescuento;
						 to ;
						 lnSum_Montodeimpuestointerno, lnSum_Montodeimpuestointernosindescuento, lnSum_Montodeiva, lnSum_Montodeivasindescuento, lnSum_Montonogravado, lnSum_Montonogravadosindescuento
				endif
				this.lEsNavegacion = .f.
			else
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							lnSum_Montodeimpuestointerno = lnSum_Montodeimpuestointerno + .Montodeimpuestointerno
							lnSum_Montodeimpuestointernosindescuento = lnSum_Montodeimpuestointernosindescuento + .Montodeimpuestointernosindescuento
							lnSum_Montodeiva = lnSum_Montodeiva + .Montodeiva
							lnSum_Montodeivasindescuento = lnSum_Montodeivasindescuento + .Montodeivasindescuento
							lnSum_Montonogravado = lnSum_Montonogravado + .Montonogravado
							lnSum_Montonogravadosindescuento = lnSum_Montonogravadosindescuento + .Montonogravadosindescuento
						endwith
					endif
				endfor

				if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
					loItem = .oItem
					with loItem 
						lnSum_Montodeimpuestointerno = lnSum_Montodeimpuestointerno + .Montodeimpuestointerno
						lnSum_Montodeimpuestointernosindescuento = lnSum_Montodeimpuestointernosindescuento + .Montodeimpuestointernosindescuento
						lnSum_Montodeiva = lnSum_Montodeiva + .Montodeiva
						lnSum_Montodeivasindescuento = lnSum_Montodeivasindescuento + .Montodeivasindescuento
						lnSum_Montonogravado = lnSum_Montonogravado + .Montonogravado
						lnSum_Montonogravadosindescuento = lnSum_Montonogravadosindescuento + .Montonogravadosindescuento
					endwith
				endif
			endif

			if .Sum_Montodeimpuestointerno != lnSum_Montodeimpuestointerno
				.Sum_Montodeimpuestointerno = lnSum_Montodeimpuestointerno
				.EventoCambioSum_Montodeimpuestointerno()
			endif
			if .Sum_Montodeimpuestointernosindescuento != lnSum_Montodeimpuestointernosindescuento
				.Sum_Montodeimpuestointernosindescuento = lnSum_Montodeimpuestointernosindescuento
				.EventoCambioSum_Montodeimpuestointernosindescuento()
			endif
			if .Sum_Montodeiva != lnSum_Montodeiva
				.Sum_Montodeiva = lnSum_Montodeiva
				.EventoCambioSum_Montodeiva()
			endif
			if .Sum_Montodeivasindescuento != lnSum_Montodeivasindescuento
				.Sum_Montodeivasindescuento = lnSum_Montodeivasindescuento
				.EventoCambioSum_Montodeivasindescuento()
			endif
			if .Sum_Montonogravado != lnSum_Montonogravado
				.Sum_Montonogravado = lnSum_Montonogravado
				.EventoCambioSum_Montonogravado()
			endif
			if .Sum_Montonogravadosindescuento != lnSum_Montonogravadosindescuento
				.Sum_Montonogravadosindescuento = lnSum_Montonogravadosindescuento
				.EventoCambioSum_Montonogravadosindescuento()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Montodeimpuestointerno() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Montodeimpuestointernosindescuento() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Montodeiva() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Montodeivasindescuento() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Montonogravado() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Montonogravadosindescuento() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalizar( toItem as Object ) as Void
		local lnItem as integer, loItem as Object, lnSum_Montodeimpuestointerno as Number, lnSum_Montodeimpuestointernosindescuento as Number, lnSum_Montodeiva as Number, lnSum_Montodeivasindescuento as Number, lnSum_Montonogravado as Number, lnSum_Montonogravadosindescuento as Number

		with this
			lnSum_Montodeimpuestointerno = 0
			lnSum_Montodeimpuestointernosindescuento = 0
			lnSum_Montodeiva = 0
			lnSum_Montodeivasindescuento = 0
			lnSum_Montonogravado = 0
			lnSum_Montonogravadosindescuento = 0
			if !this.lEsNavegacion
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							lnSum_Montodeimpuestointerno = lnSum_Montodeimpuestointerno + .Montodeimpuestointerno
							lnSum_Montodeimpuestointernosindescuento = lnSum_Montodeimpuestointernosindescuento + .Montodeimpuestointernosindescuento
							lnSum_Montodeiva = lnSum_Montodeiva + .Montodeiva
							lnSum_Montodeivasindescuento = lnSum_Montodeivasindescuento + .Montodeivasindescuento
							lnSum_Montonogravado = lnSum_Montonogravado + .Montonogravado
							lnSum_Montonogravadosindescuento = lnSum_Montonogravadosindescuento + .Montonogravadosindescuento
						endwith
					endif
				endfor

			endif
			if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
				loItem = .oItem
				with loItem 
					lnSum_Montodeimpuestointerno = lnSum_Montodeimpuestointerno + .Montodeimpuestointerno
					lnSum_Montodeimpuestointernosindescuento = lnSum_Montodeimpuestointernosindescuento + .Montodeimpuestointernosindescuento
					lnSum_Montodeiva = lnSum_Montodeiva + .Montodeiva
					lnSum_Montodeivasindescuento = lnSum_Montodeivasindescuento + .Montodeivasindescuento
					lnSum_Montonogravado = lnSum_Montonogravado + .Montonogravado
					lnSum_Montonogravadosindescuento = lnSum_Montonogravadosindescuento + .Montonogravadosindescuento
				endwith
			endif

			if .Sum_Montodeimpuestointerno != lnSum_Montodeimpuestointerno
				.Sum_Montodeimpuestointerno = lnSum_Montodeimpuestointerno
				.EventoCambioSum_Montodeimpuestointerno()
			endif
			if .Sum_Montodeimpuestointernosindescuento != lnSum_Montodeimpuestointernosindescuento
				.Sum_Montodeimpuestointernosindescuento = lnSum_Montodeimpuestointernosindescuento
				.EventoCambioSum_Montodeimpuestointernosindescuento()
			endif
			if .Sum_Montodeiva != lnSum_Montodeiva
				.Sum_Montodeiva = lnSum_Montodeiva
				.EventoCambioSum_Montodeiva()
			endif
			if .Sum_Montodeivasindescuento != lnSum_Montodeivasindescuento
				.Sum_Montodeivasindescuento = lnSum_Montodeivasindescuento
				.EventoCambioSum_Montodeivasindescuento()
			endif
			if .Sum_Montonogravado != lnSum_Montonogravado
				.Sum_Montonogravado = lnSum_Montonogravado
				.EventoCambioSum_Montonogravado()
			endif
			if .Sum_Montonogravadosindescuento != lnSum_Montonogravadosindescuento
				.Sum_Montonogravadosindescuento = lnSum_Montonogravadosindescuento
				.EventoCambioSum_Montonogravadosindescuento()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Acumular( tlForzar as Boolean, tcAtributo as String, tnValor as Decimal, tnValorAnt as Decimal ) as Void
		local lnItem as integer, loItem as Object, lnSum_Montodeimpuestointerno as Number, lnSum_Montodeimpuestointernosindescuento as Number, lnSum_Montodeiva as Number, lnSum_Montodeivasindescuento as Number, lnSum_Montonogravado as Number, lnSum_Montonogravadosindescuento as Number

		do case
		case tnValor = tnValorAnt
		case tcAtributo == 'Montodeimpuestointerno'
			this.Sum_Montodeimpuestointerno = this.Sum_Montodeimpuestointerno - tnValorAnt + tnValor
			this.EventoCambioSum_Montodeimpuestointerno()
		case tcAtributo == 'Montodeimpuestointernosindescuento'
			this.Sum_Montodeimpuestointernosindescuento = this.Sum_Montodeimpuestointernosindescuento - tnValorAnt + tnValor
			this.EventoCambioSum_Montodeimpuestointernosindescuento()
		case tcAtributo == 'Montodeiva'
			this.Sum_Montodeiva = this.Sum_Montodeiva - tnValorAnt + tnValor
			this.EventoCambioSum_Montodeiva()
		case tcAtributo == 'Montodeivasindescuento'
			this.Sum_Montodeivasindescuento = this.Sum_Montodeivasindescuento - tnValorAnt + tnValor
			this.EventoCambioSum_Montodeivasindescuento()
		case tcAtributo == 'Montonogravado'
			this.Sum_Montonogravado = this.Sum_Montonogravado - tnValorAnt + tnValor
			this.EventoCambioSum_Montonogravado()
		case tcAtributo == 'Montonogravadosindescuento'
			this.Sum_Montonogravadosindescuento = this.Sum_Montonogravadosindescuento - tnValorAnt + tnValor
			this.EventoCambioSum_Montonogravadosindescuento()

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
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemFACTURAELECTRONICAImpuestosdetalle' )
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

		select c_Impuestosdetalle
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Codigo = c_Impuestosdetalle.Codigo
			loItem.PorcentajeDeIva = c_Impuestosdetalle.PorcentajeDeIva
			loItem.MontoDeIva = c_Impuestosdetalle.MontoDeIva
			loItem.MontoDeIvaSinDescuento = c_Impuestosdetalle.MontoDeIvaSinDescuento
			loItem.MontoNoGravado = c_Impuestosdetalle.MontoNoGravado
			loItem.MontoNoGravadoSinDescuento = c_Impuestosdetalle.MontoNoGravadoSinDescuento
			loItem.MontoDeImpuestoInterno = c_Impuestosdetalle.MontoDeImpuestoInterno
			loItem.MontoDeImpuestoInternoSinDescuento = c_Impuestosdetalle.MontoDeImpuestoInternoSinDescuento
			loItem.NROITEM = c_Impuestosdetalle.NROITEM
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
			
			if vartype( this.Item[lni].PORCENTAJEDEIVA) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].PORCENTAJEDEIVA ) ) ) 
				lnValorDelDecimal = this.Item[lni].PORCENTAJEDEIVA - int( this.Item[lni].PORCENTAJEDEIVA )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 4
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo PORCENTAJEDEIVA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:4), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PORCENTAJEDEIVA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTODEIVA) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTODEIVA ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTODEIVA - int( this.Item[lni].MONTODEIVA )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTODEIVA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTODEIVA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTODEIVASINDESCUENTO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTODEIVASINDESCUENTO ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTODEIVASINDESCUENTO - int( this.Item[lni].MONTODEIVASINDESCUENTO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTODEIVASINDESCUENTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTODEIVASINDESCUENTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTONOGRAVADO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTONOGRAVADO ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTONOGRAVADO - int( this.Item[lni].MONTONOGRAVADO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTONOGRAVADO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTONOGRAVADO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTONOGRAVADOSINDESCUENTO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTONOGRAVADOSINDESCUENTO ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTONOGRAVADOSINDESCUENTO - int( this.Item[lni].MONTONOGRAVADOSINDESCUENTO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTONOGRAVADOSINDESCUENTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTONOGRAVADOSINDESCUENTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTODEIMPUESTOINTERNO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTODEIMPUESTOINTERNO ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTODEIMPUESTOINTERNO - int( this.Item[lni].MONTODEIMPUESTOINTERNO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTODEIMPUESTOINTERNO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTODEIMPUESTOINTERNO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTODEIMPUESTOINTERNOSINDESCUENTO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTODEIMPUESTOINTERNOSINDESCUENTO ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTODEIMPUESTOINTERNOSINDESCUENTO - int( this.Item[lni].MONTODEIMPUESTOINTERNOSINDESCUENTO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTODEIMPUESTOINTERNOSINDESCUENTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTODEIMPUESTOINTERNOSINDESCUENTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Porcentajedeiva = toItemOrigen.Porcentajedeiva
		toItemDestino.Montodeiva = toItemOrigen.Montodeiva
		toItemDestino.Montodeivasindescuento = toItemOrigen.Montodeivasindescuento
		toItemDestino.Montonogravado = toItemOrigen.Montonogravado
		toItemDestino.Montonogravadosindescuento = toItemOrigen.Montonogravadosindescuento
		toItemDestino.Montodeimpuestointerno = toItemOrigen.Montodeimpuestointerno
		toItemDestino.Montodeimpuestointernosindescuento = toItemOrigen.Montodeimpuestointernosindescuento
		toItemDestino.Nroitem = toItemOrigen.Nroitem
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


enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Codigo = []
	Porcentajedeiva = 0
	Montodeiva = 0
	Montodeivasindescuento = 0
	Montonogravado = 0
	Montonogravadosindescuento = 0
	Montodeimpuestointerno = 0
	Montodeimpuestointernosindescuento = 0
	Nroitem = 0
	NroItem = 0

enddefine