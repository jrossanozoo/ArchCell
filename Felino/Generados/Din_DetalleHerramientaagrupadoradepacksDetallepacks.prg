
define class Din_DetalleHERRAMIENTAAGRUPADORADEPACKSDetallepacks as detalle of detalle.prg

	Sum_Cantidad = 0

	nCantidadItems = 99999
	cNombre = 'Detallepacks'
	cEtiqueta = 'Detallepacks'
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
				.CodigoDeBarras = this.Item[ tnItem ].CodigoDeBarras
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodigoDeBarras', .CodigoDeBarras )
			
				.Comportamiento = this.Item[ tnItem ].Comportamiento
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Comportamiento', .Comportamiento )
			
				.NoProcesarStock = this.Item[ tnItem ].NoProcesarStock
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NoProcesarStock', .NoProcesarStock )
			
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.Numero = this.Item[ tnItem ].Numero
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Numero', .Numero )
			
				.Equivalencia_PK = this.Item[ tnItem ].Equivalencia_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Equivalencia_PK', .Equivalencia_PK )
			
				.Articulo_PK = this.Item[ tnItem ].Articulo_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Articulo_PK', .Articulo_PK )
			
				.ArticuloDetalle = this.Item[ tnItem ].ArticuloDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ArticuloDetalle', .ArticuloDetalle )
			
				.Color_PK = this.Item[ tnItem ].Color_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Color_PK', .Color_PK )
			
				.ColorDetalle = this.Item[ tnItem ].ColorDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ColorDetalle', .ColorDetalle )
			
				.Talle = this.Item[ tnItem ].Talle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Talle', .Talle )
			
				.Cantidad = this.Item[ tnItem ].Cantidad
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Cantidad', .Cantidad )
			
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
			.CodigoDeBarras = this.oItem.CodigoDeBarras
			.Comportamiento = this.oItem.Comportamiento
			.NoProcesarStock = this.oItem.NoProcesarStock
			.NROITEM = this.oItem.NROITEM
			.Numero = this.oItem.Numero
			.Equivalencia_PK = this.oItem.Equivalencia_PK
			.Articulo_PK = this.oItem.Articulo_PK
			.ArticuloDetalle = this.oItem.ArticuloDetalle
			.Color_PK = this.oItem.Color_PK
			.ColorDetalle = this.oItem.ColorDetalle
			.Talle = this.oItem.Talle
			.Cantidad = this.oItem.Cantidad
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
			.Item[ lnItem ].CodigoDeBarras = .oItem.CodigoDeBarras
			.Item[ lnItem ].Comportamiento = .oItem.Comportamiento
			.Item[ lnItem ].NoProcesarStock = .oItem.NoProcesarStock
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].Numero = .oItem.Numero
			.Item[ lnItem ].Equivalencia_PK = .oItem.Equivalencia_PK
			.Item[ lnItem ].Articulo_PK = .oItem.Articulo_PK
			.Item[ lnItem ].ArticuloDetalle = .oItem.ArticuloDetalle
			.Item[ lnItem ].Color_PK = .oItem.Color_PK
			.Item[ lnItem ].ColorDetalle = .oItem.ColorDetalle
			.Item[ lnItem ].Talle = .oItem.Talle
			.Item[ lnItem ].Cantidad = .oItem.Cantidad
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Sumarizar() as boolean
		local lnItem as integer, loItem as Object, lnSum_Cantidad as Number

		with this
			lnSum_Cantidad = 0
			if this.lEsNavegacion
				if select( 'c_Detallepacks' ) > 0 and reccount( 'c_Detallepacks' ) > 0
					sum Cantidad;
						 to ;
						 lnSum_Cantidad
				endif
				this.lEsNavegacion = .f.
			else
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							if !empty(.ARTICULO_PK)
								lnSum_Cantidad = lnSum_Cantidad + .Cantidad
							endif
						endwith
					endif
				endfor

				if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
					loItem = .oItem
					with loItem 
						lnSum_Cantidad = lnSum_Cantidad + .Cantidad
					endwith
				endif
			endif

			if .Sum_Cantidad != lnSum_Cantidad
				.Sum_Cantidad = lnSum_Cantidad
				.EventoCambioSum_Cantidad()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Cantidad() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalizar( toItem as Object ) as Void
		local lnItem as integer, loItem as Object, lnSum_Cantidad as Number

		with this
			lnSum_Cantidad = 0
			if !this.lEsNavegacion
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							if !empty(.ARTICULO_PK)
								lnSum_Cantidad = lnSum_Cantidad + .Cantidad
							endif
						endwith
					endif
				endfor

			endif
			if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
				loItem = .oItem
				with loItem 
					if !empty(.ARTICULO_PK)
						lnSum_Cantidad = lnSum_Cantidad + .Cantidad
					endif
				endwith
			endif

			if .Sum_Cantidad != lnSum_Cantidad
				.Sum_Cantidad = lnSum_Cantidad
				.EventoCambioSum_Cantidad()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Acumular( tlForzar as Boolean, tcAtributo as String, tnValor as Decimal, tnValorAnt as Decimal ) as Void
		local lnItem as integer, loItem as Object, lnSum_Cantidad as Number

		do case
		case tnValor = tnValorAnt
		case tcAtributo == 'Cantidad'
			this.Sum_Cantidad = this.Sum_Cantidad - tnValorAnt + tnValor
			this.EventoCambioSum_Cantidad()

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
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemHERRAMIENTAAGRUPADORADEPACKSDetallepacks' )
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

		select c_Detallepacks
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Comportamiento = c_Detallepacks.Comportamiento
			loItem.NoProcesarStock = c_Detallepacks.NoProcesarStock
			loItem.NROITEM = c_Detallepacks.NROITEM
			loItem.Numero = c_Detallepacks.Numero
			loItem.Equivalencia_PK = c_Detallepacks.Equivalencia
			loItem.Articulo_PK = c_Detallepacks.Articulo
			loItem.ArticuloDetalle = c_Detallepacks.ArticuloDetalle
			loItem.Color_PK = c_Detallepacks.Color
			loItem.ColorDetalle = c_Detallepacks.ColorDetalle
			loItem.Talle = c_Detallepacks.Talle
			loItem.Cantidad = c_Detallepacks.Cantidad
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

		if  empty( this.item[ tnItem ].Articulo_PK ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc


	*-----------------------------------------------------------------------------------------
	Function ValidarFormatoAtributos() as boolean
	local lnLargoEntero as integer, lnValorDelDecimal as integer, lnLargoDecimal as integer, llRetorno as boolean, lnI as Integer

		llRetorno = dodefault()
		for lni = 1 to this.Count
			
			if vartype( this.Item[lni].COMPORTAMIENTO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].COMPORTAMIENTO ) ) ) 
				lnValorDelDecimal = this.Item[lni].COMPORTAMIENTO - int( this.Item[lni].COMPORTAMIENTO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 1
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo COMPORTAMIENTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:1), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo COMPORTAMIENTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NOPROCESARSTOCK) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NOPROCESARSTOCK del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].NUMERO) = 'C'
				if len( alltrim( this.Item[lni].NUMERO )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo NUMERO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].NUMERO ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NUMERO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].EQUIVALENCIA_PK) = 'C'
				if len( alltrim( this.Item[lni].EQUIVALENCIA_PK )) <= 14
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo EQUIVALENCIA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].EQUIVALENCIA_PK ))) + ' Máxima:14), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo EQUIVALENCIA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ARTICULO_PK) = 'C'
				if len( alltrim( this.Item[lni].ARTICULO_PK )) <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo ARTICULO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].ARTICULO_PK ))) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ARTICULO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ARTICULODETALLE) = 'C'
				if len( alltrim( this.Item[lni].ARTICULODETALLE )) <= 40
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo ARTICULODETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].ARTICULODETALLE ))) + ' Máxima:40), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ARTICULODETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].COLOR_PK) = 'C'
				if len( alltrim( this.Item[lni].COLOR_PK )) <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo COLOR del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].COLOR_PK ))) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo COLOR del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].COLORDETALLE) = 'C'
				if len( alltrim( this.Item[lni].COLORDETALLE )) <= 50
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo COLORDETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].COLORDETALLE ))) + ' Máxima:50), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo COLORDETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TALLE) = 'C'
				if len( alltrim( this.Item[lni].TALLE )) <= 5
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TALLE ))) + ' Máxima:5), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CANTIDAD) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].CANTIDAD ) ) ) 
				lnValorDelDecimal = this.Item[lni].CANTIDAD - int( this.Item[lni].CANTIDAD )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 8
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo CANTIDAD del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:8), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CANTIDAD del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Codigodebarras = toItemOrigen.Codigodebarras
		toItemDestino.Comportamiento = toItemOrigen.Comportamiento
		toItemDestino.Noprocesarstock = toItemOrigen.Noprocesarstock
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Numero = toItemOrigen.Numero
		toItemDestino.Equivalencia_PK = toItemOrigen.Equivalencia_PK
		toItemDestino.Articulo_PK = toItemOrigen.Articulo_PK
		toItemDestino.Articulodetalle = toItemOrigen.Articulodetalle
		toItemDestino.Color_PK = toItemOrigen.Color_PK
		toItemDestino.Colordetalle = toItemOrigen.Colordetalle
		toItemDestino.Talle = toItemOrigen.Talle
		toItemDestino.Cantidad = toItemOrigen.Cantidad
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
	function ObtenerAtributoPrePantalla() as String
		return 'Articulo_PK'
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
		lcRetorno = 'Articulo_pk'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Codigodebarras = []
	Comportamiento = 0
	Noprocesarstock = .F.
	Nroitem = 0
	Numero = []
	Equivalencia_PK = []
	Articulo_PK = []
	Articulodetalle = []
	Color_PK = []
	Colordetalle = []
	Talle = []
	Cantidad = 0
	NroItem = 0

enddefine