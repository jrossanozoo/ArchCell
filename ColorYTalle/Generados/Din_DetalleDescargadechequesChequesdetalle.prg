
define class Din_DetalleDESCARGADECHEQUESChequesdetalle as DetalleDescargacheque of DetalleDescargacheque.Prg

	Sum_Pesosalcambio = 0

	nCantidadItems = 999
	cNombre = 'Chequesdetalle'
	cEtiqueta = 'Detalle'
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
			
				.Tipo = this.Item[ tnItem ].Tipo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Tipo', .Tipo )
			
				.Valor_PK = this.Item[ tnItem ].Valor_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Valor_PK', .Valor_PK )
			
				.PesosAlCambio = this.Item[ tnItem ].PesosAlCambio
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PesosAlCambio', .PesosAlCambio )
			
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.NumeroCheque_PK = this.Item[ tnItem ].NumeroCheque_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumeroCheque_PK', .NumeroCheque_PK )
			
				.NumeroInterno = this.Item[ tnItem ].NumeroInterno
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumeroInterno', .NumeroInterno )
			
				.IdItemComponente = this.Item[ tnItem ].IdItemComponente
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'IdItemComponente', .IdItemComponente )
			
				.EntidadFinanciera_PK = this.Item[ tnItem ].EntidadFinanciera_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'EntidadFinanciera_PK', .EntidadFinanciera_PK )
			
				.EntidadFinancieraDetalle = this.Item[ tnItem ].EntidadFinancieraDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'EntidadFinancieraDetalle', .EntidadFinancieraDetalle )
			
				.Numero = this.Item[ tnItem ].Numero
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Numero', .Numero )
			
				.FechaEmision = this.Item[ tnItem ].FechaEmision
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'FechaEmision', .FechaEmision )
			
				.FechaPago = this.Item[ tnItem ].FechaPago
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'FechaPago', .FechaPago )
			
				.CodigoTributarioLibrador = this.Item[ tnItem ].CodigoTributarioLibrador
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodigoTributarioLibrador', .CodigoTributarioLibrador )
			
				.Cliente_PK = this.Item[ tnItem ].Cliente_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Cliente_PK', .Cliente_PK )
			
				.ClienteDetalle = this.Item[ tnItem ].ClienteDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ClienteDetalle', .ClienteDetalle )
			
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
			.Codigo = this.oItem.Codigo
			.Tipo = this.oItem.Tipo
			.Valor_PK = this.oItem.Valor_PK
			.PesosAlCambio = this.oItem.PesosAlCambio
			.NROITEM = this.oItem.NROITEM
			.NumeroCheque_PK = this.oItem.NumeroCheque_PK
			.NumeroInterno = this.oItem.NumeroInterno
			.IdItemComponente = this.oItem.IdItemComponente
			.EntidadFinanciera_PK = this.oItem.EntidadFinanciera_PK
			.EntidadFinancieraDetalle = this.oItem.EntidadFinancieraDetalle
			.Numero = this.oItem.Numero
			.FechaEmision = this.oItem.FechaEmision
			.FechaPago = this.oItem.FechaPago
			.CodigoTributarioLibrador = this.oItem.CodigoTributarioLibrador
			.Cliente_PK = this.oItem.Cliente_PK
			.ClienteDetalle = this.oItem.ClienteDetalle
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
			.Item[ lnItem ].Codigo = .oItem.Codigo
			.Item[ lnItem ].Tipo = .oItem.Tipo
			.Item[ lnItem ].Valor_PK = .oItem.Valor_PK
			.Item[ lnItem ].PesosAlCambio = .oItem.PesosAlCambio
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].NumeroCheque_PK = .oItem.NumeroCheque_PK
			.Item[ lnItem ].NumeroInterno = .oItem.NumeroInterno
			.Item[ lnItem ].IdItemComponente = .oItem.IdItemComponente
			.Item[ lnItem ].EntidadFinanciera_PK = .oItem.EntidadFinanciera_PK
			.Item[ lnItem ].EntidadFinancieraDetalle = .oItem.EntidadFinancieraDetalle
			.Item[ lnItem ].Numero = .oItem.Numero
			.Item[ lnItem ].FechaEmision = .oItem.FechaEmision
			.Item[ lnItem ].FechaPago = .oItem.FechaPago
			.Item[ lnItem ].CodigoTributarioLibrador = .oItem.CodigoTributarioLibrador
			.Item[ lnItem ].Cliente_PK = .oItem.Cliente_PK
			.Item[ lnItem ].ClienteDetalle = .oItem.ClienteDetalle
			.Item[ lnItem ].Monto = .oItem.Monto
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
				if select( 'c_Chequesdetalle' ) > 0 and reccount( 'c_Chequesdetalle' ) > 0
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
							lnSum_Pesosalcambio = lnSum_Pesosalcambio + .Pesosalcambio
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
							lnSum_Pesosalcambio = lnSum_Pesosalcambio + .Pesosalcambio
						endwith
					endif
				endfor

			endif
			if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
				loItem = .oItem
				with loItem 
					lnSum_Pesosalcambio = lnSum_Pesosalcambio + .Pesosalcambio
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
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemDESCARGADECHEQUESChequesdetalle' )
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

		select c_Chequesdetalle
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Codigo = c_Chequesdetalle.Codigo
			loItem.Tipo = c_Chequesdetalle.Tipo
			loItem.PesosAlCambio = c_Chequesdetalle.PesosAlCambio
			loItem.NROITEM = c_Chequesdetalle.NROITEM
			loItem.NumeroCheque_PK = c_Chequesdetalle.NumeroCheque
			loItem.NumeroInterno = c_Chequesdetalle.NumeroInterno
			loItem.IdItemComponente = c_Chequesdetalle.IdItemComponente
			loItem.EntidadFinanciera_PK = c_Chequesdetalle.EntidadFinanciera
			loItem.EntidadFinancieraDetalle = c_Chequesdetalle.EntidadFinancieraDetalle
			loItem.Numero = c_Chequesdetalle.Numero
			loItem.FechaEmision = goLibrerias.ObtenerFechaFormateada( c_Chequesdetalle.FechaEmision )
			loItem.FechaPago = goLibrerias.ObtenerFechaFormateada( c_Chequesdetalle.FechaPago )
			loItem.CodigoTributarioLibrador = c_Chequesdetalle.CodigoTributarioLibrador
			loItem.Cliente_PK = c_Chequesdetalle.Cliente
			loItem.ClienteDetalle = c_Chequesdetalle.ClienteDetalle
			loItem.Monto = c_Chequesdetalle.Monto
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

		if  empty( this.item[ tnItem ].Numerointerno ) 
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
			
			if vartype( this.Item[lni].ENTIDADFINANCIERA_PK) = 'C'
				if len( alltrim( this.Item[lni].ENTIDADFINANCIERA_PK )) <= 5
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo ENTIDADFINANCIERA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].ENTIDADFINANCIERA_PK ))) + ' Máxima:5), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ENTIDADFINANCIERA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ENTIDADFINANCIERADETALLE) = 'C'
				if len( alltrim( this.Item[lni].ENTIDADFINANCIERADETALLE )) <= 40
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo ENTIDADFINANCIERADETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].ENTIDADFINANCIERADETALLE ))) + ' Máxima:40), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ENTIDADFINANCIERADETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if inlist(vartype( this.Item[lni].FECHAEMISION),'D','T')
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo FECHAEMISION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if inlist(vartype( this.Item[lni].FECHAPAGO),'D','T')
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo FECHAPAGO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CODIGOTRIBUTARIOLIBRADOR) = 'C'
				if len( alltrim( this.Item[lni].CODIGOTRIBUTARIOLIBRADOR )) <= 15
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGOTRIBUTARIOLIBRADOR del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGOTRIBUTARIOLIBRADOR ))) + ' Máxima:15), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGOTRIBUTARIOLIBRADOR del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CLIENTE_PK) = 'C'
				if len( alltrim( this.Item[lni].CLIENTE_PK )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CLIENTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CLIENTE_PK ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CLIENTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CLIENTEDETALLE) = 'C'
				if len( alltrim( this.Item[lni].CLIENTEDETALLE )) <= 185
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CLIENTEDETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CLIENTEDETALLE ))) + ' Máxima:185), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CLIENTEDETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Codigo = toItemOrigen.Codigo
		toItemDestino.Tipo = toItemOrigen.Tipo
		toItemDestino.Valor_pk = toItemOrigen.Valor_pk
		toItemDestino.Pesosalcambio = toItemOrigen.Pesosalcambio
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Numerocheque_PK = toItemOrigen.Numerocheque_PK
		toItemDestino.Numerointerno = toItemOrigen.Numerointerno
		toItemDestino.Iditemcomponente = toItemOrigen.Iditemcomponente
		toItemDestino.Entidadfinanciera_PK = toItemOrigen.Entidadfinanciera_PK
		toItemDestino.Entidadfinancieradetalle = toItemOrigen.Entidadfinancieradetalle
		toItemDestino.Numero = toItemOrigen.Numero
		toItemDestino.Fechaemision = toItemOrigen.Fechaemision
		toItemDestino.Fechapago = toItemOrigen.Fechapago
		toItemDestino.Codigotributariolibrador = toItemOrigen.Codigotributariolibrador
		toItemDestino.Cliente_PK = toItemOrigen.Cliente_PK
		toItemDestino.Clientedetalle = toItemOrigen.Clientedetalle
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

	*--------------------------------------------------------------------------------------------------------
	function ObtenerCampoInicialYOBligatorioDelDetalle() as String
	local lcRetorno as string
		lcRetorno = 'NumeroInterno'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Codigo = []
	Tipo = 0
	Valor_pk = []
	Pesosalcambio = 0
	Nroitem = 0
	Numerocheque_PK = []
	Numerointerno = []
	Iditemcomponente = []
	Entidadfinanciera_PK = []
	Entidadfinancieradetalle = []
	Numero = 0
	Fechaemision = ctod( '  /  /    ' )
	Fechapago = ctod( '  /  /    ' )
	Codigotributariolibrador = []
	Cliente_PK = []
	Clientedetalle = []
	Monto = 0
	NroItem = 0

enddefine