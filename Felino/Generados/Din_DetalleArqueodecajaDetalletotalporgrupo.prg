
define class Din_DetalleARQUEODECAJADetalletotalporgrupo as detalle of detalle.prg


	nCantidadItems = 999
	cNombre = 'Detalletotalporgrupo'
	cEtiqueta = 'Total por grupo'
	cMensajeErrorUnicidad = 'La columna  no admite valores repetidos.'
	cNombreVisual = 'Total por grupo'

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
			
				.Agrupa = this.Item[ tnItem ].Agrupa
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Agrupa', .Agrupa )
			
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.AgrupaDesc = this.Item[ tnItem ].AgrupaDesc
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'AgrupaDesc', .AgrupaDesc )
			
				.TotalGrupo = this.Item[ tnItem ].TotalGrupo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TotalGrupo', .TotalGrupo )
			
				.Arqueado = this.Item[ tnItem ].Arqueado
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Arqueado', .Arqueado )
			
				.DifGrupo = this.Item[ tnItem ].DifGrupo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'DifGrupo', .DifGrupo )
			
				.ArqueadoEfec = this.Item[ tnItem ].ArqueadoEfec
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ArqueadoEfec', .ArqueadoEfec )
			
				.ArqueadoOtros = this.Item[ tnItem ].ArqueadoOtros
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ArqueadoOtros', .ArqueadoOtros )
			
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
			.Agrupa = this.oItem.Agrupa
			.NROITEM = this.oItem.NROITEM
			.AgrupaDesc = this.oItem.AgrupaDesc
			.TotalGrupo = this.oItem.TotalGrupo
			.Arqueado = this.oItem.Arqueado
			.DifGrupo = this.oItem.DifGrupo
			.ArqueadoEfec = this.oItem.ArqueadoEfec
			.ArqueadoOtros = this.oItem.ArqueadoOtros
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
			.Item[ lnItem ].Agrupa = .oItem.Agrupa
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].AgrupaDesc = .oItem.AgrupaDesc
			.Item[ lnItem ].TotalGrupo = .oItem.TotalGrupo
			.Item[ lnItem ].Arqueado = .oItem.Arqueado
			.Item[ lnItem ].DifGrupo = .oItem.DifGrupo
			.Item[ lnItem ].ArqueadoEfec = .oItem.ArqueadoEfec
			.Item[ lnItem ].ArqueadoOtros = .oItem.ArqueadoOtros
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'ItemARQUEODECAJADetalletotalporgrupo' )
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

		select c_Detalletotalporgrupo
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Codigo = c_Detalletotalporgrupo.Codigo
			loItem.Agrupa = c_Detalletotalporgrupo.Agrupa
			loItem.NROITEM = c_Detalletotalporgrupo.NROITEM
			loItem.AgrupaDesc = c_Detalletotalporgrupo.AgrupaDesc
			loItem.TotalGrupo = c_Detalletotalporgrupo.TotalGrupo
			loItem.Arqueado = c_Detalletotalporgrupo.Arqueado
			loItem.DifGrupo = c_Detalletotalporgrupo.DifGrupo
			loItem.ArqueadoEfec = c_Detalletotalporgrupo.ArqueadoEfec
			loItem.ArqueadoOtros = c_Detalletotalporgrupo.ArqueadoOtros
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

		if  empty( this.item[ tnItem ].Agrupa ) 
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
			
			if vartype( this.Item[lni].AGRUPA) = 'C'
				if len( alltrim( this.Item[lni].AGRUPA )) <= 5
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo AGRUPA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].AGRUPA ))) + ' Máxima:5), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo AGRUPA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].AGRUPADESC) = 'C'
				if len( alltrim( this.Item[lni].AGRUPADESC )) <= 50
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo AGRUPADESC del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].AGRUPADESC ))) + ' Máxima:50), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo AGRUPADESC del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TOTALGRUPO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].TOTALGRUPO ) ) ) 
				lnValorDelDecimal = this.Item[lni].TOTALGRUPO - int( this.Item[lni].TOTALGRUPO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo TOTALGRUPO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TOTALGRUPO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ARQUEADO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].ARQUEADO ) ) ) 
				lnValorDelDecimal = this.Item[lni].ARQUEADO - int( this.Item[lni].ARQUEADO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo ARQUEADO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ARQUEADO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].DIFGRUPO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].DIFGRUPO ) ) ) 
				lnValorDelDecimal = this.Item[lni].DIFGRUPO - int( this.Item[lni].DIFGRUPO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo DIFGRUPO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo DIFGRUPO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ARQUEADOEFEC) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].ARQUEADOEFEC ) ) ) 
				lnValorDelDecimal = this.Item[lni].ARQUEADOEFEC - int( this.Item[lni].ARQUEADOEFEC )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo ARQUEADOEFEC del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ARQUEADOEFEC del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ARQUEADOOTROS) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].ARQUEADOOTROS ) ) ) 
				lnValorDelDecimal = this.Item[lni].ARQUEADOOTROS - int( this.Item[lni].ARQUEADOOTROS )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo ARQUEADOOTROS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ARQUEADOOTROS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Agrupa = toItemOrigen.Agrupa
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Agrupadesc = toItemOrigen.Agrupadesc
		toItemDestino.Totalgrupo = toItemOrigen.Totalgrupo
		toItemDestino.Arqueado = toItemOrigen.Arqueado
		toItemDestino.Difgrupo = toItemOrigen.Difgrupo
		toItemDestino.Arqueadoefec = toItemOrigen.Arqueadoefec
		toItemDestino.Arqueadootros = toItemOrigen.Arqueadootros
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
	Agrupa = []
	Nroitem = 0
	Agrupadesc = []
	Totalgrupo = 0
	Arqueado = 0
	Difgrupo = 0
	Arqueadoefec = 0
	Arqueadootros = 0
	NroItem = 0

enddefine