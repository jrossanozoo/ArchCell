
define class Din_DetalleORDENDEPAGOImpuestoscomprobante as detalle of detalle.prg

	Sum_Monto = 0

	nCantidadItems = 999
	cNombre = 'Impuestoscomprobante'
	cEtiqueta = 'Impuesto'
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
			
				.PorcentajeConvenio = this.Item[ tnItem ].PorcentajeConvenio
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PorcentajeConvenio', .PorcentajeConvenio )
			
				.MontoBase = this.Item[ tnItem ].MontoBase
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoBase', .MontoBase )
			
				.PorcentajeBase = this.Item[ tnItem ].PorcentajeBase
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PorcentajeBase', .PorcentajeBase )
			
				.Porcentaje = this.Item[ tnItem ].Porcentaje
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Porcentaje', .Porcentaje )
			
				.Tooltip = this.Item[ tnItem ].Tooltip
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Tooltip', .Tooltip )
			
				.TipoImpuestoCDR = this.Item[ tnItem ].TipoImpuestoCDR
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TipoImpuestoCDR', .TipoImpuestoCDR )
			
				.CodigoCDR = this.Item[ tnItem ].CodigoCDR
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodigoCDR', .CodigoCDR )
			
				.AcumuladoPagos = this.Item[ tnItem ].AcumuladoPagos
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'AcumuladoPagos', .AcumuladoPagos )
			
				.AcumuladoRetenciones = this.Item[ tnItem ].AcumuladoRetenciones
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'AcumuladoRetenciones', .AcumuladoRetenciones )
			
				.EscalaMontoFijo = this.Item[ tnItem ].EscalaMontoFijo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'EscalaMontoFijo', .EscalaMontoFijo )
			
				.EscalaPorcentaje = this.Item[ tnItem ].EscalaPorcentaje
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'EscalaPorcentaje', .EscalaPorcentaje )
			
				.EscalaSobreExcedente = this.Item[ tnItem ].EscalaSobreExcedente
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'EscalaSobreExcedente', .EscalaSobreExcedente )
			
				.MinimoNoImp = this.Item[ tnItem ].MinimoNoImp
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MinimoNoImp', .MinimoNoImp )
			
				.Jurisdiccion = this.Item[ tnItem ].Jurisdiccion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Jurisdiccion', .Jurisdiccion )
			
				.JurisdiccionDescripcion = this.Item[ tnItem ].JurisdiccionDescripcion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'JurisdiccionDescripcion', .JurisdiccionDescripcion )
			
				.Resolucion = this.Item[ tnItem ].Resolucion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Resolucion', .Resolucion )
			
				.MinimoNoImponible = this.Item[ tnItem ].MinimoNoImponible
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MinimoNoImponible', .MinimoNoImponible )
			
				.BaseDeCalculo = this.Item[ tnItem ].BaseDeCalculo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'BaseDeCalculo', .BaseDeCalculo )
			
				.RegimenImpositivo = this.Item[ tnItem ].RegimenImpositivo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RegimenImpositivo', .RegimenImpositivo )
			
				.Escala = this.Item[ tnItem ].Escala
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Escala', .Escala )
			
				.Minimo = this.Item[ tnItem ].Minimo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Minimo', .Minimo )
			
				.RegimenImpositivoDescripcion = this.Item[ tnItem ].RegimenImpositivoDescripcion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RegimenImpositivoDescripcion', .RegimenImpositivoDescripcion )
			
				.AcumuladoComprobante = this.Item[ tnItem ].AcumuladoComprobante
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'AcumuladoComprobante', .AcumuladoComprobante )
			
				.esRG2616AR = this.Item[ tnItem ].esRG2616AR
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'esRG2616AR', .esRG2616AR )
			
				.esRG1575AR = this.Item[ tnItem ].esRG1575AR
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'esRG1575AR', .esRG1575AR )
			
				.CertificadoSIRE = this.Item[ tnItem ].CertificadoSIRE
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CertificadoSIRE', .CertificadoSIRE )
			
				.CodSeguridadSIRE = this.Item[ tnItem ].CodSeguridadSIRE
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodSeguridadSIRE', .CodSeguridadSIRE )
			
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.CodImp_PK = this.Item[ tnItem ].CodImp_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodImp_PK', .CodImp_PK )
			
				.CodImpDetalle = this.Item[ tnItem ].CodImpDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodImpDetalle', .CodImpDetalle )
			
				.Monto = this.Item[ tnItem ].Monto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Monto', .Monto )
			
				.ConvenioMultilateral = this.Item[ tnItem ].ConvenioMultilateral
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ConvenioMultilateral', .ConvenioMultilateral )
			
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
			.PorcentajeConvenio = this.oItem.PorcentajeConvenio
			.MontoBase = this.oItem.MontoBase
			.PorcentajeBase = this.oItem.PorcentajeBase
			.Porcentaje = this.oItem.Porcentaje
			.Tooltip = this.oItem.Tooltip
			.TipoImpuestoCDR = this.oItem.TipoImpuestoCDR
			.CodigoCDR = this.oItem.CodigoCDR
			.AcumuladoPagos = this.oItem.AcumuladoPagos
			.AcumuladoRetenciones = this.oItem.AcumuladoRetenciones
			.EscalaMontoFijo = this.oItem.EscalaMontoFijo
			.EscalaPorcentaje = this.oItem.EscalaPorcentaje
			.EscalaSobreExcedente = this.oItem.EscalaSobreExcedente
			.MinimoNoImp = this.oItem.MinimoNoImp
			.Jurisdiccion = this.oItem.Jurisdiccion
			.JurisdiccionDescripcion = this.oItem.JurisdiccionDescripcion
			.Resolucion = this.oItem.Resolucion
			.MinimoNoImponible = this.oItem.MinimoNoImponible
			.BaseDeCalculo = this.oItem.BaseDeCalculo
			.RegimenImpositivo = this.oItem.RegimenImpositivo
			.Escala = this.oItem.Escala
			.Minimo = this.oItem.Minimo
			.RegimenImpositivoDescripcion = this.oItem.RegimenImpositivoDescripcion
			.AcumuladoComprobante = this.oItem.AcumuladoComprobante
			.esRG2616AR = this.oItem.esRG2616AR
			.esRG1575AR = this.oItem.esRG1575AR
			.CertificadoSIRE = this.oItem.CertificadoSIRE
			.CodSeguridadSIRE = this.oItem.CodSeguridadSIRE
			.NROITEM = this.oItem.NROITEM
			.CodImp_PK = this.oItem.CodImp_PK
			.CodImpDetalle = this.oItem.CodImpDetalle
			.Monto = this.oItem.Monto
			.ConvenioMultilateral = this.oItem.ConvenioMultilateral
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
			.Item[ lnItem ].PorcentajeConvenio = .oItem.PorcentajeConvenio
			.Item[ lnItem ].MontoBase = .oItem.MontoBase
			.Item[ lnItem ].PorcentajeBase = .oItem.PorcentajeBase
			.Item[ lnItem ].Porcentaje = .oItem.Porcentaje
			.Item[ lnItem ].Tooltip = .oItem.Tooltip
			.Item[ lnItem ].TipoImpuestoCDR = .oItem.TipoImpuestoCDR
			.Item[ lnItem ].CodigoCDR = .oItem.CodigoCDR
			.Item[ lnItem ].AcumuladoPagos = .oItem.AcumuladoPagos
			.Item[ lnItem ].AcumuladoRetenciones = .oItem.AcumuladoRetenciones
			.Item[ lnItem ].EscalaMontoFijo = .oItem.EscalaMontoFijo
			.Item[ lnItem ].EscalaPorcentaje = .oItem.EscalaPorcentaje
			.Item[ lnItem ].EscalaSobreExcedente = .oItem.EscalaSobreExcedente
			.Item[ lnItem ].MinimoNoImp = .oItem.MinimoNoImp
			.Item[ lnItem ].Jurisdiccion = .oItem.Jurisdiccion
			.Item[ lnItem ].JurisdiccionDescripcion = .oItem.JurisdiccionDescripcion
			.Item[ lnItem ].Resolucion = .oItem.Resolucion
			.Item[ lnItem ].MinimoNoImponible = .oItem.MinimoNoImponible
			.Item[ lnItem ].BaseDeCalculo = .oItem.BaseDeCalculo
			.Item[ lnItem ].RegimenImpositivo = .oItem.RegimenImpositivo
			.Item[ lnItem ].Escala = .oItem.Escala
			.Item[ lnItem ].Minimo = .oItem.Minimo
			.Item[ lnItem ].RegimenImpositivoDescripcion = .oItem.RegimenImpositivoDescripcion
			.Item[ lnItem ].AcumuladoComprobante = .oItem.AcumuladoComprobante
			.Item[ lnItem ].esRG2616AR = .oItem.esRG2616AR
			.Item[ lnItem ].esRG1575AR = .oItem.esRG1575AR
			.Item[ lnItem ].CertificadoSIRE = .oItem.CertificadoSIRE
			.Item[ lnItem ].CodSeguridadSIRE = .oItem.CodSeguridadSIRE
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].CodImp_PK = .oItem.CodImp_PK
			.Item[ lnItem ].CodImpDetalle = .oItem.CodImpDetalle
			.Item[ lnItem ].Monto = .oItem.Monto
			.Item[ lnItem ].ConvenioMultilateral = .oItem.ConvenioMultilateral
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Sumarizar() as boolean
		local lnItem as integer, loItem as Object, lnSum_Monto as Number

		with this
			lnSum_Monto = 0
			if this.lEsNavegacion
				if select( 'c_Impuestoscomprobante' ) > 0 and reccount( 'c_Impuestoscomprobante' ) > 0
					sum Monto;
						 to ;
						 lnSum_Monto
				endif
				this.lEsNavegacion = .f.
			else
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							if !empty(.CODIMP_PK)
								lnSum_Monto = lnSum_Monto + .Monto
							endif
						endwith
					endif
				endfor

				if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
					loItem = .oItem
					with loItem 
						lnSum_Monto = lnSum_Monto + .Monto
					endwith
				endif
			endif

			if .Sum_Monto != lnSum_Monto
				.Sum_Monto = lnSum_Monto
				.EventoCambioSum_Monto()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Monto() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalizar( toItem as Object ) as Void
		local lnItem as integer, loItem as Object, lnSum_Monto as Number

		with this
			lnSum_Monto = 0
			if !this.lEsNavegacion
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							if !empty(.CODIMP_PK)
								lnSum_Monto = lnSum_Monto + .Monto
							endif
						endwith
					endif
				endfor

			endif
			if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
				loItem = .oItem
				with loItem 
					if !empty(.CODIMP_PK)
						lnSum_Monto = lnSum_Monto + .Monto
					endif
				endwith
			endif

			if .Sum_Monto != lnSum_Monto
				.Sum_Monto = lnSum_Monto
				.EventoCambioSum_Monto()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Acumular( tlForzar as Boolean, tcAtributo as String, tnValor as Decimal, tnValorAnt as Decimal ) as Void
		local lnItem as integer, loItem as Object, lnSum_Monto as Number

		do case
		case tnValor = tnValorAnt
		case tcAtributo == 'Monto'
			this.Sum_Monto = this.Sum_Monto - tnValorAnt + tnValor
			this.EventoCambioSum_Monto()

		endcase
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Limpiar() as boolean
		DoDefault()
		this.Sumarizar()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'ItemORDENDEPAGOImpuestoscomprobante' )
			this.enlazar( 'oItem.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oItem.EventoObtenerInformacion', 'inyectarInformacion' )
			this.oItem.inicializar()
			bindevent( this.oItem, 'AcumularSumarizado', this, 'Acumular', 0) 
			bindevent( this.oItem, 'TotalizarSumarizado', this, 'Totalizar', 0) 
			bindevent( this.oItem, 'CambioSumarizado', this, 'Sumarizar', 0) 
			bindevent( this.oItem, 'EventoDespuesDeSetear', this, 'ValidarCantidadDeItemsEnDetalle' )
		endif
		return this.oItem
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Cargar() as Void
		local loItem as object, lnI as integer, lcClave as string, lcFiltro as String 
		lnI = 1

		select c_Impuestoscomprobante
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Codigo = c_Impuestoscomprobante.Codigo
			loItem.TipoImpuestoCDR = c_Impuestoscomprobante.TipoImpuestoCDR
			loItem.CodigoCDR = c_Impuestoscomprobante.CodigoCDR
			loItem.NROITEM = c_Impuestoscomprobante.NROITEM
			loItem.CodImp_PK = c_Impuestoscomprobante.CodImp
			loItem.CodImpDetalle = c_Impuestoscomprobante.CodImpDetalle
			loItem.Monto = c_Impuestoscomprobante.Monto
			loItem.NroItem = lnI 
			this.AgregarItemPlano( loItem )
			lnI = lnI + 1
		endscan

		this.Sumarizar()

	endfunc


	*--------------------------------------------------------------------------------------------------------
	function ValidarExistenciaCamposFijosItemPlano( tnItem as integer ) as Boolean
		Local llRetorno as boolean
		llRetorno = .t.

		if  empty( this.item[ tnItem ].Codimp_PK ) 
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
			
			if vartype( this.Item[lni].TIPOIMPUESTOCDR) = 'C'
				if len( alltrim( this.Item[lni].TIPOIMPUESTOCDR )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TIPOIMPUESTOCDR del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TIPOIMPUESTOCDR ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TIPOIMPUESTOCDR del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CODIGOCDR) = 'C'
				if len( alltrim( this.Item[lni].CODIGOCDR )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGOCDR del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGOCDR ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGOCDR del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].CODIMP_PK) = 'C'
				if len( alltrim( this.Item[lni].CODIMP_PK )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIMP del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIMP_PK ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIMP del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CODIMPDETALLE) = 'C'
				if len( alltrim( this.Item[lni].CODIMPDETALLE )) <= 50
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIMPDETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIMPDETALLE ))) + ' Máxima:50), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIMPDETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTO ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTO - int( this.Item[lni].MONTO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Porcentajeconvenio = toItemOrigen.Porcentajeconvenio
		toItemDestino.Montobase = toItemOrigen.Montobase
		toItemDestino.Porcentajebase = toItemOrigen.Porcentajebase
		toItemDestino.Porcentaje = toItemOrigen.Porcentaje
		toItemDestino.Tooltip = toItemOrigen.Tooltip
		toItemDestino.Tipoimpuestocdr = toItemOrigen.Tipoimpuestocdr
		toItemDestino.Codigocdr = toItemOrigen.Codigocdr
		toItemDestino.Acumuladopagos = toItemOrigen.Acumuladopagos
		toItemDestino.Acumuladoretenciones = toItemOrigen.Acumuladoretenciones
		toItemDestino.Escalamontofijo = toItemOrigen.Escalamontofijo
		toItemDestino.Escalaporcentaje = toItemOrigen.Escalaporcentaje
		toItemDestino.Escalasobreexcedente = toItemOrigen.Escalasobreexcedente
		toItemDestino.Minimonoimp = toItemOrigen.Minimonoimp
		toItemDestino.Jurisdiccion = toItemOrigen.Jurisdiccion
		toItemDestino.Jurisdicciondescripcion = toItemOrigen.Jurisdicciondescripcion
		toItemDestino.Resolucion = toItemOrigen.Resolucion
		toItemDestino.Minimonoimponible = toItemOrigen.Minimonoimponible
		toItemDestino.Basedecalculo = toItemOrigen.Basedecalculo
		toItemDestino.Regimenimpositivo = toItemOrigen.Regimenimpositivo
		toItemDestino.Escala = toItemOrigen.Escala
		toItemDestino.Minimo = toItemOrigen.Minimo
		toItemDestino.Regimenimpositivodescripcion = toItemOrigen.Regimenimpositivodescripcion
		toItemDestino.Acumuladocomprobante = toItemOrigen.Acumuladocomprobante
		toItemDestino.Esrg2616ar = toItemOrigen.Esrg2616ar
		toItemDestino.Esrg1575ar = toItemOrigen.Esrg1575ar
		toItemDestino.Certificadosire = toItemOrigen.Certificadosire
		toItemDestino.Codseguridadsire = toItemOrigen.Codseguridadsire
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Codimp_PK = toItemOrigen.Codimp_PK
		toItemDestino.Codimpdetalle = toItemOrigen.Codimpdetalle
		toItemDestino.Monto = toItemOrigen.Monto
		toItemDestino.Conveniomultilateral = toItemOrigen.Conveniomultilateral
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Actualizar( tcClave as String ) as Void
		DoDefault( tcClave )
		this.Sumarizar()
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
		lcRetorno = 'CodImp_pk'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Codigo = []
	Porcentajeconvenio = 0
	Montobase = 0
	Porcentajebase = 0
	Porcentaje = 0
	Tooltip = []
	Tipoimpuestocdr = []
	Codigocdr = []
	Acumuladopagos = 0
	Acumuladoretenciones = 0
	Escalamontofijo = 0
	Escalaporcentaje = 0
	Escalasobreexcedente = 0
	Minimonoimp = 0
	Jurisdiccion = []
	Jurisdicciondescripcion = []
	Resolucion = []
	Minimonoimponible = 0
	Basedecalculo = []
	Regimenimpositivo = []
	Escala = .F.
	Minimo = 0
	Regimenimpositivodescripcion = []
	Acumuladocomprobante = 0
	Esrg2616ar = .F.
	Esrg1575ar = .F.
	Certificadosire = []
	Codseguridadsire = []
	Nroitem = 0
	Codimp_PK = []
	Codimpdetalle = []
	Monto = 0
	Conveniomultilateral = []
	NroItem = 0

enddefine