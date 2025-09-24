
define class Din_DetalleCANCELACIONDESENIASSeniascancdetalle as detalle of detalle.prg

	Sum_Importe = 0

	nCantidadItems = 999
	cNombre = 'Seniascancdetalle'
	cEtiqueta = 'Artículos señados'
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
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.Codigo = this.Item[ tnItem ].Codigo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Codigo', .Codigo )
			
				.IdSeniaCancelada = this.Item[ tnItem ].IdSeniaCancelada
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'IdSeniaCancelada', .IdSeniaCancelada )
			
				.Cliente_PK = this.Item[ tnItem ].Cliente_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Cliente_PK', .Cliente_PK )
			
				.ClienteDetalle = this.Item[ tnItem ].ClienteDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ClienteDetalle', .ClienteDetalle )
			
				.Comprobante = this.Item[ tnItem ].Comprobante
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Comprobante', .Comprobante )
			
				.FechaAlta = this.Item[ tnItem ].FechaAlta
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'FechaAlta', .FechaAlta )
			
				.FechaVto = this.Item[ tnItem ].FechaVto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'FechaVto', .FechaVto )
			
				.Importe = this.Item[ tnItem ].Importe
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Importe', .Importe )
			
				.Seleccionada = this.Item[ tnItem ].Seleccionada
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Seleccionada', .Seleccionada )
			
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
			.IdSeniaCancelada = this.oItem.IdSeniaCancelada
			.Cliente_PK = this.oItem.Cliente_PK
			.ClienteDetalle = this.oItem.ClienteDetalle
			.Comprobante = this.oItem.Comprobante
			.FechaAlta = this.oItem.FechaAlta
			.FechaVto = this.oItem.FechaVto
			.Importe = this.oItem.Importe
			.Seleccionada = this.oItem.Seleccionada
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
			.Item[ lnItem ].IdSeniaCancelada = .oItem.IdSeniaCancelada
			.Item[ lnItem ].Cliente_PK = .oItem.Cliente_PK
			.Item[ lnItem ].ClienteDetalle = .oItem.ClienteDetalle
			.Item[ lnItem ].Comprobante = .oItem.Comprobante
			.Item[ lnItem ].FechaAlta = .oItem.FechaAlta
			.Item[ lnItem ].FechaVto = .oItem.FechaVto
			.Item[ lnItem ].Importe = .oItem.Importe
			.Item[ lnItem ].Seleccionada = .oItem.Seleccionada
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Sumarizar() as boolean
		local lnItem as integer, loItem as Object, lnSum_Importe as Number

		with this
			lnSum_Importe = 0
			if this.lEsNavegacion
				if select( 'c_Seniascancdetalle' ) > 0 and reccount( 'c_Seniascancdetalle' ) > 0
					sum Importe;
						 to ;
						 lnSum_Importe
				endif
				this.lEsNavegacion = .f.
			else
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							lnSum_Importe = lnSum_Importe + .Importe
						endwith
					endif
				endfor

				if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
					loItem = .oItem
					with loItem 
						lnSum_Importe = lnSum_Importe + .Importe
					endwith
				endif
			endif

			if .Sum_Importe != lnSum_Importe
				.Sum_Importe = lnSum_Importe
				.EventoCambioSum_Importe()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Importe() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalizar( toItem as Object ) as Void
		local lnItem as integer, loItem as Object, lnSum_Importe as Number

		with this
			lnSum_Importe = 0
			if !this.lEsNavegacion
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							lnSum_Importe = lnSum_Importe + .Importe
						endwith
					endif
				endfor

			endif
			if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
				loItem = .oItem
				with loItem 
					lnSum_Importe = lnSum_Importe + .Importe
				endwith
			endif

			if .Sum_Importe != lnSum_Importe
				.Sum_Importe = lnSum_Importe
				.EventoCambioSum_Importe()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Acumular( tlForzar as Boolean, tcAtributo as String, tnValor as Decimal, tnValorAnt as Decimal ) as Void
		local lnItem as integer, loItem as Object, lnSum_Importe as Number

		do case
		case tnValor = tnValorAnt
		case tcAtributo == 'Importe'
			this.Sum_Importe = this.Sum_Importe - tnValorAnt + tnValor
			this.EventoCambioSum_Importe()

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
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemCANCELACIONDESENIASSeniascancdetalle' )
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

		select c_Seniascancdetalle
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.NROITEM = c_Seniascancdetalle.NROITEM
			loItem.Codigo = c_Seniascancdetalle.Codigo
			loItem.IdSeniaCancelada = c_Seniascancdetalle.IdSeniaCancelada
			loItem.Cliente_PK = c_Seniascancdetalle.Cliente
			loItem.ClienteDetalle = c_Seniascancdetalle.ClienteDetalle
			loItem.Comprobante = c_Seniascancdetalle.Comprobante
			loItem.FechaAlta = goLibrerias.ObtenerFechaFormateada( c_Seniascancdetalle.FechaAlta )
			loItem.FechaVto = goLibrerias.ObtenerFechaFormateada( c_Seniascancdetalle.FechaVto )
			loItem.Importe = c_Seniascancdetalle.Importe
			loItem.Seleccionada = c_Seniascancdetalle.Seleccionada
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

		if  empty( this.item[ tnItem ].Cliente_PK ) or ; 			 empty( this.item[ tnItem ].Clientedetalle ) or ; 			 empty( this.item[ tnItem ].Comprobante ) 
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
			
			if vartype( this.Item[lni].IDSENIACANCELADA) = 'C'
				if len( alltrim( this.Item[lni].IDSENIACANCELADA )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo IDSENIACANCELADA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].IDSENIACANCELADA ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo IDSENIACANCELADA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CLIENTE_PK) = 'C'
				if len( alltrim( this.Item[lni].CLIENTE_PK )) <= 5
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CLIENTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CLIENTE_PK ))) + ' Máxima:5), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CLIENTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CLIENTEDETALLE) = 'C'
				if len( alltrim( this.Item[lni].CLIENTEDETALLE )) <= 30
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CLIENTEDETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CLIENTEDETALLE ))) + ' Máxima:30), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CLIENTEDETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].COMPROBANTE) = 'C'
				if len( alltrim( this.Item[lni].COMPROBANTE )) <= 20
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo COMPROBANTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].COMPROBANTE ))) + ' Máxima:20), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo COMPROBANTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if inlist(vartype( this.Item[lni].FECHAALTA),'D','T')
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo FECHAALTA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if inlist(vartype( this.Item[lni].FECHAVTO),'D','T')
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo FECHAVTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].IMPORTE) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].IMPORTE ) ) ) 
				lnValorDelDecimal = this.Item[lni].IMPORTE - int( this.Item[lni].IMPORTE )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo IMPORTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo IMPORTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].SELECCIONADA) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo SELECCIONADA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Idseniacancelada = toItemOrigen.Idseniacancelada
		toItemDestino.Cliente_PK = toItemOrigen.Cliente_PK
		toItemDestino.Clientedetalle = toItemOrigen.Clientedetalle
		toItemDestino.Comprobante = toItemOrigen.Comprobante
		toItemDestino.Fechaalta = toItemOrigen.Fechaalta
		toItemDestino.Fechavto = toItemOrigen.Fechavto
		toItemDestino.Importe = toItemOrigen.Importe
		toItemDestino.Seleccionada = toItemOrigen.Seleccionada
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
		lcRetorno = 'Cliente_pk'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Nroitem = 0
	Codigo = []
	Idseniacancelada = []
	Cliente_PK = []
	Clientedetalle = []
	Comprobante = []
	Fechaalta = ctod( '  /  /    ' )
	Fechavto = ctod( '  /  /    ' )
	Importe = 0
	Seleccionada = .F.
	NroItem = 0

enddefine