
define class Din_DetalleFACTURADEEXPORTACIONValoresdetalle as DetalleValoresventa of DetalleValoresventa.Prg

	Sum_Aplicableparavuelto = 0
	Sum_Descuentomonto = 0
	Sum_Descuentomontoenpesos = 0
	Sum_Descuentomontosinimpuestos = 0
	Sum_Montoalcambio = 0
	Sum_Montodesrec = 0
	Sum_Montodesrecpesos = 0
	Sum_Pesosalcambio = 0
	Sum_Recargomonto = 0
	Sum_Recargomontoenpesos = 0
	Sum_Recargomontosinimpuestos = 0
	Sum_Recargosinpercepciones = 0
	Sum_Recibido = 0
	Sum_Recibidoalcambio = 0
	Sum_Total = 0

	nCantidadItems = 999
	cNombre = 'Valoresdetalle'
	cEtiqueta = 'Valoresdetalle'
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
			
				.Redondeo = this.Item[ tnItem ].Redondeo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Redondeo', .Redondeo )
			
				.IdItemValores = this.Item[ tnItem ].IdItemValores
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'IdItemValores', .IdItemValores )
			
				.AutorizacionPOS = this.Item[ tnItem ].AutorizacionPOS
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'AutorizacionPOS', .AutorizacionPOS )
			
				.Cuotas = this.Item[ tnItem ].Cuotas
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Cuotas', .Cuotas )
			
				.DescuentoPorcentaje = this.Item[ tnItem ].DescuentoPorcentaje
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'DescuentoPorcentaje', .DescuentoPorcentaje )
			
				.DescuentoMonto = this.Item[ tnItem ].DescuentoMonto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'DescuentoMonto', .DescuentoMonto )
			
				.DescuentoMontoEnPesos = this.Item[ tnItem ].DescuentoMontoEnPesos
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'DescuentoMontoEnPesos', .DescuentoMontoEnPesos )
			
				.RecargoMontoEnPesos = this.Item[ tnItem ].RecargoMontoEnPesos
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RecargoMontoEnPesos', .RecargoMontoEnPesos )
			
				.DescuentoMontoSinImpuestos = this.Item[ tnItem ].DescuentoMontoSinImpuestos
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'DescuentoMontoSinImpuestos', .DescuentoMontoSinImpuestos )
			
				.CondicionDePago_PK = this.Item[ tnItem ].CondicionDePago_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CondicionDePago_PK', .CondicionDePago_PK )
			
				.MontoDesRecPesos = this.Item[ tnItem ].MontoDesRecPesos
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoDesRecPesos', .MontoDesRecPesos )
			
				.EsVuelto = this.Item[ tnItem ].EsVuelto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'EsVuelto', .EsVuelto )
			
				.CantTipoValoresAcumulados = this.Item[ tnItem ].CantTipoValoresAcumulados
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CantTipoValoresAcumulados', .CantTipoValoresAcumulados )
			
				.nCoeficienteImpuestos = this.Item[ tnItem ].nCoeficienteImpuestos
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'nCoeficienteImpuestos', .nCoeficienteImpuestos )
			
				.nDiferenciaRedondeo = this.Item[ tnItem ].nDiferenciaRedondeo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'nDiferenciaRedondeo', .nDiferenciaRedondeo )
			
				.DiferenciaPorRedondeoDelRecibido = this.Item[ tnItem ].DiferenciaPorRedondeoDelRecibido
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'DiferenciaPorRedondeoDelRecibido', .DiferenciaPorRedondeoDelRecibido )
			
				.PorcentajeDiferenciaRedondeoRecibido = this.Item[ tnItem ].PorcentajeDiferenciaRedondeoRecibido
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PorcentajeDiferenciaRedondeoRecibido', .PorcentajeDiferenciaRedondeoRecibido )
			
				.EsAnulacion = this.Item[ tnItem ].EsAnulacion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'EsAnulacion', .EsAnulacion )
			
				.VisualizarEnEstadoDeCaja = this.Item[ tnItem ].VisualizarEnEstadoDeCaja
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'VisualizarEnEstadoDeCaja', .VisualizarEnEstadoDeCaja )
			
				.ChequeElectronico = this.Item[ tnItem ].ChequeElectronico
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ChequeElectronico', .ChequeElectronico )
			
				.IdItemRetiroEnEfectivo = this.Item[ tnItem ].IdItemRetiroEnEfectivo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'IdItemRetiroEnEfectivo', .IdItemRetiroEnEfectivo )
			
				.EsRetiroEfectivo = this.Item[ tnItem ].EsRetiroEfectivo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'EsRetiroEfectivo', .EsRetiroEfectivo )
			
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
			
				.MontoAlCambio = this.Item[ tnItem ].MontoAlCambio
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoAlCambio', .MontoAlCambio )
			
				.EsCuponHuerfano = this.Item[ tnItem ].EsCuponHuerfano
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'EsCuponHuerfano', .EsCuponHuerfano )
			
				.AplicableParaVuelto = this.Item[ tnItem ].AplicableParaVuelto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'AplicableParaVuelto', .AplicableParaVuelto )
			
				.RecargoPorcentaje = this.Item[ tnItem ].RecargoPorcentaje
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RecargoPorcentaje', .RecargoPorcentaje )
			
				.PorcentajeDesRec = this.Item[ tnItem ].PorcentajeDesRec
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PorcentajeDesRec', .PorcentajeDesRec )
			
				.RecargoMonto = this.Item[ tnItem ].RecargoMonto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RecargoMonto', .RecargoMonto )
			
				.MontoDesRec = this.Item[ tnItem ].MontoDesRec
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoDesRec', .MontoDesRec )
			
				.Total = this.Item[ tnItem ].Total
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Total', .Total )
			
				.RecibidoSugerido = this.Item[ tnItem ].RecibidoSugerido
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RecibidoSugerido', .RecibidoSugerido )
			
				.Recibido = this.Item[ tnItem ].Recibido
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Recibido', .Recibido )
			
				.RecargoMontoSinImpuestos = this.Item[ tnItem ].RecargoMontoSinImpuestos
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RecargoMontoSinImpuestos', .RecargoMontoSinImpuestos )
			
				.RecibidoAlCambio = this.Item[ tnItem ].RecibidoAlCambio
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RecibidoAlCambio', .RecibidoAlCambio )
			
				.MontoAMonedaSistema = this.Item[ tnItem ].MontoAMonedaSistema
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoAMonedaSistema', .MontoAMonedaSistema )
			
				.MontoCupon = this.Item[ tnItem ].MontoCupon
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoCupon', .MontoCupon )
			
				.RecargoSinPercepciones = this.Item[ tnItem ].RecargoSinPercepciones
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RecargoSinPercepciones', .RecargoSinPercepciones )
			
				.NumeroValeDeCambio_PK = this.Item[ tnItem ].NumeroValeDeCambio_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumeroValeDeCambio_PK', .NumeroValeDeCambio_PK )
			
				.PermiteVuelto = this.Item[ tnItem ].PermiteVuelto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PermiteVuelto', .PermiteVuelto )
			
				.CodigoDeCupon = this.Item[ tnItem ].CodigoDeCupon
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodigoDeCupon', .CodigoDeCupon )
			
				.Cupon_PK = this.Item[ tnItem ].Cupon_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Cupon_PK', .Cupon_PK )
			
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
			.Redondeo = this.oItem.Redondeo
			.IdItemValores = this.oItem.IdItemValores
			.AutorizacionPOS = this.oItem.AutorizacionPOS
			.Cuotas = this.oItem.Cuotas
			.DescuentoPorcentaje = this.oItem.DescuentoPorcentaje
			.DescuentoMonto = this.oItem.DescuentoMonto
			.DescuentoMontoEnPesos = this.oItem.DescuentoMontoEnPesos
			.RecargoMontoEnPesos = this.oItem.RecargoMontoEnPesos
			.DescuentoMontoSinImpuestos = this.oItem.DescuentoMontoSinImpuestos
			.CondicionDePago_PK = this.oItem.CondicionDePago_PK
			.MontoDesRecPesos = this.oItem.MontoDesRecPesos
			.EsVuelto = this.oItem.EsVuelto
			.CantTipoValoresAcumulados = this.oItem.CantTipoValoresAcumulados
			.nCoeficienteImpuestos = this.oItem.nCoeficienteImpuestos
			.nDiferenciaRedondeo = this.oItem.nDiferenciaRedondeo
			.DiferenciaPorRedondeoDelRecibido = this.oItem.DiferenciaPorRedondeoDelRecibido
			.PorcentajeDiferenciaRedondeoRecibido = this.oItem.PorcentajeDiferenciaRedondeoRecibido
			.EsAnulacion = this.oItem.EsAnulacion
			.VisualizarEnEstadoDeCaja = this.oItem.VisualizarEnEstadoDeCaja
			.ChequeElectronico = this.oItem.ChequeElectronico
			.IdItemRetiroEnEfectivo = this.oItem.IdItemRetiroEnEfectivo
			.EsRetiroEfectivo = this.oItem.EsRetiroEfectivo
			.ValorDetalle = this.oItem.ValorDetalle
			.Fecha = this.oItem.Fecha
			.NumeroInterno = this.oItem.NumeroInterno
			.Monto = this.oItem.Monto
			.MontoOri = this.oItem.MontoOri
			.MontoAlCambio = this.oItem.MontoAlCambio
			.EsCuponHuerfano = this.oItem.EsCuponHuerfano
			.AplicableParaVuelto = this.oItem.AplicableParaVuelto
			.RecargoPorcentaje = this.oItem.RecargoPorcentaje
			.PorcentajeDesRec = this.oItem.PorcentajeDesRec
			.RecargoMonto = this.oItem.RecargoMonto
			.MontoDesRec = this.oItem.MontoDesRec
			.Total = this.oItem.Total
			.RecibidoSugerido = this.oItem.RecibidoSugerido
			.Recibido = this.oItem.Recibido
			.RecargoMontoSinImpuestos = this.oItem.RecargoMontoSinImpuestos
			.RecibidoAlCambio = this.oItem.RecibidoAlCambio
			.MontoAMonedaSistema = this.oItem.MontoAMonedaSistema
			.MontoCupon = this.oItem.MontoCupon
			.RecargoSinPercepciones = this.oItem.RecargoSinPercepciones
			.NumeroValeDeCambio_PK = this.oItem.NumeroValeDeCambio_PK
			.PermiteVuelto = this.oItem.PermiteVuelto
			.CodigoDeCupon = this.oItem.CodigoDeCupon
			.Cupon_PK = this.oItem.Cupon_PK
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
			.Item[ lnItem ].Redondeo = .oItem.Redondeo
			.Item[ lnItem ].IdItemValores = .oItem.IdItemValores
			.Item[ lnItem ].AutorizacionPOS = .oItem.AutorizacionPOS
			.Item[ lnItem ].Cuotas = .oItem.Cuotas
			.Item[ lnItem ].DescuentoPorcentaje = .oItem.DescuentoPorcentaje
			.Item[ lnItem ].DescuentoMonto = .oItem.DescuentoMonto
			.Item[ lnItem ].DescuentoMontoEnPesos = .oItem.DescuentoMontoEnPesos
			.Item[ lnItem ].RecargoMontoEnPesos = .oItem.RecargoMontoEnPesos
			.Item[ lnItem ].DescuentoMontoSinImpuestos = .oItem.DescuentoMontoSinImpuestos
			.Item[ lnItem ].CondicionDePago_PK = .oItem.CondicionDePago_PK
			.Item[ lnItem ].MontoDesRecPesos = .oItem.MontoDesRecPesos
			.Item[ lnItem ].EsVuelto = .oItem.EsVuelto
			.Item[ lnItem ].CantTipoValoresAcumulados = .oItem.CantTipoValoresAcumulados
			.Item[ lnItem ].nCoeficienteImpuestos = .oItem.nCoeficienteImpuestos
			.Item[ lnItem ].nDiferenciaRedondeo = .oItem.nDiferenciaRedondeo
			.Item[ lnItem ].DiferenciaPorRedondeoDelRecibido = .oItem.DiferenciaPorRedondeoDelRecibido
			.Item[ lnItem ].PorcentajeDiferenciaRedondeoRecibido = .oItem.PorcentajeDiferenciaRedondeoRecibido
			.Item[ lnItem ].EsAnulacion = .oItem.EsAnulacion
			.Item[ lnItem ].VisualizarEnEstadoDeCaja = .oItem.VisualizarEnEstadoDeCaja
			.Item[ lnItem ].ChequeElectronico = .oItem.ChequeElectronico
			.Item[ lnItem ].IdItemRetiroEnEfectivo = .oItem.IdItemRetiroEnEfectivo
			.Item[ lnItem ].EsRetiroEfectivo = .oItem.EsRetiroEfectivo
			.Item[ lnItem ].ValorDetalle = .oItem.ValorDetalle
			.Item[ lnItem ].Fecha = .oItem.Fecha
			.Item[ lnItem ].NumeroInterno = .oItem.NumeroInterno
			.Item[ lnItem ].Monto = .oItem.Monto
			.Item[ lnItem ].MontoOri = .oItem.MontoOri
			.Item[ lnItem ].MontoAlCambio = .oItem.MontoAlCambio
			.Item[ lnItem ].EsCuponHuerfano = .oItem.EsCuponHuerfano
			.Item[ lnItem ].AplicableParaVuelto = .oItem.AplicableParaVuelto
			.Item[ lnItem ].RecargoPorcentaje = .oItem.RecargoPorcentaje
			.Item[ lnItem ].PorcentajeDesRec = .oItem.PorcentajeDesRec
			.Item[ lnItem ].RecargoMonto = .oItem.RecargoMonto
			.Item[ lnItem ].MontoDesRec = .oItem.MontoDesRec
			.Item[ lnItem ].Total = .oItem.Total
			.Item[ lnItem ].RecibidoSugerido = .oItem.RecibidoSugerido
			.Item[ lnItem ].Recibido = .oItem.Recibido
			.Item[ lnItem ].RecargoMontoSinImpuestos = .oItem.RecargoMontoSinImpuestos
			.Item[ lnItem ].RecibidoAlCambio = .oItem.RecibidoAlCambio
			.Item[ lnItem ].MontoAMonedaSistema = .oItem.MontoAMonedaSistema
			.Item[ lnItem ].MontoCupon = .oItem.MontoCupon
			.Item[ lnItem ].RecargoSinPercepciones = .oItem.RecargoSinPercepciones
			.Item[ lnItem ].NumeroValeDeCambio_PK = .oItem.NumeroValeDeCambio_PK
			.Item[ lnItem ].PermiteVuelto = .oItem.PermiteVuelto
			.Item[ lnItem ].CodigoDeCupon = .oItem.CodigoDeCupon
			.Item[ lnItem ].Cupon_PK = .oItem.Cupon_PK
			.Item[ lnItem ].IdItemComponente = .oItem.IdItemComponente
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Sumarizar() as boolean
		local lnItem as integer, loItem as Object, lnSum_Aplicableparavuelto as Number, lnSum_Descuentomonto as Number, lnSum_Descuentomontoenpesos as Number, lnSum_Descuentomontosinimpuestos as Number, lnSum_Montoalcambio as Number, lnSum_Montodesrec as Number, lnSum_Montodesrecpesos as Number, lnSum_Pesosalcambio as Number, lnSum_Recargomonto as Number, lnSum_Recargomontoenpesos as Number, lnSum_Recargomontosinimpuestos as Number, lnSum_Recargosinpercepciones as Number, lnSum_Recibido as Number, lnSum_Recibidoalcambio as Number, lnSum_Total as Number

		with this
			lnSum_Aplicableparavuelto = 0
			lnSum_Descuentomonto = 0
			lnSum_Descuentomontoenpesos = 0
			lnSum_Descuentomontosinimpuestos = 0
			lnSum_Montoalcambio = 0
			lnSum_Montodesrec = 0
			lnSum_Montodesrecpesos = 0
			lnSum_Pesosalcambio = 0
			lnSum_Recargomonto = 0
			lnSum_Recargomontoenpesos = 0
			lnSum_Recargomontosinimpuestos = 0
			lnSum_Recargosinpercepciones = 0
			lnSum_Recibido = 0
			lnSum_Recibidoalcambio = 0
			lnSum_Total = 0
			if this.lEsNavegacion
				if select( 'c_Valoresdetalle' ) > 0 and reccount( 'c_Valoresdetalle' ) > 0
					sum Descuentomonto, Descuentomontoenpesos, Descuentomontosinimpuestos, Montodesrec, Montodesrecpesos, Pesosalcambio, Recargomonto, Recargomontoenpesos, Recargomontosinimpuestos, Recargosinpercepciones, Recibido, Recibidoalcambio, Total;
						 to ;
						 lnSum_Descuentomonto, lnSum_Descuentomontoenpesos, lnSum_Descuentomontosinimpuestos, lnSum_Montodesrec, lnSum_Montodesrecpesos, lnSum_Pesosalcambio, lnSum_Recargomonto, lnSum_Recargomontoenpesos, lnSum_Recargomontosinimpuestos, lnSum_Recargosinpercepciones, lnSum_Recibido, lnSum_Recibidoalcambio, lnSum_Total
				endif
				this.lEsNavegacion = .f.
			else
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							if !empty(.VALOR_PK)
								lnSum_Aplicableparavuelto = lnSum_Aplicableparavuelto + .Aplicableparavuelto
								lnSum_Descuentomonto = lnSum_Descuentomonto + .Descuentomonto
								lnSum_Descuentomontoenpesos = lnSum_Descuentomontoenpesos + .Descuentomontoenpesos
								lnSum_Descuentomontosinimpuestos = lnSum_Descuentomontosinimpuestos + .Descuentomontosinimpuestos
								lnSum_Montoalcambio = lnSum_Montoalcambio + .Montoalcambio
								lnSum_Montodesrec = lnSum_Montodesrec + .Montodesrec
								lnSum_Montodesrecpesos = lnSum_Montodesrecpesos + .Montodesrecpesos
								lnSum_Pesosalcambio = lnSum_Pesosalcambio + .Pesosalcambio
								lnSum_Recargomonto = lnSum_Recargomonto + .Recargomonto
								lnSum_Recargomontoenpesos = lnSum_Recargomontoenpesos + .Recargomontoenpesos
								lnSum_Recargomontosinimpuestos = lnSum_Recargomontosinimpuestos + .Recargomontosinimpuestos
								lnSum_Recargosinpercepciones = lnSum_Recargosinpercepciones + .Recargosinpercepciones
								lnSum_Recibido = lnSum_Recibido + .Recibido
								lnSum_Recibidoalcambio = lnSum_Recibidoalcambio + .Recibidoalcambio
								lnSum_Total = lnSum_Total + .Total
							endif
						endwith
					endif
				endfor

				if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
					loItem = .oItem
					with loItem 
						lnSum_Aplicableparavuelto = lnSum_Aplicableparavuelto + .Aplicableparavuelto
						lnSum_Descuentomonto = lnSum_Descuentomonto + .Descuentomonto
						lnSum_Descuentomontoenpesos = lnSum_Descuentomontoenpesos + .Descuentomontoenpesos
						lnSum_Descuentomontosinimpuestos = lnSum_Descuentomontosinimpuestos + .Descuentomontosinimpuestos
						lnSum_Montoalcambio = lnSum_Montoalcambio + .Montoalcambio
						lnSum_Montodesrec = lnSum_Montodesrec + .Montodesrec
						lnSum_Montodesrecpesos = lnSum_Montodesrecpesos + .Montodesrecpesos
						lnSum_Pesosalcambio = lnSum_Pesosalcambio + .Pesosalcambio
						lnSum_Recargomonto = lnSum_Recargomonto + .Recargomonto
						lnSum_Recargomontoenpesos = lnSum_Recargomontoenpesos + .Recargomontoenpesos
						lnSum_Recargomontosinimpuestos = lnSum_Recargomontosinimpuestos + .Recargomontosinimpuestos
						lnSum_Recargosinpercepciones = lnSum_Recargosinpercepciones + .Recargosinpercepciones
						lnSum_Recibido = lnSum_Recibido + .Recibido
						lnSum_Recibidoalcambio = lnSum_Recibidoalcambio + .Recibidoalcambio
						lnSum_Total = lnSum_Total + .Total
					endwith
				endif
			endif

			if .Sum_Aplicableparavuelto != lnSum_Aplicableparavuelto
				.Sum_Aplicableparavuelto = lnSum_Aplicableparavuelto
				.EventoCambioSum_Aplicableparavuelto()
			endif
			if .Sum_Descuentomonto != lnSum_Descuentomonto
				.Sum_Descuentomonto = lnSum_Descuentomonto
				.EventoCambioSum_Descuentomonto()
			endif
			if .Sum_Descuentomontoenpesos != lnSum_Descuentomontoenpesos
				.Sum_Descuentomontoenpesos = lnSum_Descuentomontoenpesos
				.EventoCambioSum_Descuentomontoenpesos()
			endif
			if .Sum_Descuentomontosinimpuestos != lnSum_Descuentomontosinimpuestos
				.Sum_Descuentomontosinimpuestos = lnSum_Descuentomontosinimpuestos
				.EventoCambioSum_Descuentomontosinimpuestos()
			endif
			if .Sum_Montoalcambio != lnSum_Montoalcambio
				.Sum_Montoalcambio = lnSum_Montoalcambio
				.EventoCambioSum_Montoalcambio()
			endif
			if .Sum_Montodesrec != lnSum_Montodesrec
				.Sum_Montodesrec = lnSum_Montodesrec
				.EventoCambioSum_Montodesrec()
			endif
			if .Sum_Montodesrecpesos != lnSum_Montodesrecpesos
				.Sum_Montodesrecpesos = lnSum_Montodesrecpesos
				.EventoCambioSum_Montodesrecpesos()
			endif
			if .Sum_Pesosalcambio != lnSum_Pesosalcambio
				.Sum_Pesosalcambio = lnSum_Pesosalcambio
				.EventoCambioSum_Pesosalcambio()
			endif
			if .Sum_Recargomonto != lnSum_Recargomonto
				.Sum_Recargomonto = lnSum_Recargomonto
				.EventoCambioSum_Recargomonto()
			endif
			if .Sum_Recargomontoenpesos != lnSum_Recargomontoenpesos
				.Sum_Recargomontoenpesos = lnSum_Recargomontoenpesos
				.EventoCambioSum_Recargomontoenpesos()
			endif
			if .Sum_Recargomontosinimpuestos != lnSum_Recargomontosinimpuestos
				.Sum_Recargomontosinimpuestos = lnSum_Recargomontosinimpuestos
				.EventoCambioSum_Recargomontosinimpuestos()
			endif
			if .Sum_Recargosinpercepciones != lnSum_Recargosinpercepciones
				.Sum_Recargosinpercepciones = lnSum_Recargosinpercepciones
				.EventoCambioSum_Recargosinpercepciones()
			endif
			if .Sum_Recibido != lnSum_Recibido
				.Sum_Recibido = lnSum_Recibido
				.EventoCambioSum_Recibido()
			endif
			if .Sum_Recibidoalcambio != lnSum_Recibidoalcambio
				.Sum_Recibidoalcambio = lnSum_Recibidoalcambio
				.EventoCambioSum_Recibidoalcambio()
			endif
			if .Sum_Total != lnSum_Total
				.Sum_Total = lnSum_Total
				.EventoCambioSum_Total()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Aplicableparavuelto() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Descuentomonto() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Descuentomontoenpesos() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Descuentomontosinimpuestos() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Montoalcambio() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Montodesrec() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Montodesrecpesos() as boolean
		** Evento que se dispara cuando cambia el sumarizado
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
	function EventoCambioSum_Recargomontoenpesos() as boolean
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
	function EventoCambioSum_Recibido() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Recibidoalcambio() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Total() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalizar( toItem as Object ) as Void
		local lnItem as integer, loItem as Object, lnSum_Aplicableparavuelto as Number, lnSum_Descuentomonto as Number, lnSum_Descuentomontoenpesos as Number, lnSum_Descuentomontosinimpuestos as Number, lnSum_Montoalcambio as Number, lnSum_Montodesrec as Number, lnSum_Montodesrecpesos as Number, lnSum_Pesosalcambio as Number, lnSum_Recargomonto as Number, lnSum_Recargomontoenpesos as Number, lnSum_Recargomontosinimpuestos as Number, lnSum_Recargosinpercepciones as Number, lnSum_Recibido as Number, lnSum_Recibidoalcambio as Number, lnSum_Total as Number

		with this
			lnSum_Aplicableparavuelto = 0
			lnSum_Descuentomonto = 0
			lnSum_Descuentomontoenpesos = 0
			lnSum_Descuentomontosinimpuestos = 0
			lnSum_Montoalcambio = 0
			lnSum_Montodesrec = 0
			lnSum_Montodesrecpesos = 0
			lnSum_Pesosalcambio = 0
			lnSum_Recargomonto = 0
			lnSum_Recargomontoenpesos = 0
			lnSum_Recargomontosinimpuestos = 0
			lnSum_Recargosinpercepciones = 0
			lnSum_Recibido = 0
			lnSum_Recibidoalcambio = 0
			lnSum_Total = 0
			if !this.lEsNavegacion
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							if !empty(.VALOR_PK)
								lnSum_Aplicableparavuelto = lnSum_Aplicableparavuelto + .Aplicableparavuelto
								lnSum_Descuentomonto = lnSum_Descuentomonto + .Descuentomonto
								lnSum_Descuentomontoenpesos = lnSum_Descuentomontoenpesos + .Descuentomontoenpesos
								lnSum_Descuentomontosinimpuestos = lnSum_Descuentomontosinimpuestos + .Descuentomontosinimpuestos
								lnSum_Montoalcambio = lnSum_Montoalcambio + .Montoalcambio
								lnSum_Montodesrec = lnSum_Montodesrec + .Montodesrec
								lnSum_Montodesrecpesos = lnSum_Montodesrecpesos + .Montodesrecpesos
								lnSum_Pesosalcambio = lnSum_Pesosalcambio + .Pesosalcambio
								lnSum_Recargomonto = lnSum_Recargomonto + .Recargomonto
								lnSum_Recargomontoenpesos = lnSum_Recargomontoenpesos + .Recargomontoenpesos
								lnSum_Recargomontosinimpuestos = lnSum_Recargomontosinimpuestos + .Recargomontosinimpuestos
								lnSum_Recargosinpercepciones = lnSum_Recargosinpercepciones + .Recargosinpercepciones
								lnSum_Recibido = lnSum_Recibido + .Recibido
								lnSum_Recibidoalcambio = lnSum_Recibidoalcambio + .Recibidoalcambio
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
						lnSum_Aplicableparavuelto = lnSum_Aplicableparavuelto + .Aplicableparavuelto
						lnSum_Descuentomonto = lnSum_Descuentomonto + .Descuentomonto
						lnSum_Descuentomontoenpesos = lnSum_Descuentomontoenpesos + .Descuentomontoenpesos
						lnSum_Descuentomontosinimpuestos = lnSum_Descuentomontosinimpuestos + .Descuentomontosinimpuestos
						lnSum_Montoalcambio = lnSum_Montoalcambio + .Montoalcambio
						lnSum_Montodesrec = lnSum_Montodesrec + .Montodesrec
						lnSum_Montodesrecpesos = lnSum_Montodesrecpesos + .Montodesrecpesos
						lnSum_Pesosalcambio = lnSum_Pesosalcambio + .Pesosalcambio
						lnSum_Recargomonto = lnSum_Recargomonto + .Recargomonto
						lnSum_Recargomontoenpesos = lnSum_Recargomontoenpesos + .Recargomontoenpesos
						lnSum_Recargomontosinimpuestos = lnSum_Recargomontosinimpuestos + .Recargomontosinimpuestos
						lnSum_Recargosinpercepciones = lnSum_Recargosinpercepciones + .Recargosinpercepciones
						lnSum_Recibido = lnSum_Recibido + .Recibido
						lnSum_Recibidoalcambio = lnSum_Recibidoalcambio + .Recibidoalcambio
						lnSum_Total = lnSum_Total + .Total
					endif
				endwith
			endif

			if .Sum_Aplicableparavuelto != lnSum_Aplicableparavuelto
				.Sum_Aplicableparavuelto = lnSum_Aplicableparavuelto
				.EventoCambioSum_Aplicableparavuelto()
			endif
			if .Sum_Descuentomonto != lnSum_Descuentomonto
				.Sum_Descuentomonto = lnSum_Descuentomonto
				.EventoCambioSum_Descuentomonto()
			endif
			if .Sum_Descuentomontoenpesos != lnSum_Descuentomontoenpesos
				.Sum_Descuentomontoenpesos = lnSum_Descuentomontoenpesos
				.EventoCambioSum_Descuentomontoenpesos()
			endif
			if .Sum_Descuentomontosinimpuestos != lnSum_Descuentomontosinimpuestos
				.Sum_Descuentomontosinimpuestos = lnSum_Descuentomontosinimpuestos
				.EventoCambioSum_Descuentomontosinimpuestos()
			endif
			if .Sum_Montoalcambio != lnSum_Montoalcambio
				.Sum_Montoalcambio = lnSum_Montoalcambio
				.EventoCambioSum_Montoalcambio()
			endif
			if .Sum_Montodesrec != lnSum_Montodesrec
				.Sum_Montodesrec = lnSum_Montodesrec
				.EventoCambioSum_Montodesrec()
			endif
			if .Sum_Montodesrecpesos != lnSum_Montodesrecpesos
				.Sum_Montodesrecpesos = lnSum_Montodesrecpesos
				.EventoCambioSum_Montodesrecpesos()
			endif
			if .Sum_Pesosalcambio != lnSum_Pesosalcambio
				.Sum_Pesosalcambio = lnSum_Pesosalcambio
				.EventoCambioSum_Pesosalcambio()
			endif
			if .Sum_Recargomonto != lnSum_Recargomonto
				.Sum_Recargomonto = lnSum_Recargomonto
				.EventoCambioSum_Recargomonto()
			endif
			if .Sum_Recargomontoenpesos != lnSum_Recargomontoenpesos
				.Sum_Recargomontoenpesos = lnSum_Recargomontoenpesos
				.EventoCambioSum_Recargomontoenpesos()
			endif
			if .Sum_Recargomontosinimpuestos != lnSum_Recargomontosinimpuestos
				.Sum_Recargomontosinimpuestos = lnSum_Recargomontosinimpuestos
				.EventoCambioSum_Recargomontosinimpuestos()
			endif
			if .Sum_Recargosinpercepciones != lnSum_Recargosinpercepciones
				.Sum_Recargosinpercepciones = lnSum_Recargosinpercepciones
				.EventoCambioSum_Recargosinpercepciones()
			endif
			if .Sum_Recibido != lnSum_Recibido
				.Sum_Recibido = lnSum_Recibido
				.EventoCambioSum_Recibido()
			endif
			if .Sum_Recibidoalcambio != lnSum_Recibidoalcambio
				.Sum_Recibidoalcambio = lnSum_Recibidoalcambio
				.EventoCambioSum_Recibidoalcambio()
			endif
			if .Sum_Total != lnSum_Total
				.Sum_Total = lnSum_Total
				.EventoCambioSum_Total()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Acumular( tlForzar as Boolean, tcAtributo as String, tnValor as Decimal, tnValorAnt as Decimal ) as Void
		local lnItem as integer, loItem as Object, lnSum_Aplicableparavuelto as Number, lnSum_Descuentomonto as Number, lnSum_Descuentomontoenpesos as Number, lnSum_Descuentomontosinimpuestos as Number, lnSum_Montoalcambio as Number, lnSum_Montodesrec as Number, lnSum_Montodesrecpesos as Number, lnSum_Pesosalcambio as Number, lnSum_Recargomonto as Number, lnSum_Recargomontoenpesos as Number, lnSum_Recargomontosinimpuestos as Number, lnSum_Recargosinpercepciones as Number, lnSum_Recibido as Number, lnSum_Recibidoalcambio as Number, lnSum_Total as Number

		do case
		case tnValor = tnValorAnt
		case tcAtributo == 'Aplicableparavuelto'
			this.Sum_Aplicableparavuelto = this.Sum_Aplicableparavuelto - tnValorAnt + tnValor
			this.EventoCambioSum_Aplicableparavuelto()
		case tcAtributo == 'Descuentomonto'
			this.Sum_Descuentomonto = this.Sum_Descuentomonto - tnValorAnt + tnValor
			this.EventoCambioSum_Descuentomonto()
		case tcAtributo == 'Descuentomontoenpesos'
			this.Sum_Descuentomontoenpesos = this.Sum_Descuentomontoenpesos - tnValorAnt + tnValor
			this.EventoCambioSum_Descuentomontoenpesos()
		case tcAtributo == 'Descuentomontosinimpuestos'
			this.Sum_Descuentomontosinimpuestos = this.Sum_Descuentomontosinimpuestos - tnValorAnt + tnValor
			this.EventoCambioSum_Descuentomontosinimpuestos()
		case tcAtributo == 'Montoalcambio'
			this.Sum_Montoalcambio = this.Sum_Montoalcambio - tnValorAnt + tnValor
			this.EventoCambioSum_Montoalcambio()
		case tcAtributo == 'Montodesrec'
			this.Sum_Montodesrec = this.Sum_Montodesrec - tnValorAnt + tnValor
			this.EventoCambioSum_Montodesrec()
		case tcAtributo == 'Montodesrecpesos'
			this.Sum_Montodesrecpesos = this.Sum_Montodesrecpesos - tnValorAnt + tnValor
			this.EventoCambioSum_Montodesrecpesos()
		case tcAtributo == 'Pesosalcambio'
			this.Sum_Pesosalcambio = this.Sum_Pesosalcambio - tnValorAnt + tnValor
			this.EventoCambioSum_Pesosalcambio()
		case tcAtributo == 'Recargomonto'
			this.Sum_Recargomonto = this.Sum_Recargomonto - tnValorAnt + tnValor
			this.EventoCambioSum_Recargomonto()
		case tcAtributo == 'Recargomontoenpesos'
			this.Sum_Recargomontoenpesos = this.Sum_Recargomontoenpesos - tnValorAnt + tnValor
			this.EventoCambioSum_Recargomontoenpesos()
		case tcAtributo == 'Recargomontosinimpuestos'
			this.Sum_Recargomontosinimpuestos = this.Sum_Recargomontosinimpuestos - tnValorAnt + tnValor
			this.EventoCambioSum_Recargomontosinimpuestos()
		case tcAtributo == 'Recargosinpercepciones'
			this.Sum_Recargosinpercepciones = this.Sum_Recargosinpercepciones - tnValorAnt + tnValor
			this.EventoCambioSum_Recargosinpercepciones()
		case tcAtributo == 'Recibido'
			this.Sum_Recibido = this.Sum_Recibido - tnValorAnt + tnValor
			this.EventoCambioSum_Recibido()
		case tcAtributo == 'Recibidoalcambio'
			this.Sum_Recibidoalcambio = this.Sum_Recibidoalcambio - tnValorAnt + tnValor
			this.EventoCambioSum_Recibidoalcambio()
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
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemFACTURADEEXPORTACIONValoresdetalle' )
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
			loItem.Redondeo = c_Valoresdetalle.Redondeo
			loItem.IdItemValores = c_Valoresdetalle.IdItemValores
			loItem.AutorizacionPOS = c_Valoresdetalle.AutorizacionPOS
			loItem.DescuentoPorcentaje = c_Valoresdetalle.DescuentoPorcentaje
			loItem.DescuentoMonto = c_Valoresdetalle.DescuentoMonto
			loItem.DescuentoMontoEnPesos = c_Valoresdetalle.DescuentoMontoEnPesos
			loItem.RecargoMontoEnPesos = c_Valoresdetalle.RecargoMontoEnPesos
			loItem.DescuentoMontoSinImpuestos = c_Valoresdetalle.DescuentoMontoSinImpuestos
			loItem.CondicionDePago_PK = c_Valoresdetalle.CondicionDePago
			loItem.MontoDesRecPesos = c_Valoresdetalle.MontoDesRecPesos
			loItem.EsVuelto = c_Valoresdetalle.EsVuelto
			loItem.VisualizarEnEstadoDeCaja = c_Valoresdetalle.VisualizarEnEstadoDeCaja
			loItem.ChequeElectronico = c_Valoresdetalle.ChequeElectronico
			loItem.IdItemRetiroEnEfectivo = c_Valoresdetalle.IdItemRetiroEnEfectivo
			loItem.EsRetiroEfectivo = c_Valoresdetalle.EsRetiroEfectivo
			loItem.ValorDetalle = c_Valoresdetalle.ValorDetalle
			loItem.Fecha = goLibrerias.ObtenerFechaFormateada( c_Valoresdetalle.Fecha )
			loItem.NumeroInterno = c_Valoresdetalle.NumeroInterno
			loItem.Monto = c_Valoresdetalle.Monto
			loItem.RecargoPorcentaje = c_Valoresdetalle.RecargoPorcentaje
			loItem.PorcentajeDesRec = c_Valoresdetalle.PorcentajeDesRec
			loItem.RecargoMonto = c_Valoresdetalle.RecargoMonto
			loItem.MontoDesRec = c_Valoresdetalle.MontoDesRec
			loItem.Total = c_Valoresdetalle.Total
			loItem.Recibido = c_Valoresdetalle.Recibido
			loItem.RecargoMontoSinImpuestos = c_Valoresdetalle.RecargoMontoSinImpuestos
			loItem.RecibidoAlCambio = c_Valoresdetalle.RecibidoAlCambio
			loItem.MontoAMonedaSistema = c_Valoresdetalle.MontoAMonedaSistema
			loItem.MontoCupon = c_Valoresdetalle.MontoCupon
			loItem.RecargoSinPercepciones = c_Valoresdetalle.RecargoSinPercepciones
			loItem.NumeroValeDeCambio_PK = c_Valoresdetalle.NumeroValeDeCambio
			loItem.PermiteVuelto = c_Valoresdetalle.PermiteVuelto
			loItem.CodigoDeCupon = c_Valoresdetalle.CodigoDeCupon
			loItem.Cupon_PK = c_Valoresdetalle.Cupon
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
				if lnLargoEntero <= 11
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo COTIZA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:11), en el detalle ' + this.cEtiqueta + '.' )
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
				if lnLargoEntero <= 7
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo PESOSALCAMBIO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:7), en el detalle ' + this.cEtiqueta + '.' )
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
				if lnLargoEntero <= 11
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo ULTIMACOTIZACION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:11), en el detalle ' + this.cEtiqueta + '.' )
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
			
			if vartype( this.Item[lni].REDONDEO) = 'C'
				if len( alltrim( this.Item[lni].REDONDEO )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo REDONDEO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].REDONDEO ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo REDONDEO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].IDITEMVALORES) = 'C'
				if len( alltrim( this.Item[lni].IDITEMVALORES )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo IDITEMVALORES del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].IDITEMVALORES ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo IDITEMVALORES del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].AUTORIZACIONPOS) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo AUTORIZACIONPOS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].DESCUENTOPORCENTAJE) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].DESCUENTOPORCENTAJE ) ) ) 
				lnValorDelDecimal = this.Item[lni].DESCUENTOPORCENTAJE - int( this.Item[lni].DESCUENTOPORCENTAJE )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 4
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo DESCUENTOPORCENTAJE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:4), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo DESCUENTOPORCENTAJE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].DESCUENTOMONTO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].DESCUENTOMONTO ) ) ) 
				lnValorDelDecimal = this.Item[lni].DESCUENTOMONTO - int( this.Item[lni].DESCUENTOMONTO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo DESCUENTOMONTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo DESCUENTOMONTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].DESCUENTOMONTOENPESOS) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].DESCUENTOMONTOENPESOS ) ) ) 
				lnValorDelDecimal = this.Item[lni].DESCUENTOMONTOENPESOS - int( this.Item[lni].DESCUENTOMONTOENPESOS )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo DESCUENTOMONTOENPESOS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo DESCUENTOMONTOENPESOS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].RECARGOMONTOENPESOS) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].RECARGOMONTOENPESOS ) ) ) 
				lnValorDelDecimal = this.Item[lni].RECARGOMONTOENPESOS - int( this.Item[lni].RECARGOMONTOENPESOS )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo RECARGOMONTOENPESOS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo RECARGOMONTOENPESOS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].DESCUENTOMONTOSINIMPUESTOS) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].DESCUENTOMONTOSINIMPUESTOS ) ) ) 
				lnValorDelDecimal = this.Item[lni].DESCUENTOMONTOSINIMPUESTOS - int( this.Item[lni].DESCUENTOMONTOSINIMPUESTOS )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo DESCUENTOMONTOSINIMPUESTOS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo DESCUENTOMONTOSINIMPUESTOS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].MONTODESRECPESOS) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTODESRECPESOS ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTODESRECPESOS - int( this.Item[lni].MONTODESRECPESOS )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTODESRECPESOS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTODESRECPESOS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ESVUELTO) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ESVUELTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].IDITEMRETIROENEFECTIVO) = 'C'
				if len( alltrim( this.Item[lni].IDITEMRETIROENEFECTIVO )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo IDITEMRETIROENEFECTIVO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].IDITEMRETIROENEFECTIVO ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo IDITEMRETIROENEFECTIVO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ESRETIROEFECTIVO) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ESRETIROEFECTIVO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].PORCENTAJEDESREC) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].PORCENTAJEDESREC ) ) ) 
				lnValorDelDecimal = this.Item[lni].PORCENTAJEDESREC - int( this.Item[lni].PORCENTAJEDESREC )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 4
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo PORCENTAJEDESREC del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:4), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PORCENTAJEDESREC del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].MONTODESREC) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTODESREC ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTODESREC - int( this.Item[lni].MONTODESREC )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 6
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTODESREC del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:6), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTODESREC del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TOTAL) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].TOTAL ) ) ) 
				lnValorDelDecimal = this.Item[lni].TOTAL - int( this.Item[lni].TOTAL )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 14
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo TOTAL del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:14), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TOTAL del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].RECIBIDO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].RECIBIDO ) ) ) 
				lnValorDelDecimal = this.Item[lni].RECIBIDO - int( this.Item[lni].RECIBIDO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo RECIBIDO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo RECIBIDO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].RECARGOMONTOSINIMPUESTOS) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].RECARGOMONTOSINIMPUESTOS ) ) ) 
				lnValorDelDecimal = this.Item[lni].RECARGOMONTOSINIMPUESTOS - int( this.Item[lni].RECARGOMONTOSINIMPUESTOS )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 6
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo RECARGOMONTOSINIMPUESTOS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:6), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo RECARGOMONTOSINIMPUESTOS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].RECIBIDOALCAMBIO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].RECIBIDOALCAMBIO ) ) ) 
				lnValorDelDecimal = this.Item[lni].RECIBIDOALCAMBIO - int( this.Item[lni].RECIBIDOALCAMBIO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo RECIBIDOALCAMBIO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo RECIBIDOALCAMBIO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].RECARGOSINPERCEPCIONES) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].RECARGOSINPERCEPCIONES ) ) ) 
				lnValorDelDecimal = this.Item[lni].RECARGOSINPERCEPCIONES - int( this.Item[lni].RECARGOSINPERCEPCIONES )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 6
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo RECARGOSINPERCEPCIONES del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:6), en el detalle ' + this.cEtiqueta + '.' )
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
		toItemDestino.Redondeo = toItemOrigen.Redondeo
		toItemDestino.Iditemvalores = toItemOrigen.Iditemvalores
		toItemDestino.Autorizacionpos = toItemOrigen.Autorizacionpos
		toItemDestino.Cuotas = toItemOrigen.Cuotas
		toItemDestino.Descuentoporcentaje = toItemOrigen.Descuentoporcentaje
		toItemDestino.Descuentomonto = toItemOrigen.Descuentomonto
		toItemDestino.Descuentomontoenpesos = toItemOrigen.Descuentomontoenpesos
		toItemDestino.Recargomontoenpesos = toItemOrigen.Recargomontoenpesos
		toItemDestino.Descuentomontosinimpuestos = toItemOrigen.Descuentomontosinimpuestos
		toItemDestino.Condiciondepago_PK = toItemOrigen.Condiciondepago_PK
		toItemDestino.Montodesrecpesos = toItemOrigen.Montodesrecpesos
		toItemDestino.Esvuelto = toItemOrigen.Esvuelto
		toItemDestino.Canttipovaloresacumulados = toItemOrigen.Canttipovaloresacumulados
		toItemDestino.Ncoeficienteimpuestos = toItemOrigen.Ncoeficienteimpuestos
		toItemDestino.Ndiferenciaredondeo = toItemOrigen.Ndiferenciaredondeo
		toItemDestino.Diferenciaporredondeodelrecibido = toItemOrigen.Diferenciaporredondeodelrecibido
		toItemDestino.Porcentajediferenciaredondeorecibido = toItemOrigen.Porcentajediferenciaredondeorecibido
		toItemDestino.Esanulacion = toItemOrigen.Esanulacion
		toItemDestino.Visualizarenestadodecaja = toItemOrigen.Visualizarenestadodecaja
		toItemDestino.Chequeelectronico = toItemOrigen.Chequeelectronico
		toItemDestino.Iditemretiroenefectivo = toItemOrigen.Iditemretiroenefectivo
		toItemDestino.Esretiroefectivo = toItemOrigen.Esretiroefectivo
		toItemDestino.Valordetalle = toItemOrigen.Valordetalle
		toItemDestino.Fecha = toItemOrigen.Fecha
		toItemDestino.Numerointerno = toItemOrigen.Numerointerno
		toItemDestino.Monto = toItemOrigen.Monto
		toItemDestino.Montoori = toItemOrigen.Montoori
		toItemDestino.Montoalcambio = toItemOrigen.Montoalcambio
		toItemDestino.Escuponhuerfano = toItemOrigen.Escuponhuerfano
		toItemDestino.Aplicableparavuelto = toItemOrigen.Aplicableparavuelto
		toItemDestino.Recargoporcentaje = toItemOrigen.Recargoporcentaje
		toItemDestino.Porcentajedesrec = toItemOrigen.Porcentajedesrec
		toItemDestino.Recargomonto = toItemOrigen.Recargomonto
		toItemDestino.Montodesrec = toItemOrigen.Montodesrec
		toItemDestino.Total = toItemOrigen.Total
		toItemDestino.Recibidosugerido = toItemOrigen.Recibidosugerido
		toItemDestino.Recibido = toItemOrigen.Recibido
		toItemDestino.Recargomontosinimpuestos = toItemOrigen.Recargomontosinimpuestos
		toItemDestino.Recibidoalcambio = toItemOrigen.Recibidoalcambio
		toItemDestino.Montoamonedasistema = toItemOrigen.Montoamonedasistema
		toItemDestino.Montocupon = toItemOrigen.Montocupon
		toItemDestino.Recargosinpercepciones = toItemOrigen.Recargosinpercepciones
		toItemDestino.Numerovaledecambio_PK = toItemOrigen.Numerovaledecambio_PK
		toItemDestino.Permitevuelto = toItemOrigen.Permitevuelto
		toItemDestino.Codigodecupon = toItemOrigen.Codigodecupon
		toItemDestino.Cupon_PK = toItemOrigen.Cupon_PK
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
		lcRetorno = '!EsVuelto'
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
	Redondeo = []
	Iditemvalores = []
	Autorizacionpos = .F.
	Cuotas = 0
	Descuentoporcentaje = 0
	Descuentomonto = 0
	Descuentomontoenpesos = 0
	Recargomontoenpesos = 0
	Descuentomontosinimpuestos = 0
	Condiciondepago_PK = []
	Montodesrecpesos = 0
	Esvuelto = .F.
	Canttipovaloresacumulados = 0
	Ncoeficienteimpuestos = 0
	Ndiferenciaredondeo = 0
	Diferenciaporredondeodelrecibido = 0
	Porcentajediferenciaredondeorecibido = 0
	Esanulacion = .F.
	Visualizarenestadodecaja = .F.
	Chequeelectronico = .F.
	Iditemretiroenefectivo = []
	Esretiroefectivo = .F.
	Valordetalle = []
	Fecha = ctod( '  /  /    ' )
	Numerointerno = []
	Monto = 0
	Montoori = 0
	Montoalcambio = 0
	Escuponhuerfano = .F.
	Aplicableparavuelto = 0
	Recargoporcentaje = 0
	Porcentajedesrec = 0
	Recargomonto = 0
	Montodesrec = 0
	Total = 0
	Recibidosugerido = 0
	Recibido = 0
	Recargomontosinimpuestos = 0
	Recibidoalcambio = 0
	Montoamonedasistema = 0
	Montocupon = 0
	Recargosinpercepciones = 0
	Numerovaledecambio_PK = []
	Permitevuelto = .F.
	Codigodecupon = []
	Cupon_PK = []
	Iditemcomponente = []
	NroItem = 0
	lTieneImporteEnRecibido = .t.

enddefine