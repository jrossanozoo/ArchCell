
define class Din_DetalleECOMMERCEEquivaloresdetalle as detalle of detalle.prg


	cAtributosUnicidad = 'ValorEcommerce'
	nCantidadItems = 999
	cNombre = 'Equivaloresdetalle'
	cEtiqueta = 'Equivalencias de valores'
	cMensajeErrorUnicidad = 'La columna Código de valor ecommerce no admite valores repetidos.'
	cNombreVisual = 'Equivalencias de valores'

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
			
				.ValorEcommerce = this.Item[ tnItem ].ValorEcommerce
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ValorEcommerce', .ValorEcommerce )
			
				.TipoValorEcommerce = this.Item[ tnItem ].TipoValorEcommerce
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TipoValorEcommerce', .TipoValorEcommerce )
			
				.ValorDragonfish_PK = this.Item[ tnItem ].ValorDragonfish_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ValorDragonfish_PK', .ValorDragonfish_PK )
			
				.ValorDescripcion = this.Item[ tnItem ].ValorDescripcion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ValorDescripcion', .ValorDescripcion )
			
				.TipoValorDragon = this.Item[ tnItem ].TipoValorDragon
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TipoValorDragon', .TipoValorDragon )
			
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
			.ValorEcommerce = this.oItem.ValorEcommerce
			.TipoValorEcommerce = this.oItem.TipoValorEcommerce
			.ValorDragonfish_PK = this.oItem.ValorDragonfish_PK
			.ValorDescripcion = this.oItem.ValorDescripcion
			.TipoValorDragon = this.oItem.TipoValorDragon
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
			.Item[ lnItem ].ValorEcommerce = .oItem.ValorEcommerce
			.Item[ lnItem ].TipoValorEcommerce = .oItem.TipoValorEcommerce
			.Item[ lnItem ].ValorDragonfish_PK = .oItem.ValorDragonfish_PK
			.Item[ lnItem ].ValorDescripcion = .oItem.ValorDescripcion
			.Item[ lnItem ].TipoValorDragon = .oItem.TipoValorDragon
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemECOMMERCEEquivaloresdetalle' )
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

		select c_Equivaloresdetalle
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.NROITEM = c_Equivaloresdetalle.NROITEM
			loItem.Codigo = c_Equivaloresdetalle.Codigo
			loItem.ValorEcommerce = c_Equivaloresdetalle.ValorEcommerce
			loItem.TipoValorEcommerce = c_Equivaloresdetalle.TipoValorEcommerce
			loItem.ValorDragonfish_PK = c_Equivaloresdetalle.ValorDragonfish
			loItem.ValorDescripcion = c_Equivaloresdetalle.ValorDescripcion
			loItem.TipoValorDragon = c_Equivaloresdetalle.TipoValorDragon
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

		if  empty( this.item[ tnItem ].Valorecommerce ) 
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
			
			if vartype( this.Item[lni].VALORECOMMERCE) = 'C'
				if len( alltrim( this.Item[lni].VALORECOMMERCE )) <= 30
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo VALORECOMMERCE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].VALORECOMMERCE ))) + ' Máxima:30), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo VALORECOMMERCE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TIPOVALORECOMMERCE) = 'C'
				if len( alltrim( this.Item[lni].TIPOVALORECOMMERCE )) <= 30
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TIPOVALORECOMMERCE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TIPOVALORECOMMERCE ))) + ' Máxima:30), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TIPOVALORECOMMERCE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].VALORDRAGONFISH_PK) = 'C'
				if len( alltrim( this.Item[lni].VALORDRAGONFISH_PK )) <= 5
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo VALORDRAGONFISH del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].VALORDRAGONFISH_PK ))) + ' Máxima:5), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo VALORDRAGONFISH del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].VALORDESCRIPCION) = 'C'
				if len( alltrim( this.Item[lni].VALORDESCRIPCION )) <= 40
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo VALORDESCRIPCION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].VALORDESCRIPCION ))) + ' Máxima:40), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo VALORDESCRIPCION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TIPOVALORDRAGON) = 'C'
				if len( alltrim( this.Item[lni].TIPOVALORDRAGON )) <= 30
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TIPOVALORDRAGON del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TIPOVALORDRAGON ))) + ' Máxima:30), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TIPOVALORDRAGON del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Valorecommerce = toItemOrigen.Valorecommerce
		toItemDestino.Tipovalorecommerce = toItemOrigen.Tipovalorecommerce
		toItemDestino.Valordragonfish_PK = toItemOrigen.Valordragonfish_PK
		toItemDestino.Valordescripcion = toItemOrigen.Valordescripcion
		toItemDestino.Tipovalordragon = toItemOrigen.Tipovalordragon
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
		lcRetorno = 'ValorEcommerce'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Nroitem = 0
	Codigo = []
	Valorecommerce = []
	Tipovalorecommerce = []
	Valordragonfish_PK = []
	Valordescripcion = []
	Tipovalordragon = []
	NroItem = 0

enddefine