
define class Din_DetallePROCESARNCPENDIENTEPROMOBANCOCuponespendientes as detalle of detalle.prg


	nCantidadItems = 999
	cNombre = 'Cuponespendientes'
	cEtiqueta = 'Cupones pendientes'
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
			
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.IdAjuste = this.Item[ tnItem ].IdAjuste
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'IdAjuste', .IdAjuste )
			
				.IdCupon = this.Item[ tnItem ].IdCupon
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'IdCupon', .IdCupon )
			
				.IdFactura = this.Item[ tnItem ].IdFactura
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'IdFactura', .IdFactura )
			
				.LetraFactura = this.Item[ tnItem ].LetraFactura
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'LetraFactura', .LetraFactura )
			
				.PuntoDeVentaFactura = this.Item[ tnItem ].PuntoDeVentaFactura
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PuntoDeVentaFactura', .PuntoDeVentaFactura )
			
				.NumeroFactura = this.Item[ tnItem ].NumeroFactura
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumeroFactura', .NumeroFactura )
			
				.ComprobanteOrigen = this.Item[ tnItem ].ComprobanteOrigen
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ComprobanteOrigen', .ComprobanteOrigen )
			
				.Fecha = this.Item[ tnItem ].Fecha
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Fecha', .Fecha )
			
				.Caja = this.Item[ tnItem ].Caja
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Caja', .Caja )
			
				.NotaDeCredito = this.Item[ tnItem ].NotaDeCredito
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NotaDeCredito', .NotaDeCredito )
			
				.IdCliente = this.Item[ tnItem ].IdCliente
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'IdCliente', .IdCliente )
			
				.ClienteDescripcion = this.Item[ tnItem ].ClienteDescripcion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ClienteDescripcion', .ClienteDescripcion )
			
				.MontoAjuste = this.Item[ tnItem ].MontoAjuste
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoAjuste', .MontoAjuste )
			
				.FactTipo = this.Item[ tnItem ].FactTipo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'FactTipo', .FactTipo )
			
				.Vendedor = this.Item[ tnItem ].Vendedor
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Vendedor', .Vendedor )
			
				.Seleccion = this.Item[ tnItem ].Seleccion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Seleccion', .Seleccion )
			
				.TipoNotaDeCredito = this.Item[ tnItem ].TipoNotaDeCredito
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TipoNotaDeCredito', .TipoNotaDeCredito )
			
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
			.IdAjuste = this.oItem.IdAjuste
			.IdCupon = this.oItem.IdCupon
			.IdFactura = this.oItem.IdFactura
			.LetraFactura = this.oItem.LetraFactura
			.PuntoDeVentaFactura = this.oItem.PuntoDeVentaFactura
			.NumeroFactura = this.oItem.NumeroFactura
			.ComprobanteOrigen = this.oItem.ComprobanteOrigen
			.Fecha = this.oItem.Fecha
			.Caja = this.oItem.Caja
			.NotaDeCredito = this.oItem.NotaDeCredito
			.IdCliente = this.oItem.IdCliente
			.ClienteDescripcion = this.oItem.ClienteDescripcion
			.MontoAjuste = this.oItem.MontoAjuste
			.FactTipo = this.oItem.FactTipo
			.Vendedor = this.oItem.Vendedor
			.Seleccion = this.oItem.Seleccion
			.TipoNotaDeCredito = this.oItem.TipoNotaDeCredito
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
			.Item[ lnItem ].IdAjuste = .oItem.IdAjuste
			.Item[ lnItem ].IdCupon = .oItem.IdCupon
			.Item[ lnItem ].IdFactura = .oItem.IdFactura
			.Item[ lnItem ].LetraFactura = .oItem.LetraFactura
			.Item[ lnItem ].PuntoDeVentaFactura = .oItem.PuntoDeVentaFactura
			.Item[ lnItem ].NumeroFactura = .oItem.NumeroFactura
			.Item[ lnItem ].ComprobanteOrigen = .oItem.ComprobanteOrigen
			.Item[ lnItem ].Fecha = .oItem.Fecha
			.Item[ lnItem ].Caja = .oItem.Caja
			.Item[ lnItem ].NotaDeCredito = .oItem.NotaDeCredito
			.Item[ lnItem ].IdCliente = .oItem.IdCliente
			.Item[ lnItem ].ClienteDescripcion = .oItem.ClienteDescripcion
			.Item[ lnItem ].MontoAjuste = .oItem.MontoAjuste
			.Item[ lnItem ].FactTipo = .oItem.FactTipo
			.Item[ lnItem ].Vendedor = .oItem.Vendedor
			.Item[ lnItem ].Seleccion = .oItem.Seleccion
			.Item[ lnItem ].TipoNotaDeCredito = .oItem.TipoNotaDeCredito
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemPROCESARNCPENDIENTEPROMOBANCOCuponespendientes' )
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

		select c_Cuponespendientes
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Codigo = c_Cuponespendientes.Codigo
			loItem.NROITEM = c_Cuponespendientes.NROITEM
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

		if  empty( this.item[ tnItem ].Codigo ) 
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
		toItemDestino.Idajuste = toItemOrigen.Idajuste
		toItemDestino.Idcupon = toItemOrigen.Idcupon
		toItemDestino.Idfactura = toItemOrigen.Idfactura
		toItemDestino.Letrafactura = toItemOrigen.Letrafactura
		toItemDestino.Puntodeventafactura = toItemOrigen.Puntodeventafactura
		toItemDestino.Numerofactura = toItemOrigen.Numerofactura
		toItemDestino.Comprobanteorigen = toItemOrigen.Comprobanteorigen
		toItemDestino.Fecha = toItemOrigen.Fecha
		toItemDestino.Caja = toItemOrigen.Caja
		toItemDestino.Notadecredito = toItemOrigen.Notadecredito
		toItemDestino.Idcliente = toItemOrigen.Idcliente
		toItemDestino.Clientedescripcion = toItemOrigen.Clientedescripcion
		toItemDestino.Montoajuste = toItemOrigen.Montoajuste
		toItemDestino.Facttipo = toItemOrigen.Facttipo
		toItemDestino.Vendedor = toItemOrigen.Vendedor
		toItemDestino.Seleccion = toItemOrigen.Seleccion
		toItemDestino.Tiponotadecredito = toItemOrigen.Tiponotadecredito
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

	Codigo = []
	Nroitem = 0
	Idajuste = []
	Idcupon = []
	Idfactura = []
	Letrafactura = []
	Puntodeventafactura = 0
	Numerofactura = 0
	Comprobanteorigen = []
	Fecha = ctod( '  /  /    ' )
	Caja = 0
	Notadecredito = []
	Idcliente = []
	Clientedescripcion = []
	Montoajuste = 0
	Facttipo = 0
	Vendedor = []
	Seleccion = .F.
	Tiponotadecredito = 0
	NroItem = 0

enddefine