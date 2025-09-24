
define class Din_DetalleASIENTOAsientodetalle as detalle of detalle.prg

	Sum_Debe = 0
	Sum_Haber = 0

	nCantidadItems = 999
	cNombre = 'Asientodetalle'
	cEtiqueta = 'Cuentas'
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
			
				.CuentaALaQueAjusta = this.Item[ tnItem ].CuentaALaQueAjusta
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CuentaALaQueAjusta', .CuentaALaQueAjusta )
			
				.FechaDelAjuste = this.Item[ tnItem ].FechaDelAjuste
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'FechaDelAjuste', .FechaDelAjuste )
			
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.PlanDeCuentas_PK = this.Item[ tnItem ].PlanDeCuentas_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PlanDeCuentas_PK', .PlanDeCuentas_PK )
			
				.PlanDeCuentasDetalle = this.Item[ tnItem ].PlanDeCuentasDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PlanDeCuentasDetalle', .PlanDeCuentasDetalle )
			
				.Leyenda = this.Item[ tnItem ].Leyenda
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Leyenda', .Leyenda )
			
				.CENTRODECOSTO_PK = this.Item[ tnItem ].CENTRODECOSTO_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CENTRODECOSTO_PK', .CENTRODECOSTO_PK )
			
				.Debe = this.Item[ tnItem ].Debe
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Debe', .Debe )
			
				.Haber = this.Item[ tnItem ].Haber
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Haber', .Haber )
			
				.Saldo = this.Item[ tnItem ].Saldo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Saldo', .Saldo )
			
				.RequiereCC = this.Item[ tnItem ].RequiereCC
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RequiereCC', .RequiereCC )
			
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
			.CuentaALaQueAjusta = this.oItem.CuentaALaQueAjusta
			.FechaDelAjuste = this.oItem.FechaDelAjuste
			.NROITEM = this.oItem.NROITEM
			.PlanDeCuentas_PK = this.oItem.PlanDeCuentas_PK
			.PlanDeCuentasDetalle = this.oItem.PlanDeCuentasDetalle
			.Leyenda = this.oItem.Leyenda
			.CENTRODECOSTO_PK = this.oItem.CENTRODECOSTO_PK
			.Debe = this.oItem.Debe
			.Haber = this.oItem.Haber
			.Saldo = this.oItem.Saldo
			.RequiereCC = this.oItem.RequiereCC
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
			.Item[ lnItem ].CuentaALaQueAjusta = .oItem.CuentaALaQueAjusta
			.Item[ lnItem ].FechaDelAjuste = .oItem.FechaDelAjuste
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].PlanDeCuentas_PK = .oItem.PlanDeCuentas_PK
			.Item[ lnItem ].PlanDeCuentasDetalle = .oItem.PlanDeCuentasDetalle
			.Item[ lnItem ].Leyenda = .oItem.Leyenda
			.Item[ lnItem ].CENTRODECOSTO_PK = .oItem.CENTRODECOSTO_PK
			.Item[ lnItem ].Debe = .oItem.Debe
			.Item[ lnItem ].Haber = .oItem.Haber
			.Item[ lnItem ].Saldo = .oItem.Saldo
			.Item[ lnItem ].RequiereCC = .oItem.RequiereCC
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Sumarizar() as boolean
		local lnItem as integer, loItem as Object, lnSum_Debe as Number, lnSum_Haber as Number

		with this
			lnSum_Debe = 0
			lnSum_Haber = 0
			if this.lEsNavegacion
				if select( 'c_Asientodetalle' ) > 0 and reccount( 'c_Asientodetalle' ) > 0
					sum Debe, Haber;
						 to ;
						 lnSum_Debe, lnSum_Haber
				endif
				this.lEsNavegacion = .f.
			else
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							if !empty(.PLANDECUENTAS_PK)
								lnSum_Debe = lnSum_Debe + .Debe
								lnSum_Haber = lnSum_Haber + .Haber
							endif
						endwith
					endif
				endfor

				if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
					loItem = .oItem
					with loItem 
						lnSum_Debe = lnSum_Debe + .Debe
						lnSum_Haber = lnSum_Haber + .Haber
					endwith
				endif
			endif

			if .Sum_Debe != lnSum_Debe
				.Sum_Debe = lnSum_Debe
				.EventoCambioSum_Debe()
			endif
			if .Sum_Haber != lnSum_Haber
				.Sum_Haber = lnSum_Haber
				.EventoCambioSum_Haber()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Debe() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Haber() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalizar( toItem as Object ) as Void
		local lnItem as integer, loItem as Object, lnSum_Debe as Number, lnSum_Haber as Number

		with this
			lnSum_Debe = 0
			lnSum_Haber = 0
			if !this.lEsNavegacion
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							if !empty(.PLANDECUENTAS_PK)
								lnSum_Debe = lnSum_Debe + .Debe
								lnSum_Haber = lnSum_Haber + .Haber
							endif
						endwith
					endif
				endfor

			endif
			if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
				loItem = .oItem
				with loItem 
					if !empty(.PLANDECUENTAS_PK)
						lnSum_Debe = lnSum_Debe + .Debe
						lnSum_Haber = lnSum_Haber + .Haber
					endif
				endwith
			endif

			if .Sum_Debe != lnSum_Debe
				.Sum_Debe = lnSum_Debe
				.EventoCambioSum_Debe()
			endif
			if .Sum_Haber != lnSum_Haber
				.Sum_Haber = lnSum_Haber
				.EventoCambioSum_Haber()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Acumular( tlForzar as Boolean, tcAtributo as String, tnValor as Decimal, tnValorAnt as Decimal ) as Void
		local lnItem as integer, loItem as Object, lnSum_Debe as Number, lnSum_Haber as Number

		do case
		case tnValor = tnValorAnt
		case tcAtributo == 'Debe'
			this.Sum_Debe = this.Sum_Debe - tnValorAnt + tnValor
			this.EventoCambioSum_Debe()
		case tcAtributo == 'Haber'
			this.Sum_Haber = this.Sum_Haber - tnValorAnt + tnValor
			this.EventoCambioSum_Haber()

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
			this.oItem = _Screen.zoo.crearobjeto( 'ItemASIENTOAsientodetalle' )
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

		select c_Asientodetalle
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Codigo = c_Asientodetalle.Codigo
			loItem.CuentaALaQueAjusta = c_Asientodetalle.CuentaALaQueAjusta
			loItem.FechaDelAjuste = goLibrerias.ObtenerFechaFormateada( c_Asientodetalle.FechaDelAjuste )
			loItem.NROITEM = c_Asientodetalle.NROITEM
			loItem.PlanDeCuentas_PK = c_Asientodetalle.PlanDeCuentas
			loItem.PlanDeCuentasDetalle = c_Asientodetalle.PlanDeCuentasDetalle
			loItem.Leyenda = c_Asientodetalle.Leyenda
			loItem.CENTRODECOSTO_PK = c_Asientodetalle.CENTRODECOSTO
			loItem.Debe = c_Asientodetalle.Debe
			loItem.Haber = c_Asientodetalle.Haber
			loItem.Saldo = c_Asientodetalle.Saldo
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

		if  empty( this.item[ tnItem ].Plandecuentas_PK ) 
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
				if len( alltrim( this.Item[lni].CODIGO )) <= 20
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGO ))) + ' Máxima:20), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CUENTAALAQUEAJUSTA) = 'C'
				if len( alltrim( this.Item[lni].CUENTAALAQUEAJUSTA )) <= 30
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CUENTAALAQUEAJUSTA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CUENTAALAQUEAJUSTA ))) + ' Máxima:30), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CUENTAALAQUEAJUSTA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if inlist(vartype( this.Item[lni].FECHADELAJUSTE),'D','T')
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo FECHADELAJUSTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].PLANDECUENTAS_PK) = 'C'
				if len( alltrim( this.Item[lni].PLANDECUENTAS_PK )) <= 30
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo PLANDECUENTAS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].PLANDECUENTAS_PK ))) + ' Máxima:30), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PLANDECUENTAS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PLANDECUENTASDETALLE) = 'C'
				if len( alltrim( this.Item[lni].PLANDECUENTASDETALLE )) <= 100
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo PLANDECUENTASDETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].PLANDECUENTASDETALLE ))) + ' Máxima:100), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PLANDECUENTASDETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].LEYENDA) = 'C'
				if len( alltrim( this.Item[lni].LEYENDA )) <= 150
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo LEYENDA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].LEYENDA ))) + ' Máxima:150), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo LEYENDA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CENTRODECOSTO_PK) = 'C'
				if len( alltrim( this.Item[lni].CENTRODECOSTO_PK )) <= 20
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CENTRODECOSTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CENTRODECOSTO_PK ))) + ' Máxima:20), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CENTRODECOSTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].DEBE) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].DEBE ) ) ) 
				lnValorDelDecimal = this.Item[lni].DEBE - int( this.Item[lni].DEBE )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 12
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo DEBE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:12), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo DEBE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].HABER) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].HABER ) ) ) 
				lnValorDelDecimal = this.Item[lni].HABER - int( this.Item[lni].HABER )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 12
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo HABER del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:12), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo HABER del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].SALDO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].SALDO ) ) ) 
				lnValorDelDecimal = this.Item[lni].SALDO - int( this.Item[lni].SALDO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 12
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo SALDO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:12), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo SALDO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Cuentaalaqueajusta = toItemOrigen.Cuentaalaqueajusta
		toItemDestino.Fechadelajuste = toItemOrigen.Fechadelajuste
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Plandecuentas_PK = toItemOrigen.Plandecuentas_PK
		toItemDestino.Plandecuentasdetalle = toItemOrigen.Plandecuentasdetalle
		toItemDestino.Leyenda = toItemOrigen.Leyenda
		toItemDestino.Centrodecosto_PK = toItemOrigen.Centrodecosto_PK
		toItemDestino.Debe = toItemOrigen.Debe
		toItemDestino.Haber = toItemOrigen.Haber
		toItemDestino.Saldo = toItemOrigen.Saldo
		toItemDestino.Requierecc = toItemOrigen.Requierecc
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
		lcRetorno = 'PlanDeCuentas_pk'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Codigo = []
	Cuentaalaqueajusta = []
	Fechadelajuste = ctod( '  /  /    ' )
	Nroitem = 0
	Plandecuentas_PK = []
	Plandecuentasdetalle = []
	Leyenda = []
	Centrodecosto_PK = []
	Debe = 0
	Haber = 0
	Saldo = 0
	Requierecc = .F.
	NroItem = 0

enddefine