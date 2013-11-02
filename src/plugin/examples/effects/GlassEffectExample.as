package plugin.examples.effects 
{
	import zest3d.applications.Zest3DApplication;
	import zest3d.effects.GlassEffect;
	import zest3d.geometry.SkyboxGeometry;
	import zest3d.primitives.CubePrimitive;
	import zest3d.primitives.PlanePrimitive;
	import zest3d.primitives.TorusPrimitive;
	import zest3d.resources.TextureCube;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class GlassEffectExample extends Zest3DApplication 
	{
		
		[Embed(source="E:/My Flash Documents/Zest3D Testing/lib/skybox.atf", mimeType="application/octet-stream")]
		private var SkyboxATF:Class;
		
		private var _torus0:TorusPrimitive;
		private var _torus1:TorusPrimitive;
		private var _torus2:TorusPrimitive;
		
		override public function initialize():void 
		{			
			var skyTexture:TextureCube = TextureCube.fromByteArray( new SkyboxATF() );
			var glassEffect:GlassEffect = new GlassEffect( skyTexture );
			
			_torus0 = new TorusPrimitive( glassEffect, false, true );
			_torus0.x = -3.5;
			scene.addChild( _torus0 );
			
			_torus1 = new TorusPrimitive( glassEffect, false, true );
			_torus1.x = 3.5;
			scene.addChild( _torus1 );
			
			_torus2 = new TorusPrimitive( glassEffect, false, true );
			scene.addChild( _torus2 );
			
			skybox = new SkyboxGeometry( skyTexture );
			skybox.rotationX = 180 * (Math.PI/180)
		}
		
		override protected function update(appTime:Number):void 
		{
			_torus0.rotationY += 0.05;
			_torus1.rotationY -= 0.05;
			_torus2.rotationY += 0.05;
		}
	}

}