
define class Din_DetalleCIERREDELOTEDetalle as detalle of detalle.prg

	Sum_Montototal = 0
	Sum_Montototalanulacioncompras = 0
	Sum_Montototalanulaciondevoluciones = 0
	Sum_Montototalcompras = 0
	Sum_Montototaldevoluciones = 0

	nCantidadItems = 999
	cNombre = 'Detalle'
	cEtiqueta = 'Detalle'
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
			
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.NroLote = this.Item[ tnItem ].NroLote
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NroLote', .NroLote )
			
				.Tarjeta_PK = this.Item[ tnItem ].Tarjeta_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Tarjeta_PK', .Tarjeta_PK )
			
				.TarjetaDetalle = this.Item[ tnItem ].TarjetaDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TarjetaDetalle', .TarjetaDetalle )
			
				.MontoTotalCompras = this.Item[ tnItem ].MontoTotalCompras
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoTotalCompras', .MontoTotalCompras )
			
				.MontoTotalAnulacionCompras = this.Item[ tnItem ].MontoTotalAnulacionCompras
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoTotalAnulacionCompras', .MontoTotalAnulacionCompras )
			
				.MontoTotalDevoluciones = this.Item[ tnItem ].MontoTotalDevoluciones
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoTotalDevoluciones', .MontoTotalDevoluciones )
			
				.MontoTotalAnulacionDevoluciones = this.Item[ tnItem ].MontoTotalAnulacionDevoluciones
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoTotalAnulacionDevoluciones', .MontoTotalAnulacionDevoluciones )
			
				.MontoTotal = this.Item[ tnItem ].MontoTotal
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MontoTotal', .MontoTotal )
			
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
			.NROITEM = this.oItem.NROITEM
			.NroLote = this.oItem.NroLote
			.Tarjeta_PK = this.oItem.Tarjeta_PK
			.TarjetaDetalle = this.oItem.TarjetaDetalle
			.MontoTotalCompras = this.oItem.MontoTotalCompras
			.MontoTotalAnulacionCompras = this.oItem.MontoTotalAnulacionCompras
			.MontoTotalDevoluciones = this.oItem.MontoTotalDevoluciones
			.MontoTotalAnulacionDevoluciones = this.oItem.MontoTotalAnulacionDevoluciones
			.MontoTotal = this.oItem.MontoTotal
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
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].NroLote = .oItem.NroLote
			.Item[ lnItem ].Tarjeta_PK = .oItem.Tarjeta_PK
			.Item[ lnItem ].TarjetaDetalle = .oItem.TarjetaDetalle
			.Item[ lnItem ].MontoTotalCompras = .oItem.MontoTotalCompras
			.Item[ lnItem ].MontoTotalAnulacionCompras = .oItem.MontoTotalAnulacionCompras
			.Item[ lnItem ].MontoTotalDevoluciones = .oItem.MontoTotalDevoluciones
			.Item[ lnItem ].MontoTotalAnulacionDevoluciones = .oItem.MontoTotalAnulacionDevoluciones
			.Item[ lnItem ].MontoTotal = .oItem.MontoTotal
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Sumarizar() as boolean
		local lnItem as integer, loItem as Object, lnSum_Montototal as Number, lnSum_Montototalanulacioncompras as Number, lnSum_Montototalanulaciondevoluciones as Number, lnSum_Montototalcompras as Number, lnSum_Montototaldevoluciones as Number

		with this
			lnSum_Montototal = 0
			lnSum_Montototalanulacioncompras = 0
			lnSum_Montototalanulaciondevoluciones = 0
			lnSum_Montototalcompras = 0
			lnSum_Montototaldevoluciones = 0
			if this.lEsNavegacion
				if select( 'c_Detalle' ) > 0 and reccount( 'c_Detalle' ) > 0
					sum Montototal, Montototalanulacioncompras, Montototalanulaciondevoluciones, Montototalcompras, Montototaldevoluciones;
						 to ;
						 lnSum_Montototal, lnSum_Montototalanulacioncompras, lnSum_Montototalanulaciondevoluciones, lnSum_Montototalcompras, lnSum_Montototaldevoluciones
				endif
				this.lEsNavegacion = .f.
			else
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							lnSum_Montototal = lnSum_Montototal + .Montototal
							lnSum_Montototalanulacioncompras = lnSum_Montototalanulacioncompras + .Montototalanulacioncompras
							lnSum_Montototalanulaciondevoluciones = lnSum_Montototalanulaciondevoluciones + .Montototalanulaciondevoluciones
							lnSum_Montototalcompras = lnSum_Montototalcompras + .Montototalcompras
							lnSum_Montototaldevoluciones = lnSum_Montototaldevoluciones + .Montototaldevoluciones
						endwith
					endif
				endfor

				if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
					loItem = .oItem
					with loItem 
						lnSum_Montototal = lnSum_Montototal + .Montototal
						lnSum_Montototalanulacioncompras = lnSum_Montototalanulacioncompras + .Montototalanulacioncompras
						lnSum_Montototalanulaciondevoluciones = lnSum_Montototalanulaciondevoluciones + .Montototalanulaciondevoluciones
						lnSum_Montototalcompras = lnSum_Montototalcompras + .Montototalcompras
						lnSum_Montototaldevoluciones = lnSum_Montototaldevoluciones + .Montototaldevoluciones
					endwith
				endif
			endif

			if .Sum_Montototal != lnSum_Montototal
				.Sum_Montototal = lnSum_Montototal
				.EventoCambioSum_Montototal()
			endif
			if .Sum_Montototalanulacioncompras != lnSum_Montototalanulacioncompras
				.Sum_Montototalanulacioncompras = lnSum_Montototalanulacioncompras
				.EventoCambioSum_Montototalanulacioncompras()
			endif
			if .Sum_Montototalanulaciondevoluciones != lnSum_Montototalanulaciondevoluciones
				.Sum_Montototalanulaciondevoluciones = lnSum_Montototalanulaciondevoluciones
				.EventoCambioSum_Montototalanulaciondevoluciones()
			endif
			if .Sum_Montototalcompras != lnSum_Montototalcompras
				.Sum_Montototalcompras = lnSum_Montototalcompras
				.EventoCambioSum_Montototalcompras()
			endif
			if .Sum_Montototaldevoluciones != lnSum_Montototaldevoluciones
				.Sum_Montototaldevoluciones = lnSum_Montototaldevoluciones
				.EventoCambioSum_Montototaldevoluciones()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Montototal() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Montototalanulacioncompras() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Montototalanulaciondevoluciones() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Montototalcompras() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Montototaldevoluciones() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalizar( toItem as Object ) as Void
		local lnItem as integer, loItem as Object, lnSum_Montototal as Number, lnSum_Montototalanulacioncompras as Number, lnSum_Montototalanulaciondevoluciones as Number, lnSum_Montototalcompras as Number, lnSum_Montototaldevoluciones as Number

		with this
			lnSum_Montototal = 0
			lnSum_Montototalanulacioncompras = 0
			lnSum_Montototalanulaciondevoluciones = 0
			lnSum_Montototalcompras = 0
			lnSum_Montototaldevoluciones = 0
			if !this.lEsNavegacion
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							lnSum_Montototal = lnSum_Montototal + .Montototal
							lnSum_Montototalanulacioncompras = lnSum_Montototalanulacioncompras + .Montototalanulacioncompras
							lnSum_Montototalanulaciondevoluciones = lnSum_Montototalanulaciondevoluciones + .Montototalanulaciondevoluciones
							lnSum_Montototalcompras = lnSum_Montototalcompras + .Montototalcompras
							lnSum_Montototaldevoluciones = lnSum_Montototaldevoluciones + .Montototaldevoluciones
						endwith
					endif
				endfor

			endif
			if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
				loItem = .oItem
				with loItem 
					lnSum_Montototal = lnSum_Montototal + .Montototal
					lnSum_Montototalanulacioncompras = lnSum_Montototalanulacioncompras + .Montototalanulacioncompras
					lnSum_Montototalanulaciondevoluciones = lnSum_Montototalanulaciondevoluciones + .Montototalanulaciondevoluciones
					lnSum_Montototalcompras = lnSum_Montototalcompras + .Montototalcompras
					lnSum_Montototaldevoluciones = lnSum_Montototaldevoluciones + .Montototaldevoluciones
				endwith
			endif

			if .Sum_Montototal != lnSum_Montototal
				.Sum_Montototal = lnSum_Montototal
				.EventoCambioSum_Montototal()
			endif
			if .Sum_Montototalanulacioncompras != lnSum_Montototalanulacioncompras
				.Sum_Montototalanulacioncompras = lnSum_Montototalanulacioncompras
				.EventoCambioSum_Montototalanulacioncompras()
			endif
			if .Sum_Montototalanulaciondevoluciones != lnSum_Montototalanulaciondevoluciones
				.Sum_Montototalanulaciondevoluciones = lnSum_Montototalanulaciondevoluciones
				.EventoCambioSum_Montototalanulaciondevoluciones()
			endif
			if .Sum_Montototalcompras != lnSum_Montototalcompras
				.Sum_Montototalcompras = lnSum_Montototalcompras
				.EventoCambioSum_Montototalcompras()
			endif
			if .Sum_Montototaldevoluciones != lnSum_Montototaldevoluciones
				.Sum_Montototaldevoluciones = lnSum_Montototaldevoluciones
				.EventoCambioSum_Montototaldevoluciones()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Acumular( tlForzar as Boolean, tcAtributo as String, tnValor as Decimal, tnValorAnt as Decimal ) as Void
		local lnItem as integer, loItem as Object, lnSum_Montototal as Number, lnSum_Montototalanulacioncompras as Number, lnSum_Montototalanulaciondevoluciones as Number, lnSum_Montototalcompras as Number, lnSum_Montototaldevoluciones as Number

		do case
		case tnValor = tnValorAnt
		case tcAtributo == 'Montototal'
			this.Sum_Montototal = this.Sum_Montototal - tnValorAnt + tnValor
			this.EventoCambioSum_Montototal()
		case tcAtributo == 'Montototalanulacioncompras'
			this.Sum_Montototalanulacioncompras = this.Sum_Montototalanulacioncompras - tnValorAnt + tnValor
			this.EventoCambioSum_Montototalanulacioncompras()
		case tcAtributo == 'Montototalanulaciondevoluciones'
			this.Sum_Montototalanulaciondevoluciones = this.Sum_Montototalanulaciondevoluciones - tnValorAnt + tnValor
			this.EventoCambioSum_Montototalanulaciondevoluciones()
		case tcAtributo == 'Montototalcompras'
			this.Sum_Montototalcompras = this.Sum_Montototalcompras - tnValorAnt + tnValor
			this.EventoCambioSum_Montototalcompras()
		case tcAtributo == 'Montototaldevoluciones'
			this.Sum_Montototaldevoluciones = this.Sum_Montototaldevoluciones - tnValorAnt + tnValor
			this.EventoCambioSum_Montototaldevoluciones()

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
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemCIERREDELOTEDetalle' )
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

		select c_Detalle
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Codigo = c_Detalle.Codigo
			loItem.NROITEM = c_Detalle.NROITEM
			loItem.NroLote = c_Detalle.NroLote
			loItem.Tarjeta_PK = c_Detalle.Tarjeta
			loItem.TarjetaDetalle = c_Detalle.TarjetaDetalle
			loItem.MontoTotalCompras = c_Detalle.MontoTotalCompras
			loItem.MontoTotalAnulacionCompras = c_Detalle.MontoTotalAnulacionCompras
			loItem.MontoTotalDevoluciones = c_Detalle.MontoTotalDevoluciones
			loItem.MontoTotalAnulacionDevoluciones = c_Detalle.MontoTotalAnulacionDevoluciones
			loItem.MontoTotal = c_Detalle.MontoTotal
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

		if  empty( this.item[ tnItem ].Tarjeta_PK ) 
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
			
			if vartype( this.Item[lni].NROLOTE) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].NROLOTE ) ) ) 
				lnValorDelDecimal = this.Item[lni].NROLOTE - int( this.Item[lni].NROLOTE )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 8
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo NROLOTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:8), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NROLOTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TARJETA_PK) = 'C'
				if len( alltrim( this.Item[lni].TARJETA_PK )) <= 5
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TARJETA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TARJETA_PK ))) + ' Máxima:5), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TARJETA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TARJETADETALLE) = 'C'
				if len( alltrim( this.Item[lni].TARJETADETALLE )) <= 40
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TARJETADETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TARJETADETALLE ))) + ' Máxima:40), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TARJETADETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTOTOTALCOMPRAS) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTOTOTALCOMPRAS ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTOTOTALCOMPRAS - int( this.Item[lni].MONTOTOTALCOMPRAS )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTOTOTALCOMPRAS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTOTOTALCOMPRAS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTOTOTALANULACIONCOMPRAS) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTOTOTALANULACIONCOMPRAS ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTOTOTALANULACIONCOMPRAS - int( this.Item[lni].MONTOTOTALANULACIONCOMPRAS )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTOTOTALANULACIONCOMPRAS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTOTOTALANULACIONCOMPRAS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTOTOTALDEVOLUCIONES) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTOTOTALDEVOLUCIONES ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTOTOTALDEVOLUCIONES - int( this.Item[lni].MONTOTOTALDEVOLUCIONES )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTOTOTALDEVOLUCIONES del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTOTOTALDEVOLUCIONES del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTOTOTALANULACIONDEVOLUCIONES) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTOTOTALANULACIONDEVOLUCIONES ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTOTOTALANULACIONDEVOLUCIONES - int( this.Item[lni].MONTOTOTALANULACIONDEVOLUCIONES )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTOTOTALANULACIONDEVOLUCIONES del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTOTOTALANULACIONDEVOLUCIONES del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTOTOTAL) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTOTOTAL ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTOTOTAL - int( this.Item[lni].MONTOTOTAL )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTOTOTAL del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTOTOTAL del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Nrolote = toItemOrigen.Nrolote
		toItemDestino.Tarjeta_PK = toItemOrigen.Tarjeta_PK
		toItemDestino.Tarjetadetalle = toItemOrigen.Tarjetadetalle
		toItemDestino.Montototalcompras = toItemOrigen.Montototalcompras
		toItemDestino.Montototalanulacioncompras = toItemOrigen.Montototalanulacioncompras
		toItemDestino.Montototaldevoluciones = toItemOrigen.Montototaldevoluciones
		toItemDestino.Montototalanulaciondevoluciones = toItemOrigen.Montototalanulaciondevoluciones
		toItemDestino.Montototal = toItemOrigen.Montototal
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
		lcRetorno = 'Tarjeta_pk'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Codigo = []
	Nroitem = 0
	Nrolote = 0
	Tarjeta_PK = []
	Tarjetadetalle = []
	Montototalcompras = 0
	Montototalanulacioncompras = 0
	Montototaldevoluciones = 0
	Montototalanulaciondevoluciones = 0
	Montototal = 0
	NroItem = 0

enddefine