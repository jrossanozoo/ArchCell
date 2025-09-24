
define class Din_DetalleMOVIMIENTOSTOCKDESDEPRODUCCMovimientodetalle as DetalleArticulosproduccion of DetalleArticulosproduccion.Prg

	Sum_Cantidad = 0
	Sum_Cantidadstockdf = 0

	nCantidadItems = 999
	cNombre = 'Movimientodetalle'
	cEtiqueta = 'Artículos'
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
			
				.NoProcesarStock = this.Item[ tnItem ].NoProcesarStock
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NoProcesarStock', .NoProcesarStock )
			
				.CodigoDeBarras = this.Item[ tnItem ].CodigoDeBarras
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodigoDeBarras', .CodigoDeBarras )
			
				.Equivalencia_PK = this.Item[ tnItem ].Equivalencia_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Equivalencia_PK', .Equivalencia_PK )
			
				.Comportamiento = this.Item[ tnItem ].Comportamiento
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Comportamiento', .Comportamiento )
			
				.Inventario_PK = this.Item[ tnItem ].Inventario_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Inventario_PK', .Inventario_PK )
			
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.Insumo_PK = this.Item[ tnItem ].Insumo_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Insumo_PK', .Insumo_PK )
			
				.InsumoDetalle = this.Item[ tnItem ].InsumoDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'InsumoDetalle', .InsumoDetalle )
			
				.Color_PK = this.Item[ tnItem ].Color_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Color_PK', .Color_PK )
			
				.ColorDetalle = this.Item[ tnItem ].ColorDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ColorDetalle', .ColorDetalle )
			
				.Talle_PK = this.Item[ tnItem ].Talle_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Talle_PK', .Talle_PK )
			
				.TalleDetalle = this.Item[ tnItem ].TalleDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TalleDetalle', .TalleDetalle )
			
				.Partida = this.Item[ tnItem ].Partida
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Partida', .Partida )
			
				.Unidad_PK = this.Item[ tnItem ].Unidad_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Unidad_PK', .Unidad_PK )
			
				.Cantidad = this.Item[ tnItem ].Cantidad
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Cantidad', .Cantidad )
			
				.Articulo_PK = this.Item[ tnItem ].Articulo_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Articulo_PK', .Articulo_PK )
			
				.ArticuloDetalle = this.Item[ tnItem ].ArticuloDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ArticuloDetalle', .ArticuloDetalle )
			
				.ColorArt_PK = this.Item[ tnItem ].ColorArt_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ColorArt_PK', .ColorArt_PK )
			
				.ColorArtDetalle = this.Item[ tnItem ].ColorArtDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ColorArtDetalle', .ColorArtDetalle )
			
				.TalleArt_PK = this.Item[ tnItem ].TalleArt_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TalleArt_PK', .TalleArt_PK )
			
				.TalleArtDetalle = this.Item[ tnItem ].TalleArtDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TalleArtDetalle', .TalleArtDetalle )
			
				.UnidadStockDF_PK = this.Item[ tnItem ].UnidadStockDF_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'UnidadStockDF_PK', .UnidadStockDF_PK )
			
				.Rinde = this.Item[ tnItem ].Rinde
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Rinde', .Rinde )
			
				.CantidadStockDF = this.Item[ tnItem ].CantidadStockDF
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CantidadStockDF', .CantidadStockDF )
			
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
			.NoProcesarStock = this.oItem.NoProcesarStock
			.CodigoDeBarras = this.oItem.CodigoDeBarras
			.Equivalencia_PK = this.oItem.Equivalencia_PK
			.Comportamiento = this.oItem.Comportamiento
			.Inventario_PK = this.oItem.Inventario_PK
			.NROITEM = this.oItem.NROITEM
			.Insumo_PK = this.oItem.Insumo_PK
			.InsumoDetalle = this.oItem.InsumoDetalle
			.Color_PK = this.oItem.Color_PK
			.ColorDetalle = this.oItem.ColorDetalle
			.Talle_PK = this.oItem.Talle_PK
			.TalleDetalle = this.oItem.TalleDetalle
			.Partida = this.oItem.Partida
			.Unidad_PK = this.oItem.Unidad_PK
			.Cantidad = this.oItem.Cantidad
			.Articulo_PK = this.oItem.Articulo_PK
			.ArticuloDetalle = this.oItem.ArticuloDetalle
			.ColorArt_PK = this.oItem.ColorArt_PK
			.ColorArtDetalle = this.oItem.ColorArtDetalle
			.TalleArt_PK = this.oItem.TalleArt_PK
			.TalleArtDetalle = this.oItem.TalleArtDetalle
			.UnidadStockDF_PK = this.oItem.UnidadStockDF_PK
			.Rinde = this.oItem.Rinde
			.CantidadStockDF = this.oItem.CantidadStockDF
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
			.Item[ lnItem ].NoProcesarStock = .oItem.NoProcesarStock
			.Item[ lnItem ].CodigoDeBarras = .oItem.CodigoDeBarras
			.Item[ lnItem ].Equivalencia_PK = .oItem.Equivalencia_PK
			.Item[ lnItem ].Comportamiento = .oItem.Comportamiento
			.Item[ lnItem ].Inventario_PK = .oItem.Inventario_PK
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].Insumo_PK = .oItem.Insumo_PK
			.Item[ lnItem ].InsumoDetalle = .oItem.InsumoDetalle
			.Item[ lnItem ].Color_PK = .oItem.Color_PK
			.Item[ lnItem ].ColorDetalle = .oItem.ColorDetalle
			.Item[ lnItem ].Talle_PK = .oItem.Talle_PK
			.Item[ lnItem ].TalleDetalle = .oItem.TalleDetalle
			.Item[ lnItem ].Partida = .oItem.Partida
			.Item[ lnItem ].Unidad_PK = .oItem.Unidad_PK
			.Item[ lnItem ].Cantidad = .oItem.Cantidad
			.Item[ lnItem ].Articulo_PK = .oItem.Articulo_PK
			.Item[ lnItem ].ArticuloDetalle = .oItem.ArticuloDetalle
			.Item[ lnItem ].ColorArt_PK = .oItem.ColorArt_PK
			.Item[ lnItem ].ColorArtDetalle = .oItem.ColorArtDetalle
			.Item[ lnItem ].TalleArt_PK = .oItem.TalleArt_PK
			.Item[ lnItem ].TalleArtDetalle = .oItem.TalleArtDetalle
			.Item[ lnItem ].UnidadStockDF_PK = .oItem.UnidadStockDF_PK
			.Item[ lnItem ].Rinde = .oItem.Rinde
			.Item[ lnItem ].CantidadStockDF = .oItem.CantidadStockDF
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Sumarizar() as boolean
		local lnItem as integer, loItem as Object, lnSum_Cantidad as Number, lnSum_Cantidadstockdf as Number

		with this
			lnSum_Cantidad = 0
			lnSum_Cantidadstockdf = 0
			if this.lEsNavegacion
				if select( 'c_Movimientodetalle' ) > 0 and reccount( 'c_Movimientodetalle' ) > 0
					sum Cantidad, Cantidadstockdf;
						 to ;
						 lnSum_Cantidad, lnSum_Cantidadstockdf
				endif
				this.lEsNavegacion = .f.
			else
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							if !empty(.INSUMO_PK)
								lnSum_Cantidad = lnSum_Cantidad + .Cantidad
								lnSum_Cantidadstockdf = lnSum_Cantidadstockdf + .Cantidadstockdf
							endif
						endwith
					endif
				endfor

				if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
					loItem = .oItem
					with loItem 
						lnSum_Cantidad = lnSum_Cantidad + .Cantidad
						lnSum_Cantidadstockdf = lnSum_Cantidadstockdf + .Cantidadstockdf
					endwith
				endif
			endif

			if .Sum_Cantidad != lnSum_Cantidad
				.Sum_Cantidad = lnSum_Cantidad
				.EventoCambioSum_Cantidad()
			endif
			if .Sum_Cantidadstockdf != lnSum_Cantidadstockdf
				.Sum_Cantidadstockdf = lnSum_Cantidadstockdf
				.EventoCambioSum_Cantidadstockdf()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Cantidad() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Cantidadstockdf() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalizar( toItem as Object ) as Void
		local lnItem as integer, loItem as Object, lnSum_Cantidad as Number, lnSum_Cantidadstockdf as Number

		with this
			lnSum_Cantidad = 0
			lnSum_Cantidadstockdf = 0
			if !this.lEsNavegacion
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							if !empty(.INSUMO_PK)
								lnSum_Cantidad = lnSum_Cantidad + .Cantidad
								lnSum_Cantidadstockdf = lnSum_Cantidadstockdf + .Cantidadstockdf
							endif
						endwith
					endif
				endfor

			endif
			if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
				loItem = .oItem
				with loItem 
					if !empty(.INSUMO_PK)
						lnSum_Cantidad = lnSum_Cantidad + .Cantidad
						lnSum_Cantidadstockdf = lnSum_Cantidadstockdf + .Cantidadstockdf
					endif
				endwith
			endif

			if .Sum_Cantidad != lnSum_Cantidad
				.Sum_Cantidad = lnSum_Cantidad
				.EventoCambioSum_Cantidad()
			endif
			if .Sum_Cantidadstockdf != lnSum_Cantidadstockdf
				.Sum_Cantidadstockdf = lnSum_Cantidadstockdf
				.EventoCambioSum_Cantidadstockdf()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Acumular( tlForzar as Boolean, tcAtributo as String, tnValor as Decimal, tnValorAnt as Decimal ) as Void
		local lnItem as integer, loItem as Object, lnSum_Cantidad as Number, lnSum_Cantidadstockdf as Number

		do case
		case tnValor = tnValorAnt
		case tcAtributo == 'Cantidad'
			this.Sum_Cantidad = this.Sum_Cantidad - tnValorAnt + tnValor
			this.EventoCambioSum_Cantidad()
		case tcAtributo == 'Cantidadstockdf'
			this.Sum_Cantidadstockdf = this.Sum_Cantidadstockdf - tnValorAnt + tnValor
			this.EventoCambioSum_Cantidadstockdf()

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
			this.oItem = _Screen.zoo.crearobjeto( 'ItemMOVIMIENTOSTOCKDESDEPRODUCCMovimientodetalle' )
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

		select c_Movimientodetalle
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Codigo = c_Movimientodetalle.Codigo
			loItem.NoProcesarStock = c_Movimientodetalle.NoProcesarStock
			loItem.Equivalencia_PK = c_Movimientodetalle.Equivalencia
			loItem.Comportamiento = c_Movimientodetalle.Comportamiento
			loItem.Inventario_PK = c_Movimientodetalle.Inventario
			loItem.NROITEM = c_Movimientodetalle.NROITEM
			loItem.Insumo_PK = c_Movimientodetalle.Insumo
			loItem.InsumoDetalle = c_Movimientodetalle.InsumoDetalle
			loItem.Color_PK = c_Movimientodetalle.Color
			loItem.ColorDetalle = c_Movimientodetalle.ColorDetalle
			loItem.Talle_PK = c_Movimientodetalle.Talle
			loItem.TalleDetalle = c_Movimientodetalle.TalleDetalle
			loItem.Partida = c_Movimientodetalle.Partida
			loItem.Unidad_PK = c_Movimientodetalle.Unidad
			loItem.Cantidad = c_Movimientodetalle.Cantidad
			loItem.Articulo_PK = c_Movimientodetalle.Articulo
			loItem.ArticuloDetalle = c_Movimientodetalle.ArticuloDetalle
			loItem.ColorArt_PK = c_Movimientodetalle.ColorArt
			loItem.ColorArtDetalle = c_Movimientodetalle.ColorArtDetalle
			loItem.TalleArt_PK = c_Movimientodetalle.TalleArt
			loItem.TalleArtDetalle = c_Movimientodetalle.TalleArtDetalle
			loItem.UnidadStockDF_PK = c_Movimientodetalle.UnidadStockDF
			loItem.Rinde = c_Movimientodetalle.Rinde
			loItem.CantidadStockDF = c_Movimientodetalle.CantidadStockDF
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

		if  empty( this.item[ tnItem ].Insumo_PK ) 
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
			
			if vartype( this.Item[lni].NOPROCESARSTOCK) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NOPROCESARSTOCK del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].EQUIVALENCIA_PK) = 'C'
				if len( alltrim( this.Item[lni].EQUIVALENCIA_PK )) <= 20
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo EQUIVALENCIA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].EQUIVALENCIA_PK ))) + ' Máxima:20), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo EQUIVALENCIA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
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
			
			if vartype( this.Item[lni].INVENTARIO_PK) = 'C'
				if len( alltrim( this.Item[lni].INVENTARIO_PK )) <= 15
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo INVENTARIO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].INVENTARIO_PK ))) + ' Máxima:15), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo INVENTARIO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].INSUMO_PK) = 'C'
				if len( alltrim( this.Item[lni].INSUMO_PK )) <= 25
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo INSUMO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].INSUMO_PK ))) + ' Máxima:25), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo INSUMO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].INSUMODETALLE) = 'C'
				if len( alltrim( this.Item[lni].INSUMODETALLE )) <= 100
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo INSUMODETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].INSUMODETALLE ))) + ' Máxima:100), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo INSUMODETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].COLOR_PK) = 'C'
				if len( alltrim( this.Item[lni].COLOR_PK )) <= 6
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo COLOR del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].COLOR_PK ))) + ' Máxima:6), en el detalle ' + this.cEtiqueta + '.' )
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
			
			if vartype( this.Item[lni].TALLE_PK) = 'C'
				if len( alltrim( this.Item[lni].TALLE_PK )) <= 5
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TALLE_PK ))) + ' Máxima:5), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TALLEDETALLE) = 'C'
				if len( alltrim( this.Item[lni].TALLEDETALLE )) <= 50
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TALLEDETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TALLEDETALLE ))) + ' Máxima:50), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TALLEDETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PARTIDA) = 'C'
				if len( alltrim( this.Item[lni].PARTIDA )) <= 25
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo PARTIDA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].PARTIDA ))) + ' Máxima:25), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PARTIDA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].UNIDAD_PK) = 'C'
				if len( alltrim( this.Item[lni].UNIDAD_PK )) <= 3
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo UNIDAD del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].UNIDAD_PK ))) + ' Máxima:3), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo UNIDAD del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].ARTICULO_PK) = 'C'
				if len( alltrim( this.Item[lni].ARTICULO_PK )) <= 15
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo ARTICULO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].ARTICULO_PK ))) + ' Máxima:15), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ARTICULO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ARTICULODETALLE) = 'C'
				if len( alltrim( this.Item[lni].ARTICULODETALLE )) <= 100
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo ARTICULODETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].ARTICULODETALLE ))) + ' Máxima:100), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ARTICULODETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].COLORART_PK) = 'C'
				if len( alltrim( this.Item[lni].COLORART_PK )) <= 6
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo COLORART del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].COLORART_PK ))) + ' Máxima:6), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo COLORART del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].COLORARTDETALLE) = 'C'
				if len( alltrim( this.Item[lni].COLORARTDETALLE )) <= 50
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo COLORARTDETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].COLORARTDETALLE ))) + ' Máxima:50), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo COLORARTDETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TALLEART_PK) = 'C'
				if len( alltrim( this.Item[lni].TALLEART_PK )) <= 5
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TALLEART del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TALLEART_PK ))) + ' Máxima:5), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TALLEART del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TALLEARTDETALLE) = 'C'
				if len( alltrim( this.Item[lni].TALLEARTDETALLE )) <= 50
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TALLEARTDETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TALLEARTDETALLE ))) + ' Máxima:50), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TALLEARTDETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].UNIDADSTOCKDF_PK) = 'C'
				if len( alltrim( this.Item[lni].UNIDADSTOCKDF_PK )) <= 3
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo UNIDADSTOCKDF del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].UNIDADSTOCKDF_PK ))) + ' Máxima:3), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo UNIDADSTOCKDF del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].RINDE) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].RINDE ) ) ) 
				lnValorDelDecimal = this.Item[lni].RINDE - int( this.Item[lni].RINDE )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 7
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo RINDE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:7), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo RINDE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CANTIDADSTOCKDF) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].CANTIDADSTOCKDF ) ) ) 
				lnValorDelDecimal = this.Item[lni].CANTIDADSTOCKDF - int( this.Item[lni].CANTIDADSTOCKDF )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 8
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo CANTIDADSTOCKDF del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:8), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CANTIDADSTOCKDF del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Noprocesarstock = toItemOrigen.Noprocesarstock
		toItemDestino.Codigodebarras = toItemOrigen.Codigodebarras
		toItemDestino.Equivalencia_PK = toItemOrigen.Equivalencia_PK
		toItemDestino.Comportamiento = toItemOrigen.Comportamiento
		toItemDestino.Inventario_PK = toItemOrigen.Inventario_PK
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Insumo_PK = toItemOrigen.Insumo_PK
		toItemDestino.Insumodetalle = toItemOrigen.Insumodetalle
		toItemDestino.Color_PK = toItemOrigen.Color_PK
		toItemDestino.Colordetalle = toItemOrigen.Colordetalle
		toItemDestino.Talle_PK = toItemOrigen.Talle_PK
		toItemDestino.Talledetalle = toItemOrigen.Talledetalle
		toItemDestino.Partida = toItemOrigen.Partida
		toItemDestino.Unidad_PK = toItemOrigen.Unidad_PK
		toItemDestino.Cantidad = toItemOrigen.Cantidad
		toItemDestino.Articulo_PK = toItemOrigen.Articulo_PK
		toItemDestino.Articulodetalle = toItemOrigen.Articulodetalle
		toItemDestino.Colorart_PK = toItemOrigen.Colorart_PK
		toItemDestino.Colorartdetalle = toItemOrigen.Colorartdetalle
		toItemDestino.Talleart_PK = toItemOrigen.Talleart_PK
		toItemDestino.Talleartdetalle = toItemOrigen.Talleartdetalle
		toItemDestino.Unidadstockdf_PK = toItemOrigen.Unidadstockdf_PK
		toItemDestino.Rinde = toItemOrigen.Rinde
		toItemDestino.Cantidadstockdf = toItemOrigen.Cantidadstockdf
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
		lcRetorno = 'Insumo_pk'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Codigo = []
	Noprocesarstock = .F.
	Codigodebarras = []
	Equivalencia_PK = []
	Comportamiento = 0
	Inventario_PK = []
	Nroitem = 0
	Insumo_PK = []
	Insumodetalle = []
	Color_PK = []
	Colordetalle = []
	Talle_PK = []
	Talledetalle = []
	Partida = []
	Unidad_PK = []
	Cantidad = 0
	Articulo_PK = []
	Articulodetalle = []
	Colorart_PK = []
	Colorartdetalle = []
	Talleart_PK = []
	Talleartdetalle = []
	Unidadstockdf_PK = []
	Rinde = 0
	Cantidadstockdf = 0
	NroItem = 0

enddefine