
define class Din_DetalleFACTURADECOMPRAValoresdetalle as DetalleValorescompra of DetalleValorescompra.Prg

	Sum_Pesosalcambio = 0
	Sum_Recargomonto = 0
	Sum_Recargomontosinimpuestos = 0
	Sum_Recargosinpercepciones = 0
	Sum_Total = 0

	nCantidadItems = 999
	cNombre = 'Valoresdetalle'
	cEtiqueta = 'Valores'
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
			
				.Cotiza = this.Item[ tnItem ].Cotiza
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Cotiza', .Cotiza )
			
				.FechaComp = this.Item[ tnItem ].FechaComp
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'FechaComp', .FechaComp )
			
				.Letra = this.Item[ tnItem ].Letra
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Letra', .Letra )
			
				.NroDocumento = this.Item[ tnItem ].NroDocumento
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NroDocumento', .NroDocumento )
			
				.NroItem = this.Item[ tnItem ].NroItem
			
				.NumeroCheque_PK = this.Item[ tnItem ].NumeroCheque_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumeroCheque_PK', .NumeroCheque_PK )
			
				.NumeroCupon = this.Item[ tnItem ].NumeroCupon
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumeroCupon', .NumeroCupon )
			
				.NumeroTarjeta = this.Item[ tnItem ].NumeroTarjeta
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumeroTarjeta', .NumeroTarjeta )
			
				.NumerodeComprobante = this.Item[ tnItem ].NumerodeComprobante
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumerodeComprobante', .NumerodeComprobante )
			
				.PesosAlCambio = this.Item[ tnItem ].PesosAlCambio
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PesosAlCambio', .PesosAlCambio )
			
				.PuntoDeVenta = this.Item[ tnItem ].PuntoDeVenta
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PuntoDeVenta', .PuntoDeVenta )
			
				.Signo = this.Item[ tnItem ].Signo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Signo', .Signo )
			
				.Tipo = this.Item[ tnItem ].Tipo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Tipo', .Tipo )
			
				.TipoDocumento = this.Item[ tnItem ].TipoDocumento
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TipoDocumento', .TipoDocumento )
			
				.TipodeComprobante = this.Item[ tnItem ].TipodeComprobante
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TipodeComprobante', .TipodeComprobante )
			
				.Turno = this.Item[ tnItem ].Turno
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Turno', .Turno )
			
				.Valor_PK = this.Item[ tnItem ].Valor_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Valor_PK', .Valor_PK )
			
				.Vendedor = this.Item[ tnItem ].Vendedor
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Vendedor', .Vendedor )
			
				.FechaUltCotizacion = this.Item[ tnItem ].FechaUltCotizacion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'FechaUltCotizacion', .FechaUltCotizacion )
			
				.UltimaCotizacion = this.Item[ tnItem ].UltimaCotizacion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'UltimaCotizacion', .UltimaCotizacion )
			
				.Caja_PK = this.Item[ tnItem ].Caja_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Caja_PK', .Caja_PK )
			
				.PersonalizarComprobante = this.Item[ tnItem ].PersonalizarComprobante
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PersonalizarComprobante', .PersonalizarComprobante )
			
				.CondicionRecargo = this.Item[ tnItem ].CondicionRecargo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CondicionRecargo', .CondicionRecargo )
			
				.NumeroChequePropio_PK = this.Item[ tnItem ].NumeroChequePropio_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumeroChequePropio_PK', .NumeroChequePropio_PK )
			
				.CondicionDePago_PK = this.Item[ tnItem ].CondicionDePago_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CondicionDePago_PK', .CondicionDePago_PK )
			
				.VisualizarEnEstadoDeCaja = this.Item[ tnItem ].VisualizarEnEstadoDeCaja
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'VisualizarEnEstadoDeCaja', .VisualizarEnEstadoDeCaja )
			
				.ChequeElectronico = this.Item[ tnItem ].ChequeElectronico
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ChequeElectronico', .ChequeElectronico )
			
				.ValorDetalle = this.Item[ tnItem ].ValorDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ValorDetalle', .ValorDetalle )
			
				.Fecha = this.Item[ tnItem ].Fecha
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Fecha', .Fecha )
			
				.NumeroInterno = this.Item[ tnItem ].NumeroInterno
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumeroInterno', .NumeroInterno )
			
				.Monto = this.Item[ tnItem ].Monto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Monto', .Monto )
			
				.MontoOri = this.Item[ tnItem ].MontoOri
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoOri', .MontoOri )
			
				.RecargoPorcentaje = this.Item[ tnItem ].RecargoPorcentaje
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RecargoPorcentaje', .RecargoPorcentaje )
			
				.RecargoMonto = this.Item[ tnItem ].RecargoMonto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RecargoMonto', .RecargoMonto )
			
				.Total = this.Item[ tnItem ].Total
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Total', .Total )
			
				.RecargoMontoSinImpuestos = this.Item[ tnItem ].RecargoMontoSinImpuestos
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RecargoMontoSinImpuestos', .RecargoMontoSinImpuestos )
			
				.MontoAMonedaSistema = this.Item[ tnItem ].MontoAMonedaSistema
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoAMonedaSistema', .MontoAMonedaSistema )
			
				.RecargoSinPercepciones = this.Item[ tnItem ].RecargoSinPercepciones
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RecargoSinPercepciones', .RecargoSinPercepciones )
			
				.NumeroValeDeCambio_PK = this.Item[ tnItem ].NumeroValeDeCambio_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumeroValeDeCambio_PK', .NumeroValeDeCambio_PK )
			
				.PermiteVuelto = this.Item[ tnItem ].PermiteVuelto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PermiteVuelto', .PermiteVuelto )
			
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
			.Cotiza = this.oItem.Cotiza
			.FechaComp = this.oItem.FechaComp
			.Letra = this.oItem.Letra
			.NroDocumento = this.oItem.NroDocumento
			.NroItem = this.oItem.NroItem
			.NumeroCheque_PK = this.oItem.NumeroCheque_PK
			.NumeroCupon = this.oItem.NumeroCupon
			.NumeroTarjeta = this.oItem.NumeroTarjeta
			.NumerodeComprobante = this.oItem.NumerodeComprobante
			.PesosAlCambio = this.oItem.PesosAlCambio
			.PuntoDeVenta = this.oItem.PuntoDeVenta
			.Signo = this.oItem.Signo
			.Tipo = this.oItem.Tipo
			.TipoDocumento = this.oItem.TipoDocumento
			.TipodeComprobante = this.oItem.TipodeComprobante
			.Turno = this.oItem.Turno
			.Valor_PK = this.oItem.Valor_PK
			.Vendedor = this.oItem.Vendedor
			.FechaUltCotizacion = this.oItem.FechaUltCotizacion
			.UltimaCotizacion = this.oItem.UltimaCotizacion
			.Caja_PK = this.oItem.Caja_PK
			.PersonalizarComprobante = this.oItem.PersonalizarComprobante
			.CondicionRecargo = this.oItem.CondicionRecargo
			.NumeroChequePropio_PK = this.oItem.NumeroChequePropio_PK
			.CondicionDePago_PK = this.oItem.CondicionDePago_PK
			.VisualizarEnEstadoDeCaja = this.oItem.VisualizarEnEstadoDeCaja
			.ChequeElectronico = this.oItem.ChequeElectronico
			.ValorDetalle = this.oItem.ValorDetalle
			.Fecha = this.oItem.Fecha
			.NumeroInterno = this.oItem.NumeroInterno
			.Monto = this.oItem.Monto
			.MontoOri = this.oItem.MontoOri
			.RecargoPorcentaje = this.oItem.RecargoPorcentaje
			.RecargoMonto = this.oItem.RecargoMonto
			.Total = this.oItem.Total
			.RecargoMontoSinImpuestos = this.oItem.RecargoMontoSinImpuestos
			.MontoAMonedaSistema = this.oItem.MontoAMonedaSistema
			.RecargoSinPercepciones = this.oItem.RecargoSinPercepciones
			.NumeroValeDeCambio_PK = this.oItem.NumeroValeDeCambio_PK
			.PermiteVuelto = this.oItem.PermiteVuelto
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
			.Item[ lnItem ].Cotiza = .oItem.Cotiza
			.Item[ lnItem ].FechaComp = .oItem.FechaComp
			.Item[ lnItem ].Letra = .oItem.Letra
			.Item[ lnItem ].NroDocumento = .oItem.NroDocumento
			.Item[ lnItem ].NroItem = .oItem.NroItem
			.Item[ lnItem ].NumeroCheque_PK = .oItem.NumeroCheque_PK
			.Item[ lnItem ].NumeroCupon = .oItem.NumeroCupon
			.Item[ lnItem ].NumeroTarjeta = .oItem.NumeroTarjeta
			.Item[ lnItem ].NumerodeComprobante = .oItem.NumerodeComprobante
			.Item[ lnItem ].PesosAlCambio = .oItem.PesosAlCambio
			.Item[ lnItem ].PuntoDeVenta = .oItem.PuntoDeVenta
			.Item[ lnItem ].Signo = .oItem.Signo
			.Item[ lnItem ].Tipo = .oItem.Tipo
			.Item[ lnItem ].TipoDocumento = .oItem.TipoDocumento
			.Item[ lnItem ].TipodeComprobante = .oItem.TipodeComprobante
			.Item[ lnItem ].Turno = .oItem.Turno
			.Item[ lnItem ].Valor_PK = .oItem.Valor_PK
			.Item[ lnItem ].Vendedor = .oItem.Vendedor
			.Item[ lnItem ].FechaUltCotizacion = .oItem.FechaUltCotizacion
			.Item[ lnItem ].UltimaCotizacion = .oItem.UltimaCotizacion
			.Item[ lnItem ].Caja_PK = .oItem.Caja_PK
			.Item[ lnItem ].PersonalizarComprobante = .oItem.PersonalizarComprobante
			.Item[ lnItem ].CondicionRecargo = .oItem.CondicionRecargo
			.Item[ lnItem ].NumeroChequePropio_PK = .oItem.NumeroChequePropio_PK
			.Item[ lnItem ].CondicionDePago_PK = .oItem.CondicionDePago_PK
			.Item[ lnItem ].VisualizarEnEstadoDeCaja = .oItem.VisualizarEnEstadoDeCaja
			.Item[ lnItem ].ChequeElectronico = .oItem.ChequeElectronico
			.Item[ lnItem ].ValorDetalle = .oItem.ValorDetalle
			.Item[ lnItem ].Fecha = .oItem.Fecha
			.Item[ lnItem ].NumeroInterno = .oItem.NumeroInterno
			.Item[ lnItem ].Monto = .oItem.Monto
			.Item[ lnItem ].MontoOri = .oItem.MontoOri
			.Item[ lnItem ].RecargoPorcentaje = .oItem.RecargoPorcentaje
			.Item[ lnItem ].RecargoMonto = .oItem.RecargoMonto
			.Item[ lnItem ].Total = .oItem.Total
			.Item[ lnItem ].RecargoMontoSinImpuestos = .oItem.RecargoMontoSinImpuestos
			.Item[ lnItem ].MontoAMonedaSistema = .oItem.MontoAMonedaSistema
			.Item[ lnItem ].RecargoSinPercepciones = .oItem.RecargoSinPercepciones
			.Item[ lnItem ].NumeroValeDeCambio_PK = .oItem.NumeroValeDeCambio_PK
			.Item[ lnItem ].PermiteVuelto = .oItem.PermiteVuelto
			.Item[ lnItem ].IdItemComponente = .oItem.IdItemComponente
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Sumarizar() as boolean
		local lnItem as integer, loItem as Object, lnSum_Pesosalcambio as Number, lnSum_Recargomonto as Number, lnSum_Recargomontosinimpuestos as Number, lnSum_Recargosinpercepciones as Number, lnSum_Total as Number

		with this
			lnSum_Pesosalcambio = 0
			lnSum_Recargomonto = 0
			lnSum_Recargomontosinimpuestos = 0
			lnSum_Recargosinpercepciones = 0
			lnSum_Total = 0
			if this.lEsNavegacion
				if select( 'c_Valoresdetalle' ) > 0 and reccount( 'c_Valoresdetalle' ) > 0
					sum Pesosalcambio, Recargomonto, Recargomontosinimpuestos, Recargosinpercepciones, Total;
						 to ;
						 lnSum_Pesosalcambio, lnSum_Recargomonto, lnSum_Recargomontosinimpuestos, lnSum_Recargosinpercepciones, lnSum_Total
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
								lnSum_Recargomonto = lnSum_Recargomonto + .Recargomonto
								lnSum_Recargomontosinimpuestos = lnSum_Recargomontosinimpuestos + .Recargomontosinimpuestos
								lnSum_Recargosinpercepciones = lnSum_Recargosinpercepciones + .Recargosinpercepciones
								lnSum_Total = lnSum_Total + .Total
							endif
						endwith
					endif
				endfor

				if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
					loItem = .oItem
					with loItem 
						lnSum_Pesosalcambio = lnSum_Pesosalcambio + .Pesosalcambio
						lnSum_Recargomonto = lnSum_Recargomonto + .Recargomonto
						lnSum_Recargomontosinimpuestos = lnSum_Recargomontosinimpuestos + .Recargomontosinimpuestos
						lnSum_Recargosinpercepciones = lnSum_Recargosinpercepciones + .Recargosinpercepciones
						lnSum_Total = lnSum_Total + .Total
					endwith
				endif
			endif

			if .Sum_Pesosalcambio != lnSum_Pesosalcambio
				.Sum_Pesosalcambio = lnSum_Pesosalcambio
				.EventoCambioSum_Pesosalcambio()
			endif
			if .Sum_Recargomonto != lnSum_Recargomonto
				.Sum_Recargomonto = lnSum_Recargomonto
				.EventoCambioSum_Recargomonto()
			endif
			if .Sum_Recargomontosinimpuestos != lnSum_Recargomontosinimpuestos
				.Sum_Recargomontosinimpuestos = lnSum_Recargomontosinimpuestos
				.EventoCambioSum_Recargomontosinimpuestos()
			endif
			if .Sum_Recargosinpercepciones != lnSum_Recargosinpercepciones
				.Sum_Recargosinpercepciones = lnSum_Recargosinpercepciones
				.EventoCambioSum_Recargosinpercepciones()
			endif
			if .Sum_Total != lnSum_Total
				.Sum_Total = lnSum_Total
				.EventoCambioSum_Total()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Pesosalcambio() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Recargomonto() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Recargomontosinimpuestos() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Recargosinpercepciones() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Total() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalizar( toItem as Object ) as Void
		local lnItem as integer, loItem as Object, lnSum_Pesosalcambio as Number, lnSum_Recargomonto as Number, lnSum_Recargomontosinimpuestos as Number, lnSum_Recargosinpercepciones as Number, lnSum_Total as Number

		with this
			lnSum_Pesosalcambio = 0
			lnSum_Recargomonto = 0
			lnSum_Recargomontosinimpuestos = 0
			lnSum_Recargosinpercepciones = 0
			lnSum_Total = 0
			if !this.lEsNavegacion
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							if !empty(.VALOR_PK)
								lnSum_Pesosalcambio = lnSum_Pesosalcambio + .Pesosalcambio
								lnSum_Recargomonto = lnSum_Recargomonto + .Recargomonto
								lnSum_Recargomontosinimpuestos = lnSum_Recargomontosinimpuestos + .Recargomontosinimpuestos
								lnSum_Recargosinpercepciones = lnSum_Recargosinpercepciones + .Recargosinpercepciones
								lnSum_Total = lnSum_Total + .Total
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
						lnSum_Recargomonto = lnSum_Recargomonto + .Recargomonto
						lnSum_Recargomontosinimpuestos = lnSum_Recargomontosinimpuestos + .Recargomontosinimpuestos
						lnSum_Recargosinpercepciones = lnSum_Recargosinpercepciones + .Recargosinpercepciones
						lnSum_Total = lnSum_Total + .Total
					endif
				endwith
			endif

			if .Sum_Pesosalcambio != lnSum_Pesosalcambio
				.Sum_Pesosalcambio = lnSum_Pesosalcambio
				.EventoCambioSum_Pesosalcambio()
			endif
			if .Sum_Recargomonto != lnSum_Recargomonto
				.Sum_Recargomonto = lnSum_Recargomonto
				.EventoCambioSum_Recargomonto()
			endif
			if .Sum_Recargomontosinimpuestos != lnSum_Recargomontosinimpuestos
				.Sum_Recargomontosinimpuestos = lnSum_Recargomontosinimpuestos
				.EventoCambioSum_Recargomontosinimpuestos()
			endif
			if .Sum_Recargosinpercepciones != lnSum_Recargosinpercepciones
				.Sum_Recargosinpercepciones = lnSum_Recargosinpercepciones
				.EventoCambioSum_Recargosinpercepciones()
			endif
			if .Sum_Total != lnSum_Total
				.Sum_Total = lnSum_Total
				.EventoCambioSum_Total()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Acumular( tlForzar as Boolean, tcAtributo as String, tnValor as Decimal, tnValorAnt as Decimal ) as Void
		local lnItem as integer, loItem as Object, lnSum_Pesosalcambio as Number, lnSum_Recargomonto as Number, lnSum_Recargomontosinimpuestos as Number, lnSum_Recargosinpercepciones as Number, lnSum_Total as Number

		do case
		case tnValor = tnValorAnt
		case tcAtributo == 'Pesosalcambio'
			this.Sum_Pesosalcambio = this.Sum_Pesosalcambio - tnValorAnt + tnValor
			this.EventoCambioSum_Pesosalcambio()
		case tcAtributo == 'Recargomonto'
			this.Sum_Recargomonto = this.Sum_Recargomonto - tnValorAnt + tnValor
			this.EventoCambioSum_Recargomonto()
		case tcAtributo == 'Recargomontosinimpuestos'
			this.Sum_Recargomontosinimpuestos = this.Sum_Recargomontosinimpuestos - tnValorAnt + tnValor
			this.EventoCambioSum_Recargomontosinimpuestos()
		case tcAtributo == 'Recargosinpercepciones'
			this.Sum_Recargosinpercepciones = this.Sum_Recargosinpercepciones - tnValorAnt + tnValor
			this.EventoCambioSum_Recargosinpercepciones()
		case tcAtributo == 'Total'
			this.Sum_Total = this.Sum_Total - tnValorAnt + tnValor
			this.EventoCambioSum_Total()

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
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemFACTURADECOMPRAValoresdetalle' )
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

		select c_Valoresdetalle
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Codigo = c_Valoresdetalle.Codigo
			loItem.Cotiza = c_Valoresdetalle.Cotiza
			loItem.FechaComp = goLibrerias.ObtenerFechaFormateada( c_Valoresdetalle.FechaComp )
			loItem.Letra = c_Valoresdetalle.Letra
			loItem.NroDocumento = c_Valoresdetalle.NroDocumento
			loItem.NroItem = c_Valoresdetalle.NroItem
			loItem.NumeroCheque_PK = c_Valoresdetalle.NumeroCheque
			loItem.NumeroCupon = c_Valoresdetalle.NumeroCupon
			loItem.NumeroTarjeta = c_Valoresdetalle.NumeroTarjeta
			loItem.NumerodeComprobante = c_Valoresdetalle.NumerodeComprobante
			loItem.PesosAlCambio = c_Valoresdetalle.PesosAlCambio
			loItem.PuntoDeVenta = c_Valoresdetalle.PuntoDeVenta
			loItem.Signo = c_Valoresdetalle.Signo
			loItem.Tipo = c_Valoresdetalle.Tipo
			loItem.TipoDocumento = c_Valoresdetalle.TipoDocumento
			loItem.TipodeComprobante = c_Valoresdetalle.TipodeComprobante
			loItem.Turno = c_Valoresdetalle.Turno
			loItem.Valor_PK = c_Valoresdetalle.Valor
			loItem.Vendedor = c_Valoresdetalle.Vendedor
			loItem.FechaUltCotizacion = goLibrerias.ObtenerFechaFormateada( c_Valoresdetalle.FechaUltCotizacion )
			loItem.UltimaCotizacion = c_Valoresdetalle.UltimaCotizacion
			loItem.Caja_PK = c_Valoresdetalle.Caja
			loItem.PersonalizarComprobante = c_Valoresdetalle.PersonalizarComprobante
			loItem.NumeroChequePropio_PK = c_Valoresdetalle.NumeroChequePropio
			loItem.CondicionDePago_PK = c_Valoresdetalle.CondicionDePago
			loItem.VisualizarEnEstadoDeCaja = c_Valoresdetalle.VisualizarEnEstadoDeCaja
			loItem.ChequeElectronico = c_Valoresdetalle.ChequeElectronico
			loItem.ValorDetalle = c_Valoresdetalle.ValorDetalle
			loItem.Fecha = goLibrerias.ObtenerFechaFormateada( c_Valoresdetalle.Fecha )
			loItem.NumeroInterno = c_Valoresdetalle.NumeroInterno
			loItem.Monto = c_Valoresdetalle.Monto
			loItem.RecargoPorcentaje = c_Valoresdetalle.RecargoPorcentaje
			loItem.RecargoMonto = c_Valoresdetalle.RecargoMonto
			loItem.Total = c_Valoresdetalle.Total
			loItem.RecargoMontoSinImpuestos = c_Valoresdetalle.RecargoMontoSinImpuestos
			loItem.MontoAMonedaSistema = c_Valoresdetalle.MontoAMonedaSistema
			loItem.RecargoSinPercepciones = c_Valoresdetalle.RecargoSinPercepciones
			loItem.NumeroValeDeCambio_PK = c_Valoresdetalle.NumeroValeDeCambio
			loItem.PermiteVuelto = c_Valoresdetalle.PermiteVuelto
			loItem.IdItemComponente = c_Valoresdetalle.IdItemComponente
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
			
			if vartype( this.Item[lni].NRODOCUMENTO) = 'C'
				if len( alltrim( this.Item[lni].NRODOCUMENTO )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo NRODOCUMENTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].NRODOCUMENTO ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NRODOCUMENTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
				if lnLargoEntero <= 5
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo NUMEROCUPON del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:5), en el detalle ' + this.cEtiqueta + '.' )
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
			
			if vartype( this.Item[lni].NUMERODECOMPROBANTE) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].NUMERODECOMPROBANTE ) ) ) 
				lnValorDelDecimal = this.Item[lni].NUMERODECOMPROBANTE - int( this.Item[lni].NUMERODECOMPROBANTE )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 8
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo NUMERODECOMPROBANTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:8), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NUMERODECOMPROBANTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].SIGNO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].SIGNO ) ) ) 
				lnValorDelDecimal = this.Item[lni].SIGNO - int( this.Item[lni].SIGNO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo SIGNO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo SIGNO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].TIPODOCUMENTO) = 'C'
				if len( alltrim( this.Item[lni].TIPODOCUMENTO )) <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TIPODOCUMENTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TIPODOCUMENTO ))) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TIPODOCUMENTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TIPODECOMPROBANTE) = 'C'
				if len( alltrim( this.Item[lni].TIPODECOMPROBANTE )) <= 3
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TIPODECOMPROBANTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TIPODECOMPROBANTE ))) + ' Máxima:3), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TIPODECOMPROBANTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TURNO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].TURNO ) ) ) 
				lnValorDelDecimal = this.Item[lni].TURNO - int( this.Item[lni].TURNO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 1
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo TURNO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:1), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TURNO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].VENDEDOR) = 'C'
				if len( alltrim( this.Item[lni].VENDEDOR )) <= 5
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo VENDEDOR del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].VENDEDOR ))) + ' Máxima:5), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo VENDEDOR del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if inlist(vartype( this.Item[lni].FECHAULTCOTIZACION),'D','T')
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo FECHAULTCOTIZACION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].PERSONALIZARCOMPROBANTE) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PERSONALIZARCOMPROBANTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].CONDICIONDEPAGO_PK) = 'C'
				if len( alltrim( this.Item[lni].CONDICIONDEPAGO_PK )) <= 5
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CONDICIONDEPAGO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CONDICIONDEPAGO_PK ))) + ' Máxima:5), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CONDICIONDEPAGO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].VALORDETALLE) = 'C'
				if len( alltrim( this.Item[lni].VALORDETALLE )) <= 40
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo VALORDETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].VALORDETALLE ))) + ' Máxima:40), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo VALORDETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if inlist(vartype( this.Item[lni].FECHA),'D','T')
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo FECHA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].RECARGOPORCENTAJE) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].RECARGOPORCENTAJE ) ) ) 
				lnValorDelDecimal = this.Item[lni].RECARGOPORCENTAJE - int( this.Item[lni].RECARGOPORCENTAJE )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 4
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo RECARGOPORCENTAJE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:4), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo RECARGOPORCENTAJE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].RECARGOMONTO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].RECARGOMONTO ) ) ) 
				lnValorDelDecimal = this.Item[lni].RECARGOMONTO - int( this.Item[lni].RECARGOMONTO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 6
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo RECARGOMONTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:6), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo RECARGOMONTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].RECARGOMONTOSINIMPUESTOS) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].RECARGOMONTOSINIMPUESTOS ) ) ) 
				lnValorDelDecimal = this.Item[lni].RECARGOMONTOSINIMPUESTOS - int( this.Item[lni].RECARGOMONTOSINIMPUESTOS )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo RECARGOMONTOSINIMPUESTOS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo RECARGOMONTOSINIMPUESTOS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].RECARGOSINPERCEPCIONES) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].RECARGOSINPERCEPCIONES ) ) ) 
				lnValorDelDecimal = this.Item[lni].RECARGOSINPERCEPCIONES - int( this.Item[lni].RECARGOSINPERCEPCIONES )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo RECARGOSINPERCEPCIONES del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo RECARGOSINPERCEPCIONES del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NUMEROVALEDECAMBIO_PK) = 'C'
				if len( alltrim( this.Item[lni].NUMEROVALEDECAMBIO_PK )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo NUMEROVALEDECAMBIO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].NUMEROVALEDECAMBIO_PK ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NUMEROVALEDECAMBIO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PERMITEVUELTO) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PERMITEVUELTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Cotiza = toItemOrigen.Cotiza
		toItemDestino.Fechacomp = toItemOrigen.Fechacomp
		toItemDestino.Letra = toItemOrigen.Letra
		toItemDestino.Nrodocumento = toItemOrigen.Nrodocumento
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Numerocheque_PK = toItemOrigen.Numerocheque_PK
		toItemDestino.Numerocupon = toItemOrigen.Numerocupon
		toItemDestino.Numerotarjeta = toItemOrigen.Numerotarjeta
		toItemDestino.Numerodecomprobante = toItemOrigen.Numerodecomprobante
		toItemDestino.Pesosalcambio = toItemOrigen.Pesosalcambio
		toItemDestino.Puntodeventa = toItemOrigen.Puntodeventa
		toItemDestino.Signo = toItemOrigen.Signo
		toItemDestino.Tipo = toItemOrigen.Tipo
		toItemDestino.Tipodocumento = toItemOrigen.Tipodocumento
		toItemDestino.Tipodecomprobante = toItemOrigen.Tipodecomprobante
		toItemDestino.Turno = toItemOrigen.Turno
		toItemDestino.Valor_PK = toItemOrigen.Valor_PK
		toItemDestino.Vendedor = toItemOrigen.Vendedor
		toItemDestino.Fechaultcotizacion = toItemOrigen.Fechaultcotizacion
		toItemDestino.Ultimacotizacion = toItemOrigen.Ultimacotizacion
		toItemDestino.Caja_PK = toItemOrigen.Caja_PK
		toItemDestino.Personalizarcomprobante = toItemOrigen.Personalizarcomprobante
		toItemDestino.Condicionrecargo = toItemOrigen.Condicionrecargo
		toItemDestino.Numerochequepropio_PK = toItemOrigen.Numerochequepropio_PK
		toItemDestino.Condiciondepago_PK = toItemOrigen.Condiciondepago_PK
		toItemDestino.Visualizarenestadodecaja = toItemOrigen.Visualizarenestadodecaja
		toItemDestino.Chequeelectronico = toItemOrigen.Chequeelectronico
		toItemDestino.Valordetalle = toItemOrigen.Valordetalle
		toItemDestino.Fecha = toItemOrigen.Fecha
		toItemDestino.Numerointerno = toItemOrigen.Numerointerno
		toItemDestino.Monto = toItemOrigen.Monto
		toItemDestino.Montoori = toItemOrigen.Montoori
		toItemDestino.Recargoporcentaje = toItemOrigen.Recargoporcentaje
		toItemDestino.Recargomonto = toItemOrigen.Recargomonto
		toItemDestino.Total = toItemOrigen.Total
		toItemDestino.Recargomontosinimpuestos = toItemOrigen.Recargomontosinimpuestos
		toItemDestino.Montoamonedasistema = toItemOrigen.Montoamonedasistema
		toItemDestino.Recargosinpercepciones = toItemOrigen.Recargosinpercepciones
		toItemDestino.Numerovaledecambio_PK = toItemOrigen.Numerovaledecambio_PK
		toItemDestino.Permitevuelto = toItemOrigen.Permitevuelto
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
	Cotiza = 0
	Fechacomp = ctod( '  /  /    ' )
	Letra = []
	Nrodocumento = []
	Nroitem = 0
	Numerocheque_PK = []
	Numerocupon = 0
	Numerotarjeta = []
	Numerodecomprobante = 0
	Pesosalcambio = 0
	Puntodeventa = 0
	Signo = 0
	Tipo = 0
	Tipodocumento = []
	Tipodecomprobante = []
	Turno = 0
	Valor_PK = []
	Vendedor = []
	Fechaultcotizacion = ctod( '  /  /    ' )
	Ultimacotizacion = 0
	Caja_PK = 0
	Personalizarcomprobante = .F.
	Condicionrecargo = 0
	Numerochequepropio_PK = []
	Condiciondepago_PK = []
	Visualizarenestadodecaja = .F.
	Chequeelectronico = .F.
	Valordetalle = []
	Fecha = ctod( '  /  /    ' )
	Numerointerno = []
	Monto = 0
	Montoori = 0
	Recargoporcentaje = 0
	Recargomonto = 0
	Total = 0
	Recargomontosinimpuestos = 0
	Montoamonedasistema = 0
	Recargosinpercepciones = 0
	Numerovaledecambio_PK = []
	Permitevuelto = .F.
	Iditemcomponente = []
	NroItem = 0
	lTieneImporteEnRecibido = .f.

enddefine