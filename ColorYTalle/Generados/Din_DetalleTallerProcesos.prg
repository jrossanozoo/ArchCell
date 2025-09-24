
define class Din_DetalleTALLERProcesos as detalle of detalle.prg


	nCantidadItems = 999
	cNombre = 'Procesos'
	cEtiqueta = 'Procesos'
	cMensajeErrorUnicidad = 'La columna  no admite valores repetidos.'
	cNombreVisual = 'Procesos'

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
			
				.Proceso_PK = this.Item[ tnItem ].Proceso_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Proceso_PK', .Proceso_PK )
			
				.ProcesoDescripcion = this.Item[ tnItem ].ProcesoDescripcion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ProcesoDescripcion', .ProcesoDescripcion )
			
				.InventarioEntrada_PK = this.Item[ tnItem ].InventarioEntrada_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'InventarioEntrada_PK', .InventarioEntrada_PK )
			
				.InventarioSalida_PK = this.Item[ tnItem ].InventarioSalida_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'InventarioSalida_PK', .InventarioSalida_PK )
			
				.ListaDeCosto_PK = this.Item[ tnItem ].ListaDeCosto_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ListaDeCosto_PK', .ListaDeCosto_PK )
			
				.InsumoEnLiquidacion = this.Item[ tnItem ].InsumoEnLiquidacion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'InsumoEnLiquidacion', .InsumoEnLiquidacion )
			
				.DescarteEnLiquidacion = this.Item[ tnItem ].DescarteEnLiquidacion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'DescarteEnLiquidacion', .DescarteEnLiquidacion )
			
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
			.Proceso_PK = this.oItem.Proceso_PK
			.ProcesoDescripcion = this.oItem.ProcesoDescripcion
			.InventarioEntrada_PK = this.oItem.InventarioEntrada_PK
			.InventarioSalida_PK = this.oItem.InventarioSalida_PK
			.ListaDeCosto_PK = this.oItem.ListaDeCosto_PK
			.InsumoEnLiquidacion = this.oItem.InsumoEnLiquidacion
			.DescarteEnLiquidacion = this.oItem.DescarteEnLiquidacion
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
			.Item[ lnItem ].Proceso_PK = .oItem.Proceso_PK
			.Item[ lnItem ].ProcesoDescripcion = .oItem.ProcesoDescripcion
			.Item[ lnItem ].InventarioEntrada_PK = .oItem.InventarioEntrada_PK
			.Item[ lnItem ].InventarioSalida_PK = .oItem.InventarioSalida_PK
			.Item[ lnItem ].ListaDeCosto_PK = .oItem.ListaDeCosto_PK
			.Item[ lnItem ].InsumoEnLiquidacion = .oItem.InsumoEnLiquidacion
			.Item[ lnItem ].DescarteEnLiquidacion = .oItem.DescarteEnLiquidacion
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemTALLERProcesos' )
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

		select c_Procesos
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Codigo = c_Procesos.Codigo
			loItem.NROITEM = c_Procesos.NROITEM
			loItem.Proceso_PK = c_Procesos.Proceso
			loItem.ProcesoDescripcion = c_Procesos.ProcesoDescripcion
			loItem.InventarioEntrada_PK = c_Procesos.InventarioEntrada
			loItem.InventarioSalida_PK = c_Procesos.InventarioSalida
			loItem.ListaDeCosto_PK = c_Procesos.ListaDeCosto
			loItem.InsumoEnLiquidacion = c_Procesos.InsumoEnLiquidacion
			loItem.DescarteEnLiquidacion = c_Procesos.DescarteEnLiquidacion
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

		if  empty( this.item[ tnItem ].Proceso_PK ) 
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
				if len( alltrim( this.Item[lni].CODIGO )) <= 15
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGO ))) + ' Máxima:15), en el detalle ' + this.cEtiqueta + '.' )
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
			
			if vartype( this.Item[lni].PROCESO_PK) = 'C'
				if len( alltrim( this.Item[lni].PROCESO_PK )) <= 15
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo PROCESO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].PROCESO_PK ))) + ' Máxima:15), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PROCESO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PROCESODESCRIPCION) = 'C'
				if len( alltrim( this.Item[lni].PROCESODESCRIPCION )) <= 250
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo PROCESODESCRIPCION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].PROCESODESCRIPCION ))) + ' Máxima:250), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PROCESODESCRIPCION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].INVENTARIOENTRADA_PK) = 'C'
				if len( alltrim( this.Item[lni].INVENTARIOENTRADA_PK )) <= 15
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo INVENTARIOENTRADA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].INVENTARIOENTRADA_PK ))) + ' Máxima:15), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo INVENTARIOENTRADA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].INVENTARIOSALIDA_PK) = 'C'
				if len( alltrim( this.Item[lni].INVENTARIOSALIDA_PK )) <= 15
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo INVENTARIOSALIDA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].INVENTARIOSALIDA_PK ))) + ' Máxima:15), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo INVENTARIOSALIDA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].LISTADECOSTO_PK) = 'C'
				if len( alltrim( this.Item[lni].LISTADECOSTO_PK )) <= 6
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo LISTADECOSTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].LISTADECOSTO_PK ))) + ' Máxima:6), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo LISTADECOSTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].INSUMOENLIQUIDACION) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].INSUMOENLIQUIDACION ) ) ) 
				lnValorDelDecimal = this.Item[lni].INSUMOENLIQUIDACION - int( this.Item[lni].INSUMOENLIQUIDACION )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo INSUMOENLIQUIDACION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo INSUMOENLIQUIDACION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].DESCARTEENLIQUIDACION) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].DESCARTEENLIQUIDACION ) ) ) 
				lnValorDelDecimal = this.Item[lni].DESCARTEENLIQUIDACION - int( this.Item[lni].DESCARTEENLIQUIDACION )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo DESCARTEENLIQUIDACION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo DESCARTEENLIQUIDACION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Proceso_PK = toItemOrigen.Proceso_PK
		toItemDestino.Procesodescripcion = toItemOrigen.Procesodescripcion
		toItemDestino.Inventarioentrada_PK = toItemOrigen.Inventarioentrada_PK
		toItemDestino.Inventariosalida_PK = toItemOrigen.Inventariosalida_PK
		toItemDestino.Listadecosto_PK = toItemOrigen.Listadecosto_PK
		toItemDestino.Insumoenliquidacion = toItemOrigen.Insumoenliquidacion
		toItemDestino.Descarteenliquidacion = toItemOrigen.Descarteenliquidacion
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
		lcRetorno = 'Proceso_pk'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Codigo = []
	Nroitem = 0
	Proceso_PK = []
	Procesodescripcion = []
	Inventarioentrada_PK = []
	Inventariosalida_PK = []
	Listadecosto_PK = []
	Insumoenliquidacion = 0
	Descarteenliquidacion = 0
	NroItem = 0

enddefine