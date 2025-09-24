
define class Din_DetalleOPERACIONECOMMERCEPublicaciondetalle as detalle of detalle.prg

	Sum_Cantidad = 0
	Sum_Monto = 0

	nCantidadItems = 999
	cNombre = 'Publicaciondetalle'
	cEtiqueta = 'Operación detalle'
	cMensajeErrorUnicidad = 'La columna  no admite valores repetidos.'
	cNombreVisual = 'Detalle de operaciones'

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
				.IDPublicacion = this.Item[ tnItem ].IDPublicacion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'IDPublicacion', .IDPublicacion )
			
				.Codigo = this.Item[ tnItem ].Codigo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Codigo', .Codigo )
			
				.Comportamiento = this.Item[ tnItem ].Comportamiento
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Comportamiento', .Comportamiento )
			
				.StoreOrderId = this.Item[ tnItem ].StoreOrderId
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'StoreOrderId', .StoreOrderId )
			
				.NumeroOperacion = this.Item[ tnItem ].NumeroOperacion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumeroOperacion', .NumeroOperacion )
			
				.NroOperacionCancelacion = this.Item[ tnItem ].NroOperacionCancelacion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NroOperacionCancelacion', .NroOperacionCancelacion )
			
				.CodigoHerrCancelacion = this.Item[ tnItem ].CodigoHerrCancelacion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodigoHerrCancelacion', .CodigoHerrCancelacion )
			
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.Descripcion = this.Item[ tnItem ].Descripcion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Descripcion', .Descripcion )
			
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
			
				.Precio = this.Item[ tnItem ].Precio
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Precio', .Precio )
			
				.Monto = this.Item[ tnItem ].Monto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Monto', .Monto )
			
				.Descuento = this.Item[ tnItem ].Descuento
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Descuento', .Descuento )
			
				.MontoDescuento = this.Item[ tnItem ].MontoDescuento
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoDescuento', .MontoDescuento )
			
				.FechaCancelacion = this.Item[ tnItem ].FechaCancelacion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'FechaCancelacion', .FechaCancelacion )
			
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
			.IDPublicacion = this.oItem.IDPublicacion
			.Codigo = this.oItem.Codigo
			.Comportamiento = this.oItem.Comportamiento
			.StoreOrderId = this.oItem.StoreOrderId
			.NumeroOperacion = this.oItem.NumeroOperacion
			.NroOperacionCancelacion = this.oItem.NroOperacionCancelacion
			.CodigoHerrCancelacion = this.oItem.CodigoHerrCancelacion
			.NROITEM = this.oItem.NROITEM
			.Descripcion = this.oItem.Descripcion
			.Articulo_PK = this.oItem.Articulo_PK
			.ArticuloDetalle = this.oItem.ArticuloDetalle
			.Color_PK = this.oItem.Color_PK
			.ColorDetalle = this.oItem.ColorDetalle
			.Talle = this.oItem.Talle
			.Cantidad = this.oItem.Cantidad
			.Precio = this.oItem.Precio
			.Monto = this.oItem.Monto
			.Descuento = this.oItem.Descuento
			.MontoDescuento = this.oItem.MontoDescuento
			.FechaCancelacion = this.oItem.FechaCancelacion
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
			.Item[ lnItem ].IDPublicacion = .oItem.IDPublicacion
			.Item[ lnItem ].Codigo = .oItem.Codigo
			.Item[ lnItem ].Comportamiento = .oItem.Comportamiento
			.Item[ lnItem ].StoreOrderId = .oItem.StoreOrderId
			.Item[ lnItem ].NumeroOperacion = .oItem.NumeroOperacion
			.Item[ lnItem ].NroOperacionCancelacion = .oItem.NroOperacionCancelacion
			.Item[ lnItem ].CodigoHerrCancelacion = .oItem.CodigoHerrCancelacion
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].Descripcion = .oItem.Descripcion
			.Item[ lnItem ].Articulo_PK = .oItem.Articulo_PK
			.Item[ lnItem ].ArticuloDetalle = .oItem.ArticuloDetalle
			.Item[ lnItem ].Color_PK = .oItem.Color_PK
			.Item[ lnItem ].ColorDetalle = .oItem.ColorDetalle
			.Item[ lnItem ].Talle = .oItem.Talle
			.Item[ lnItem ].Cantidad = .oItem.Cantidad
			.Item[ lnItem ].Precio = .oItem.Precio
			.Item[ lnItem ].Monto = .oItem.Monto
			.Item[ lnItem ].Descuento = .oItem.Descuento
			.Item[ lnItem ].MontoDescuento = .oItem.MontoDescuento
			.Item[ lnItem ].FechaCancelacion = .oItem.FechaCancelacion
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Sumarizar() as boolean
		local lnItem as integer, loItem as Object, lnSum_Cantidad as Number, lnSum_Monto as Number

		with this
			lnSum_Cantidad = 0
			lnSum_Monto = 0
			if this.lEsNavegacion
				if select( 'c_Publicaciondetalle' ) > 0 and reccount( 'c_Publicaciondetalle' ) > 0
					sum Cantidad, Monto;
						 to ;
						 lnSum_Cantidad, lnSum_Monto
				endif
				this.lEsNavegacion = .f.
			else
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							lnSum_Cantidad = lnSum_Cantidad + .Cantidad
							lnSum_Monto = lnSum_Monto + .Monto
						endwith
					endif
				endfor

				if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
					loItem = .oItem
					with loItem 
						lnSum_Cantidad = lnSum_Cantidad + .Cantidad
						lnSum_Monto = lnSum_Monto + .Monto
					endwith
				endif
			endif

			if .Sum_Cantidad != lnSum_Cantidad
				.Sum_Cantidad = lnSum_Cantidad
				.EventoCambioSum_Cantidad()
			endif
			if .Sum_Monto != lnSum_Monto
				.Sum_Monto = lnSum_Monto
				.EventoCambioSum_Monto()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Cantidad() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Monto() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalizar( toItem as Object ) as Void
		local lnItem as integer, loItem as Object, lnSum_Cantidad as Number, lnSum_Monto as Number

		with this
			lnSum_Cantidad = 0
			lnSum_Monto = 0
			if !this.lEsNavegacion
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							lnSum_Cantidad = lnSum_Cantidad + .Cantidad
							lnSum_Monto = lnSum_Monto + .Monto
						endwith
					endif
				endfor

			endif
			if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
				loItem = .oItem
				with loItem 
					lnSum_Cantidad = lnSum_Cantidad + .Cantidad
					lnSum_Monto = lnSum_Monto + .Monto
				endwith
			endif

			if .Sum_Cantidad != lnSum_Cantidad
				.Sum_Cantidad = lnSum_Cantidad
				.EventoCambioSum_Cantidad()
			endif
			if .Sum_Monto != lnSum_Monto
				.Sum_Monto = lnSum_Monto
				.EventoCambioSum_Monto()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Acumular( tlForzar as Boolean, tcAtributo as String, tnValor as Decimal, tnValorAnt as Decimal ) as Void
		local lnItem as integer, loItem as Object, lnSum_Cantidad as Number, lnSum_Monto as Number

		do case
		case tnValor = tnValorAnt
		case tcAtributo == 'Cantidad'
			this.Sum_Cantidad = this.Sum_Cantidad - tnValorAnt + tnValor
			this.EventoCambioSum_Cantidad()
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
			this.oItem = _Screen.zoo.crearobjeto( 'ItemOPERACIONECOMMERCEPublicaciondetalle' )
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

		select c_Publicaciondetalle
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.IDPublicacion = c_Publicaciondetalle.IDPublicacion
			loItem.Codigo = c_Publicaciondetalle.Codigo
			loItem.Comportamiento = c_Publicaciondetalle.Comportamiento
			loItem.StoreOrderId = c_Publicaciondetalle.StoreOrderId
			loItem.NumeroOperacion = c_Publicaciondetalle.NumeroOperacion
			loItem.NroOperacionCancelacion = c_Publicaciondetalle.NroOperacionCancelacion
			loItem.CodigoHerrCancelacion = c_Publicaciondetalle.CodigoHerrCancelacion
			loItem.NROITEM = c_Publicaciondetalle.NROITEM
			loItem.Descripcion = c_Publicaciondetalle.Descripcion
			loItem.Articulo_PK = c_Publicaciondetalle.Articulo
			loItem.ArticuloDetalle = c_Publicaciondetalle.ArticuloDetalle
			loItem.Color_PK = c_Publicaciondetalle.Color
			loItem.ColorDetalle = c_Publicaciondetalle.ColorDetalle
			loItem.Talle = c_Publicaciondetalle.Talle
			loItem.Cantidad = c_Publicaciondetalle.Cantidad
			loItem.Precio = c_Publicaciondetalle.Precio
			loItem.Monto = c_Publicaciondetalle.Monto
			loItem.Descuento = c_Publicaciondetalle.Descuento
			loItem.MontoDescuento = c_Publicaciondetalle.MontoDescuento
			loItem.FechaCancelacion = goLibrerias.ObtenerFechaFormateada( c_Publicaciondetalle.FechaCancelacion )
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

		if  empty( this.item[ tnItem ].Idpublicacion ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc


	*-----------------------------------------------------------------------------------------
	Function ValidarFormatoAtributos() as boolean
	local lnLargoEntero as integer, lnValorDelDecimal as integer, lnLargoDecimal as integer, llRetorno as boolean, lnI as Integer

		llRetorno = dodefault()
		for lni = 1 to this.Count
			
			if vartype( this.Item[lni].IDPUBLICACION) = 'C'
				if len( alltrim( this.Item[lni].IDPUBLICACION )) <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo IDPUBLICACION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].IDPUBLICACION ))) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo IDPUBLICACION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].STOREORDERID) = 'C'
				if len( alltrim( this.Item[lni].STOREORDERID )) <= 20
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo STOREORDERID del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].STOREORDERID ))) + ' Máxima:20), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo STOREORDERID del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NUMEROOPERACION) = 'C'
				if len( alltrim( this.Item[lni].NUMEROOPERACION )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo NUMEROOPERACION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].NUMEROOPERACION ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NUMEROOPERACION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NROOPERACIONCANCELACION) = 'C'
				if len( alltrim( this.Item[lni].NROOPERACIONCANCELACION )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo NROOPERACIONCANCELACION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].NROOPERACIONCANCELACION ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NROOPERACIONCANCELACION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CODIGOHERRCANCELACION) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].CODIGOHERRCANCELACION ) ) ) 
				lnValorDelDecimal = this.Item[lni].CODIGOHERRCANCELACION - int( this.Item[lni].CODIGOHERRCANCELACION )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo CODIGOHERRCANCELACION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGOHERRCANCELACION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].DESCRIPCION) = 'C'
				if len( alltrim( this.Item[lni].DESCRIPCION )) <= 100
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo DESCRIPCION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].DESCRIPCION ))) + ' Máxima:100), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo DESCRIPCION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
				if len( alltrim( this.Item[lni].TALLE )) <= 3
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TALLE ))) + ' Máxima:3), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CANTIDAD) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].CANTIDAD ) ) ) 
				lnValorDelDecimal = this.Item[lni].CANTIDAD - int( this.Item[lni].CANTIDAD )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo CANTIDAD del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CANTIDAD del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PRECIO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].PRECIO ) ) ) 
				lnValorDelDecimal = this.Item[lni].PRECIO - int( this.Item[lni].PRECIO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo PRECIO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PRECIO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].DESCUENTO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].DESCUENTO ) ) ) 
				if 0 > this.Item[lni].DESCUENTO 
					lnLargoEntero = lnLargoEntero - 1
				Endif
				lnValorDelDecimal = this.Item[lni].DESCUENTO - int( this.Item[lni].DESCUENTO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo DESCUENTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo DESCUENTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTODESCUENTO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTODESCUENTO ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTODESCUENTO - int( this.Item[lni].MONTODESCUENTO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTODESCUENTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTODESCUENTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if inlist(vartype( this.Item[lni].FECHACANCELACION),'D','T')
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo FECHACANCELACION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Idpublicacion = toItemOrigen.Idpublicacion
		toItemDestino.Codigo = toItemOrigen.Codigo
		toItemDestino.Comportamiento = toItemOrigen.Comportamiento
		toItemDestino.Storeorderid = toItemOrigen.Storeorderid
		toItemDestino.Numerooperacion = toItemOrigen.Numerooperacion
		toItemDestino.Nrooperacioncancelacion = toItemOrigen.Nrooperacioncancelacion
		toItemDestino.Codigoherrcancelacion = toItemOrigen.Codigoherrcancelacion
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Descripcion = toItemOrigen.Descripcion
		toItemDestino.Articulo_PK = toItemOrigen.Articulo_PK
		toItemDestino.Articulodetalle = toItemOrigen.Articulodetalle
		toItemDestino.Color_PK = toItemOrigen.Color_PK
		toItemDestino.Colordetalle = toItemOrigen.Colordetalle
		toItemDestino.Talle = toItemOrigen.Talle
		toItemDestino.Cantidad = toItemOrigen.Cantidad
		toItemDestino.Precio = toItemOrigen.Precio
		toItemDestino.Monto = toItemOrigen.Monto
		toItemDestino.Descuento = toItemOrigen.Descuento
		toItemDestino.Montodescuento = toItemOrigen.Montodescuento
		toItemDestino.Fechacancelacion = toItemOrigen.Fechacancelacion
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
		lcRetorno = 'IDPublicacion'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Idpublicacion = []
	Codigo = []
	Comportamiento = 0
	Storeorderid = []
	Numerooperacion = []
	Nrooperacioncancelacion = []
	Codigoherrcancelacion = 0
	Nroitem = 0
	Descripcion = []
	Articulo_PK = []
	Articulodetalle = []
	Color_PK = []
	Colordetalle = []
	Talle = []
	Cantidad = 0
	Precio = 0
	Monto = 0
	Descuento = 0
	Montodescuento = 0
	Fechacancelacion = ctod( '  /  /    ' )
	NroItem = 0

enddefine