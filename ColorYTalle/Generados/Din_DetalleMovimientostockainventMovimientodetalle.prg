
define class Din_DetalleMOVIMIENTOSTOCKAINVENTMovimientodetalle as DetalleArticulosproduccion of DetalleArticulosproduccion.Prg

	Sum_Cantidad = 0

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
			
				.Cantidad = this.Item[ tnItem ].Cantidad
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Cantidad', .Cantidad )
			
				.InventarioDestino_PK = this.Item[ tnItem ].InventarioDestino_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'InventarioDestino_PK', .InventarioDestino_PK )
			
				.InventarioDestinoDetalle = this.Item[ tnItem ].InventarioDestinoDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'InventarioDestinoDetalle', .InventarioDestinoDetalle )
			
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
			.Inventario_PK = this.oItem.Inventario_PK
			.NROITEM = this.oItem.NROITEM
			.Insumo_PK = this.oItem.Insumo_PK
			.InsumoDetalle = this.oItem.InsumoDetalle
			.Color_PK = this.oItem.Color_PK
			.ColorDetalle = this.oItem.ColorDetalle
			.Talle_PK = this.oItem.Talle_PK
			.TalleDetalle = this.oItem.TalleDetalle
			.Partida = this.oItem.Partida
			.Cantidad = this.oItem.Cantidad
			.InventarioDestino_PK = this.oItem.InventarioDestino_PK
			.InventarioDestinoDetalle = this.oItem.InventarioDestinoDetalle
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
			.Item[ lnItem ].Inventario_PK = .oItem.Inventario_PK
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].Insumo_PK = .oItem.Insumo_PK
			.Item[ lnItem ].InsumoDetalle = .oItem.InsumoDetalle
			.Item[ lnItem ].Color_PK = .oItem.Color_PK
			.Item[ lnItem ].ColorDetalle = .oItem.ColorDetalle
			.Item[ lnItem ].Talle_PK = .oItem.Talle_PK
			.Item[ lnItem ].TalleDetalle = .oItem.TalleDetalle
			.Item[ lnItem ].Partida = .oItem.Partida
			.Item[ lnItem ].Cantidad = .oItem.Cantidad
			.Item[ lnItem ].InventarioDestino_PK = .oItem.InventarioDestino_PK
			.Item[ lnItem ].InventarioDestinoDetalle = .oItem.InventarioDestinoDetalle
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
				if select( 'c_Movimientodetalle' ) > 0 and reccount( 'c_Movimientodetalle' ) > 0
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
							if !empty(.INSUMO_PK)
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
							if !empty(.INSUMO_PK)
								lnSum_Cantidad = lnSum_Cantidad + .Cantidad
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
			this.oItem = _Screen.zoo.crearobjeto( 'ItemMOVIMIENTOSTOCKAINVENTMovimientodetalle' )
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
			loItem.Inventario_PK = c_Movimientodetalle.Inventario
			loItem.NROITEM = c_Movimientodetalle.NROITEM
			loItem.Insumo_PK = c_Movimientodetalle.Insumo
			loItem.InsumoDetalle = c_Movimientodetalle.InsumoDetalle
			loItem.Color_PK = c_Movimientodetalle.Color
			loItem.ColorDetalle = c_Movimientodetalle.ColorDetalle
			loItem.Talle_PK = c_Movimientodetalle.Talle
			loItem.TalleDetalle = c_Movimientodetalle.TalleDetalle
			loItem.Partida = c_Movimientodetalle.Partida
			loItem.Cantidad = c_Movimientodetalle.Cantidad
			loItem.InventarioDestino_PK = c_Movimientodetalle.InventarioDestino
			loItem.InventarioDestinoDetalle = c_Movimientodetalle.InventarioDestinoDetalle
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
			
			if vartype( this.Item[lni].INVENTARIODESTINO_PK) = 'C'
				if len( alltrim( this.Item[lni].INVENTARIODESTINO_PK )) <= 15
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo INVENTARIODESTINO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].INVENTARIODESTINO_PK ))) + ' Máxima:15), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo INVENTARIODESTINO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].INVENTARIODESTINODETALLE) = 'C'
				if len( alltrim( this.Item[lni].INVENTARIODESTINODETALLE )) <= 100
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo INVENTARIODESTINODETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].INVENTARIODESTINODETALLE ))) + ' Máxima:100), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo INVENTARIODESTINODETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Inventario_PK = toItemOrigen.Inventario_PK
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Insumo_PK = toItemOrigen.Insumo_PK
		toItemDestino.Insumodetalle = toItemOrigen.Insumodetalle
		toItemDestino.Color_PK = toItemOrigen.Color_PK
		toItemDestino.Colordetalle = toItemOrigen.Colordetalle
		toItemDestino.Talle_PK = toItemOrigen.Talle_PK
		toItemDestino.Talledetalle = toItemOrigen.Talledetalle
		toItemDestino.Partida = toItemOrigen.Partida
		toItemDestino.Cantidad = toItemOrigen.Cantidad
		toItemDestino.Inventariodestino_PK = toItemOrigen.Inventariodestino_PK
		toItemDestino.Inventariodestinodetalle = toItemOrigen.Inventariodestinodetalle
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
	Inventario_PK = []
	Nroitem = 0
	Insumo_PK = []
	Insumodetalle = []
	Color_PK = []
	Colordetalle = []
	Talle_PK = []
	Talledetalle = []
	Partida = []
	Cantidad = 0
	Inventariodestino_PK = []
	Inventariodestinodetalle = []
	NroItem = 0

enddefine