
define class Din_DetalleCOMPROBANTEPAGOComprobantepagodetalle as detalle of detalle.prg

	Sum_Monto = 0

	nCantidadItems = 999
	cNombre = 'Comprobantepagodetalle'
	cEtiqueta = 'Conceptos'
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
				.Concepto_PK = this.Item[ tnItem ].Concepto_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Concepto_PK', .Concepto_PK )
			
				.Codigo = this.Item[ tnItem ].Codigo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Codigo', .Codigo )
			
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.ConceptoDetalle = this.Item[ tnItem ].ConceptoDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ConceptoDetalle', .ConceptoDetalle )
			
				.CentroDeCosto_PK = this.Item[ tnItem ].CentroDeCosto_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CentroDeCosto_PK', .CentroDeCosto_PK )
			
				.DistribucionCentroDeCosto_PK = this.Item[ tnItem ].DistribucionCentroDeCosto_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'DistribucionCentroDeCosto_PK', .DistribucionCentroDeCosto_PK )
			
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
			.Concepto_PK = this.oItem.Concepto_PK
			.Codigo = this.oItem.Codigo
			.NROITEM = this.oItem.NROITEM
			.ConceptoDetalle = this.oItem.ConceptoDetalle
			.CentroDeCosto_PK = this.oItem.CentroDeCosto_PK
			.DistribucionCentroDeCosto_PK = this.oItem.DistribucionCentroDeCosto_PK
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
			.Item[ lnItem ].Concepto_PK = .oItem.Concepto_PK
			.Item[ lnItem ].Codigo = .oItem.Codigo
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].ConceptoDetalle = .oItem.ConceptoDetalle
			.Item[ lnItem ].CentroDeCosto_PK = .oItem.CentroDeCosto_PK
			.Item[ lnItem ].DistribucionCentroDeCosto_PK = .oItem.DistribucionCentroDeCosto_PK
			.Item[ lnItem ].Monto = .oItem.Monto
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Sumarizar() as boolean
		local lnItem as integer, loItem as Object, lnSum_Monto as Number

		with this
			lnSum_Monto = 0
			if this.lEsNavegacion
				if select( 'c_Comprobantepagodetalle' ) > 0 and reccount( 'c_Comprobantepagodetalle' ) > 0
					sum Monto;
						 to ;
						 lnSum_Monto
				endif
				this.lEsNavegacion = .f.
			else
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							if !empty(.CONCEPTO_PK)
								lnSum_Monto = lnSum_Monto + .Monto
							endif
						endwith
					endif
				endfor

				if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
					loItem = .oItem
					with loItem 
						lnSum_Monto = lnSum_Monto + .Monto
					endwith
				endif
			endif

			if .Sum_Monto != lnSum_Monto
				.Sum_Monto = lnSum_Monto
				.EventoCambioSum_Monto()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Monto() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalizar( toItem as Object ) as Void
		local lnItem as integer, loItem as Object, lnSum_Monto as Number

		with this
			lnSum_Monto = 0
			if !this.lEsNavegacion
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							if !empty(.CONCEPTO_PK)
								lnSum_Monto = lnSum_Monto + .Monto
							endif
						endwith
					endif
				endfor

			endif
			if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
				loItem = .oItem
				with loItem 
					if !empty(.CONCEPTO_PK)
						lnSum_Monto = lnSum_Monto + .Monto
					endif
				endwith
			endif

			if .Sum_Monto != lnSum_Monto
				.Sum_Monto = lnSum_Monto
				.EventoCambioSum_Monto()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Acumular( tlForzar as Boolean, tcAtributo as String, tnValor as Decimal, tnValorAnt as Decimal ) as Void
		local lnItem as integer, loItem as Object, lnSum_Monto as Number

		do case
		case tnValor = tnValorAnt
		case tcAtributo == 'Monto'
			this.Sum_Monto = this.Sum_Monto - tnValorAnt + tnValor
			this.EventoCambioSum_Monto()

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
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemCOMPROBANTEPAGOComprobantepagodetalle' )
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

		select c_Comprobantepagodetalle
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Concepto_PK = c_Comprobantepagodetalle.Concepto
			loItem.Codigo = c_Comprobantepagodetalle.Codigo
			loItem.NROITEM = c_Comprobantepagodetalle.NROITEM
			loItem.ConceptoDetalle = c_Comprobantepagodetalle.ConceptoDetalle
			loItem.CentroDeCosto_PK = c_Comprobantepagodetalle.CentroDeCosto
			loItem.DistribucionCentroDeCosto_PK = c_Comprobantepagodetalle.DistribucionCentroDeCosto
			loItem.Monto = c_Comprobantepagodetalle.Monto
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

		if  empty( this.item[ tnItem ].Concepto_PK ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc


	*-----------------------------------------------------------------------------------------
	Function ValidarFormatoAtributos() as boolean
	local lnLargoEntero as integer, lnValorDelDecimal as integer, lnLargoDecimal as integer, llRetorno as boolean, lnI as Integer

		llRetorno = dodefault()
		for lni = 1 to this.Count
			
			if vartype( this.Item[lni].CONCEPTO_PK) = 'C'
				if len( alltrim( this.Item[lni].CONCEPTO_PK )) <= 15
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CONCEPTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CONCEPTO_PK ))) + ' Máxima:15), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CONCEPTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].CONCEPTODETALLE) = 'C'
				if len( alltrim( this.Item[lni].CONCEPTODETALLE )) <= 40
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CONCEPTODETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CONCEPTODETALLE ))) + ' Máxima:40), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CONCEPTODETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].DISTRIBUCIONCENTRODECOSTO_PK) = 'C'
				if len( alltrim( this.Item[lni].DISTRIBUCIONCENTRODECOSTO_PK )) <= 20
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo DISTRIBUCIONCENTRODECOSTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].DISTRIBUCIONCENTRODECOSTO_PK ))) + ' Máxima:20), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo DISTRIBUCIONCENTRODECOSTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Concepto_PK = toItemOrigen.Concepto_PK
		toItemDestino.Codigo = toItemOrigen.Codigo
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Conceptodetalle = toItemOrigen.Conceptodetalle
		toItemDestino.Centrodecosto_PK = toItemOrigen.Centrodecosto_PK
		toItemDestino.Distribucioncentrodecosto_PK = toItemOrigen.Distribucioncentrodecosto_PK
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
		lcRetorno = 'Concepto_pk'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Concepto_PK = []
	Codigo = []
	Nroitem = 0
	Conceptodetalle = []
	Centrodecosto_PK = []
	Distribucioncentrodecosto_PK = []
	Monto = 0
	NroItem = 0

enddefine