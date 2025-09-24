
define class Din_DetalleCOMPROBANTEDERETENCIONESGANANCIASImpuestosdetalle as detalle of detalle.prg

	Sum_Monto = 0

	nCantidadItems = 999
	cNombre = 'Impuestosdetalle'
	cEtiqueta = 'Impuestosdetalle'
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
			
				.ConvenioMultilateral = this.Item[ tnItem ].ConvenioMultilateral
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ConvenioMultilateral', .ConvenioMultilateral )
			
				.PorcentajeDeConvenio = this.Item[ tnItem ].PorcentajeDeConvenio
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PorcentajeDeConvenio', .PorcentajeDeConvenio )
			
				.PorcentajeDeBase = this.Item[ tnItem ].PorcentajeDeBase
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PorcentajeDeBase', .PorcentajeDeBase )
			
				.MontoBase = this.Item[ tnItem ].MontoBase
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoBase', .MontoBase )
			
				.BaseDeCalculo = this.Item[ tnItem ].BaseDeCalculo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'BaseDeCalculo', .BaseDeCalculo )
			
				.RegimenImpositivo = this.Item[ tnItem ].RegimenImpositivo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RegimenImpositivo', .RegimenImpositivo )
			
				.Escala = this.Item[ tnItem ].Escala
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Escala', .Escala )
			
				.Minimo = this.Item[ tnItem ].Minimo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Minimo', .Minimo )
			
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
			
				.MontoComprobanteOrigen = this.Item[ tnItem ].MontoComprobanteOrigen
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoComprobanteOrigen', .MontoComprobanteOrigen )
			
				.RegimenImpositivoDescripcion = this.Item[ tnItem ].RegimenImpositivoDescripcion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RegimenImpositivoDescripcion', .RegimenImpositivoDescripcion )
			
				.AcumuladoComprobantes = this.Item[ tnItem ].AcumuladoComprobantes
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'AcumuladoComprobantes', .AcumuladoComprobantes )
			
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
			
				.Jurisdiccion = this.Item[ tnItem ].Jurisdiccion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Jurisdiccion', .Jurisdiccion )
			
				.JurisdiccionDescripcion = this.Item[ tnItem ].JurisdiccionDescripcion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'JurisdiccionDescripcion', .JurisdiccionDescripcion )
			
				.Resolucion = this.Item[ tnItem ].Resolucion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Resolucion', .Resolucion )
			
				.MinimoNoImponible = this.Item[ tnItem ].MinimoNoImponible
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MinimoNoImponible', .MinimoNoImponible )
			
				.Porcentaje = this.Item[ tnItem ].Porcentaje
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Porcentaje', .Porcentaje )
			
				.Monto = this.Item[ tnItem ].Monto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Monto', .Monto )
			
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
			.ConvenioMultilateral = this.oItem.ConvenioMultilateral
			.PorcentajeDeConvenio = this.oItem.PorcentajeDeConvenio
			.PorcentajeDeBase = this.oItem.PorcentajeDeBase
			.MontoBase = this.oItem.MontoBase
			.BaseDeCalculo = this.oItem.BaseDeCalculo
			.RegimenImpositivo = this.oItem.RegimenImpositivo
			.Escala = this.oItem.Escala
			.Minimo = this.oItem.Minimo
			.AcumuladoPagos = this.oItem.AcumuladoPagos
			.AcumuladoRetenciones = this.oItem.AcumuladoRetenciones
			.EscalaMontoFijo = this.oItem.EscalaMontoFijo
			.EscalaPorcentaje = this.oItem.EscalaPorcentaje
			.EscalaSobreExcedente = this.oItem.EscalaSobreExcedente
			.MinimoNoImp = this.oItem.MinimoNoImp
			.MontoComprobanteOrigen = this.oItem.MontoComprobanteOrigen
			.RegimenImpositivoDescripcion = this.oItem.RegimenImpositivoDescripcion
			.AcumuladoComprobantes = this.oItem.AcumuladoComprobantes
			.esRG2616AR = this.oItem.esRG2616AR
			.esRG1575AR = this.oItem.esRG1575AR
			.CertificadoSIRE = this.oItem.CertificadoSIRE
			.CodSeguridadSIRE = this.oItem.CodSeguridadSIRE
			.NROITEM = this.oItem.NROITEM
			.CodImp_PK = this.oItem.CodImp_PK
			.CodImpDetalle = this.oItem.CodImpDetalle
			.Jurisdiccion = this.oItem.Jurisdiccion
			.JurisdiccionDescripcion = this.oItem.JurisdiccionDescripcion
			.Resolucion = this.oItem.Resolucion
			.MinimoNoImponible = this.oItem.MinimoNoImponible
			.Porcentaje = this.oItem.Porcentaje
			.Monto = this.oItem.Monto
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
			.Item[ lnItem ].ConvenioMultilateral = .oItem.ConvenioMultilateral
			.Item[ lnItem ].PorcentajeDeConvenio = .oItem.PorcentajeDeConvenio
			.Item[ lnItem ].PorcentajeDeBase = .oItem.PorcentajeDeBase
			.Item[ lnItem ].MontoBase = .oItem.MontoBase
			.Item[ lnItem ].BaseDeCalculo = .oItem.BaseDeCalculo
			.Item[ lnItem ].RegimenImpositivo = .oItem.RegimenImpositivo
			.Item[ lnItem ].Escala = .oItem.Escala
			.Item[ lnItem ].Minimo = .oItem.Minimo
			.Item[ lnItem ].AcumuladoPagos = .oItem.AcumuladoPagos
			.Item[ lnItem ].AcumuladoRetenciones = .oItem.AcumuladoRetenciones
			.Item[ lnItem ].EscalaMontoFijo = .oItem.EscalaMontoFijo
			.Item[ lnItem ].EscalaPorcentaje = .oItem.EscalaPorcentaje
			.Item[ lnItem ].EscalaSobreExcedente = .oItem.EscalaSobreExcedente
			.Item[ lnItem ].MinimoNoImp = .oItem.MinimoNoImp
			.Item[ lnItem ].MontoComprobanteOrigen = .oItem.MontoComprobanteOrigen
			.Item[ lnItem ].RegimenImpositivoDescripcion = .oItem.RegimenImpositivoDescripcion
			.Item[ lnItem ].AcumuladoComprobantes = .oItem.AcumuladoComprobantes
			.Item[ lnItem ].esRG2616AR = .oItem.esRG2616AR
			.Item[ lnItem ].esRG1575AR = .oItem.esRG1575AR
			.Item[ lnItem ].CertificadoSIRE = .oItem.CertificadoSIRE
			.Item[ lnItem ].CodSeguridadSIRE = .oItem.CodSeguridadSIRE
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].CodImp_PK = .oItem.CodImp_PK
			.Item[ lnItem ].CodImpDetalle = .oItem.CodImpDetalle
			.Item[ lnItem ].Jurisdiccion = .oItem.Jurisdiccion
			.Item[ lnItem ].JurisdiccionDescripcion = .oItem.JurisdiccionDescripcion
			.Item[ lnItem ].Resolucion = .oItem.Resolucion
			.Item[ lnItem ].MinimoNoImponible = .oItem.MinimoNoImponible
			.Item[ lnItem ].Porcentaje = .oItem.Porcentaje
			.Item[ lnItem ].Monto = .oItem.Monto
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
				if select( 'c_Impuestosdetalle' ) > 0 and reccount( 'c_Impuestosdetalle' ) > 0
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
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemCOMPROBANTEDERETENCIONESGANANCIASImpuestosdetalle' )
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

		select c_Impuestosdetalle
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Codigo = c_Impuestosdetalle.Codigo
			loItem.ConvenioMultilateral = c_Impuestosdetalle.ConvenioMultilateral
			loItem.PorcentajeDeConvenio = c_Impuestosdetalle.PorcentajeDeConvenio
			loItem.PorcentajeDeBase = c_Impuestosdetalle.PorcentajeDeBase
			loItem.MontoBase = c_Impuestosdetalle.MontoBase
			loItem.BaseDeCalculo = c_Impuestosdetalle.BaseDeCalculo
			loItem.RegimenImpositivo = c_Impuestosdetalle.RegimenImpositivo
			loItem.Escala = c_Impuestosdetalle.Escala
			loItem.Minimo = c_Impuestosdetalle.Minimo
			loItem.AcumuladoPagos = c_Impuestosdetalle.AcumuladoPagos
			loItem.AcumuladoRetenciones = c_Impuestosdetalle.AcumuladoRetenciones
			loItem.EscalaMontoFijo = c_Impuestosdetalle.EscalaMontoFijo
			loItem.EscalaPorcentaje = c_Impuestosdetalle.EscalaPorcentaje
			loItem.EscalaSobreExcedente = c_Impuestosdetalle.EscalaSobreExcedente
			loItem.MinimoNoImp = c_Impuestosdetalle.MinimoNoImp
			loItem.MontoComprobanteOrigen = c_Impuestosdetalle.MontoComprobanteOrigen
			loItem.RegimenImpositivoDescripcion = c_Impuestosdetalle.RegimenImpositivoDescripcion
			loItem.AcumuladoComprobantes = c_Impuestosdetalle.AcumuladoComprobantes
			loItem.esRG2616AR = c_Impuestosdetalle.esRG2616AR
			loItem.esRG1575AR = c_Impuestosdetalle.esRG1575AR
			loItem.CertificadoSIRE = c_Impuestosdetalle.CertificadoSIRE
			loItem.CodSeguridadSIRE = c_Impuestosdetalle.CodSeguridadSIRE
			loItem.NROITEM = c_Impuestosdetalle.NROITEM
			loItem.CodImp_PK = c_Impuestosdetalle.CodImp
			loItem.CodImpDetalle = c_Impuestosdetalle.CodImpDetalle
			loItem.Jurisdiccion = c_Impuestosdetalle.Jurisdiccion
			loItem.JurisdiccionDescripcion = c_Impuestosdetalle.JurisdiccionDescripcion
			loItem.Resolucion = c_Impuestosdetalle.Resolucion
			loItem.MinimoNoImponible = c_Impuestosdetalle.MinimoNoImponible
			loItem.Porcentaje = c_Impuestosdetalle.Porcentaje
			loItem.Monto = c_Impuestosdetalle.Monto
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
			
			if vartype( this.Item[lni].CONVENIOMULTILATERAL) = 'C'
				if len( alltrim( this.Item[lni].CONVENIOMULTILATERAL )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CONVENIOMULTILATERAL del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CONVENIOMULTILATERAL ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CONVENIOMULTILATERAL del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PORCENTAJEDECONVENIO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].PORCENTAJEDECONVENIO ) ) ) 
				lnValorDelDecimal = this.Item[lni].PORCENTAJEDECONVENIO - int( this.Item[lni].PORCENTAJEDECONVENIO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 4
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo PORCENTAJEDECONVENIO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:4), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PORCENTAJEDECONVENIO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PORCENTAJEDEBASE) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].PORCENTAJEDEBASE ) ) ) 
				lnValorDelDecimal = this.Item[lni].PORCENTAJEDEBASE - int( this.Item[lni].PORCENTAJEDEBASE )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 4
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo PORCENTAJEDEBASE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:4), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PORCENTAJEDEBASE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTOBASE) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTOBASE ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTOBASE - int( this.Item[lni].MONTOBASE )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTOBASE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTOBASE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].BASEDECALCULO) = 'C'
				if len( alltrim( this.Item[lni].BASEDECALCULO )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo BASEDECALCULO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].BASEDECALCULO ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo BASEDECALCULO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].REGIMENIMPOSITIVO) = 'C'
				if len( alltrim( this.Item[lni].REGIMENIMPOSITIVO )) <= 5
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo REGIMENIMPOSITIVO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].REGIMENIMPOSITIVO ))) + ' Máxima:5), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo REGIMENIMPOSITIVO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ESCALA) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ESCALA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MINIMO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MINIMO ) ) ) 
				lnValorDelDecimal = this.Item[lni].MINIMO - int( this.Item[lni].MINIMO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MINIMO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MINIMO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ACUMULADOPAGOS) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].ACUMULADOPAGOS ) ) ) 
				lnValorDelDecimal = this.Item[lni].ACUMULADOPAGOS - int( this.Item[lni].ACUMULADOPAGOS )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo ACUMULADOPAGOS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ACUMULADOPAGOS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ACUMULADORETENCIONES) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].ACUMULADORETENCIONES ) ) ) 
				lnValorDelDecimal = this.Item[lni].ACUMULADORETENCIONES - int( this.Item[lni].ACUMULADORETENCIONES )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo ACUMULADORETENCIONES del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ACUMULADORETENCIONES del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ESCALAMONTOFIJO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].ESCALAMONTOFIJO ) ) ) 
				lnValorDelDecimal = this.Item[lni].ESCALAMONTOFIJO - int( this.Item[lni].ESCALAMONTOFIJO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo ESCALAMONTOFIJO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ESCALAMONTOFIJO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ESCALAPORCENTAJE) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].ESCALAPORCENTAJE ) ) ) 
				lnValorDelDecimal = this.Item[lni].ESCALAPORCENTAJE - int( this.Item[lni].ESCALAPORCENTAJE )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 4
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo ESCALAPORCENTAJE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:4), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ESCALAPORCENTAJE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ESCALASOBREEXCEDENTE) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].ESCALASOBREEXCEDENTE ) ) ) 
				lnValorDelDecimal = this.Item[lni].ESCALASOBREEXCEDENTE - int( this.Item[lni].ESCALASOBREEXCEDENTE )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo ESCALASOBREEXCEDENTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ESCALASOBREEXCEDENTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MINIMONOIMP) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MINIMONOIMP ) ) ) 
				lnValorDelDecimal = this.Item[lni].MINIMONOIMP - int( this.Item[lni].MINIMONOIMP )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MINIMONOIMP del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MINIMONOIMP del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTOCOMPROBANTEORIGEN) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTOCOMPROBANTEORIGEN ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTOCOMPROBANTEORIGEN - int( this.Item[lni].MONTOCOMPROBANTEORIGEN )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTOCOMPROBANTEORIGEN del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTOCOMPROBANTEORIGEN del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].REGIMENIMPOSITIVODESCRIPCION) = 'C'
				if len( alltrim( this.Item[lni].REGIMENIMPOSITIVODESCRIPCION )) <= 100
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo REGIMENIMPOSITIVODESCRIPCION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].REGIMENIMPOSITIVODESCRIPCION ))) + ' Máxima:100), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo REGIMENIMPOSITIVODESCRIPCION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ACUMULADOCOMPROBANTES) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].ACUMULADOCOMPROBANTES ) ) ) 
				lnValorDelDecimal = this.Item[lni].ACUMULADOCOMPROBANTES - int( this.Item[lni].ACUMULADOCOMPROBANTES )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo ACUMULADOCOMPROBANTES del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ACUMULADOCOMPROBANTES del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ESRG2616AR) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ESRG2616AR del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ESRG1575AR) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ESRG1575AR del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CERTIFICADOSIRE) = 'C'
				if len( alltrim( this.Item[lni].CERTIFICADOSIRE )) <= 25
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CERTIFICADOSIRE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CERTIFICADOSIRE ))) + ' Máxima:25), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CERTIFICADOSIRE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CODSEGURIDADSIRE) = 'C'
				if len( alltrim( this.Item[lni].CODSEGURIDADSIRE )) <= 4
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODSEGURIDADSIRE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODSEGURIDADSIRE ))) + ' Máxima:4), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODSEGURIDADSIRE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].JURISDICCION) = 'C'
				if len( alltrim( this.Item[lni].JURISDICCION )) <= 8
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo JURISDICCION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].JURISDICCION ))) + ' Máxima:8), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo JURISDICCION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].JURISDICCIONDESCRIPCION) = 'C'
				if len( alltrim( this.Item[lni].JURISDICCIONDESCRIPCION )) <= 50
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo JURISDICCIONDESCRIPCION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].JURISDICCIONDESCRIPCION ))) + ' Máxima:50), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo JURISDICCIONDESCRIPCION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].RESOLUCION) = 'C'
				if len( alltrim( this.Item[lni].RESOLUCION )) <= 60
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo RESOLUCION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].RESOLUCION ))) + ' Máxima:60), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo RESOLUCION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MINIMONOIMPONIBLE) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MINIMONOIMPONIBLE ) ) ) 
				lnValorDelDecimal = this.Item[lni].MINIMONOIMPONIBLE - int( this.Item[lni].MINIMONOIMPONIBLE )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MINIMONOIMPONIBLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MINIMONOIMPONIBLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PORCENTAJE) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].PORCENTAJE ) ) ) 
				lnValorDelDecimal = this.Item[lni].PORCENTAJE - int( this.Item[lni].PORCENTAJE )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 4
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo PORCENTAJE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:4), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PORCENTAJE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTO ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTO - int( this.Item[lni].MONTO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
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
		toItemDestino.Conveniomultilateral = toItemOrigen.Conveniomultilateral
		toItemDestino.Porcentajedeconvenio = toItemOrigen.Porcentajedeconvenio
		toItemDestino.Porcentajedebase = toItemOrigen.Porcentajedebase
		toItemDestino.Montobase = toItemOrigen.Montobase
		toItemDestino.Basedecalculo = toItemOrigen.Basedecalculo
		toItemDestino.Regimenimpositivo = toItemOrigen.Regimenimpositivo
		toItemDestino.Escala = toItemOrigen.Escala
		toItemDestino.Minimo = toItemOrigen.Minimo
		toItemDestino.Acumuladopagos = toItemOrigen.Acumuladopagos
		toItemDestino.Acumuladoretenciones = toItemOrigen.Acumuladoretenciones
		toItemDestino.Escalamontofijo = toItemOrigen.Escalamontofijo
		toItemDestino.Escalaporcentaje = toItemOrigen.Escalaporcentaje
		toItemDestino.Escalasobreexcedente = toItemOrigen.Escalasobreexcedente
		toItemDestino.Minimonoimp = toItemOrigen.Minimonoimp
		toItemDestino.Montocomprobanteorigen = toItemOrigen.Montocomprobanteorigen
		toItemDestino.Regimenimpositivodescripcion = toItemOrigen.Regimenimpositivodescripcion
		toItemDestino.Acumuladocomprobantes = toItemOrigen.Acumuladocomprobantes
		toItemDestino.Esrg2616ar = toItemOrigen.Esrg2616ar
		toItemDestino.Esrg1575ar = toItemOrigen.Esrg1575ar
		toItemDestino.Certificadosire = toItemOrigen.Certificadosire
		toItemDestino.Codseguridadsire = toItemOrigen.Codseguridadsire
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Codimp_PK = toItemOrigen.Codimp_PK
		toItemDestino.Codimpdetalle = toItemOrigen.Codimpdetalle
		toItemDestino.Jurisdiccion = toItemOrigen.Jurisdiccion
		toItemDestino.Jurisdicciondescripcion = toItemOrigen.Jurisdicciondescripcion
		toItemDestino.Resolucion = toItemOrigen.Resolucion
		toItemDestino.Minimonoimponible = toItemOrigen.Minimonoimponible
		toItemDestino.Porcentaje = toItemOrigen.Porcentaje
		toItemDestino.Monto = toItemOrigen.Monto
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
	Conveniomultilateral = []
	Porcentajedeconvenio = 0
	Porcentajedebase = 0
	Montobase = 0
	Basedecalculo = []
	Regimenimpositivo = []
	Escala = .F.
	Minimo = 0
	Acumuladopagos = 0
	Acumuladoretenciones = 0
	Escalamontofijo = 0
	Escalaporcentaje = 0
	Escalasobreexcedente = 0
	Minimonoimp = 0
	Montocomprobanteorigen = 0
	Regimenimpositivodescripcion = []
	Acumuladocomprobantes = 0
	Esrg2616ar = .F.
	Esrg1575ar = .F.
	Certificadosire = []
	Codseguridadsire = []
	Nroitem = 0
	Codimp_PK = []
	Codimpdetalle = []
	Jurisdiccion = []
	Jurisdicciondescripcion = []
	Resolucion = []
	Minimonoimponible = 0
	Porcentaje = 0
	Monto = 0
	NroItem = 0

enddefine