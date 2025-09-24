
define class Frm_PerfilesEstilo2 as Perfiles of Perfiles.vcx
	ColControles = null
	oAspectoAplicacion = null

	icon = 'zooIcon.ico'
	*-----------------------------------------------------------------------------------------
	function oAspectoAplicacion_Access() as Void
		if (type("this.oAspectoAplicacion") <> "O" or isnull(this.oAspectoAplicacion))
			this.oAspectoAplicacion = _screen.zoo.CrearObjetoPorProducto("AspectoAplicacion")
		endif
		Return this.oAspectoAplicacion
	endfunc
	function SeteosVisuales() as boolean
		this.ColControles = newobject('collection')
		this.icon = this.oAspectoAplicacion.ObtenerIconoDeLaAplicacion()

		************* perfiles/78d1cq7c8/Form

		with this
			.THEMES = .T.
			.PICTURE = ''

			.HEIGHT = 553
			.LEFT = 14
			.LOCKSCREEN = .F.
			.NAME = [perfiles]
			.TOP = 115
			.WIDTH = 980
			.WINDOWTYPE = 0

			************* lstSeguridad/Lstbase/Listbox
			if type( '.lstSeguridad' ) # 'O'
				.newobject( 'lstSeguridad', 'LSTBASE', 'LSTBASE.VCX' )
			endif

			with .lstSeguridad
				.THEMES = .T.
				.PICTURE = ''


				.VISIBLE = .T.

			endwith


			************* cmdAgregar/Cmdbase/Commandbutton
			if type( '.cmdAgregar' ) # 'O'
				.newobject( 'cmdAgregar', 'CMDBASE', 'CMDBASE.VCX' )
			endif

			with .cmdAgregar
				.THEMES = .T.
				.DISABLEDPICTURE = ''
				.PICTURE = ''


				.VISIBLE = .T.

			endwith


			************* CmdCopiar/Cmdbase/Commandbutton
			if type( '.CmdCopiar' ) # 'O'
				.newobject( 'CmdCopiar', 'CMDBASE', 'CMDBASE.VCX' )
			endif

			with .CmdCopiar
				.THEMES = .T.
				.DISABLEDPICTURE = ''
				.PICTURE = ''


				.VISIBLE = .T.

			endwith


			************* CmdQuitar/Cmdbase/Commandbutton
			if type( '.CmdQuitar' ) # 'O'
				.newobject( 'CmdQuitar', 'CMDBASE', 'CMDBASE.VCX' )
			endif

			with .CmdQuitar
				.THEMES = .T.
				.DISABLEDPICTURE = ''
				.PICTURE = ''


				.VISIBLE = .T.

			endwith


			************* Pageframe1/Pageframe/Pageframe
			if type( '.Pageframe1' ) # 'O'
				.newobject( 'Pageframe1', 'PAGEFRAME' )
			endif

			with .Pageframe1
				.THEMES = .F.
				.TABS = .T.


				.VISIBLE = .T.

				************* Page1/Page/Page

				with .Page1
					.PICTURE = ''


					.NAME = [Page1]

					************* cmdHabilitar/Cmdbase/Commandbutton
					if type( '.cmdHabilitar' ) # 'O'
						.newobject( 'cmdHabilitar', 'CMDBASE', 'CMDBASE.VCX' )
					endif

					with .cmdHabilitar
						.THEMES = .T.
						.DISABLEDPICTURE = ''
						.PICTURE = 'habilitar.bmp'


						.VISIBLE = .T.

					endwith


					************* CmdDeshabilitar/Cmdbase/Commandbutton
					if type( '.CmdDeshabilitar' ) # 'O'
						.newobject( 'CmdDeshabilitar', 'CMDBASE', 'CMDBASE.VCX' )
					endif

					with .CmdDeshabilitar
						.THEMES = .T.
						.DISABLEDPICTURE = ''
						.PICTURE = 'deshabilitar.bmp'


						.VISIBLE = .T.

					endwith


					************* oleArbol/Olecontrol/Olecontrol
					if type( '.oleArbol' ) # 'O'
						.addObject( 'oleArbol', 'OLECONTROL', 'MSCOMCTLLIB.TREECTRL.2' )
					endif

					with .oleArbol

						.HEIGHT = 446
						.LEFT = 5
						.TOP = 12
						.WIDTH = 383
						.VISIBLE = .T.

					endwith


					************* CmdRequiereClave/Cmdbase/Commandbutton
					if type( '.CmdRequiereClave' ) # 'O'
						.newobject( 'CmdRequiereClave', 'CMDBASE', 'CMDBASE.VCX' )
					endif

					with .CmdRequiereClave
						.THEMES = .T.
						.DISABLEDPICTURE = ''
						.PICTURE = 'requiereclave.bmp'


						.VISIBLE = .T.

					endwith


				endwith


				************* Page2/Page/Page

				with .Page2
					.PICTURE = ''


					.NAME = [Page2]

					************* Label3/Lblbase/Label
					if type( '.Label3' ) # 'O'
						.newobject( 'Label3', 'LBLBASE', 'LBLBASE.VCX' )
					endif

					with .Label3


						.VISIBLE = .T.

					endwith


					************* cmdSacarUno/Cmdbase/Commandbutton
					if type( '.cmdSacarUno' ) # 'O'
						.newobject( 'cmdSacarUno', 'CMDBASE', 'CMDBASE.VCX' )
					endif

					with .cmdSacarUno
						.THEMES = .T.
						.DISABLEDPICTURE = ''
						.PICTURE = ''


						.VISIBLE = .T.

					endwith


					************* cmdSacarTodos/Cmdbase/Commandbutton
					if type( '.cmdSacarTodos' ) # 'O'
						.newobject( 'cmdSacarTodos', 'CMDBASE', 'CMDBASE.VCX' )
					endif

					with .cmdSacarTodos
						.THEMES = .T.
						.DISABLEDPICTURE = ''
						.PICTURE = ''


						.VISIBLE = .T.

					endwith


					************* cmdAgregarTodos/Cmdbase/Commandbutton
					if type( '.cmdAgregarTodos' ) # 'O'
						.newobject( 'cmdAgregarTodos', 'CMDBASE', 'CMDBASE.VCX' )
					endif

					with .cmdAgregarTodos
						.THEMES = .T.
						.DISABLEDPICTURE = ''
						.PICTURE = ''


						.VISIBLE = .T.

					endwith


					************* cmdAgregarUno/Cmdbase/Commandbutton
					if type( '.cmdAgregarUno' ) # 'O'
						.newobject( 'cmdAgregarUno', 'CMDBASE', 'CMDBASE.VCX' )
					endif

					with .cmdAgregarUno
						.THEMES = .T.
						.DISABLEDPICTURE = ''
						.PICTURE = ''


						.VISIBLE = .T.

					endwith


					************* Label4/Lblbase/Label
					if type( '.Label4' ) # 'O'
						.newobject( 'Label4', 'LBLBASE', 'LBLBASE.VCX' )
					endif

					with .Label4


						.VISIBLE = .T.

					endwith


					************* lstDisponibles/Lstbase/Listbox
					if type( '.lstDisponibles' ) # 'O'
						.newobject( 'lstDisponibles', 'LSTBASE', 'LSTBASE.VCX' )
					endif

					with .lstDisponibles
						.THEMES = .T.
						.PICTURE = ''


						.VISIBLE = .T.

					endwith


					************* lstSeleccionados/Lstbase/Listbox
					if type( '.lstSeleccionados' ) # 'O'
						.newobject( 'lstSeleccionados', 'LSTBASE', 'LSTBASE.VCX' )
					endif

					with .lstSeleccionados
						.THEMES = .T.
						.PICTURE = ''


						.VISIBLE = .T.

					endwith


				endwith


			endwith


			************* imgLista/Olecontrol/Olecontrol
			if type( '.imgLista' ) # 'O'
				.addObject( 'imgLista', 'OLECONTROL', 'MSCOMCTLLIB.IMAGELISTCTRL.2' )
			endif

			with .imgLista

				.HEIGHT = 49
				.LEFT = 156
				.TOP = 384
				.WIDTH = 97
				.VISIBLE = .F.

			endwith


			************* OBOTONERA/Botonera/Container
			if type( '.OBOTONERA' ) # 'O'
				.newobject( 'OBOTONERA', 'BOTONERA', 'BOTONERA.prg', '', 'NO')
			endif

			with .OBOTONERA
				.PICTURE = ''


				.BACKCOLOR = 16777215
				.BACKSTYLE = 1
				.BORDERCOLOR = 0
				.BORDERWIDTH = 0
				.CACCIONB1 = [thisform.click_boton1()]
				.CACCIONB2 = [thisform.click_boton2()]
				.CCAPTIONB1 = [Guardar]
				.CCAPTIONB2 = [Cancelar]
				.DISABLEDBACKCOLOR = 0
				.FORECOLOR = 0
				.HEIGHT = 55
				.LHABILITARB1 = .T.
				.LHABILITARB2 = .T.
				.LSEPUEDEORDENAR = .F.
				.NAME = [OBOTONERA]
				.NBACKCOLORCONFOCO = 0
				.NBACKCOLORSINFOCO = 16777215
				.NFORECOLORCONFOCO = 0
				.NFORECOLORSINFOCO = 0
				.OCONTROLESORDENADOS = null
				.SPECIALEFFECT = 0
				.TOP = 498
				.WIDTH = 980
				.VISIBLE = .T.

				************* IMGLOGOIZQUIERDO/Zooimagen/Image
				if type( '.IMGLOGOIZQUIERDO' ) # 'O'
					.newobject( 'IMGLOGOIZQUIERDO', 'ZOOIMAGEN', 'ZOOIMAGEN.prg', '', 'NO')
				endif

				with .IMGLOGOIZQUIERDO
					.THEMES = .F.
					.PICTURE = this.oAspectoAplicacion.ObtenerPieIzquierdoAbm()


					.BACKSTYLE = 0
					.BORDERCOLOR = 16771561
					.BORDERSTYLE = 0
					.CEXPRESIONRUTADINAMICA = [this.oAspectoAplicacion.ObtenerPieIzquierdoAbm()]
					.HEIGHT = 45
					.LEFT = 5
					.NAME = [IMGLOGOIZQUIERDO]
					.NBACKCOLORCONFOCO = 0
					.NFORECOLORCONFOCO = 0
					.TOP = 5
					.WIDTH = 210
					.VISIBLE = .T.

				endwith
				*------------------ Eventos IMGLOGOIZQUIERDO


				************* IMGLOGODERECHO/Zooimagen/Image
				if type( '.IMGLOGODERECHO' ) # 'O'
					.newobject( 'IMGLOGODERECHO', 'ZOOIMAGEN', 'ZOOIMAGEN.prg', '', 'NO')
				endif

				with .IMGLOGODERECHO
					.THEMES = .F.
					.PICTURE = this.oAspectoAplicacion.ObtenerPieDerechoAbm()


					.BACKSTYLE = 0
					.BORDERCOLOR = 16771561
					.BORDERSTYLE = 0
					.CEXPRESIONRUTADINAMICA = [this.oAspectoAplicacion.ObtenerPieDerechoAbm()]
					.HEIGHT = 55
					.LEFT = 793
					.NAME = [IMGLOGODERECHO]
					.NBACKCOLORCONFOCO = 0
					.NFORECOLORCONFOCO = 0
					.TOP = 0
					.WIDTH = 187
					.VISIBLE = .F.

				endwith
				*------------------ Eventos IMGLOGODERECHO


				************* CMDACEPTAR/Botonconfoco/Commandbutton
				if type( '.CMDACEPTAR' ) # 'O'
					.newobject( 'CMDACEPTAR', 'BOTONCONFOCO', 'BOTONCONFOCO.prg', '', 'NO')
				endif

				with .CMDACEPTAR
					.THEMES = .F.
					.DISABLEDPICTURE = ''
					.PICTURE = ''


					.AUTOSIZE = .F.
					.BACKCOLOR = 14999520
					.CAPTION = [Guardar]
					.DISABLEDBACKCOLOR = 14999520
					.DISABLEDFORECOLOR = 10070188
					.FONTBOLD = .F.
					.FONTITALIC = .F.
					.FONTNAME = [TAHOMA]
					.FONTSIZE = 8
					.FORECOLOR = 0
					.HEIGHT = 27
					.LEFT = 834
					.NAME = [CMDACEPTAR]
					.NBACKCOLORCONFOCO = 0
					.NFORECOLORCONFOCO = 0
					.SPECIALEFFECT = 2
					.TOP = 14
					.WIDTH = 59
					.VISIBLE = .T.

				endwith
				*------------------ Eventos CMDACEPTAR


				************* CMDCANCELAR/Botonconfoco/Commandbutton
				if type( '.CMDCANCELAR' ) # 'O'
					.newobject( 'CMDCANCELAR', 'BOTONCONFOCO', 'BOTONCONFOCO.prg', '', 'NO')
				endif

				with .CMDCANCELAR
					.THEMES = .F.
					.DISABLEDPICTURE = ''
					.PICTURE = ''


					.AUTOSIZE = .F.
					.BACKCOLOR = 14999520
					.CANCEL = .T.
					.CAPTION = [Cancelar]
					.DISABLEDBACKCOLOR = 14999520
					.DISABLEDFORECOLOR = 10070188
					.FONTBOLD = .F.
					.FONTITALIC = .F.
					.FONTNAME = [TAHOMA]
					.FONTSIZE = 8
					.FORECOLOR = 0
					.HEIGHT = 27
					.LEFT = 907
					.NAME = [CMDCANCELAR]
					.NBACKCOLORCONFOCO = 0
					.NFORECOLORCONFOCO = 0
					.SPECIALEFFECT = 2
					.TABSTOP = .F.
					.TOP = 14
					.WIDTH = 59
					.VISIBLE = .T.

				endwith
				*------------------ Eventos CMDCANCELAR


				************* LNLLINEA/Zoolinea/Line
				if type( '.LNLLINEA' ) # 'O'
					.newobject( 'LNLLINEA', 'ZOOLINEA', 'ZOOLINEA.prg', '', 'NO')
				endif

				with .LNLLINEA


					.BORDERCOLOR = 10485760
					.BORDERSTYLE = 1
					.BORDERWIDTH = 0
					.HEIGHT = 0
					.LEFT = 0
					.NAME = [LNLLINEA]
					.NBACKCOLORCONFOCO = 0
					.NFORECOLORCONFOCO = 0
					.TOP = 0
					.WIDTH = 980
					.VISIBLE = .T.

				endwith
				*------------------ Eventos LNLLINEA


			endwith
			*------------------ Eventos OBOTONERA
			bindevent( .OBOTONERA.cmdAceptar, 'Click', .OBOTONERA, 'Aceptar', 0 ) 
			bindevent( .OBOTONERA.cmdCancelar, 'Click', .OBOTONERA, 'Cancelar', 0 ) 


		endwith


		this.AgregarBarraDeEstado()

		this.MaxButton = .f.
		this.MinButton = .t.
		this.Closable = .t.
		this.ControlBox = .t.
		this.BorderStyle = 0
		this.Showtips = .t.
		this.Autocenter = .t.

	endfunc

	function unload() as Variant
		local lcVar
		lcVar = this.cVariableRetorno 
		&lcVar = dodefault()
		return &lcVar
	endfunc

Enddefine