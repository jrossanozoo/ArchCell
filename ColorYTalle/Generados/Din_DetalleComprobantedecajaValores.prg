
define class Din_DetalleCOMPROBANTEDECAJAValores as DetalleValoresfondos of DetalleValoresfondos.Prg

	Sum_Recargomonto = 0

	nCantidadItems = 999
	cNombre = 'Valores'
	cEtiqueta = 'Detalle de valores'
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
				.Tipo = this.Item[ tnItem ].Tipo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Tipo', .Tipo )
			
				.FechaComp = this.Item[ tnItem ].FechaComp
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'FechaComp', .FechaComp )
			
				.Total = this.Item[ tnItem ].Total
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Total', .Total )
			
				.RecargoMonto = this.Item[ tnItem ].RecargoMonto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RecargoMonto', .RecargoMonto )
			
				.RecargoPorcentaje = this.Item[ tnItem ].RecargoPorcentaje
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RecargoPorcentaje', .RecargoPorcentaje )
			
				.RecargoMontoSinImpuestos = this.Item[ tnItem ].RecargoMontoSinImpuestos
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RecargoMontoSinImpuestos', .RecargoMontoSinImpuestos )
			
				.RecargoSinPercepciones = this.Item[ tnItem ].RecargoSinPercepciones
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RecargoSinPercepciones', .RecargoSinPercepciones )
			
				.Caja_PK = this.Item[ tnItem ].Caja_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Caja_PK', .Caja_PK )
			
				.CajaValor = this.Item[ tnItem ].CajaValor
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CajaValor', .CajaValor )
			
				.NumeroCheque_PK = this.Item[ tnItem ].NumeroCheque_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumeroCheque_PK', .NumeroCheque_PK )
			
				.NumeroChequePropio_PK = this.Item[ tnItem ].NumeroChequePropio_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumeroChequePropio_PK', .NumeroChequePropio_PK )
			
				.ChequeElectronico = this.Item[ tnItem ].ChequeElectronico
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ChequeElectronico', .ChequeElectronico )
			
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.Numero = this.Item[ tnItem ].Numero
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Numero', .Numero )
			
				.Valor_PK = this.Item[ tnItem ].Valor_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Valor_PK', .Valor_PK )
			
				.ValorDetalle = this.Item[ tnItem ].ValorDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ValorDetalle', .ValorDetalle )
			
				.Fecha = this.Item[ tnItem ].Fecha
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Fecha', .Fecha )
			
				.NumeroInterno = this.Item[ tnItem ].NumeroInterno
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumeroInterno', .NumeroInterno )
			
				.Monto = this.Item[ tnItem ].Monto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Monto', .Monto )
			
				.Cotiza = this.Item[ tnItem ].Cotiza
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Cotiza', .Cotiza )
			
				.MontoAMonedaSistema = this.Item[ tnItem ].MontoAMonedaSistema
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoAMonedaSistema', .MontoAMonedaSistema )
			
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
			.Tipo = this.oItem.Tipo
			.FechaComp = this.oItem.FechaComp
			.Total = this.oItem.Total
			.RecargoMonto = this.oItem.RecargoMonto
			.RecargoPorcentaje = this.oItem.RecargoPorcentaje
			.RecargoMontoSinImpuestos = this.oItem.RecargoMontoSinImpuestos
			.RecargoSinPercepciones = this.oItem.RecargoSinPercepciones
			.Caja_PK = this.oItem.Caja_PK
			.CajaValor = this.oItem.CajaValor
			.NumeroCheque_PK = this.oItem.NumeroCheque_PK
			.NumeroChequePropio_PK = this.oItem.NumeroChequePropio_PK
			.ChequeElectronico = this.oItem.ChequeElectronico
			.NROITEM = this.oItem.NROITEM
			.Numero = this.oItem.Numero
			.Valor_PK = this.oItem.Valor_PK
			.ValorDetalle = this.oItem.ValorDetalle
			.Fecha = this.oItem.Fecha
			.NumeroInterno = this.oItem.NumeroInterno
			.Monto = this.oItem.Monto
			.Cotiza = this.oItem.Cotiza
			.MontoAMonedaSistema = this.oItem.MontoAMonedaSistema
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
			.Item[ lnItem ].Tipo = .oItem.Tipo
			.Item[ lnItem ].FechaComp = .oItem.FechaComp
			.Item[ lnItem ].Total = .oItem.Total
			.Item[ lnItem ].RecargoMonto = .oItem.RecargoMonto
			.Item[ lnItem ].RecargoPorcentaje = .oItem.RecargoPorcentaje
			.Item[ lnItem ].RecargoMontoSinImpuestos = .oItem.RecargoMontoSinImpuestos
			.Item[ lnItem ].RecargoSinPercepciones = .oItem.RecargoSinPercepciones
			.Item[ lnItem ].Caja_PK = .oItem.Caja_PK
			.Item[ lnItem ].CajaValor = .oItem.CajaValor
			.Item[ lnItem ].NumeroCheque_PK = .oItem.NumeroCheque_PK
			.Item[ lnItem ].NumeroChequePropio_PK = .oItem.NumeroChequePropio_PK
			.Item[ lnItem ].ChequeElectronico = .oItem.ChequeElectronico
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].Numero = .oItem.Numero
			.Item[ lnItem ].Valor_PK = .oItem.Valor_PK
			.Item[ lnItem ].ValorDetalle = .oItem.ValorDetalle
			.Item[ lnItem ].Fecha = .oItem.Fecha
			.Item[ lnItem ].NumeroInterno = .oItem.NumeroInterno
			.Item[ lnItem ].Monto = .oItem.Monto
			.Item[ lnItem ].Cotiza = .oItem.Cotiza
			.Item[ lnItem ].MontoAMonedaSistema = .oItem.MontoAMonedaSistema
			.Item[ lnItem ].IdItemComponente = .oItem.IdItemComponente
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Sumarizar() as boolean
		local lnItem as integer, loItem as Object, lnSum_Recargomonto as Number

		with this
			lnSum_Recargomonto = 0
			if this.lEsNavegacion
				if select( 'c_Valores' ) > 0 and reccount( 'c_Valores' ) > 0
				endif
				this.lEsNavegacion = .f.
			else
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							if !empty(.VALOR_PK)
								lnSum_Recargomonto = lnSum_Recargomonto + .Recargomonto
							endif
						endwith
					endif
				endfor

				if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
					loItem = .oItem
					with loItem 
						lnSum_Recargomonto = lnSum_Recargomonto + .Recargomonto
					endwith
				endif
			endif

			if .Sum_Recargomonto != lnSum_Recargomonto
				.Sum_Recargomonto = lnSum_Recargomonto
				.EventoCambioSum_Recargomonto()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Recargomonto() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalizar( toItem as Object ) as Void
		local lnItem as integer, loItem as Object, lnSum_Recargomonto as Number

		with this
			lnSum_Recargomonto = 0
			if !this.lEsNavegacion
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							if !empty(.VALOR_PK)
								lnSum_Recargomonto = lnSum_Recargomonto + .Recargomonto
							endif
						endwith
					endif
				endfor

			endif
			if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
				loItem = .oItem
				with loItem 
					if !empty(.VALOR_PK)
						lnSum_Recargomonto = lnSum_Recargomonto + .Recargomonto
					endif
				endwith
			endif

			if .Sum_Recargomonto != lnSum_Recargomonto
				.Sum_Recargomonto = lnSum_Recargomonto
				.EventoCambioSum_Recargomonto()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Acumular( tlForzar as Boolean, tcAtributo as String, tnValor as Decimal, tnValorAnt as Decimal ) as Void
		local lnItem as integer, loItem as Object, lnSum_Recargomonto as Number

		do case
		case tnValor = tnValorAnt
		case tcAtributo == 'Recargomonto'
			this.Sum_Recargomonto = this.Sum_Recargomonto - tnValorAnt + tnValor
			this.EventoCambioSum_Recargomonto()

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
			this.oItem = _Screen.zoo.crearobjeto( 'ItemCOMPROBANTEDECAJAValores' )
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

		select c_Valores
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Tipo = c_Valores.Tipo
			loItem.FechaComp = goLibrerias.ObtenerFechaFormateada( c_Valores.FechaComp )
			loItem.Total = c_Valores.Total
			loItem.Caja_PK = c_Valores.Caja
			loItem.CajaValor = c_Valores.CajaValor
			loItem.NumeroCheque_PK = c_Valores.NumeroCheque
			loItem.NumeroChequePropio_PK = c_Valores.NumeroChequePropio
			loItem.ChequeElectronico = c_Valores.ChequeElectronico
			loItem.NROITEM = c_Valores.NROITEM
			loItem.Numero = c_Valores.Numero
			loItem.Valor_PK = c_Valores.Valor
			loItem.ValorDetalle = c_Valores.ValorDetalle
			loItem.Fecha = goLibrerias.ObtenerFechaFormateada( c_Valores.Fecha )
			loItem.NumeroInterno = c_Valores.NumeroInterno
			loItem.Monto = c_Valores.Monto
			loItem.Cotiza = c_Valores.Cotiza
			loItem.MontoAMonedaSistema = c_Valores.MontoAMonedaSistema
			loItem.IdItemComponente = c_Valores.IdItemComponente
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
			
			if inlist(vartype( this.Item[lni].FECHACOMP),'D','T')
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo FECHACOMP del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].CAJAVALOR) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].CAJAVALOR ) ) ) 
				lnValorDelDecimal = this.Item[lni].CAJAVALOR - int( this.Item[lni].CAJAVALOR )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo CAJAVALOR del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CAJAVALOR del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].NUMERO) = 'C'
				if len( alltrim( this.Item[lni].NUMERO )) <= 20
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo NUMERO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].NUMERO ))) + ' Máxima:20), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NUMERO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Tipo = toItemOrigen.Tipo
		toItemDestino.Fechacomp = toItemOrigen.Fechacomp
		toItemDestino.Total = toItemOrigen.Total
		toItemDestino.Recargomonto = toItemOrigen.Recargomonto
		toItemDestino.Recargoporcentaje = toItemOrigen.Recargoporcentaje
		toItemDestino.Recargomontosinimpuestos = toItemOrigen.Recargomontosinimpuestos
		toItemDestino.Recargosinpercepciones = toItemOrigen.Recargosinpercepciones
		toItemDestino.Caja_PK = toItemOrigen.Caja_PK
		toItemDestino.Cajavalor = toItemOrigen.Cajavalor
		toItemDestino.Numerocheque_PK = toItemOrigen.Numerocheque_PK
		toItemDestino.Numerochequepropio_PK = toItemOrigen.Numerochequepropio_PK
		toItemDestino.Chequeelectronico = toItemOrigen.Chequeelectronico
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Numero = toItemOrigen.Numero
		toItemDestino.Valor_PK = toItemOrigen.Valor_PK
		toItemDestino.Valordetalle = toItemOrigen.Valordetalle
		toItemDestino.Fecha = toItemOrigen.Fecha
		toItemDestino.Numerointerno = toItemOrigen.Numerointerno
		toItemDestino.Monto = toItemOrigen.Monto
		toItemDestino.Cotiza = toItemOrigen.Cotiza
		toItemDestino.Montoamonedasistema = toItemOrigen.Montoamonedasistema
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

	Tipo = 0
	Fechacomp = ctod( '  /  /    ' )
	Total = 0
	Recargomonto = 0
	Recargoporcentaje = 0
	Recargomontosinimpuestos = 0
	Recargosinpercepciones = 0
	Caja_PK = 0
	Cajavalor = 0
	Numerocheque_PK = []
	Numerochequepropio_PK = []
	Chequeelectronico = .F.
	Nroitem = 0
	Numero = []
	Valor_PK = []
	Valordetalle = []
	Fecha = ctod( '  /  /    ' )
	Numerointerno = []
	Monto = 0
	Cotiza = 0
	Montoamonedasistema = 0
	Iditemcomponente = []
	NroItem = 0
	lTieneImporteEnRecibido = .f.

enddefine