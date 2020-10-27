package;


import haxe.io.Bytes;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

		}

		if (rootPath == null) {

			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif console
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_disc_numbers_regular_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_disc_numbers_alt_regular_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_disc_text_regular_ttf);
		
		#end

		var data, manifest, library, bundle;

		#if kha

		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);

		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");

		#else

		data = '{"name":null,"assets":"aoy4:pathy21:assets%2Fa_bottom.pngy4:sizei693y4:typey5:IMAGEy2:idR1y7:preloadtgoR0y18:assets%2Fa_top.pngR2i553R3R4R5R7R6tgoR0y15:assets%2Fbg.pngR2i224842R3R4R5R8R6tgoR0y20:assets%2Fblood_0.pngR2i3209R3R4R5R9R6tgoR0y20:assets%2Fblood_1.pngR2i3084R3R4R5R10R6tgoR0y20:assets%2Fblood_2.pngR2i3252R3R4R5R11R6tgoR0y20:assets%2Fblood_3.pngR2i3282R3R4R5R12R6tgoR0y17:assets%2Fdisc.pngR2i4580R3R4R5R13R6tgoR0y24:assets%2Fdisc_bloody.pngR2i7298R3R4R5R14R6tgoR0y23:assets%2Fdisc_floor.pngR2i28214R3R4R5R15R6tgoR0y21:assets%2Fdisc_man.pngR2i804R3R4R5R16R6tgoR0y26:assets%2Fdisc_man_dead.pngR2i585R3R4R5R17R6tgoR0y28:assets%2Fdisc_man_shadow.pngR2i299R3R4R5R18R6tgoR0y27:assets%2Fdisc_man_sheet.pngR2i2938R3R4R5R19R6tgoR2i4208R3y4:FONTy9:classNamey40:__ASSET__assets_disc_numbers_regular_ttfR5y33:assets%2FDisc_numbers-Regular.ttfR6tgoR2i3684R3R20R21y44:__ASSET__assets_disc_numbers_alt_regular_ttfR5y37:assets%2FDisc_numbers_alt-Regular.ttfR6tgoR2i10828R3R20R21y37:__ASSET__assets_disc_text_regular_ttfR5y30:assets%2FDisc_text-Regular.ttfR6tgoR0y21:assets%2Fl_bottom.pngR2i703R3R4R5R28R6tgoR0y18:assets%2Fl_top.pngR2i415R3R4R5R29R6tgoR0y22:assets%2Fmenu_disc.pngR2i2083R3R4R5R30R6tgoR0y16:assets%2Fpeg.pngR2i3460R3R4R5R31R6tgoR0y21:assets%2Fp_bottom.pngR2i895R3R4R5R32R6tgoR0y18:assets%2Fp_top.pngR2i560R3R4R5R33R6tgoR0y23:assets%2Fscrew_hole.pngR2i227R3R4R5R34R6tgoR0y18:assets%2Ftitle.pngR2i3279R3R4R5R35R6tgoR0y21:assets%2Fy_bottom.pngR2i949R3R4R5R36R6tgoR0y18:assets%2Fy_top.pngR2i534R3R4R5R37R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

		#end

	}


}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_a_bottom_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_a_top_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_blood_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_blood_1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_blood_2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_blood_3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_disc_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_disc_bloody_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_disc_floor_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_disc_man_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_disc_man_dead_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_disc_man_shadow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_disc_man_sheet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_disc_numbers_regular_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_disc_numbers_alt_regular_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_disc_text_regular_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_l_bottom_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_l_top_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_disc_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_peg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_p_bottom_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_p_top_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_screw_hole_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_title_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_y_bottom_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_y_top_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:image("assets/a_bottom.png") @:noCompletion #if display private #end class __ASSET__assets_a_bottom_png extends lime.graphics.Image {}
@:keep @:image("assets/a_top.png") @:noCompletion #if display private #end class __ASSET__assets_a_top_png extends lime.graphics.Image {}
@:keep @:image("assets/bg.png") @:noCompletion #if display private #end class __ASSET__assets_bg_png extends lime.graphics.Image {}
@:keep @:image("assets/blood_0.png") @:noCompletion #if display private #end class __ASSET__assets_blood_0_png extends lime.graphics.Image {}
@:keep @:image("assets/blood_1.png") @:noCompletion #if display private #end class __ASSET__assets_blood_1_png extends lime.graphics.Image {}
@:keep @:image("assets/blood_2.png") @:noCompletion #if display private #end class __ASSET__assets_blood_2_png extends lime.graphics.Image {}
@:keep @:image("assets/blood_3.png") @:noCompletion #if display private #end class __ASSET__assets_blood_3_png extends lime.graphics.Image {}
@:keep @:image("assets/disc.png") @:noCompletion #if display private #end class __ASSET__assets_disc_png extends lime.graphics.Image {}
@:keep @:image("assets/disc_bloody.png") @:noCompletion #if display private #end class __ASSET__assets_disc_bloody_png extends lime.graphics.Image {}
@:keep @:image("assets/disc_floor.png") @:noCompletion #if display private #end class __ASSET__assets_disc_floor_png extends lime.graphics.Image {}
@:keep @:image("assets/disc_man.png") @:noCompletion #if display private #end class __ASSET__assets_disc_man_png extends lime.graphics.Image {}
@:keep @:image("assets/disc_man_dead.png") @:noCompletion #if display private #end class __ASSET__assets_disc_man_dead_png extends lime.graphics.Image {}
@:keep @:image("assets/disc_man_shadow.png") @:noCompletion #if display private #end class __ASSET__assets_disc_man_shadow_png extends lime.graphics.Image {}
@:keep @:image("assets/disc_man_sheet.png") @:noCompletion #if display private #end class __ASSET__assets_disc_man_sheet_png extends lime.graphics.Image {}
@:keep @:font("export/html5/obj/webfont/Disc_numbers-Regular.ttf") @:noCompletion #if display private #end class __ASSET__assets_disc_numbers_regular_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/Disc_numbers_alt-Regular.ttf") @:noCompletion #if display private #end class __ASSET__assets_disc_numbers_alt_regular_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/Disc_text-Regular.ttf") @:noCompletion #if display private #end class __ASSET__assets_disc_text_regular_ttf extends lime.text.Font {}
@:keep @:image("assets/l_bottom.png") @:noCompletion #if display private #end class __ASSET__assets_l_bottom_png extends lime.graphics.Image {}
@:keep @:image("assets/l_top.png") @:noCompletion #if display private #end class __ASSET__assets_l_top_png extends lime.graphics.Image {}
@:keep @:image("assets/menu_disc.png") @:noCompletion #if display private #end class __ASSET__assets_menu_disc_png extends lime.graphics.Image {}
@:keep @:image("assets/peg.png") @:noCompletion #if display private #end class __ASSET__assets_peg_png extends lime.graphics.Image {}
@:keep @:image("assets/p_bottom.png") @:noCompletion #if display private #end class __ASSET__assets_p_bottom_png extends lime.graphics.Image {}
@:keep @:image("assets/p_top.png") @:noCompletion #if display private #end class __ASSET__assets_p_top_png extends lime.graphics.Image {}
@:keep @:image("assets/screw_hole.png") @:noCompletion #if display private #end class __ASSET__assets_screw_hole_png extends lime.graphics.Image {}
@:keep @:image("assets/title.png") @:noCompletion #if display private #end class __ASSET__assets_title_png extends lime.graphics.Image {}
@:keep @:image("assets/y_bottom.png") @:noCompletion #if display private #end class __ASSET__assets_y_bottom_png extends lime.graphics.Image {}
@:keep @:image("assets/y_top.png") @:noCompletion #if display private #end class __ASSET__assets_y_top_png extends lime.graphics.Image {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__assets_disc_numbers_regular_ttf') @:noCompletion #if display private #end class __ASSET__assets_disc_numbers_regular_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/Disc_numbers-Regular"; #else ascender = 720; descender = -103; height = 913; numGlyphs = 18; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Disc_numbers Regular"; super (); }}
@:keep @:expose('__ASSET__assets_disc_numbers_alt_regular_ttf') @:noCompletion #if display private #end class __ASSET__assets_disc_numbers_alt_regular_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/Disc_numbers_alt-Regular"; #else ascender = 698; descender = -95; height = 883; numGlyphs = 18; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Disc_numbers_alt Regular"; super (); }}
@:keep @:expose('__ASSET__assets_disc_text_regular_ttf') @:noCompletion #if display private #end class __ASSET__assets_disc_text_regular_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/Disc_text-Regular"; #else ascender = 666; descender = -196; height = 952; numGlyphs = 55; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Disc_text Regular"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__assets_disc_numbers_regular_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_disc_numbers_regular_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_disc_numbers_regular_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_disc_numbers_alt_regular_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_disc_numbers_alt_regular_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_disc_numbers_alt_regular_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_disc_text_regular_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_disc_text_regular_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_disc_text_regular_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__assets_disc_numbers_regular_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_disc_numbers_regular_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_disc_numbers_regular_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_disc_numbers_alt_regular_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_disc_numbers_alt_regular_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_disc_numbers_alt_regular_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_disc_text_regular_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_disc_text_regular_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_disc_text_regular_ttf ()); super (); }}

#end

#end
#end

#end
