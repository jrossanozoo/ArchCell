
define class Din_DetalleGESTIONCHCUSTODIADetallechcustodia as detalle of detalle.prg


	nCantidadItems = 999
	cNombre = 'Detallechcustodia'
	cEtiqueta = 'Cheques en custodia'
	cMensajeErrorUnicidad = 'La columna  no admite valores repetidos.'
	cNombreVisual = 'Cheques en custodia'

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
				.Message = 'El item est� fuera del rango'
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
			
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.Registro = this.Item[ tnItem ].Registro
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Registro', .Registro )
			
				.NumeroInterno = this.Item[ tnItem ].NumeroInterno
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumeroInterno', .NumeroInterno )
			
				.EntidadFinanciera_PK = this.Item[ tnItem ].EntidadFinanciera_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'EntidadFinanciera_PK', .EntidadFinanciera_PK )
			
				.EntidadFinancieraDescripcion = this.Item[ tnItem ].EntidadFinancieraDescripcion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'EntidadFinancieraDescripcion', .EntidadFinancieraDescripcion )
			
				.Numero = this.Item[ tnItem ].Numero
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Numero', .Numero )
			
				.FechaEmision = this.Item[ tnItem ].FechaEmision
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'FechaEmision', .FechaEmision )
			
				.FechaPago = this.Item[ tnItem ].FechaPago
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'FechaPago', .FechaPago )
			
				.CUITLibrador = this.Item[ tnItem ].CUITLibrador
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CUITLibrador', .CUITLibrador )
			
				.Cliente_PK = this.Item[ tnItem ].Cliente_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Cliente_PK', .Cliente_PK )
			
				.ClienteDescripcion = this.Item[ tnItem ].ClienteDescripcion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ClienteDescripcion', .ClienteDescripcion )
			
				.Monto = this.Item[ tnItem ].Monto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Monto', .Monto )
			
				.Seleccion = this.Item[ tnItem ].Seleccion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Seleccion', .Seleccion )
			
				.Estado = this.Item[ tnItem ].Estado
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Estado', .Estado )
			
				.IDCheque_PK = this.Item[ tnItem ].IDCheque_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'IDCheque_PK', .IDCheque_PK )
			
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
			.NROITEM = this.oItem.NROITEM
			.Registro = this.oItem.Registro
			.NumeroInterno = this.oItem.NumeroInterno
			.EntidadFinanciera_PK = this.oItem.EntidadFinanciera_PK
			.EntidadFinancieraDescripcion = this.oItem.EntidadFinancieraDescripcion
			.Numero = this.oItem.Numero
			.FechaEmision = this.oItem.FechaEmision
			.FechaPago = this.oItem.FechaPago
			.CUITLibrador = this.oItem.CUITLibrador
			.Cliente_PK = this.oItem.Cliente_PK
			.ClienteDescripcion = this.oItem.ClienteDescripcion
			.Monto = this.oItem.Monto
			.Seleccion = this.oItem.Seleccion
			.Estado = this.oItem.Estado
			.IDCheque_PK = this.oItem.IDCheque_PK
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
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].Registro = .oItem.Registro
			.Item[ lnItem ].NumeroInterno = .oItem.NumeroInterno
			.Item[ lnItem ].EntidadFinanciera_PK = .oItem.EntidadFinanciera_PK
			.Item[ lnItem ].EntidadFinancieraDescripcion = .oItem.EntidadFinancieraDescripcion
			.Item[ lnItem ].Numero = .oItem.Numero
			.Item[ lnItem ].FechaEmision = .oItem.FechaEmision
			.Item[ lnItem ].FechaPago = .oItem.FechaPago
			.Item[ lnItem ].CUITLibrador = .oItem.CUITLibrador
			.Item[ lnItem ].Cliente_PK = .oItem.Cliente_PK
			.Item[ lnItem ].ClienteDescripcion = .oItem.ClienteDescripcion
			.Item[ lnItem ].Monto = .oItem.Monto
			.Item[ lnItem ].Seleccion = .oItem.Seleccion
			.Item[ lnItem ].Estado = .oItem.Estado
			.Item[ lnItem ].IDCheque_PK = .oItem.IDCheque_PK
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'ItemGESTIONCHCUSTODIADetallechcustodia' )
			this.enlazar( 'oItem.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oItem.EventoObtenerInformacion', 'inyectarInformacion' )
			this.oItem.inicializar()
			bindevent( this.oItem, 'EventoDespuesDeSetear', this, 'ValidarCantidadDeItemsEnDetalle' )
		endif
		return this.oItem
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Cargar() as Void
		local loItem as object, lnI as integer, lcClave as string, lcFiltro as String 
		lnI = 1

		select c_Detallechcustodia
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Codigo = c_Detallechcustodia.Codigo
			loItem.NROITEM = c_Detallechcustodia.NROITEM
			loItem.Registro = c_Detallechcustodia.Registro
			loItem.NumeroInterno = c_Detallechcustodia.NumeroInterno
			loItem.Estado = c_Detallechcustodia.Estado
			loItem.IDCheque_PK = c_Detallechcustodia.IDCheque
			loItem.NroItem = lnI 
			this.AgregarItemPlano( loItem )
			lnI = lnI + 1
		endscan

		this.CambioSumarizado()

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
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGO ))) + ' M�xima:38), en el detalle ' + this.cEtiqueta + '.' )
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
					this.AgregarInformacion( 'La longitud entera del valor del atributo NROITEM del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' M�xima:5), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NROITEM del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].REGISTRO) = 'C'
				if len( alltrim( this.Item[lni].REGISTRO )) <= 20
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo REGISTRO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].REGISTRO ))) + ' M�xima:20), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo REGISTRO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NUMEROINTERNO) = 'C'
				if len( alltrim( this.Item[lni].NUMEROINTERNO )) <= 15
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo NUMEROINTERNO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].NUMEROINTERNO ))) + ' M�xima:15), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NUMEROINTERNO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ESTADO) = 'C'
				if len( alltrim( this.Item[lni].ESTADO )) <= 5
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo ESTADO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].ESTADO ))) + ' M�xima:5), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ESTADO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].IDCHEQUE_PK) = 'C'
				if len( alltrim( this.Item[lni].IDCHEQUE_PK )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo IDCHEQUE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].IDCHEQUE_PK ))) + ' M�xima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo IDCHEQUE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Registro = toItemOrigen.Registro
		toItemDestino.Numerointerno = toItemOrigen.Numerointerno
		toItemDestino.Entidadfinanciera_PK = toItemOrigen.Entidadfinanciera_PK
		toItemDestino.Entidadfinancieradescripcion = toItemOrigen.Entidadfinancieradescripcion
		toItemDestino.Numero = toItemOrigen.Numero
		toItemDestino.Fechaemision = toItemOrigen.Fechaemision
		toItemDestino.Fechapago = toItemOrigen.Fechapago
		toItemDestino.Cuitlibrador = toItemOrigen.Cuitlibrador
		toItemDestino.Cliente_PK = toItemOrigen.Cliente_PK
		toItemDestino.Clientedescripcion = toItemOrigen.Clientedescripcion
		toItemDestino.Monto = toItemOrigen.Monto
		toItemDestino.Seleccion = toItemOrigen.Seleccion
		toItemDestino.Estado = toItemOrigen.Estado
		toItemDestino.Idcheque_PK = toItemOrigen.Idcheque_PK
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
	Nroitem = 0
	Registro = []
	Numerointerno = []
	Entidadfinanciera_PK = []
	Entidadfinancieradescripcion = []
	Numero = 0
	Fechaemision = ctod( '  /  /    ' )
	Fechapago = ctod( '  /  /    ' )
	Cuitlibrador = []
	Cliente_PK = []
	Clientedescripcion = []
	Monto = 0
	Seleccion = .F.
	Estado = []
	Idcheque_PK = []
	NroItem = 0

enddefine