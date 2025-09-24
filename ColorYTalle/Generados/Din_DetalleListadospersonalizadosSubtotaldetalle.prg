
define class Din_DetalleLISTADOSPERSONALIZADOSSubtotaldetalle as detalle of detalle.prg


	nCantidadItems = 999
	cNombre = 'Subtotaldetalle'
	cEtiqueta = 'Subtotales'
	cMensajeErrorUnicidad = 'La columna  no admite valores repetidos.'
	cNombreVisual = 'Detalle subtotales'

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
			
				.BLOQUEARREGISTRO = this.Item[ tnItem ].BLOQUEARREGISTRO
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'BLOQUEARREGISTRO', .BLOQUEARREGISTRO )
			
				.codigo = this.Item[ tnItem ].codigo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'codigo', .codigo )
			
				.Identificador = this.Item[ tnItem ].Identificador
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Identificador', .Identificador )
			
				.idCampo = this.Item[ tnItem ].idCampo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'idCampo', .idCampo )
			
				.lNuevaPaginaAntes = this.Item[ tnItem ].lNuevaPaginaAntes
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'lNuevaPaginaAntes', .lNuevaPaginaAntes )
			
				.nOrden = this.Item[ tnItem ].nOrden
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'nOrden', .nOrden )
			
				.Activado = this.Item[ tnItem ].Activado
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Activado', .Activado )
			
				.nSubTotal = this.Item[ tnItem ].nSubTotal
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'nSubTotal', .nSubTotal )
			
				.Formula = this.Item[ tnItem ].Formula
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Formula', .Formula )
			
				.AnchoFormula = this.Item[ tnItem ].AnchoFormula
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'AnchoFormula', .AnchoFormula )
			
				.EtiquetaFormula = this.Item[ tnItem ].EtiquetaFormula
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'EtiquetaFormula', .EtiquetaFormula )
			
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
			.BLOQUEARREGISTRO = this.oItem.BLOQUEARREGISTRO
			.codigo = this.oItem.codigo
			.Identificador = this.oItem.Identificador
			.idCampo = this.oItem.idCampo
			.lNuevaPaginaAntes = this.oItem.lNuevaPaginaAntes
			.nOrden = this.oItem.nOrden
			.Activado = this.oItem.Activado
			.nSubTotal = this.oItem.nSubTotal
			.Formula = this.oItem.Formula
			.AnchoFormula = this.oItem.AnchoFormula
			.EtiquetaFormula = this.oItem.EtiquetaFormula
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
			.Item[ lnItem ].BLOQUEARREGISTRO = .oItem.BLOQUEARREGISTRO
			.Item[ lnItem ].codigo = .oItem.codigo
			.Item[ lnItem ].Identificador = .oItem.Identificador
			.Item[ lnItem ].idCampo = .oItem.idCampo
			.Item[ lnItem ].lNuevaPaginaAntes = .oItem.lNuevaPaginaAntes
			.Item[ lnItem ].nOrden = .oItem.nOrden
			.Item[ lnItem ].Activado = .oItem.Activado
			.Item[ lnItem ].nSubTotal = .oItem.nSubTotal
			.Item[ lnItem ].Formula = .oItem.Formula
			.Item[ lnItem ].AnchoFormula = .oItem.AnchoFormula
			.Item[ lnItem ].EtiquetaFormula = .oItem.EtiquetaFormula
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemLISTADOSPERSONALIZADOSSubtotaldetalle' )
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

		select c_Subtotaldetalle
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.NROITEM = c_Subtotaldetalle.NROITEM
			loItem.BLOQUEARREGISTRO = c_Subtotaldetalle.BLOQUEARREGISTRO
			loItem.codigo = c_Subtotaldetalle.codigo
			loItem.Identificador = c_Subtotaldetalle.Identificador
			loItem.idCampo = c_Subtotaldetalle.idCampo
			loItem.lNuevaPaginaAntes = c_Subtotaldetalle.lNuevaPaginaAntes
			loItem.nOrden = c_Subtotaldetalle.nOrden
			loItem.Activado = c_Subtotaldetalle.Activado
			loItem.nSubTotal = c_Subtotaldetalle.nSubTotal
			loItem.Formula = c_Subtotaldetalle.Formula
			loItem.AnchoFormula = c_Subtotaldetalle.AnchoFormula
			loItem.EtiquetaFormula = c_Subtotaldetalle.EtiquetaFormula
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
			
			if vartype( this.Item[lni].BLOQUEARREGISTRO) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo BLOQUEARREGISTRO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].IDENTIFICADOR) = 'C'
				if len( alltrim( this.Item[lni].IDENTIFICADOR )) <= 200
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo IDENTIFICADOR del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].IDENTIFICADOR ))) + ' Máxima:200), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo IDENTIFICADOR del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].IDCAMPO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].IDCAMPO ) ) ) 
				lnValorDelDecimal = this.Item[lni].IDCAMPO - int( this.Item[lni].IDCAMPO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 8
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo IDCAMPO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:8), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo IDCAMPO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].LNUEVAPAGINAANTES) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo LNUEVAPAGINAANTES del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NORDEN) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].NORDEN ) ) ) 
				lnValorDelDecimal = this.Item[lni].NORDEN - int( this.Item[lni].NORDEN )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 12
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo NORDEN del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:12), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NORDEN del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ACTIVADO) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ACTIVADO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NSUBTOTAL) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].NSUBTOTAL ) ) ) 
				lnValorDelDecimal = this.Item[lni].NSUBTOTAL - int( this.Item[lni].NSUBTOTAL )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo NSUBTOTAL del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NSUBTOTAL del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].FORMULA) = 'C'
				if len( alltrim( this.Item[lni].FORMULA )) <= 200
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo FORMULA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].FORMULA ))) + ' Máxima:200), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo FORMULA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ANCHOFORMULA) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].ANCHOFORMULA ) ) ) 
				lnValorDelDecimal = this.Item[lni].ANCHOFORMULA - int( this.Item[lni].ANCHOFORMULA )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 4
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo ANCHOFORMULA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:4), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ANCHOFORMULA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ETIQUETAFORMULA) = 'C'
				if len( alltrim( this.Item[lni].ETIQUETAFORMULA )) <= 40
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo ETIQUETAFORMULA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].ETIQUETAFORMULA ))) + ' Máxima:40), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ETIQUETAFORMULA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Bloquearregistro = toItemOrigen.Bloquearregistro
		toItemDestino.Codigo = toItemOrigen.Codigo
		toItemDestino.Identificador = toItemOrigen.Identificador
		toItemDestino.Idcampo = toItemOrigen.Idcampo
		toItemDestino.Lnuevapaginaantes = toItemOrigen.Lnuevapaginaantes
		toItemDestino.Norden = toItemOrigen.Norden
		toItemDestino.Activado = toItemOrigen.Activado
		toItemDestino.Nsubtotal = toItemOrigen.Nsubtotal
		toItemDestino.Formula = toItemOrigen.Formula
		toItemDestino.Anchoformula = toItemOrigen.Anchoformula
		toItemDestino.Etiquetaformula = toItemOrigen.Etiquetaformula
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
	Bloquearregistro = .F.
	Codigo = []
	Identificador = []
	Idcampo = 0
	Lnuevapaginaantes = .F.
	Norden = 0
	Activado = .F.
	Nsubtotal = 0
	Formula = []
	Anchoformula = 0
	Etiquetaformula = []
	NroItem = 0

enddefine