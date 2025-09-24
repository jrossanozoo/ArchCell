
define class Din_DetalleCLIENTEOtrasdirecciones as detalle of detalle.prg


	nCantidadItems = 999
	cNombre = 'Otrasdirecciones'
	cEtiqueta = 'Otras direcciones'
	cMensajeErrorUnicidad = 'La columna  no admite valores repetidos.'
	cNombreVisual = 'Otras direcciones'

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
			
				.Calle = this.Item[ tnItem ].Calle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Calle', .Calle )
			
				.Numero = this.Item[ tnItem ].Numero
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Numero', .Numero )
			
				.Piso = this.Item[ tnItem ].Piso
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Piso', .Piso )
			
				.Departamento = this.Item[ tnItem ].Departamento
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Departamento', .Departamento )
			
				.Localidad = this.Item[ tnItem ].Localidad
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Localidad', .Localidad )
			
				.CodigoPostal = this.Item[ tnItem ].CodigoPostal
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodigoPostal', .CodigoPostal )
			
				.Provincia_PK = this.Item[ tnItem ].Provincia_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Provincia_PK', .Provincia_PK )
			
				.ProvinciaDetalle = this.Item[ tnItem ].ProvinciaDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ProvinciaDetalle', .ProvinciaDetalle )
			
				.Pais_PK = this.Item[ tnItem ].Pais_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Pais_PK', .Pais_PK )
			
				.PaisDetalle = this.Item[ tnItem ].PaisDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PaisDetalle', .PaisDetalle )
			
				.Telefono = this.Item[ tnItem ].Telefono
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Telefono', .Telefono )
			
				.TipoDireccion_PK = this.Item[ tnItem ].TipoDireccion_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TipoDireccion_PK', .TipoDireccion_PK )
			
				.Notas = this.Item[ tnItem ].Notas
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Notas', .Notas )
			
				.Preferente = this.Item[ tnItem ].Preferente
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Preferente', .Preferente )
			
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
			.Calle = this.oItem.Calle
			.Numero = this.oItem.Numero
			.Piso = this.oItem.Piso
			.Departamento = this.oItem.Departamento
			.Localidad = this.oItem.Localidad
			.CodigoPostal = this.oItem.CodigoPostal
			.Provincia_PK = this.oItem.Provincia_PK
			.ProvinciaDetalle = this.oItem.ProvinciaDetalle
			.Pais_PK = this.oItem.Pais_PK
			.PaisDetalle = this.oItem.PaisDetalle
			.Telefono = this.oItem.Telefono
			.TipoDireccion_PK = this.oItem.TipoDireccion_PK
			.Notas = this.oItem.Notas
			.Preferente = this.oItem.Preferente
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
			.Item[ lnItem ].Calle = .oItem.Calle
			.Item[ lnItem ].Numero = .oItem.Numero
			.Item[ lnItem ].Piso = .oItem.Piso
			.Item[ lnItem ].Departamento = .oItem.Departamento
			.Item[ lnItem ].Localidad = .oItem.Localidad
			.Item[ lnItem ].CodigoPostal = .oItem.CodigoPostal
			.Item[ lnItem ].Provincia_PK = .oItem.Provincia_PK
			.Item[ lnItem ].ProvinciaDetalle = .oItem.ProvinciaDetalle
			.Item[ lnItem ].Pais_PK = .oItem.Pais_PK
			.Item[ lnItem ].PaisDetalle = .oItem.PaisDetalle
			.Item[ lnItem ].Telefono = .oItem.Telefono
			.Item[ lnItem ].TipoDireccion_PK = .oItem.TipoDireccion_PK
			.Item[ lnItem ].Notas = .oItem.Notas
			.Item[ lnItem ].Preferente = .oItem.Preferente
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemCLIENTEOtrasdirecciones' )
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

		select c_Otrasdirecciones
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Codigo = c_Otrasdirecciones.Codigo
			loItem.NROITEM = c_Otrasdirecciones.NROITEM
			loItem.Calle = c_Otrasdirecciones.Calle
			loItem.Numero = c_Otrasdirecciones.Numero
			loItem.Piso = c_Otrasdirecciones.Piso
			loItem.Departamento = c_Otrasdirecciones.Departamento
			loItem.Localidad = c_Otrasdirecciones.Localidad
			loItem.CodigoPostal = c_Otrasdirecciones.CodigoPostal
			loItem.Provincia_PK = c_Otrasdirecciones.Provincia
			loItem.ProvinciaDetalle = c_Otrasdirecciones.ProvinciaDetalle
			loItem.Pais_PK = c_Otrasdirecciones.Pais
			loItem.PaisDetalle = c_Otrasdirecciones.PaisDetalle
			loItem.Telefono = c_Otrasdirecciones.Telefono
			loItem.TipoDireccion_PK = c_Otrasdirecciones.TipoDireccion
			loItem.Notas = c_Otrasdirecciones.Notas
			loItem.Preferente = c_Otrasdirecciones.Preferente
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

		if  empty( this.item[ tnItem ].Calle ) 
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
			
			if vartype( this.Item[lni].CALLE) = 'C'
				if len( alltrim( this.Item[lni].CALLE )) <= 250
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CALLE ))) + ' Máxima:250), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NUMERO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].NUMERO ) ) ) 
				lnValorDelDecimal = this.Item[lni].NUMERO - int( this.Item[lni].NUMERO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 5
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo NUMERO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:5), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NUMERO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PISO) = 'C'
				if len( alltrim( this.Item[lni].PISO )) <= 3
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo PISO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].PISO ))) + ' Máxima:3), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PISO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].DEPARTAMENTO) = 'C'
				if len( alltrim( this.Item[lni].DEPARTAMENTO )) <= 3
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo DEPARTAMENTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].DEPARTAMENTO ))) + ' Máxima:3), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo DEPARTAMENTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].LOCALIDAD) = 'C'
				if len( alltrim( this.Item[lni].LOCALIDAD )) <= 70
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo LOCALIDAD del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].LOCALIDAD ))) + ' Máxima:70), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo LOCALIDAD del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CODIGOPOSTAL) = 'C'
				if len( alltrim( this.Item[lni].CODIGOPOSTAL )) <= 8
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGOPOSTAL del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGOPOSTAL ))) + ' Máxima:8), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGOPOSTAL del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PROVINCIA_PK) = 'C'
				if len( alltrim( this.Item[lni].PROVINCIA_PK )) <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo PROVINCIA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].PROVINCIA_PK ))) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PROVINCIA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PROVINCIADETALLE) = 'C'
				if len( alltrim( this.Item[lni].PROVINCIADETALLE )) <= 50
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo PROVINCIADETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].PROVINCIADETALLE ))) + ' Máxima:50), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PROVINCIADETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PAIS_PK) = 'C'
				if len( alltrim( this.Item[lni].PAIS_PK )) <= 3
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo PAIS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].PAIS_PK ))) + ' Máxima:3), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PAIS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PAISDETALLE) = 'C'
				if len( alltrim( this.Item[lni].PAISDETALLE )) <= 30
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo PAISDETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].PAISDETALLE ))) + ' Máxima:30), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PAISDETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TELEFONO) = 'C'
				if len( alltrim( this.Item[lni].TELEFONO )) <= 30
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TELEFONO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TELEFONO ))) + ' Máxima:30), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TELEFONO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TIPODIRECCION_PK) = 'C'
				if len( alltrim( this.Item[lni].TIPODIRECCION_PK )) <= 4
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TIPODIRECCION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TIPODIRECCION_PK ))) + ' Máxima:4), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TIPODIRECCION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NOTAS) = 'C'
				if len( alltrim( this.Item[lni].NOTAS )) <= 50
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo NOTAS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].NOTAS ))) + ' Máxima:50), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NOTAS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PREFERENTE) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PREFERENTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Calle = toItemOrigen.Calle
		toItemDestino.Numero = toItemOrigen.Numero
		toItemDestino.Piso = toItemOrigen.Piso
		toItemDestino.Departamento = toItemOrigen.Departamento
		toItemDestino.Localidad = toItemOrigen.Localidad
		toItemDestino.Codigopostal = toItemOrigen.Codigopostal
		toItemDestino.Provincia_PK = toItemOrigen.Provincia_PK
		toItemDestino.Provinciadetalle = toItemOrigen.Provinciadetalle
		toItemDestino.Pais_PK = toItemOrigen.Pais_PK
		toItemDestino.Paisdetalle = toItemOrigen.Paisdetalle
		toItemDestino.Telefono = toItemOrigen.Telefono
		toItemDestino.Tipodireccion_PK = toItemOrigen.Tipodireccion_PK
		toItemDestino.Notas = toItemOrigen.Notas
		toItemDestino.Preferente = toItemOrigen.Preferente
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
		lcRetorno = 'Calle'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Codigo = []
	Nroitem = 0
	Calle = []
	Numero = 0
	Piso = []
	Departamento = []
	Localidad = []
	Codigopostal = []
	Provincia_PK = []
	Provinciadetalle = []
	Pais_PK = []
	Paisdetalle = []
	Telefono = []
	Tipodireccion_PK = []
	Notas = []
	Preferente = .F.
	NroItem = 0

enddefine