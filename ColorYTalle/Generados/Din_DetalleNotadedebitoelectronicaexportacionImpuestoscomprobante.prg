
define class Din_DetalleNOTADEDEBITOELECTRONICAEXPORTACIONImpuestoscomprobante as detalle of detalle.prg

	Sum_Monto = 0

	nCantidadItems = 999
	cNombre = 'Impuestoscomprobante'
	cEtiqueta = 'Impuestos del comprobante'
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
			
				.NroItem = this.Item[ tnItem ].NroItem
			
				.Monto = this.Item[ tnItem ].Monto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Monto', .Monto )
			
				.Descripcion = this.Item[ tnItem ].Descripcion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Descripcion', .Descripcion )
			
				.TipoImpuesto = this.Item[ tnItem ].TipoImpuesto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TipoImpuesto', .TipoImpuesto )
			
				.CodigoInterno = this.Item[ tnItem ].CodigoInterno
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodigoInterno', .CodigoInterno )
			
				.Porcentaje = this.Item[ tnItem ].Porcentaje
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Porcentaje', .Porcentaje )
			
				.MinimoNoImponible = this.Item[ tnItem ].MinimoNoImponible
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MinimoNoImponible', .MinimoNoImponible )
			
				.Jurisdiccion_PK = this.Item[ tnItem ].Jurisdiccion_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Jurisdiccion_PK', .Jurisdiccion_PK )
			
				.CodigoImpuesto = this.Item[ tnItem ].CodigoImpuesto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodigoImpuesto', .CodigoImpuesto )
			
				.RegimenImpositivo = this.Item[ tnItem ].RegimenImpositivo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'RegimenImpositivo', .RegimenImpositivo )
			
				.MontoBase = this.Item[ tnItem ].MontoBase
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoBase', .MontoBase )
			
				.BaseDeCalculo = this.Item[ tnItem ].BaseDeCalculo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'BaseDeCalculo', .BaseDeCalculo )
			
				.Minimo = this.Item[ tnItem ].Minimo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Minimo', .Minimo )
			
				.CertificadoSIRE = this.Item[ tnItem ].CertificadoSIRE
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CertificadoSIRE', .CertificadoSIRE )
			
				.CodSeguridadSIRE = this.Item[ tnItem ].CodSeguridadSIRE
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodSeguridadSIRE', .CodSeguridadSIRE )
			
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
			.Codigo = this.oItem.Codigo
			.NroItem = this.oItem.NroItem
			.Monto = this.oItem.Monto
			.Descripcion = this.oItem.Descripcion
			.TipoImpuesto = this.oItem.TipoImpuesto
			.CodigoInterno = this.oItem.CodigoInterno
			.Porcentaje = this.oItem.Porcentaje
			.MinimoNoImponible = this.oItem.MinimoNoImponible
			.Jurisdiccion_PK = this.oItem.Jurisdiccion_PK
			.CodigoImpuesto = this.oItem.CodigoImpuesto
			.RegimenImpositivo = this.oItem.RegimenImpositivo
			.MontoBase = this.oItem.MontoBase
			.BaseDeCalculo = this.oItem.BaseDeCalculo
			.Minimo = this.oItem.Minimo
			.CertificadoSIRE = this.oItem.CertificadoSIRE
			.CodSeguridadSIRE = this.oItem.CodSeguridadSIRE
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
			.Item[ lnItem ].Codigo = .oItem.Codigo
			.Item[ lnItem ].NroItem = .oItem.NroItem
			.Item[ lnItem ].Monto = .oItem.Monto
			.Item[ lnItem ].Descripcion = .oItem.Descripcion
			.Item[ lnItem ].TipoImpuesto = .oItem.TipoImpuesto
			.Item[ lnItem ].CodigoInterno = .oItem.CodigoInterno
			.Item[ lnItem ].Porcentaje = .oItem.Porcentaje
			.Item[ lnItem ].MinimoNoImponible = .oItem.MinimoNoImponible
			.Item[ lnItem ].Jurisdiccion_PK = .oItem.Jurisdiccion_PK
			.Item[ lnItem ].CodigoImpuesto = .oItem.CodigoImpuesto
			.Item[ lnItem ].RegimenImpositivo = .oItem.RegimenImpositivo
			.Item[ lnItem ].MontoBase = .oItem.MontoBase
			.Item[ lnItem ].BaseDeCalculo = .oItem.BaseDeCalculo
			.Item[ lnItem ].Minimo = .oItem.Minimo
			.Item[ lnItem ].CertificadoSIRE = .oItem.CertificadoSIRE
			.Item[ lnItem ].CodSeguridadSIRE = .oItem.CodSeguridadSIRE
			.Item[ lnItem ].RG5329AplicaPorArticulo = .oItem.RG5329AplicaPorArticulo
			.Item[ lnItem ].RG5329Porcentaje = .oItem.RG5329Porcentaje
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
							lnSum_Monto = lnSum_Monto + .Monto
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
							lnSum_Monto = lnSum_Monto + .Monto
						endwith
					endif
				endfor

			endif
			if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
				loItem = .oItem
				with loItem 
					lnSum_Monto = lnSum_Monto + .Monto
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
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemNOTADEDEBITOELECTRONICAEXPORTACIONImpuestoscomprobante' )
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
			loItem.NroItem = c_Impuestoscomprobante.NroItem
			loItem.Monto = c_Impuestoscomprobante.Monto
			loItem.Descripcion = c_Impuestoscomprobante.Descripcion
			loItem.TipoImpuesto = c_Impuestoscomprobante.TipoImpuesto
			loItem.CodigoInterno = c_Impuestoscomprobante.CodigoInterno
			loItem.Porcentaje = c_Impuestoscomprobante.Porcentaje
			loItem.MinimoNoImponible = c_Impuestoscomprobante.MinimoNoImponible
			loItem.Jurisdiccion_PK = c_Impuestoscomprobante.Jurisdiccion
			loItem.CodigoImpuesto = c_Impuestoscomprobante.CodigoImpuesto
			loItem.RegimenImpositivo = c_Impuestoscomprobante.RegimenImpositivo
			loItem.MontoBase = c_Impuestoscomprobante.MontoBase
			loItem.BaseDeCalculo = c_Impuestoscomprobante.BaseDeCalculo
			loItem.Minimo = c_Impuestoscomprobante.Minimo
			loItem.CertificadoSIRE = c_Impuestoscomprobante.CertificadoSIRE
			loItem.CodSeguridadSIRE = c_Impuestoscomprobante.CodSeguridadSIRE
			loItem.RG5329AplicaPorArticulo = c_Impuestoscomprobante.RG5329AplicaPorArticulo
			loItem.RG5329Porcentaje = c_Impuestoscomprobante.RG5329Porcentaje
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
			
			if vartype( this.Item[lni].DESCRIPCION) = 'C'
				if len( alltrim( this.Item[lni].DESCRIPCION )) <= 250
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo DESCRIPCION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].DESCRIPCION ))) + ' Máxima:250), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo DESCRIPCION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TIPOIMPUESTO) = 'C'
				if len( alltrim( this.Item[lni].TIPOIMPUESTO )) <= 50
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TIPOIMPUESTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TIPOIMPUESTO ))) + ' Máxima:50), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TIPOIMPUESTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].PORCENTAJE) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].PORCENTAJE ) ) ) 
				lnValorDelDecimal = this.Item[lni].PORCENTAJE - int( this.Item[lni].PORCENTAJE )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo PORCENTAJE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PORCENTAJE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MINIMONOIMPONIBLE) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MINIMONOIMPONIBLE ) ) ) 
				lnValorDelDecimal = this.Item[lni].MINIMONOIMPONIBLE - int( this.Item[lni].MINIMONOIMPONIBLE )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MINIMONOIMPONIBLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MINIMONOIMPONIBLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].JURISDICCION_PK) = 'C'
				if len( alltrim( this.Item[lni].JURISDICCION_PK )) <= 8
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo JURISDICCION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].JURISDICCION_PK ))) + ' Máxima:8), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo JURISDICCION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CODIGOIMPUESTO) = 'C'
				if len( alltrim( this.Item[lni].CODIGOIMPUESTO )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGOIMPUESTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGOIMPUESTO ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGOIMPUESTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].RG5329APLICAPORARTICULO) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo RG5329APLICAPORARTICULO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].RG5329PORCENTAJE) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].RG5329PORCENTAJE ) ) ) 
				lnValorDelDecimal = this.Item[lni].RG5329PORCENTAJE - int( this.Item[lni].RG5329PORCENTAJE )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 4
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo RG5329PORCENTAJE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:4), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo RG5329PORCENTAJE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Monto = toItemOrigen.Monto
		toItemDestino.Descripcion = toItemOrigen.Descripcion
		toItemDestino.Tipoimpuesto = toItemOrigen.Tipoimpuesto
		toItemDestino.Codigointerno = toItemOrigen.Codigointerno
		toItemDestino.Porcentaje = toItemOrigen.Porcentaje
		toItemDestino.Minimonoimponible = toItemOrigen.Minimonoimponible
		toItemDestino.Jurisdiccion_PK = toItemOrigen.Jurisdiccion_PK
		toItemDestino.Codigoimpuesto = toItemOrigen.Codigoimpuesto
		toItemDestino.Regimenimpositivo = toItemOrigen.Regimenimpositivo
		toItemDestino.Montobase = toItemOrigen.Montobase
		toItemDestino.Basedecalculo = toItemOrigen.Basedecalculo
		toItemDestino.Minimo = toItemOrigen.Minimo
		toItemDestino.Certificadosire = toItemOrigen.Certificadosire
		toItemDestino.Codseguridadsire = toItemOrigen.Codseguridadsire
		toItemDestino.Rg5329aplicaporarticulo = toItemOrigen.Rg5329aplicaporarticulo
		toItemDestino.Rg5329porcentaje = toItemOrigen.Rg5329porcentaje
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


enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Codigo = []
	Nroitem = 0
	Monto = 0
	Descripcion = []
	Tipoimpuesto = []
	Codigointerno = []
	Porcentaje = 0
	Minimonoimponible = 0
	Jurisdiccion_PK = []
	Codigoimpuesto = []
	Regimenimpositivo = []
	Montobase = 0
	Basedecalculo = []
	Minimo = 0
	Certificadosire = []
	Codseguridadsire = []
	Rg5329aplicaporarticulo = .F.
	Rg5329porcentaje = 0
	NroItem = 0

enddefine