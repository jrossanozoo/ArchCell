
define class Din_DetalleMODIFICACIONDECOSTOSDEPRODUCCIONModcostos as DetalleModificaciondecostos of DetalleModificaciondecostos.Prg


	nCantidadItems = 999
	cNombre = 'Modcostos'
	cEtiqueta = 'Costos de talleres'
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
			
				.Semielaborado_PK = this.Item[ tnItem ].Semielaborado_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Semielaborado_PK', .Semielaborado_PK )
			
				.SemielaboradoDetalle = this.Item[ tnItem ].SemielaboradoDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'SemielaboradoDetalle', .SemielaboradoDetalle )
			
				.Proceso_PK = this.Item[ tnItem ].Proceso_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Proceso_PK', .Proceso_PK )
			
				.ProcesoDetalle = this.Item[ tnItem ].ProcesoDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ProcesoDetalle', .ProcesoDetalle )
			
				.Taller_PK = this.Item[ tnItem ].Taller_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Taller_PK', .Taller_PK )
			
				.TallerDetalle = this.Item[ tnItem ].TallerDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TallerDetalle', .TallerDetalle )
			
				.Color_PK = this.Item[ tnItem ].Color_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Color_PK', .Color_PK )
			
				.ColorDetalle = this.Item[ tnItem ].ColorDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ColorDetalle', .ColorDetalle )
			
				.Talle_PK = this.Item[ tnItem ].Talle_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Talle_PK', .Talle_PK )
			
				.TalleDetalle = this.Item[ tnItem ].TalleDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TalleDetalle', .TalleDetalle )
			
				.DesdeCantidad = this.Item[ tnItem ].DesdeCantidad
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'DesdeCantidad', .DesdeCantidad )
			
				.ListaDeCosto_PK = this.Item[ tnItem ].ListaDeCosto_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ListaDeCosto_PK', .ListaDeCosto_PK )
			
				.CostoDeLista = this.Item[ tnItem ].CostoDeLista
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CostoDeLista', .CostoDeLista )
			
				.CostoActualizado = this.Item[ tnItem ].CostoActualizado
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CostoActualizado', .CostoActualizado )
			
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
			.Semielaborado_PK = this.oItem.Semielaborado_PK
			.SemielaboradoDetalle = this.oItem.SemielaboradoDetalle
			.Proceso_PK = this.oItem.Proceso_PK
			.ProcesoDetalle = this.oItem.ProcesoDetalle
			.Taller_PK = this.oItem.Taller_PK
			.TallerDetalle = this.oItem.TallerDetalle
			.Color_PK = this.oItem.Color_PK
			.ColorDetalle = this.oItem.ColorDetalle
			.Talle_PK = this.oItem.Talle_PK
			.TalleDetalle = this.oItem.TalleDetalle
			.DesdeCantidad = this.oItem.DesdeCantidad
			.ListaDeCosto_PK = this.oItem.ListaDeCosto_PK
			.CostoDeLista = this.oItem.CostoDeLista
			.CostoActualizado = this.oItem.CostoActualizado
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
			.Item[ lnItem ].Semielaborado_PK = .oItem.Semielaborado_PK
			.Item[ lnItem ].SemielaboradoDetalle = .oItem.SemielaboradoDetalle
			.Item[ lnItem ].Proceso_PK = .oItem.Proceso_PK
			.Item[ lnItem ].ProcesoDetalle = .oItem.ProcesoDetalle
			.Item[ lnItem ].Taller_PK = .oItem.Taller_PK
			.Item[ lnItem ].TallerDetalle = .oItem.TallerDetalle
			.Item[ lnItem ].Color_PK = .oItem.Color_PK
			.Item[ lnItem ].ColorDetalle = .oItem.ColorDetalle
			.Item[ lnItem ].Talle_PK = .oItem.Talle_PK
			.Item[ lnItem ].TalleDetalle = .oItem.TalleDetalle
			.Item[ lnItem ].DesdeCantidad = .oItem.DesdeCantidad
			.Item[ lnItem ].ListaDeCosto_PK = .oItem.ListaDeCosto_PK
			.Item[ lnItem ].CostoDeLista = .oItem.CostoDeLista
			.Item[ lnItem ].CostoActualizado = .oItem.CostoActualizado
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'ItemMODIFICACIONDECOSTOSDEPRODUCCIONModcostos' )
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

		select c_Modcostos
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Codigo = c_Modcostos.Codigo
			loItem.NROITEM = c_Modcostos.NROITEM
			loItem.Semielaborado_PK = c_Modcostos.Semielaborado
			loItem.SemielaboradoDetalle = c_Modcostos.SemielaboradoDetalle
			loItem.Proceso_PK = c_Modcostos.Proceso
			loItem.ProcesoDetalle = c_Modcostos.ProcesoDetalle
			loItem.Taller_PK = c_Modcostos.Taller
			loItem.TallerDetalle = c_Modcostos.TallerDetalle
			loItem.Color_PK = c_Modcostos.Color
			loItem.ColorDetalle = c_Modcostos.ColorDetalle
			loItem.Talle_PK = c_Modcostos.Talle
			loItem.TalleDetalle = c_Modcostos.TalleDetalle
			loItem.DesdeCantidad = c_Modcostos.DesdeCantidad
			loItem.ListaDeCosto_PK = c_Modcostos.ListaDeCosto
			loItem.CostoDeLista = c_Modcostos.CostoDeLista
			loItem.CostoActualizado = c_Modcostos.CostoActualizado
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

		if  empty( this.item[ tnItem ].Semielaborado_PK ) 
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
				if len( alltrim( this.Item[lni].CODIGO )) <= 20
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGO ))) + ' Máxima:20), en el detalle ' + this.cEtiqueta + '.' )
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
			
			if vartype( this.Item[lni].SEMIELABORADO_PK) = 'C'
				if len( alltrim( this.Item[lni].SEMIELABORADO_PK )) <= 25
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo SEMIELABORADO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].SEMIELABORADO_PK ))) + ' Máxima:25), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo SEMIELABORADO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].SEMIELABORADODETALLE) = 'C'
				if len( alltrim( this.Item[lni].SEMIELABORADODETALLE )) <= 100
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo SEMIELABORADODETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].SEMIELABORADODETALLE ))) + ' Máxima:100), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo SEMIELABORADODETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PROCESO_PK) = 'C'
				if len( alltrim( this.Item[lni].PROCESO_PK )) <= 15
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo PROCESO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].PROCESO_PK ))) + ' Máxima:15), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PROCESO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PROCESODETALLE) = 'C'
				if len( alltrim( this.Item[lni].PROCESODETALLE )) <= 250
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo PROCESODETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].PROCESODETALLE ))) + ' Máxima:250), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PROCESODETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TALLER_PK) = 'C'
				if len( alltrim( this.Item[lni].TALLER_PK )) <= 15
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TALLER del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TALLER_PK ))) + ' Máxima:15), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TALLER del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TALLERDETALLE) = 'C'
				if len( alltrim( this.Item[lni].TALLERDETALLE )) <= 100
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TALLERDETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TALLERDETALLE ))) + ' Máxima:100), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TALLERDETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].DESDECANTIDAD) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].DESDECANTIDAD ) ) ) 
				lnValorDelDecimal = this.Item[lni].DESDECANTIDAD - int( this.Item[lni].DESDECANTIDAD )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 7
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo DESDECANTIDAD del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:7), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo DESDECANTIDAD del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].LISTADECOSTO_PK) = 'C'
				if len( alltrim( this.Item[lni].LISTADECOSTO_PK )) <= 6
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo LISTADECOSTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].LISTADECOSTO_PK ))) + ' Máxima:6), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo LISTADECOSTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].COSTODELISTA) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].COSTODELISTA ) ) ) 
				lnValorDelDecimal = this.Item[lni].COSTODELISTA - int( this.Item[lni].COSTODELISTA )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo COSTODELISTA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo COSTODELISTA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].COSTOACTUALIZADO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].COSTOACTUALIZADO ) ) ) 
				lnValorDelDecimal = this.Item[lni].COSTOACTUALIZADO - int( this.Item[lni].COSTOACTUALIZADO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo COSTOACTUALIZADO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo COSTOACTUALIZADO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Semielaborado_PK = toItemOrigen.Semielaborado_PK
		toItemDestino.Semielaboradodetalle = toItemOrigen.Semielaboradodetalle
		toItemDestino.Proceso_PK = toItemOrigen.Proceso_PK
		toItemDestino.Procesodetalle = toItemOrigen.Procesodetalle
		toItemDestino.Taller_PK = toItemOrigen.Taller_PK
		toItemDestino.Tallerdetalle = toItemOrigen.Tallerdetalle
		toItemDestino.Color_PK = toItemOrigen.Color_PK
		toItemDestino.Colordetalle = toItemOrigen.Colordetalle
		toItemDestino.Talle_PK = toItemOrigen.Talle_PK
		toItemDestino.Talledetalle = toItemOrigen.Talledetalle
		toItemDestino.Desdecantidad = toItemOrigen.Desdecantidad
		toItemDestino.Listadecosto_PK = toItemOrigen.Listadecosto_PK
		toItemDestino.Costodelista = toItemOrigen.Costodelista
		toItemDestino.Costoactualizado = toItemOrigen.Costoactualizado
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
		lcRetorno = 'Semielaborado_pk'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Codigo = []
	Nroitem = 0
	Semielaborado_PK = []
	Semielaboradodetalle = []
	Proceso_PK = []
	Procesodetalle = []
	Taller_PK = []
	Tallerdetalle = []
	Color_PK = []
	Colordetalle = []
	Talle_PK = []
	Talledetalle = []
	Desdecantidad = 0
	Listadecosto_PK = []
	Costodelista = 0
	Costoactualizado = 0
	NroItem = 0

enddefine