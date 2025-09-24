
define class Din_DetalleCONCILIACIONDECAJAConciliamovimiento as detalle of detalle.prg


	nCantidadItems = 999
	cNombre = 'Conciliamovimiento'
	cEtiqueta = 'Conciliamovimiento'
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
			
				.codigo = this.Item[ tnItem ].codigo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'codigo', .codigo )
			
				.TipoComprobante = this.Item[ tnItem ].TipoComprobante
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TipoComprobante', .TipoComprobante )
			
				.DescTipoComprobante = this.Item[ tnItem ].DescTipoComprobante
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'DescTipoComprobante', .DescTipoComprobante )
			
				.Valor_PK = this.Item[ tnItem ].Valor_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Valor_PK', .Valor_PK )
			
				.ValorDetalle = this.Item[ tnItem ].ValorDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ValorDetalle', .ValorDetalle )
			
				.SaldoAct = this.Item[ tnItem ].SaldoAct
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'SaldoAct', .SaldoAct )
			
				.SaldoProy = this.Item[ tnItem ].SaldoProy
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'SaldoProy', .SaldoProy )
			
				.Ajuste = this.Item[ tnItem ].Ajuste
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Ajuste', .Ajuste )
			
				.Descripcion = this.Item[ tnItem ].Descripcion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Descripcion', .Descripcion )
			
				.Accion = this.Item[ tnItem ].Accion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Accion', .Accion )
			
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
			.codigo = this.oItem.codigo
			.TipoComprobante = this.oItem.TipoComprobante
			.DescTipoComprobante = this.oItem.DescTipoComprobante
			.Valor_PK = this.oItem.Valor_PK
			.ValorDetalle = this.oItem.ValorDetalle
			.SaldoAct = this.oItem.SaldoAct
			.SaldoProy = this.oItem.SaldoProy
			.Ajuste = this.oItem.Ajuste
			.Descripcion = this.oItem.Descripcion
			.Accion = this.oItem.Accion
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
			.Item[ lnItem ].codigo = .oItem.codigo
			.Item[ lnItem ].TipoComprobante = .oItem.TipoComprobante
			.Item[ lnItem ].DescTipoComprobante = .oItem.DescTipoComprobante
			.Item[ lnItem ].Valor_PK = .oItem.Valor_PK
			.Item[ lnItem ].ValorDetalle = .oItem.ValorDetalle
			.Item[ lnItem ].SaldoAct = .oItem.SaldoAct
			.Item[ lnItem ].SaldoProy = .oItem.SaldoProy
			.Item[ lnItem ].Ajuste = .oItem.Ajuste
			.Item[ lnItem ].Descripcion = .oItem.Descripcion
			.Item[ lnItem ].Accion = .oItem.Accion
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemCONCILIACIONDECAJAConciliamovimiento' )
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

		select c_Conciliamovimiento
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.NROITEM = c_Conciliamovimiento.NROITEM
			loItem.codigo = c_Conciliamovimiento.codigo
			loItem.TipoComprobante = c_Conciliamovimiento.TipoComprobante
			loItem.DescTipoComprobante = c_Conciliamovimiento.DescTipoComprobante
			loItem.Valor_PK = c_Conciliamovimiento.Valor
			loItem.ValorDetalle = c_Conciliamovimiento.ValorDetalle
			loItem.SaldoAct = c_Conciliamovimiento.SaldoAct
			loItem.SaldoProy = c_Conciliamovimiento.SaldoProy
			loItem.Ajuste = c_Conciliamovimiento.Ajuste
			loItem.Descripcion = c_Conciliamovimiento.Descripcion
			loItem.Accion = c_Conciliamovimiento.Accion
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
			
			if vartype( this.Item[lni].TIPOCOMPROBANTE) = 'C'
				if len( alltrim( this.Item[lni].TIPOCOMPROBANTE )) <= 3
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TIPOCOMPROBANTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TIPOCOMPROBANTE ))) + ' Máxima:3), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TIPOCOMPROBANTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].DESCTIPOCOMPROBANTE) = 'C'
				if len( alltrim( this.Item[lni].DESCTIPOCOMPROBANTE )) <= 50
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo DESCTIPOCOMPROBANTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].DESCTIPOCOMPROBANTE ))) + ' Máxima:50), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo DESCTIPOCOMPROBANTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
				if len( alltrim( this.Item[lni].VALORDETALLE )) <= 30
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo VALORDETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].VALORDETALLE ))) + ' Máxima:30), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo VALORDETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].SALDOACT) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].SALDOACT ) ) ) 
				lnValorDelDecimal = this.Item[lni].SALDOACT - int( this.Item[lni].SALDOACT )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo SALDOACT del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo SALDOACT del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].SALDOPROY) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].SALDOPROY ) ) ) 
				lnValorDelDecimal = this.Item[lni].SALDOPROY - int( this.Item[lni].SALDOPROY )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo SALDOPROY del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo SALDOPROY del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].AJUSTE) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].AJUSTE ) ) ) 
				lnValorDelDecimal = this.Item[lni].AJUSTE - int( this.Item[lni].AJUSTE )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo AJUSTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo AJUSTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].DESCRIPCION) = 'C'
				if len( alltrim( this.Item[lni].DESCRIPCION )) <= 50
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo DESCRIPCION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].DESCRIPCION ))) + ' Máxima:50), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo DESCRIPCION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ACCION) = 'C'
				if len( alltrim( this.Item[lni].ACCION )) <= 1
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo ACCION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].ACCION ))) + ' Máxima:1), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ACCION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Tipocomprobante = toItemOrigen.Tipocomprobante
		toItemDestino.Desctipocomprobante = toItemOrigen.Desctipocomprobante
		toItemDestino.Valor_PK = toItemOrigen.Valor_PK
		toItemDestino.Valordetalle = toItemOrigen.Valordetalle
		toItemDestino.Saldoact = toItemOrigen.Saldoact
		toItemDestino.Saldoproy = toItemOrigen.Saldoproy
		toItemDestino.Ajuste = toItemOrigen.Ajuste
		toItemDestino.Descripcion = toItemOrigen.Descripcion
		toItemDestino.Accion = toItemOrigen.Accion
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

	Nroitem = 0
	Codigo = []
	Tipocomprobante = []
	Desctipocomprobante = []
	Valor_PK = []
	Valordetalle = []
	Saldoact = 0
	Saldoproy = 0
	Ajuste = 0
	Descripcion = []
	Accion = []
	NroItem = 0

enddefine