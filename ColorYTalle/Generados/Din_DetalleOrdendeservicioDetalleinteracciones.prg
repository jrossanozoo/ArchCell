
define class Din_DetalleORDENDESERVICIODetalleinteracciones as detalle of detalle.prg


	nCantidadItems = 999
	cNombre = 'Detalleinteracciones'
	cEtiqueta = 'Historial de interacciones'
	cMensajeErrorUnicidad = 'La columna  no admite valores repetidos.'
	cNombreVisual = 'Historial de interacciones'

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
				.Fecha = this.Item[ tnItem ].Fecha
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Fecha', .Fecha )
			
				.Numero = this.Item[ tnItem ].Numero
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Numero', .Numero )
			
				.Descri = this.Item[ tnItem ].Descri
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Descri', .Descri )
			
				.Vendedor = this.Item[ tnItem ].Vendedor
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Vendedor', .Vendedor )
			
				.Estado = this.Item[ tnItem ].Estado
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Estado', .Estado )
			
				.TipoDescuento = this.Item[ tnItem ].TipoDescuento
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TipoDescuento', .TipoDescuento )
			
				.Valor = this.Item[ tnItem ].Valor
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Valor', .Valor )
			
				.Codigo = this.Item[ tnItem ].Codigo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Codigo', .Codigo )
			
				.Hora = this.Item[ tnItem ].Hora
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Hora', .Hora )
			
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
			.Fecha = this.oItem.Fecha
			.Numero = this.oItem.Numero
			.Descri = this.oItem.Descri
			.Vendedor = this.oItem.Vendedor
			.Estado = this.oItem.Estado
			.TipoDescuento = this.oItem.TipoDescuento
			.Valor = this.oItem.Valor
			.Codigo = this.oItem.Codigo
			.Hora = this.oItem.Hora
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
			.Item[ lnItem ].Fecha = .oItem.Fecha
			.Item[ lnItem ].Numero = .oItem.Numero
			.Item[ lnItem ].Descri = .oItem.Descri
			.Item[ lnItem ].Vendedor = .oItem.Vendedor
			.Item[ lnItem ].Estado = .oItem.Estado
			.Item[ lnItem ].TipoDescuento = .oItem.TipoDescuento
			.Item[ lnItem ].Valor = .oItem.Valor
			.Item[ lnItem ].Codigo = .oItem.Codigo
			.Item[ lnItem ].Hora = .oItem.Hora
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemORDENDESERVICIODetalleinteracciones' )
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

		select c_Detalleinteracciones
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

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

		return llRetorno

	endfunc


	*-----------------------------------------------------------------------------------------
	Function ValidarFormatoAtributos() as boolean
	local lnLargoEntero as integer, lnValorDelDecimal as integer, lnLargoDecimal as integer, llRetorno as boolean, lnI as Integer

		llRetorno = dodefault()
		for lni = 1 to this.Count
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
		toItemDestino.Fecha = toItemOrigen.Fecha
		toItemDestino.Numero = toItemOrigen.Numero
		toItemDestino.Descri = toItemOrigen.Descri
		toItemDestino.Vendedor = toItemOrigen.Vendedor
		toItemDestino.Estado = toItemOrigen.Estado
		toItemDestino.Tipodescuento = toItemOrigen.Tipodescuento
		toItemDestino.Valor = toItemOrigen.Valor
		toItemDestino.Codigo = toItemOrigen.Codigo
		toItemDestino.Hora = toItemOrigen.Hora
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

	Fecha = ctod( '  /  /    ' )
	Numero = []
	Descri = []
	Vendedor = []
	Estado = []
	Tipodescuento = []
	Valor = 0
	Codigo = []
	Hora = []
	NroItem = 0

enddefine