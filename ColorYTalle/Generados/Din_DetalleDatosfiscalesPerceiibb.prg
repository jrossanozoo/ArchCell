
define class Din_DetalleDATOSFISCALESPerceiibb as detalle of detalle.prg


	cAtributosUnicidad = 'Impuesto_PK'
	nCantidadItems = 999
	cNombre = 'Perceiibb'
	cEtiqueta = 'Impuestos'
	cMensajeErrorUnicidad = 'La columna Impuesto no admite valores repetidos.'
	cNombreVisual = 'Impuestos'

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
			
				.Codigo = this.Item[ tnItem ].Codigo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Codigo', .Codigo )
			
				.Impuesto_PK = this.Item[ tnItem ].Impuesto_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Impuesto_PK', .Impuesto_PK )
			
				.Aplicacion = this.Item[ tnItem ].Aplicacion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Aplicacion', .Aplicacion )
			
				.Tipo_PK = this.Item[ tnItem ].Tipo_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Tipo_PK', .Tipo_PK )
			
				.Jurisdiccion = this.Item[ tnItem ].Jurisdiccion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Jurisdiccion', .Jurisdiccion )
			
				.Resolucion = this.Item[ tnItem ].Resolucion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Resolucion', .Resolucion )
			
				.RegimenImpositivo = this.Item[ tnItem ].RegimenImpositivo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RegimenImpositivo', .RegimenImpositivo )
			
				.MinimoNoImponible = this.Item[ tnItem ].MinimoNoImponible
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MinimoNoImponible', .MinimoNoImponible )
			
				.MinimoDeRetencion = this.Item[ tnItem ].MinimoDeRetencion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MinimoDeRetencion', .MinimoDeRetencion )
			
				.Escala = this.Item[ tnItem ].Escala
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Escala', .Escala )
			
				.Porcentaje = this.Item[ tnItem ].Porcentaje
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Porcentaje', .Porcentaje )
			
				.RG2616Porcentaje = this.Item[ tnItem ].RG2616Porcentaje
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RG2616Porcentaje', .RG2616Porcentaje )
			
				.RG2616Regimen = this.Item[ tnItem ].RG2616Regimen
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RG2616Regimen', .RG2616Regimen )
			
				.RG2616Meses = this.Item[ tnItem ].RG2616Meses
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RG2616Meses', .RG2616Meses )
			
				.RG2616MontoMaximoServicios = this.Item[ tnItem ].RG2616MontoMaximoServicios
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RG2616MontoMaximoServicios', .RG2616MontoMaximoServicios )
			
				.RG2616MontoMaximoBienes = this.Item[ tnItem ].RG2616MontoMaximoBienes
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RG2616MontoMaximoBienes', .RG2616MontoMaximoBienes )
			
				.BaseDeCalculo = this.Item[ tnItem ].BaseDeCalculo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'BaseDeCalculo', .BaseDeCalculo )
			
				.RG1575Regimen = this.Item[ tnItem ].RG1575Regimen
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RG1575Regimen', .RG1575Regimen )
			
				.RG1575Porcentaje = this.Item[ tnItem ].RG1575Porcentaje
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RG1575Porcentaje', .RG1575Porcentaje )
			
				.RG1575BaseDeCalculo = this.Item[ tnItem ].RG1575BaseDeCalculo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RG1575BaseDeCalculo', .RG1575BaseDeCalculo )
			
				.codigointerno = this.Item[ tnItem ].codigointerno
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'codigointerno', .codigointerno )
			
				.SegunConvenio = this.Item[ tnItem ].SegunConvenio
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'SegunConvenio', .SegunConvenio )
			
				.ConvenioLocal = this.Item[ tnItem ].ConvenioLocal
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ConvenioLocal', .ConvenioLocal )
			
				.ConvenioMultilateral = this.Item[ tnItem ].ConvenioMultilateral
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ConvenioMultilateral', .ConvenioMultilateral )
			
				.ConvenioMultilExtranaJuris = this.Item[ tnItem ].ConvenioMultilExtranaJuris
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ConvenioMultilExtranaJuris', .ConvenioMultilExtranaJuris )
			
				.ConvenioNoInscripto = this.Item[ tnItem ].ConvenioNoInscripto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ConvenioNoInscripto', .ConvenioNoInscripto )
			
				.IIBBTucCoeficienteCero = this.Item[ tnItem ].IIBBTucCoeficienteCero
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'IIBBTucCoeficienteCero', .IIBBTucCoeficienteCero )
			
				.Regimen = this.Item[ tnItem ].Regimen
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Regimen', .Regimen )
			
				.IIBBTucReduccionAlicuota = this.Item[ tnItem ].IIBBTucReduccionAlicuota
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'IIBBTucReduccionAlicuota', .IIBBTucReduccionAlicuota )
			
				.IIBBTucAlicuotaNoInscriptos = this.Item[ tnItem ].IIBBTucAlicuotaNoInscriptos
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'IIBBTucAlicuotaNoInscriptos', .IIBBTucAlicuotaNoInscriptos )
			
				.RG5329AplicaPorArticulo = this.Item[ tnItem ].RG5329AplicaPorArticulo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RG5329AplicaPorArticulo', .RG5329AplicaPorArticulo )
			
				.RG5329Porcentaje = this.Item[ tnItem ].RG5329Porcentaje
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RG5329Porcentaje', .RG5329Porcentaje )
			
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
			.Codigo = this.oItem.Codigo
			.Impuesto_PK = this.oItem.Impuesto_PK
			.Aplicacion = this.oItem.Aplicacion
			.Tipo_PK = this.oItem.Tipo_PK
			.Jurisdiccion = this.oItem.Jurisdiccion
			.Resolucion = this.oItem.Resolucion
			.RegimenImpositivo = this.oItem.RegimenImpositivo
			.MinimoNoImponible = this.oItem.MinimoNoImponible
			.MinimoDeRetencion = this.oItem.MinimoDeRetencion
			.Escala = this.oItem.Escala
			.Porcentaje = this.oItem.Porcentaje
			.RG2616Porcentaje = this.oItem.RG2616Porcentaje
			.RG2616Regimen = this.oItem.RG2616Regimen
			.RG2616Meses = this.oItem.RG2616Meses
			.RG2616MontoMaximoServicios = this.oItem.RG2616MontoMaximoServicios
			.RG2616MontoMaximoBienes = this.oItem.RG2616MontoMaximoBienes
			.BaseDeCalculo = this.oItem.BaseDeCalculo
			.RG1575Regimen = this.oItem.RG1575Regimen
			.RG1575Porcentaje = this.oItem.RG1575Porcentaje
			.RG1575BaseDeCalculo = this.oItem.RG1575BaseDeCalculo
			.codigointerno = this.oItem.codigointerno
			.SegunConvenio = this.oItem.SegunConvenio
			.ConvenioLocal = this.oItem.ConvenioLocal
			.ConvenioMultilateral = this.oItem.ConvenioMultilateral
			.ConvenioMultilExtranaJuris = this.oItem.ConvenioMultilExtranaJuris
			.ConvenioNoInscripto = this.oItem.ConvenioNoInscripto
			.IIBBTucCoeficienteCero = this.oItem.IIBBTucCoeficienteCero
			.Regimen = this.oItem.Regimen
			.IIBBTucReduccionAlicuota = this.oItem.IIBBTucReduccionAlicuota
			.IIBBTucAlicuotaNoInscriptos = this.oItem.IIBBTucAlicuotaNoInscriptos
			.RG5329AplicaPorArticulo = this.oItem.RG5329AplicaPorArticulo
			.RG5329Porcentaje = this.oItem.RG5329Porcentaje
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
			.Item[ lnItem ].Codigo = .oItem.Codigo
			.Item[ lnItem ].Impuesto_PK = .oItem.Impuesto_PK
			.Item[ lnItem ].Aplicacion = .oItem.Aplicacion
			.Item[ lnItem ].Tipo_PK = .oItem.Tipo_PK
			.Item[ lnItem ].Jurisdiccion = .oItem.Jurisdiccion
			.Item[ lnItem ].Resolucion = .oItem.Resolucion
			.Item[ lnItem ].RegimenImpositivo = .oItem.RegimenImpositivo
			.Item[ lnItem ].MinimoNoImponible = .oItem.MinimoNoImponible
			.Item[ lnItem ].MinimoDeRetencion = .oItem.MinimoDeRetencion
			.Item[ lnItem ].Escala = .oItem.Escala
			.Item[ lnItem ].Porcentaje = .oItem.Porcentaje
			.Item[ lnItem ].RG2616Porcentaje = .oItem.RG2616Porcentaje
			.Item[ lnItem ].RG2616Regimen = .oItem.RG2616Regimen
			.Item[ lnItem ].RG2616Meses = .oItem.RG2616Meses
			.Item[ lnItem ].RG2616MontoMaximoServicios = .oItem.RG2616MontoMaximoServicios
			.Item[ lnItem ].RG2616MontoMaximoBienes = .oItem.RG2616MontoMaximoBienes
			.Item[ lnItem ].BaseDeCalculo = .oItem.BaseDeCalculo
			.Item[ lnItem ].RG1575Regimen = .oItem.RG1575Regimen
			.Item[ lnItem ].RG1575Porcentaje = .oItem.RG1575Porcentaje
			.Item[ lnItem ].RG1575BaseDeCalculo = .oItem.RG1575BaseDeCalculo
			.Item[ lnItem ].codigointerno = .oItem.codigointerno
			.Item[ lnItem ].SegunConvenio = .oItem.SegunConvenio
			.Item[ lnItem ].ConvenioLocal = .oItem.ConvenioLocal
			.Item[ lnItem ].ConvenioMultilateral = .oItem.ConvenioMultilateral
			.Item[ lnItem ].ConvenioMultilExtranaJuris = .oItem.ConvenioMultilExtranaJuris
			.Item[ lnItem ].ConvenioNoInscripto = .oItem.ConvenioNoInscripto
			.Item[ lnItem ].IIBBTucCoeficienteCero = .oItem.IIBBTucCoeficienteCero
			.Item[ lnItem ].Regimen = .oItem.Regimen
			.Item[ lnItem ].IIBBTucReduccionAlicuota = .oItem.IIBBTucReduccionAlicuota
			.Item[ lnItem ].IIBBTucAlicuotaNoInscriptos = .oItem.IIBBTucAlicuotaNoInscriptos
			.Item[ lnItem ].RG5329AplicaPorArticulo = .oItem.RG5329AplicaPorArticulo
			.Item[ lnItem ].RG5329Porcentaje = .oItem.RG5329Porcentaje
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'ItemDATOSFISCALESPerceiibb' )
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

		select c_Perceiibb
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.NROITEM = c_Perceiibb.NROITEM
			loItem.BLOQUEARREGISTRO = c_Perceiibb.BLOQUEARREGISTRO
			loItem.Codigo = c_Perceiibb.Codigo
			loItem.Impuesto_PK = c_Perceiibb.Impuesto
			loItem.codigointerno = c_Perceiibb.codigointerno
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

		if  empty( this.item[ tnItem ].Impuesto_PK ) 
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
			
			if vartype( this.Item[lni].BLOQUEARREGISTRO) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo BLOQUEARREGISTRO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CODIGO) = 'C'
				if len( alltrim( this.Item[lni].CODIGO )) <= 8
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGO ))) + ' Máxima:8), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].IMPUESTO_PK) = 'C'
				if len( alltrim( this.Item[lni].IMPUESTO_PK )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo IMPUESTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].IMPUESTO_PK ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo IMPUESTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CODIGOINTERNO) = 'C'
				if len( alltrim( this.Item[lni].CODIGOINTERNO )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGOINTERNO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGOINTERNO ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGOINTERNO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Impuesto_PK = toItemOrigen.Impuesto_PK
		toItemDestino.Aplicacion = toItemOrigen.Aplicacion
		toItemDestino.Tipo_PK = toItemOrigen.Tipo_PK
		toItemDestino.Jurisdiccion = toItemOrigen.Jurisdiccion
		toItemDestino.Resolucion = toItemOrigen.Resolucion
		toItemDestino.Regimenimpositivo = toItemOrigen.Regimenimpositivo
		toItemDestino.Minimonoimponible = toItemOrigen.Minimonoimponible
		toItemDestino.Minimoderetencion = toItemOrigen.Minimoderetencion
		toItemDestino.Escala = toItemOrigen.Escala
		toItemDestino.Porcentaje = toItemOrigen.Porcentaje
		toItemDestino.Rg2616porcentaje = toItemOrigen.Rg2616porcentaje
		toItemDestino.Rg2616regimen = toItemOrigen.Rg2616regimen
		toItemDestino.Rg2616meses = toItemOrigen.Rg2616meses
		toItemDestino.Rg2616montomaximoservicios = toItemOrigen.Rg2616montomaximoservicios
		toItemDestino.Rg2616montomaximobienes = toItemOrigen.Rg2616montomaximobienes
		toItemDestino.Basedecalculo = toItemOrigen.Basedecalculo
		toItemDestino.Rg1575regimen = toItemOrigen.Rg1575regimen
		toItemDestino.Rg1575porcentaje = toItemOrigen.Rg1575porcentaje
		toItemDestino.Rg1575basedecalculo = toItemOrigen.Rg1575basedecalculo
		toItemDestino.Codigointerno = toItemOrigen.Codigointerno
		toItemDestino.Segunconvenio = toItemOrigen.Segunconvenio
		toItemDestino.Conveniolocal = toItemOrigen.Conveniolocal
		toItemDestino.Conveniomultilateral = toItemOrigen.Conveniomultilateral
		toItemDestino.Conveniomultilextranajuris = toItemOrigen.Conveniomultilextranajuris
		toItemDestino.Convenionoinscripto = toItemOrigen.Convenionoinscripto
		toItemDestino.Iibbtuccoeficientecero = toItemOrigen.Iibbtuccoeficientecero
		toItemDestino.Regimen = toItemOrigen.Regimen
		toItemDestino.Iibbtucreduccionalicuota = toItemOrigen.Iibbtucreduccionalicuota
		toItemDestino.Iibbtucalicuotanoinscriptos = toItemOrigen.Iibbtucalicuotanoinscriptos
		toItemDestino.Rg5329aplicaporarticulo = toItemOrigen.Rg5329aplicaporarticulo
		toItemDestino.Rg5329porcentaje = toItemOrigen.Rg5329porcentaje
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
		lcRetorno = 'Impuesto_pk'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Nroitem = 0
	Bloquearregistro = .F.
	Codigo = []
	Impuesto_PK = []
	Aplicacion = []
	Tipo_PK = []
	Jurisdiccion = []
	Resolucion = []
	Regimenimpositivo = []
	Minimonoimponible = 0
	Minimoderetencion = 0
	Escala = .F.
	Porcentaje = 0
	Rg2616porcentaje = 0
	Rg2616regimen = []
	Rg2616meses = 0
	Rg2616montomaximoservicios = 0
	Rg2616montomaximobienes = 0
	Basedecalculo = []
	Rg1575regimen = []
	Rg1575porcentaje = 0
	Rg1575basedecalculo = []
	Codigointerno = []
	Segunconvenio = .F.
	Conveniolocal = 0
	Conveniomultilateral = 0
	Conveniomultilextranajuris = 0
	Convenionoinscripto = 0
	Iibbtuccoeficientecero = 0
	Regimen = []
	Iibbtucreduccionalicuota = 0
	Iibbtucalicuotanoinscriptos = 0
	Rg5329aplicaporarticulo = .F.
	Rg5329porcentaje = 0
	NroItem = 0

enddefine