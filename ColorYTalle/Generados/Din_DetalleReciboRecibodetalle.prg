
define class Din_DetalleRECIBORecibodetalle as detalle of detalle.prg

	Sum_Cuentaparaimpresion = 0
	Sum_Monto = 0
	Sum_Recargosinpercepciones = 0
	Sum_Saldoaux = 0

	nCantidadItems = 999
	cNombre = 'Recibodetalle'
	cEtiqueta = 'Recibodetalle'
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
				.Vencimiento = this.Item[ tnItem ].Vencimiento
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Vencimiento', .Vencimiento )
			
				.Codigo = this.Item[ tnItem ].Codigo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Codigo', .Codigo )
			
				.Letra = this.Item[ tnItem ].Letra
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Letra', .Letra )
			
				.PuntoDeVenta = this.Item[ tnItem ].PuntoDeVenta
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PuntoDeVenta', .PuntoDeVenta )
			
				.NumeroDeComprobante = this.Item[ tnItem ].NumeroDeComprobante
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumeroDeComprobante', .NumeroDeComprobante )
			
				.TipoDeComprobante = this.Item[ tnItem ].TipoDeComprobante
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TipoDeComprobante', .TipoDeComprobante )
			
				.Valor_PK = this.Item[ tnItem ].Valor_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Valor_PK', .Valor_PK )
			
				.Tipo = this.Item[ tnItem ].Tipo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Tipo', .Tipo )
			
				.EsPagoACuenta = this.Item[ tnItem ].EsPagoACuenta
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'EsPagoACuenta', .EsPagoACuenta )
			
				.CodigoComprobante = this.Item[ tnItem ].CodigoComprobante
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodigoComprobante', .CodigoComprobante )
			
				.RecargoSinPercepciones = this.Item[ tnItem ].RecargoSinPercepciones
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RecargoSinPercepciones', .RecargoSinPercepciones )
			
				.Caja_PK = this.Item[ tnItem ].Caja_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Caja_PK', .Caja_PK )
			
				.Secuencia = this.Item[ tnItem ].Secuencia
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Secuencia', .Secuencia )
			
				.Cliente = this.Item[ tnItem ].Cliente
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Cliente', .Cliente )
			
				.BaseDeDatosAltaFW = this.Item[ tnItem ].BaseDeDatosAltaFW
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'BaseDeDatosAltaFW', .BaseDeDatosAltaFW )
			
				.CuentaParaImpresion = this.Item[ tnItem ].CuentaParaImpresion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CuentaParaImpresion', .CuentaParaImpresion )
			
				.CAE = this.Item[ tnItem ].CAE
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CAE', .CAE )
			
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.Fecha = this.Item[ tnItem ].Fecha
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Fecha', .Fecha )
			
				.Descripcion = this.Item[ tnItem ].Descripcion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Descripcion', .Descripcion )
			
				.Anotacion = this.Item[ tnItem ].Anotacion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Anotacion', .Anotacion )
			
				.SaldoAux = this.Item[ tnItem ].SaldoAux
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'SaldoAux', .SaldoAux )
			
				.Monto = this.Item[ tnItem ].Monto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Monto', .Monto )
			
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
			.Vencimiento = this.oItem.Vencimiento
			.Codigo = this.oItem.Codigo
			.Letra = this.oItem.Letra
			.PuntoDeVenta = this.oItem.PuntoDeVenta
			.NumeroDeComprobante = this.oItem.NumeroDeComprobante
			.TipoDeComprobante = this.oItem.TipoDeComprobante
			.Valor_PK = this.oItem.Valor_PK
			.Tipo = this.oItem.Tipo
			.EsPagoACuenta = this.oItem.EsPagoACuenta
			.CodigoComprobante = this.oItem.CodigoComprobante
			.RecargoSinPercepciones = this.oItem.RecargoSinPercepciones
			.Caja_PK = this.oItem.Caja_PK
			.Secuencia = this.oItem.Secuencia
			.Cliente = this.oItem.Cliente
			.BaseDeDatosAltaFW = this.oItem.BaseDeDatosAltaFW
			.CuentaParaImpresion = this.oItem.CuentaParaImpresion
			.CAE = this.oItem.CAE
			.NROITEM = this.oItem.NROITEM
			.Fecha = this.oItem.Fecha
			.Descripcion = this.oItem.Descripcion
			.Anotacion = this.oItem.Anotacion
			.SaldoAux = this.oItem.SaldoAux
			.Monto = this.oItem.Monto
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
			.Item[ lnItem ].Vencimiento = .oItem.Vencimiento
			.Item[ lnItem ].Codigo = .oItem.Codigo
			.Item[ lnItem ].Letra = .oItem.Letra
			.Item[ lnItem ].PuntoDeVenta = .oItem.PuntoDeVenta
			.Item[ lnItem ].NumeroDeComprobante = .oItem.NumeroDeComprobante
			.Item[ lnItem ].TipoDeComprobante = .oItem.TipoDeComprobante
			.Item[ lnItem ].Valor_PK = .oItem.Valor_PK
			.Item[ lnItem ].Tipo = .oItem.Tipo
			.Item[ lnItem ].EsPagoACuenta = .oItem.EsPagoACuenta
			.Item[ lnItem ].CodigoComprobante = .oItem.CodigoComprobante
			.Item[ lnItem ].RecargoSinPercepciones = .oItem.RecargoSinPercepciones
			.Item[ lnItem ].Caja_PK = .oItem.Caja_PK
			.Item[ lnItem ].Secuencia = .oItem.Secuencia
			.Item[ lnItem ].Cliente = .oItem.Cliente
			.Item[ lnItem ].BaseDeDatosAltaFW = .oItem.BaseDeDatosAltaFW
			.Item[ lnItem ].CuentaParaImpresion = .oItem.CuentaParaImpresion
			.Item[ lnItem ].CAE = .oItem.CAE
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].Fecha = .oItem.Fecha
			.Item[ lnItem ].Descripcion = .oItem.Descripcion
			.Item[ lnItem ].Anotacion = .oItem.Anotacion
			.Item[ lnItem ].SaldoAux = .oItem.SaldoAux
			.Item[ lnItem ].Monto = .oItem.Monto
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Sumarizar() as boolean
		local lnItem as integer, loItem as Object, lnSum_Cuentaparaimpresion as Number, lnSum_Monto as Number, lnSum_Recargosinpercepciones as Number, lnSum_Saldoaux as Number

		with this
			lnSum_Cuentaparaimpresion = 0
			lnSum_Monto = 0
			lnSum_Recargosinpercepciones = 0
			lnSum_Saldoaux = 0
			if this.lEsNavegacion
				if select( 'c_Recibodetalle' ) > 0 and reccount( 'c_Recibodetalle' ) > 0
					sum Monto, Saldoaux;
						 to ;
						 lnSum_Monto, lnSum_Saldoaux
				endif
				this.lEsNavegacion = .f.
			else
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							lnSum_Cuentaparaimpresion = lnSum_Cuentaparaimpresion + .Cuentaparaimpresion
							lnSum_Monto = lnSum_Monto + .Monto
							lnSum_Recargosinpercepciones = lnSum_Recargosinpercepciones + .Recargosinpercepciones
							lnSum_Saldoaux = lnSum_Saldoaux + .Saldoaux
						endwith
					endif
				endfor

				if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
					loItem = .oItem
					with loItem 
						lnSum_Cuentaparaimpresion = lnSum_Cuentaparaimpresion + .Cuentaparaimpresion
						lnSum_Monto = lnSum_Monto + .Monto
						lnSum_Recargosinpercepciones = lnSum_Recargosinpercepciones + .Recargosinpercepciones
						lnSum_Saldoaux = lnSum_Saldoaux + .Saldoaux
					endwith
				endif
			endif

			if .Sum_Cuentaparaimpresion != lnSum_Cuentaparaimpresion
				.Sum_Cuentaparaimpresion = lnSum_Cuentaparaimpresion
				.EventoCambioSum_Cuentaparaimpresion()
			endif
			if .Sum_Monto != lnSum_Monto
				.Sum_Monto = lnSum_Monto
				.EventoCambioSum_Monto()
			endif
			if .Sum_Recargosinpercepciones != lnSum_Recargosinpercepciones
				.Sum_Recargosinpercepciones = lnSum_Recargosinpercepciones
				.EventoCambioSum_Recargosinpercepciones()
			endif
			if .Sum_Saldoaux != lnSum_Saldoaux
				.Sum_Saldoaux = lnSum_Saldoaux
				.EventoCambioSum_Saldoaux()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Cuentaparaimpresion() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Monto() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Recargosinpercepciones() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Saldoaux() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalizar( toItem as Object ) as Void
		local lnItem as integer, loItem as Object, lnSum_Cuentaparaimpresion as Number, lnSum_Monto as Number, lnSum_Recargosinpercepciones as Number, lnSum_Saldoaux as Number

		with this
			lnSum_Cuentaparaimpresion = 0
			lnSum_Monto = 0
			lnSum_Recargosinpercepciones = 0
			lnSum_Saldoaux = 0
			if !this.lEsNavegacion
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							lnSum_Cuentaparaimpresion = lnSum_Cuentaparaimpresion + .Cuentaparaimpresion
							lnSum_Monto = lnSum_Monto + .Monto
							lnSum_Recargosinpercepciones = lnSum_Recargosinpercepciones + .Recargosinpercepciones
							lnSum_Saldoaux = lnSum_Saldoaux + .Saldoaux
						endwith
					endif
				endfor

			endif
			if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
				loItem = .oItem
				with loItem 
					lnSum_Cuentaparaimpresion = lnSum_Cuentaparaimpresion + .Cuentaparaimpresion
					lnSum_Monto = lnSum_Monto + .Monto
					lnSum_Recargosinpercepciones = lnSum_Recargosinpercepciones + .Recargosinpercepciones
					lnSum_Saldoaux = lnSum_Saldoaux + .Saldoaux
				endwith
			endif

			if .Sum_Cuentaparaimpresion != lnSum_Cuentaparaimpresion
				.Sum_Cuentaparaimpresion = lnSum_Cuentaparaimpresion
				.EventoCambioSum_Cuentaparaimpresion()
			endif
			if .Sum_Monto != lnSum_Monto
				.Sum_Monto = lnSum_Monto
				.EventoCambioSum_Monto()
			endif
			if .Sum_Recargosinpercepciones != lnSum_Recargosinpercepciones
				.Sum_Recargosinpercepciones = lnSum_Recargosinpercepciones
				.EventoCambioSum_Recargosinpercepciones()
			endif
			if .Sum_Saldoaux != lnSum_Saldoaux
				.Sum_Saldoaux = lnSum_Saldoaux
				.EventoCambioSum_Saldoaux()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Acumular( tlForzar as Boolean, tcAtributo as String, tnValor as Decimal, tnValorAnt as Decimal ) as Void
		local lnItem as integer, loItem as Object, lnSum_Cuentaparaimpresion as Number, lnSum_Monto as Number, lnSum_Recargosinpercepciones as Number, lnSum_Saldoaux as Number

		do case
		case tnValor = tnValorAnt
		case tcAtributo == 'Cuentaparaimpresion'
			this.Sum_Cuentaparaimpresion = this.Sum_Cuentaparaimpresion - tnValorAnt + tnValor
			this.EventoCambioSum_Cuentaparaimpresion()
		case tcAtributo == 'Monto'
			this.Sum_Monto = this.Sum_Monto - tnValorAnt + tnValor
			this.EventoCambioSum_Monto()
		case tcAtributo == 'Recargosinpercepciones'
			this.Sum_Recargosinpercepciones = this.Sum_Recargosinpercepciones - tnValorAnt + tnValor
			this.EventoCambioSum_Recargosinpercepciones()
		case tcAtributo == 'Saldoaux'
			this.Sum_Saldoaux = this.Sum_Saldoaux - tnValorAnt + tnValor
			this.EventoCambioSum_Saldoaux()

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
			this.oItem = _Screen.zoo.crearobjeto( 'ItemRECIBORecibodetalle' )
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

		select c_Recibodetalle
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Vencimiento = goLibrerias.ObtenerFechaFormateada( c_Recibodetalle.Vencimiento )
			loItem.Codigo = c_Recibodetalle.Codigo
			loItem.Letra = c_Recibodetalle.Letra
			loItem.PuntoDeVenta = c_Recibodetalle.PuntoDeVenta
			loItem.NumeroDeComprobante = c_Recibodetalle.NumeroDeComprobante
			loItem.TipoDeComprobante = c_Recibodetalle.TipoDeComprobante
			loItem.Valor_PK = c_Recibodetalle.Valor
			loItem.Tipo = c_Recibodetalle.Tipo
			loItem.EsPagoACuenta = c_Recibodetalle.EsPagoACuenta
			loItem.CodigoComprobante = c_Recibodetalle.CodigoComprobante
			loItem.Caja_PK = c_Recibodetalle.Caja
			loItem.Secuencia = c_Recibodetalle.Secuencia
			loItem.Cliente = c_Recibodetalle.Cliente
			loItem.BaseDeDatosAltaFW = c_Recibodetalle.BaseDeDatosAltaFW
			loItem.CAE = c_Recibodetalle.CAE
			loItem.NROITEM = c_Recibodetalle.NROITEM
			loItem.Fecha = goLibrerias.ObtenerFechaFormateada( c_Recibodetalle.Fecha )
			loItem.Descripcion = c_Recibodetalle.Descripcion
			loItem.Anotacion = c_Recibodetalle.Anotacion
			loItem.SaldoAux = c_Recibodetalle.SaldoAux
			loItem.Monto = c_Recibodetalle.Monto
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

		if  empty( this.item[ tnItem ].Letra ) or ; 			 empty( this.item[ tnItem ].Puntodeventa ) or ; 			 empty( this.item[ tnItem ].Numerodecomprobante ) or ; 			 empty( this.item[ tnItem ].Tipodecomprobante ) or ; 			 empty( this.item[ tnItem ].Valor_PK ) or ; 			 empty( this.item[ tnItem ].Cliente ) or ; 			 empty( this.item[ tnItem ].Basededatosaltafw ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc


	*-----------------------------------------------------------------------------------------
	Function ValidarFormatoAtributos() as boolean
	local lnLargoEntero as integer, lnValorDelDecimal as integer, lnLargoDecimal as integer, llRetorno as boolean, lnI as Integer

		llRetorno = dodefault()
		for lni = 1 to this.Count
			
			if inlist(vartype( this.Item[lni].VENCIMIENTO),'D','T')
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo VENCIMIENTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
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
			
			if vartype( this.Item[lni].TIPODECOMPROBANTE) = 'C'
				if len( alltrim( this.Item[lni].TIPODECOMPROBANTE )) <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TIPODECOMPROBANTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TIPODECOMPROBANTE ))) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TIPODECOMPROBANTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].ESPAGOACUENTA) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ESPAGOACUENTA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CODIGOCOMPROBANTE) = 'C'
				if len( alltrim( this.Item[lni].CODIGOCOMPROBANTE )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGOCOMPROBANTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGOCOMPROBANTE ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGOCOMPROBANTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].SECUENCIA) = 'C'
				if len( alltrim( this.Item[lni].SECUENCIA )) <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo SECUENCIA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].SECUENCIA ))) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo SECUENCIA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].BASEDEDATOSALTAFW) = 'C'
				if len( alltrim( this.Item[lni].BASEDEDATOSALTAFW )) <= 8
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo BASEDEDATOSALTAFW del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].BASEDEDATOSALTAFW ))) + ' Máxima:8), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo BASEDEDATOSALTAFW del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CAE) = 'C'
				if len( alltrim( this.Item[lni].CAE )) <= 20
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CAE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CAE ))) + ' Máxima:20), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CAE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if inlist(vartype( this.Item[lni].FECHA),'D','T')
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo FECHA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].DESCRIPCION) = 'C'
				if len( alltrim( this.Item[lni].DESCRIPCION )) <= 100
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo DESCRIPCION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].DESCRIPCION ))) + ' Máxima:100), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo DESCRIPCION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ANOTACION) = 'C'
				if len( alltrim( this.Item[lni].ANOTACION )) <= 100
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo ANOTACION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].ANOTACION ))) + ' Máxima:100), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ANOTACION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].SALDOAUX) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].SALDOAUX ) ) ) 
				lnValorDelDecimal = this.Item[lni].SALDOAUX - int( this.Item[lni].SALDOAUX )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo SALDOAUX del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo SALDOAUX del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Vencimiento = toItemOrigen.Vencimiento
		toItemDestino.Codigo = toItemOrigen.Codigo
		toItemDestino.Letra = toItemOrigen.Letra
		toItemDestino.Puntodeventa = toItemOrigen.Puntodeventa
		toItemDestino.Numerodecomprobante = toItemOrigen.Numerodecomprobante
		toItemDestino.Tipodecomprobante = toItemOrigen.Tipodecomprobante
		toItemDestino.Valor_PK = toItemOrigen.Valor_PK
		toItemDestino.Tipo = toItemOrigen.Tipo
		toItemDestino.Espagoacuenta = toItemOrigen.Espagoacuenta
		toItemDestino.Codigocomprobante = toItemOrigen.Codigocomprobante
		toItemDestino.Recargosinpercepciones = toItemOrigen.Recargosinpercepciones
		toItemDestino.Caja_PK = toItemOrigen.Caja_PK
		toItemDestino.Secuencia = toItemOrigen.Secuencia
		toItemDestino.Cliente = toItemOrigen.Cliente
		toItemDestino.Basededatosaltafw = toItemOrigen.Basededatosaltafw
		toItemDestino.Cuentaparaimpresion = toItemOrigen.Cuentaparaimpresion
		toItemDestino.Cae = toItemOrigen.Cae
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Fecha = toItemOrigen.Fecha
		toItemDestino.Descripcion = toItemOrigen.Descripcion
		toItemDestino.Anotacion = toItemOrigen.Anotacion
		toItemDestino.Saldoaux = toItemOrigen.Saldoaux
		toItemDestino.Monto = toItemOrigen.Monto
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

	Vencimiento = ctod( '  /  /    ' )
	Codigo = []
	Letra = []
	Puntodeventa = 0
	Numerodecomprobante = 0
	Tipodecomprobante = []
	Valor_PK = []
	Tipo = 0
	Espagoacuenta = .F.
	Codigocomprobante = []
	Recargosinpercepciones = 0
	Caja_PK = 0
	Secuencia = []
	Cliente = []
	Basededatosaltafw = []
	Cuentaparaimpresion = 0
	Cae = []
	Nroitem = 0
	Fecha = ctod( '  /  /    ' )
	Descripcion = []
	Anotacion = []
	Saldoaux = 0
	Monto = 0
	NroItem = 0

enddefine