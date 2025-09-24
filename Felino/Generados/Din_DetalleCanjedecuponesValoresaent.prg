
define class Din_DetalleCANJEDECUPONESValoresaent as detalle of detalle.prg

	Sum_Pesosalcambio = 0

	nCantidadItems = 999
	cNombre = 'Valoresaent'
	cEtiqueta = 'Valores a entregar'
	cMensajeErrorUnicidad = 'La columna  no admite valores repetidos.'
	cNombreVisual = 'Valores a entregar'

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
			
				.Valor_PK = this.Item[ tnItem ].Valor_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Valor_PK', .Valor_PK )
			
				.Tipo = this.Item[ tnItem ].Tipo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Tipo', .Tipo )
			
				.Caja_PK = this.Item[ tnItem ].Caja_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Caja_PK', .Caja_PK )
			
				.UltimaCotizacion = this.Item[ tnItem ].UltimaCotizacion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'UltimaCotizacion', .UltimaCotizacion )
			
				.FechaUltCotizacion = this.Item[ tnItem ].FechaUltCotizacion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'FechaUltCotizacion', .FechaUltCotizacion )
			
				.Cotiza = this.Item[ tnItem ].Cotiza
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Cotiza', .Cotiza )
			
				.FechaComp = this.Item[ tnItem ].FechaComp
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'FechaComp', .FechaComp )
			
				.NumeroCheque_PK = this.Item[ tnItem ].NumeroCheque_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumeroCheque_PK', .NumeroCheque_PK )
			
				.NumeroCupon = this.Item[ tnItem ].NumeroCupon
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumeroCupon', .NumeroCupon )
			
				.NumeroTarjeta = this.Item[ tnItem ].NumeroTarjeta
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumeroTarjeta', .NumeroTarjeta )
			
				.NumeroChequePropio_PK = this.Item[ tnItem ].NumeroChequePropio_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumeroChequePropio_PK', .NumeroChequePropio_PK )
			
				.SignodeMovimiento = this.Item[ tnItem ].SignodeMovimiento
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'SignodeMovimiento', .SignodeMovimiento )
			
				.AutorizacionPOS = this.Item[ tnItem ].AutorizacionPOS
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'AutorizacionPOS', .AutorizacionPOS )
			
				.VisualizarEnEstadoDeCaja = this.Item[ tnItem ].VisualizarEnEstadoDeCaja
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'VisualizarEnEstadoDeCaja', .VisualizarEnEstadoDeCaja )
			
				.ChequeElectronico = this.Item[ tnItem ].ChequeElectronico
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ChequeElectronico', .ChequeElectronico )
			
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.ValorDetalle = this.Item[ tnItem ].ValorDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ValorDetalle', .ValorDetalle )
			
				.LetraComprobante = this.Item[ tnItem ].LetraComprobante
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'LetraComprobante', .LetraComprobante )
			
				.Fecha = this.Item[ tnItem ].Fecha
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Fecha', .Fecha )
			
				.PuntoDeVentaComprobante = this.Item[ tnItem ].PuntoDeVentaComprobante
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PuntoDeVentaComprobante', .PuntoDeVentaComprobante )
			
				.NumeroInterno = this.Item[ tnItem ].NumeroInterno
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumeroInterno', .NumeroInterno )
			
				.NroComprobante = this.Item[ tnItem ].NroComprobante
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NroComprobante', .NroComprobante )
			
				.CuponTipo = this.Item[ tnItem ].CuponTipo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CuponTipo', .CuponTipo )
			
				.TipoComprobante = this.Item[ tnItem ].TipoComprobante
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TipoComprobante', .TipoComprobante )
			
				.FechaComprobante = this.Item[ tnItem ].FechaComprobante
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'FechaComprobante', .FechaComprobante )
			
				.ComprobanteOrigen = this.Item[ tnItem ].ComprobanteOrigen
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ComprobanteOrigen', .ComprobanteOrigen )
			
				.BaseDeDatosOrigen = this.Item[ tnItem ].BaseDeDatosOrigen
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'BaseDeDatosOrigen', .BaseDeDatosOrigen )
			
				.Monto = this.Item[ tnItem ].Monto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Monto', .Monto )
			
				.Total = this.Item[ tnItem ].Total
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Total', .Total )
			
				.SerieOrigen = this.Item[ tnItem ].SerieOrigen
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'SerieOrigen', .SerieOrigen )
			
				.Hora = this.Item[ tnItem ].Hora
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Hora', .Hora )
			
				.PesosAlCambio = this.Item[ tnItem ].PesosAlCambio
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PesosAlCambio', .PesosAlCambio )
			
				.MontoAMonedaSistema = this.Item[ tnItem ].MontoAMonedaSistema
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoAMonedaSistema', .MontoAMonedaSistema )
			
				.MontoCupon = this.Item[ tnItem ].MontoCupon
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoCupon', .MontoCupon )
			
				.Cupon_PK = this.Item[ tnItem ].Cupon_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Cupon_PK', .Cupon_PK )
			
				.CodigoDeCupon = this.Item[ tnItem ].CodigoDeCupon
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodigoDeCupon', .CodigoDeCupon )
			
				.IdItemComponente = this.Item[ tnItem ].IdItemComponente
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'IdItemComponente', .IdItemComponente )
			
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
			.Valor_PK = this.oItem.Valor_PK
			.Tipo = this.oItem.Tipo
			.Caja_PK = this.oItem.Caja_PK
			.UltimaCotizacion = this.oItem.UltimaCotizacion
			.FechaUltCotizacion = this.oItem.FechaUltCotizacion
			.Cotiza = this.oItem.Cotiza
			.FechaComp = this.oItem.FechaComp
			.NumeroCheque_PK = this.oItem.NumeroCheque_PK
			.NumeroCupon = this.oItem.NumeroCupon
			.NumeroTarjeta = this.oItem.NumeroTarjeta
			.NumeroChequePropio_PK = this.oItem.NumeroChequePropio_PK
			.SignodeMovimiento = this.oItem.SignodeMovimiento
			.AutorizacionPOS = this.oItem.AutorizacionPOS
			.VisualizarEnEstadoDeCaja = this.oItem.VisualizarEnEstadoDeCaja
			.ChequeElectronico = this.oItem.ChequeElectronico
			.NROITEM = this.oItem.NROITEM
			.ValorDetalle = this.oItem.ValorDetalle
			.LetraComprobante = this.oItem.LetraComprobante
			.Fecha = this.oItem.Fecha
			.PuntoDeVentaComprobante = this.oItem.PuntoDeVentaComprobante
			.NumeroInterno = this.oItem.NumeroInterno
			.NroComprobante = this.oItem.NroComprobante
			.CuponTipo = this.oItem.CuponTipo
			.TipoComprobante = this.oItem.TipoComprobante
			.FechaComprobante = this.oItem.FechaComprobante
			.ComprobanteOrigen = this.oItem.ComprobanteOrigen
			.BaseDeDatosOrigen = this.oItem.BaseDeDatosOrigen
			.Monto = this.oItem.Monto
			.Total = this.oItem.Total
			.SerieOrigen = this.oItem.SerieOrigen
			.Hora = this.oItem.Hora
			.PesosAlCambio = this.oItem.PesosAlCambio
			.MontoAMonedaSistema = this.oItem.MontoAMonedaSistema
			.MontoCupon = this.oItem.MontoCupon
			.Cupon_PK = this.oItem.Cupon_PK
			.CodigoDeCupon = this.oItem.CodigoDeCupon
			.IdItemComponente = this.oItem.IdItemComponente
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
			.Item[ lnItem ].Valor_PK = .oItem.Valor_PK
			.Item[ lnItem ].Tipo = .oItem.Tipo
			.Item[ lnItem ].Caja_PK = .oItem.Caja_PK
			.Item[ lnItem ].UltimaCotizacion = .oItem.UltimaCotizacion
			.Item[ lnItem ].FechaUltCotizacion = .oItem.FechaUltCotizacion
			.Item[ lnItem ].Cotiza = .oItem.Cotiza
			.Item[ lnItem ].FechaComp = .oItem.FechaComp
			.Item[ lnItem ].NumeroCheque_PK = .oItem.NumeroCheque_PK
			.Item[ lnItem ].NumeroCupon = .oItem.NumeroCupon
			.Item[ lnItem ].NumeroTarjeta = .oItem.NumeroTarjeta
			.Item[ lnItem ].NumeroChequePropio_PK = .oItem.NumeroChequePropio_PK
			.Item[ lnItem ].SignodeMovimiento = .oItem.SignodeMovimiento
			.Item[ lnItem ].AutorizacionPOS = .oItem.AutorizacionPOS
			.Item[ lnItem ].VisualizarEnEstadoDeCaja = .oItem.VisualizarEnEstadoDeCaja
			.Item[ lnItem ].ChequeElectronico = .oItem.ChequeElectronico
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].ValorDetalle = .oItem.ValorDetalle
			.Item[ lnItem ].LetraComprobante = .oItem.LetraComprobante
			.Item[ lnItem ].Fecha = .oItem.Fecha
			.Item[ lnItem ].PuntoDeVentaComprobante = .oItem.PuntoDeVentaComprobante
			.Item[ lnItem ].NumeroInterno = .oItem.NumeroInterno
			.Item[ lnItem ].NroComprobante = .oItem.NroComprobante
			.Item[ lnItem ].CuponTipo = .oItem.CuponTipo
			.Item[ lnItem ].TipoComprobante = .oItem.TipoComprobante
			.Item[ lnItem ].FechaComprobante = .oItem.FechaComprobante
			.Item[ lnItem ].ComprobanteOrigen = .oItem.ComprobanteOrigen
			.Item[ lnItem ].BaseDeDatosOrigen = .oItem.BaseDeDatosOrigen
			.Item[ lnItem ].Monto = .oItem.Monto
			.Item[ lnItem ].Total = .oItem.Total
			.Item[ lnItem ].SerieOrigen = .oItem.SerieOrigen
			.Item[ lnItem ].Hora = .oItem.Hora
			.Item[ lnItem ].PesosAlCambio = .oItem.PesosAlCambio
			.Item[ lnItem ].MontoAMonedaSistema = .oItem.MontoAMonedaSistema
			.Item[ lnItem ].MontoCupon = .oItem.MontoCupon
			.Item[ lnItem ].Cupon_PK = .oItem.Cupon_PK
			.Item[ lnItem ].CodigoDeCupon = .oItem.CodigoDeCupon
			.Item[ lnItem ].IdItemComponente = .oItem.IdItemComponente
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Sumarizar() as boolean
		local lnItem as integer, loItem as Object, lnSum_Pesosalcambio as Number

		with this
			lnSum_Pesosalcambio = 0
			if this.lEsNavegacion
				if select( 'c_Valoresaent' ) > 0 and reccount( 'c_Valoresaent' ) > 0
					sum Pesosalcambio;
						 to ;
						 lnSum_Pesosalcambio
				endif
				this.lEsNavegacion = .f.
			else
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							if !empty(.VALOR_PK)
								lnSum_Pesosalcambio = lnSum_Pesosalcambio + .Pesosalcambio
							endif
						endwith
					endif
				endfor

				if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
					loItem = .oItem
					with loItem 
						lnSum_Pesosalcambio = lnSum_Pesosalcambio + .Pesosalcambio
					endwith
				endif
			endif

			if .Sum_Pesosalcambio != lnSum_Pesosalcambio
				.Sum_Pesosalcambio = lnSum_Pesosalcambio
				.EventoCambioSum_Pesosalcambio()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Pesosalcambio() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalizar( toItem as Object ) as Void
		local lnItem as integer, loItem as Object, lnSum_Pesosalcambio as Number

		with this
			lnSum_Pesosalcambio = 0
			if !this.lEsNavegacion
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							if !empty(.VALOR_PK)
								lnSum_Pesosalcambio = lnSum_Pesosalcambio + .Pesosalcambio
							endif
						endwith
					endif
				endfor

			endif
			if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
				loItem = .oItem
				with loItem 
					if !empty(.VALOR_PK)
						lnSum_Pesosalcambio = lnSum_Pesosalcambio + .Pesosalcambio
					endif
				endwith
			endif

			if .Sum_Pesosalcambio != lnSum_Pesosalcambio
				.Sum_Pesosalcambio = lnSum_Pesosalcambio
				.EventoCambioSum_Pesosalcambio()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Acumular( tlForzar as Boolean, tcAtributo as String, tnValor as Decimal, tnValorAnt as Decimal ) as Void
		local lnItem as integer, loItem as Object, lnSum_Pesosalcambio as Number

		do case
		case tnValor = tnValorAnt
		case tcAtributo == 'Pesosalcambio'
			this.Sum_Pesosalcambio = this.Sum_Pesosalcambio - tnValorAnt + tnValor
			this.EventoCambioSum_Pesosalcambio()

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
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemCANJEDECUPONESValoresaent' )
			this.enlazar( 'oItem.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oItem.EventoObtenerInformacion', 'inyectarInformacion' )
			this.oItem.inicializar()
			bindevent( this.oItem, 'AcumularSumarizado', this, 'Acumular', 0) 
			bindevent( this.oItem, 'TotalizarSumarizado', this, 'Sumarizar', 0) 
			bindevent( this.oItem, 'CambioSumarizado', this, 'Sumarizar', 0) 
			bindevent( this.oItem, 'EventoDespuesDeSetear', this, 'ValidarCantidadDeItemsEnDetalle' )
		endif
		return this.oItem
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Cargar() as Void
		local loItem as object, lnI as integer, lcClave as string, lcFiltro as String 
		lnI = 1

		select c_Valoresaent
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Codigo = c_Valoresaent.Codigo
			loItem.Valor_PK = c_Valoresaent.Valor
			loItem.Tipo = c_Valoresaent.Tipo
			loItem.Caja_PK = c_Valoresaent.Caja
			loItem.UltimaCotizacion = c_Valoresaent.UltimaCotizacion
			loItem.FechaUltCotizacion = goLibrerias.ObtenerFechaFormateada( c_Valoresaent.FechaUltCotizacion )
			loItem.Cotiza = c_Valoresaent.Cotiza
			loItem.FechaComp = goLibrerias.ObtenerFechaFormateada( c_Valoresaent.FechaComp )
			loItem.NumeroCheque_PK = c_Valoresaent.NumeroCheque
			loItem.NumeroCupon = c_Valoresaent.NumeroCupon
			loItem.NumeroTarjeta = c_Valoresaent.NumeroTarjeta
			loItem.NumeroChequePropio_PK = c_Valoresaent.NumeroChequePropio
			loItem.SignodeMovimiento = c_Valoresaent.SignodeMovimiento
			loItem.AutorizacionPOS = c_Valoresaent.AutorizacionPOS
			loItem.VisualizarEnEstadoDeCaja = c_Valoresaent.VisualizarEnEstadoDeCaja
			loItem.ChequeElectronico = c_Valoresaent.ChequeElectronico
			loItem.NROITEM = c_Valoresaent.NROITEM
			loItem.ValorDetalle = c_Valoresaent.ValorDetalle
			loItem.LetraComprobante = c_Valoresaent.LetraComprobante
			loItem.Fecha = goLibrerias.ObtenerFechaFormateada( c_Valoresaent.Fecha )
			loItem.PuntoDeVentaComprobante = c_Valoresaent.PuntoDeVentaComprobante
			loItem.NumeroInterno = c_Valoresaent.NumeroInterno
			loItem.NroComprobante = c_Valoresaent.NroComprobante
			loItem.CuponTipo = c_Valoresaent.CuponTipo
			loItem.TipoComprobante = c_Valoresaent.TipoComprobante
			loItem.FechaComprobante = goLibrerias.ObtenerFechaFormateada( c_Valoresaent.FechaComprobante )
			loItem.BaseDeDatosOrigen = c_Valoresaent.BaseDeDatosOrigen
			loItem.Monto = c_Valoresaent.Monto
			loItem.Total = c_Valoresaent.Total
			loItem.SerieOrigen = c_Valoresaent.SerieOrigen
			loItem.Hora = c_Valoresaent.Hora
			loItem.PesosAlCambio = c_Valoresaent.PesosAlCambio
			loItem.MontoAMonedaSistema = c_Valoresaent.MontoAMonedaSistema
			loItem.MontoCupon = c_Valoresaent.MontoCupon
			loItem.Cupon_PK = c_Valoresaent.Cupon
			loItem.CodigoDeCupon = c_Valoresaent.CodigoDeCupon
			loItem.IdItemComponente = c_Valoresaent.IdItemComponente
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

		if  empty( this.item[ tnItem ].Valor_PK ) 
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
			
			if vartype( this.Item[lni].VALOR_PK) = 'C'
				if len( alltrim( this.Item[lni].VALOR_PK )) <= 5
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo VALOR del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].VALOR_PK ))) + ' Máxima:5), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo VALOR del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TIPO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].TIPO ) ) ) 
				lnValorDelDecimal = this.Item[lni].TIPO - int( this.Item[lni].TIPO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo TIPO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TIPO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CAJA_PK) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].CAJA_PK ) ) ) 
				lnValorDelDecimal = this.Item[lni].CAJA_PK - int( this.Item[lni].CAJA_PK )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo CAJA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CAJA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ULTIMACOTIZACION) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].ULTIMACOTIZACION ) ) ) 
				lnValorDelDecimal = this.Item[lni].ULTIMACOTIZACION - int( this.Item[lni].ULTIMACOTIZACION )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo ULTIMACOTIZACION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ULTIMACOTIZACION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if inlist(vartype( this.Item[lni].FECHAULTCOTIZACION),'D','T')
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo FECHAULTCOTIZACION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].COTIZA) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].COTIZA ) ) ) 
				lnValorDelDecimal = this.Item[lni].COTIZA - int( this.Item[lni].COTIZA )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo COTIZA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo COTIZA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if inlist(vartype( this.Item[lni].FECHACOMP),'D','T')
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo FECHACOMP del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NUMEROCHEQUE_PK) = 'C'
				if len( alltrim( this.Item[lni].NUMEROCHEQUE_PK )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo NUMEROCHEQUE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].NUMEROCHEQUE_PK ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NUMEROCHEQUE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NUMEROCUPON) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].NUMEROCUPON ) ) ) 
				lnValorDelDecimal = this.Item[lni].NUMEROCUPON - int( this.Item[lni].NUMEROCUPON )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 12
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo NUMEROCUPON del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:12), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NUMEROCUPON del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NUMEROTARJETA) = 'C'
				if len( alltrim( this.Item[lni].NUMEROTARJETA )) <= 25
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo NUMEROTARJETA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].NUMEROTARJETA ))) + ' Máxima:25), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NUMEROTARJETA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NUMEROCHEQUEPROPIO_PK) = 'C'
				if len( alltrim( this.Item[lni].NUMEROCHEQUEPROPIO_PK )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo NUMEROCHEQUEPROPIO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].NUMEROCHEQUEPROPIO_PK ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NUMEROCHEQUEPROPIO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].SIGNODEMOVIMIENTO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].SIGNODEMOVIMIENTO ) ) ) 
				lnValorDelDecimal = this.Item[lni].SIGNODEMOVIMIENTO - int( this.Item[lni].SIGNODEMOVIMIENTO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo SIGNODEMOVIMIENTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo SIGNODEMOVIMIENTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].AUTORIZACIONPOS) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo AUTORIZACIONPOS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].VISUALIZARENESTADODECAJA) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo VISUALIZARENESTADODECAJA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CHEQUEELECTRONICO) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CHEQUEELECTRONICO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].VALORDETALLE) = 'C'
				if len( alltrim( this.Item[lni].VALORDETALLE )) <= 30
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo VALORDETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].VALORDETALLE ))) + ' Máxima:30), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo VALORDETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].LETRACOMPROBANTE) = 'C'
				if len( alltrim( this.Item[lni].LETRACOMPROBANTE )) <= 1
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo LETRACOMPROBANTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].LETRACOMPROBANTE ))) + ' Máxima:1), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo LETRACOMPROBANTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if inlist(vartype( this.Item[lni].FECHA),'D','T')
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo FECHA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PUNTODEVENTACOMPROBANTE) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].PUNTODEVENTACOMPROBANTE ) ) ) 
				lnValorDelDecimal = this.Item[lni].PUNTODEVENTACOMPROBANTE - int( this.Item[lni].PUNTODEVENTACOMPROBANTE )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 4
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo PUNTODEVENTACOMPROBANTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:4), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PUNTODEVENTACOMPROBANTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NUMEROINTERNO) = 'C'
				if len( alltrim( this.Item[lni].NUMEROINTERNO )) <= 15
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo NUMEROINTERNO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].NUMEROINTERNO ))) + ' Máxima:15), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NUMEROINTERNO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NROCOMPROBANTE) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].NROCOMPROBANTE ) ) ) 
				lnValorDelDecimal = this.Item[lni].NROCOMPROBANTE - int( this.Item[lni].NROCOMPROBANTE )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 8
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo NROCOMPROBANTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:8), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NROCOMPROBANTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CUPONTIPO) = 'C'
				if len( alltrim( this.Item[lni].CUPONTIPO )) <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CUPONTIPO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CUPONTIPO ))) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CUPONTIPO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TIPOCOMPROBANTE) = 'C'
				if len( alltrim( this.Item[lni].TIPOCOMPROBANTE )) <= 3
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TIPOCOMPROBANTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TIPOCOMPROBANTE ))) + ' Máxima:3), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TIPOCOMPROBANTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if inlist(vartype( this.Item[lni].FECHACOMPROBANTE),'D','T')
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo FECHACOMPROBANTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].BASEDEDATOSORIGEN) = 'C'
				if len( alltrim( this.Item[lni].BASEDEDATOSORIGEN )) <= 8
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo BASEDEDATOSORIGEN del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].BASEDEDATOSORIGEN ))) + ' Máxima:8), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo BASEDEDATOSORIGEN del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTO ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTO - int( this.Item[lni].MONTO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TOTAL) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].TOTAL ) ) ) 
				lnValorDelDecimal = this.Item[lni].TOTAL - int( this.Item[lni].TOTAL )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo TOTAL del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TOTAL del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].SERIEORIGEN) = 'C'
				if len( alltrim( this.Item[lni].SERIEORIGEN )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo SERIEORIGEN del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].SERIEORIGEN ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo SERIEORIGEN del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].HORA) = 'C'
				if len( alltrim( this.Item[lni].HORA )) <= 5
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo HORA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].HORA ))) + ' Máxima:5), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo HORA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PESOSALCAMBIO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].PESOSALCAMBIO ) ) ) 
				lnValorDelDecimal = this.Item[lni].PESOSALCAMBIO - int( this.Item[lni].PESOSALCAMBIO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo PESOSALCAMBIO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PESOSALCAMBIO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTOAMONEDASISTEMA) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTOAMONEDASISTEMA ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTOAMONEDASISTEMA - int( this.Item[lni].MONTOAMONEDASISTEMA )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTOAMONEDASISTEMA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTOAMONEDASISTEMA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTOCUPON) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTOCUPON ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTOCUPON - int( this.Item[lni].MONTOCUPON )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTOCUPON del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTOCUPON del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CUPON_PK) = 'C'
				if len( alltrim( this.Item[lni].CUPON_PK )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CUPON del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CUPON_PK ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CUPON del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CODIGODECUPON) = 'C'
				if len( alltrim( this.Item[lni].CODIGODECUPON )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGODECUPON del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGODECUPON ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGODECUPON del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].IDITEMCOMPONENTE) = 'C'
				if len( alltrim( this.Item[lni].IDITEMCOMPONENTE )) <= 20
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo IDITEMCOMPONENTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].IDITEMCOMPONENTE ))) + ' Máxima:20), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo IDITEMCOMPONENTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Valor_PK = toItemOrigen.Valor_PK
		toItemDestino.Tipo = toItemOrigen.Tipo
		toItemDestino.Caja_PK = toItemOrigen.Caja_PK
		toItemDestino.Ultimacotizacion = toItemOrigen.Ultimacotizacion
		toItemDestino.Fechaultcotizacion = toItemOrigen.Fechaultcotizacion
		toItemDestino.Cotiza = toItemOrigen.Cotiza
		toItemDestino.Fechacomp = toItemOrigen.Fechacomp
		toItemDestino.Numerocheque_PK = toItemOrigen.Numerocheque_PK
		toItemDestino.Numerocupon = toItemOrigen.Numerocupon
		toItemDestino.Numerotarjeta = toItemOrigen.Numerotarjeta
		toItemDestino.Numerochequepropio_PK = toItemOrigen.Numerochequepropio_PK
		toItemDestino.Signodemovimiento = toItemOrigen.Signodemovimiento
		toItemDestino.Autorizacionpos = toItemOrigen.Autorizacionpos
		toItemDestino.Visualizarenestadodecaja = toItemOrigen.Visualizarenestadodecaja
		toItemDestino.Chequeelectronico = toItemOrigen.Chequeelectronico
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Valordetalle = toItemOrigen.Valordetalle
		toItemDestino.Letracomprobante = toItemOrigen.Letracomprobante
		toItemDestino.Fecha = toItemOrigen.Fecha
		toItemDestino.Puntodeventacomprobante = toItemOrigen.Puntodeventacomprobante
		toItemDestino.Numerointerno = toItemOrigen.Numerointerno
		toItemDestino.Nrocomprobante = toItemOrigen.Nrocomprobante
		toItemDestino.Cupontipo = toItemOrigen.Cupontipo
		toItemDestino.Tipocomprobante = toItemOrigen.Tipocomprobante
		toItemDestino.Fechacomprobante = toItemOrigen.Fechacomprobante
		toItemDestino.Comprobanteorigen = toItemOrigen.Comprobanteorigen
		toItemDestino.Basededatosorigen = toItemOrigen.Basededatosorigen
		toItemDestino.Monto = toItemOrigen.Monto
		toItemDestino.Total = toItemOrigen.Total
		toItemDestino.Serieorigen = toItemOrigen.Serieorigen
		toItemDestino.Hora = toItemOrigen.Hora
		toItemDestino.Pesosalcambio = toItemOrigen.Pesosalcambio
		toItemDestino.Montoamonedasistema = toItemOrigen.Montoamonedasistema
		toItemDestino.Montocupon = toItemOrigen.Montocupon
		toItemDestino.Cupon_PK = toItemOrigen.Cupon_PK
		toItemDestino.Codigodecupon = toItemOrigen.Codigodecupon
		toItemDestino.Iditemcomponente = toItemOrigen.Iditemcomponente
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
		lcRetorno = 'Valor_pk'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Codigo = []
	Valor_PK = []
	Tipo = 0
	Caja_PK = 0
	Ultimacotizacion = 0
	Fechaultcotizacion = ctod( '  /  /    ' )
	Cotiza = 0
	Fechacomp = ctod( '  /  /    ' )
	Numerocheque_PK = []
	Numerocupon = 0
	Numerotarjeta = []
	Numerochequepropio_PK = []
	Signodemovimiento = 0
	Autorizacionpos = .F.
	Visualizarenestadodecaja = .F.
	Chequeelectronico = .F.
	Nroitem = 0
	Valordetalle = []
	Letracomprobante = []
	Fecha = ctod( '  /  /    ' )
	Puntodeventacomprobante = 0
	Numerointerno = []
	Nrocomprobante = 0
	Cupontipo = []
	Tipocomprobante = []
	Fechacomprobante = ctod( '  /  /    ' )
	Comprobanteorigen = []
	Basededatosorigen = []
	Monto = 0
	Total = 0
	Serieorigen = []
	Hora = []
	Pesosalcambio = 0
	Montoamonedasistema = 0
	Montocupon = 0
	Cupon_PK = []
	Codigodecupon = []
	Iditemcomponente = []
	NroItem = 0
	lTieneImporteEnRecibido = .f.

enddefine