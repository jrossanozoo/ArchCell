
define class Din_DetalleVENDEDORComisionesdetalle as detalle of detalle.prg


	nCantidadItems = 999
	cNombre = 'Comisionesdetalle'
	cEtiqueta = 'Comisiones'
	cMensajeErrorUnicidad = 'La columna  no admite valores repetidos.'
	cNombreVisual = 'Comisiones'

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
			
				.Comision_PK = this.Item[ tnItem ].Comision_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Comision_PK', .Comision_PK )
			
				.Descripcion = this.Item[ tnItem ].Descripcion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Descripcion', .Descripcion )
			
				.FechaModificacion = this.Item[ tnItem ].FechaModificacion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'FechaModificacion', .FechaModificacion )
			
				.HoraModificacion = this.Item[ tnItem ].HoraModificacion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'HoraModificacion', .HoraModificacion )
			
				.VigenciaDesde = this.Item[ tnItem ].VigenciaDesde
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'VigenciaDesde', .VigenciaDesde )
			
				.VigenciaHasta = this.Item[ tnItem ].VigenciaHasta
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'VigenciaHasta', .VigenciaHasta )
			
				.Porcentaje = this.Item[ tnItem ].Porcentaje
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Porcentaje', .Porcentaje )
			
				.MontoFijo = this.Item[ tnItem ].MontoFijo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoFijo', .MontoFijo )
			
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
			.Comision_PK = this.oItem.Comision_PK
			.Descripcion = this.oItem.Descripcion
			.FechaModificacion = this.oItem.FechaModificacion
			.HoraModificacion = this.oItem.HoraModificacion
			.VigenciaDesde = this.oItem.VigenciaDesde
			.VigenciaHasta = this.oItem.VigenciaHasta
			.Porcentaje = this.oItem.Porcentaje
			.MontoFijo = this.oItem.MontoFijo
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
			.Item[ lnItem ].Comision_PK = .oItem.Comision_PK
			.Item[ lnItem ].Descripcion = .oItem.Descripcion
			.Item[ lnItem ].FechaModificacion = .oItem.FechaModificacion
			.Item[ lnItem ].HoraModificacion = .oItem.HoraModificacion
			.Item[ lnItem ].VigenciaDesde = .oItem.VigenciaDesde
			.Item[ lnItem ].VigenciaHasta = .oItem.VigenciaHasta
			.Item[ lnItem ].Porcentaje = .oItem.Porcentaje
			.Item[ lnItem ].MontoFijo = .oItem.MontoFijo
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemVENDEDORComisionesdetalle' )
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

		select c_Comisionesdetalle
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.NROITEM = c_Comisionesdetalle.NROITEM
			loItem.Codigo = c_Comisionesdetalle.Codigo
			loItem.Comision_PK = c_Comisionesdetalle.Comision
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

		if  empty( this.item[ tnItem ].Comision_PK ) 
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
				if len( alltrim( this.Item[lni].CODIGO )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGO ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].COMISION_PK) = 'C'
				if len( alltrim( this.Item[lni].COMISION_PK )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo COMISION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].COMISION_PK ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo COMISION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Comision_PK = toItemOrigen.Comision_PK
		toItemDestino.Descripcion = toItemOrigen.Descripcion
		toItemDestino.Fechamodificacion = toItemOrigen.Fechamodificacion
		toItemDestino.Horamodificacion = toItemOrigen.Horamodificacion
		toItemDestino.Vigenciadesde = toItemOrigen.Vigenciadesde
		toItemDestino.Vigenciahasta = toItemOrigen.Vigenciahasta
		toItemDestino.Porcentaje = toItemOrigen.Porcentaje
		toItemDestino.Montofijo = toItemOrigen.Montofijo
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
		lcRetorno = 'Comision_pk'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Nroitem = 0
	Codigo = []
	Comision_PK = []
	Descripcion = []
	Fechamodificacion = ctod( '  /  /    ' )
	Horamodificacion = []
	Vigenciadesde = ctod( '  /  /    ' )
	Vigenciahasta = ctod( '  /  /    ' )
	Porcentaje = 0
	Montofijo = 0
	NroItem = 0

enddefine