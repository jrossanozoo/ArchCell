
define class Din_DetalleCONDICIONDEPAGOPagospersonalizados as detalle of detalle.prg

	Sum_Porcentajedelcomprobante = 0

	nCantidadItems = 999
	cNombre = 'Pagospersonalizados'
	cEtiqueta = 'Pagos personalizados'
	cMensajeErrorUnicidad = 'La columna  no admite valores repetidos.'
	cNombreVisual = 'Pagos personalizados'

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
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.Codigo = this.Item[ tnItem ].Codigo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Codigo', .Codigo )
			
				.Valor_PK = this.Item[ tnItem ].Valor_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Valor_PK', .Valor_PK )
			
				.ValorDetalle = this.Item[ tnItem ].ValorDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ValorDetalle', .ValorDetalle )
			
				.TipoValorDescripcion = this.Item[ tnItem ].TipoValorDescripcion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TipoValorDescripcion', .TipoValorDescripcion )
			
				.Descuento = this.Item[ tnItem ].Descuento
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Descuento', .Descuento )
			
				.Recargo = this.Item[ tnItem ].Recargo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Recargo', .Recargo )
			
				.DiasAPartirDeFechaComprobante = this.Item[ tnItem ].DiasAPartirDeFechaComprobante
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'DiasAPartirDeFechaComprobante', .DiasAPartirDeFechaComprobante )
			
				.PorcentajeDelComprobante = this.Item[ tnItem ].PorcentajeDelComprobante
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PorcentajeDelComprobante', .PorcentajeDelComprobante )
			
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
			.NROITEM = this.oItem.NROITEM
			.Codigo = this.oItem.Codigo
			.Valor_PK = this.oItem.Valor_PK
			.ValorDetalle = this.oItem.ValorDetalle
			.TipoValorDescripcion = this.oItem.TipoValorDescripcion
			.Descuento = this.oItem.Descuento
			.Recargo = this.oItem.Recargo
			.DiasAPartirDeFechaComprobante = this.oItem.DiasAPartirDeFechaComprobante
			.PorcentajeDelComprobante = this.oItem.PorcentajeDelComprobante
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
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].Codigo = .oItem.Codigo
			.Item[ lnItem ].Valor_PK = .oItem.Valor_PK
			.Item[ lnItem ].ValorDetalle = .oItem.ValorDetalle
			.Item[ lnItem ].TipoValorDescripcion = .oItem.TipoValorDescripcion
			.Item[ lnItem ].Descuento = .oItem.Descuento
			.Item[ lnItem ].Recargo = .oItem.Recargo
			.Item[ lnItem ].DiasAPartirDeFechaComprobante = .oItem.DiasAPartirDeFechaComprobante
			.Item[ lnItem ].PorcentajeDelComprobante = .oItem.PorcentajeDelComprobante
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Sumarizar() as boolean
		local lnItem as integer, loItem as Object, lnSum_Porcentajedelcomprobante as Number

		with this
			lnSum_Porcentajedelcomprobante = 0
			if this.lEsNavegacion
				if select( 'c_Pagospersonalizados' ) > 0 and reccount( 'c_Pagospersonalizados' ) > 0
					sum Porcentajedelcomprobante;
						 to ;
						 lnSum_Porcentajedelcomprobante
				endif
				this.lEsNavegacion = .f.
			else
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							if !empty(.VALOR_PK)
								lnSum_Porcentajedelcomprobante = lnSum_Porcentajedelcomprobante + .Porcentajedelcomprobante
							endif
						endwith
					endif
				endfor

				if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
					loItem = .oItem
					with loItem 
						lnSum_Porcentajedelcomprobante = lnSum_Porcentajedelcomprobante + .Porcentajedelcomprobante
					endwith
				endif
			endif

			if .Sum_Porcentajedelcomprobante != lnSum_Porcentajedelcomprobante
				.Sum_Porcentajedelcomprobante = lnSum_Porcentajedelcomprobante
				.EventoCambioSum_Porcentajedelcomprobante()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Porcentajedelcomprobante() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalizar( toItem as Object ) as Void
		local lnItem as integer, loItem as Object, lnSum_Porcentajedelcomprobante as Number

		with this
			lnSum_Porcentajedelcomprobante = 0
			if !this.lEsNavegacion
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							if !empty(.VALOR_PK)
								lnSum_Porcentajedelcomprobante = lnSum_Porcentajedelcomprobante + .Porcentajedelcomprobante
							endif
						endwith
					endif
				endfor

			endif
			if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
				loItem = .oItem
				with loItem 
					if !empty(.VALOR_PK)
						lnSum_Porcentajedelcomprobante = lnSum_Porcentajedelcomprobante + .Porcentajedelcomprobante
					endif
				endwith
			endif

			if .Sum_Porcentajedelcomprobante != lnSum_Porcentajedelcomprobante
				.Sum_Porcentajedelcomprobante = lnSum_Porcentajedelcomprobante
				.EventoCambioSum_Porcentajedelcomprobante()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Acumular( tlForzar as Boolean, tcAtributo as String, tnValor as Decimal, tnValorAnt as Decimal ) as Void
		local lnItem as integer, loItem as Object, lnSum_Porcentajedelcomprobante as Number

		do case
		case tnValor = tnValorAnt
		case tcAtributo == 'Porcentajedelcomprobante'
			this.Sum_Porcentajedelcomprobante = this.Sum_Porcentajedelcomprobante - tnValorAnt + tnValor
			this.EventoCambioSum_Porcentajedelcomprobante()

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
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemCONDICIONDEPAGOPagospersonalizados' )
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

		select c_Pagospersonalizados
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.NROITEM = c_Pagospersonalizados.NROITEM
			loItem.Codigo = c_Pagospersonalizados.Codigo
			loItem.Valor_PK = c_Pagospersonalizados.Valor
			loItem.ValorDetalle = c_Pagospersonalizados.ValorDetalle
			loItem.Descuento = c_Pagospersonalizados.Descuento
			loItem.Recargo = c_Pagospersonalizados.Recargo
			loItem.DiasAPartirDeFechaComprobante = c_Pagospersonalizados.DiasAPartirDeFechaComprobante
			loItem.PorcentajeDelComprobante = c_Pagospersonalizados.PorcentajeDelComprobante
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
			
			if vartype( this.Item[lni].DESCUENTO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].DESCUENTO ) ) ) 
				lnValorDelDecimal = this.Item[lni].DESCUENTO - int( this.Item[lni].DESCUENTO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 4
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo DESCUENTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:4), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo DESCUENTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].RECARGO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].RECARGO ) ) ) 
				lnValorDelDecimal = this.Item[lni].RECARGO - int( this.Item[lni].RECARGO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 4
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo RECARGO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:4), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo RECARGO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].DIASAPARTIRDEFECHACOMPROBANTE) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].DIASAPARTIRDEFECHACOMPROBANTE ) ) ) 
				lnValorDelDecimal = this.Item[lni].DIASAPARTIRDEFECHACOMPROBANTE - int( this.Item[lni].DIASAPARTIRDEFECHACOMPROBANTE )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 3
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo DIASAPARTIRDEFECHACOMPROBANTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:3), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo DIASAPARTIRDEFECHACOMPROBANTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PORCENTAJEDELCOMPROBANTE) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].PORCENTAJEDELCOMPROBANTE ) ) ) 
				lnValorDelDecimal = this.Item[lni].PORCENTAJEDELCOMPROBANTE - int( this.Item[lni].PORCENTAJEDELCOMPROBANTE )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 4
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo PORCENTAJEDELCOMPROBANTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:4), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PORCENTAJEDELCOMPROBANTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Codigo = toItemOrigen.Codigo
		toItemDestino.Valor_PK = toItemOrigen.Valor_PK
		toItemDestino.Valordetalle = toItemOrigen.Valordetalle
		toItemDestino.Tipovalordescripcion = toItemOrigen.Tipovalordescripcion
		toItemDestino.Descuento = toItemOrigen.Descuento
		toItemDestino.Recargo = toItemOrigen.Recargo
		toItemDestino.Diasapartirdefechacomprobante = toItemOrigen.Diasapartirdefechacomprobante
		toItemDestino.Porcentajedelcomprobante = toItemOrigen.Porcentajedelcomprobante
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

	Nroitem = 0
	Codigo = []
	Valor_PK = []
	Valordetalle = []
	Tipovalordescripcion = []
	Descuento = 0
	Recargo = 0
	Diasapartirdefechacomprobante = 0
	Porcentajedelcomprobante = 0
	NroItem = 0

enddefine