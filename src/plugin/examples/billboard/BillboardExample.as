package plugin.examples.billboard 
{
	import flash.events.MouseEvent;
	import zest3d.applications.Zest3DApplication;
	import zest3d.detail.BillboardNode;
	import zest3d.effects.ReflectionEffect;
	import zest3d.primitives.TorusPrimitive;
	import zest3d.resources.TextureCube;
	
	/**
	 * This BillboardNode example causes the torus mesh to orient to the camera. BillboardNodes preserve
	 * the world orientation UNIT_Y axis. Use WASD controls to move the camera.
	 * 
	 * @author Gary Paluk
	 */
	public class BillboardExample extends Zest3DApplication 
	{
		
		[Embed(source="../../../assets/atf/skybox.atf", mimeType="application/octet-stream")]
		private var SkyboxATF:Class;
		
		override public function initialize():void 
		{
			var skyTexture:TextureCube = TextureCube.fromByteArray( new SkyboxATF() );
			var reflectionEffect:ReflectionEffect = new ReflectionEffect( skyTexture );
			
			var torus:TorusPrimitive = new TorusPrimitive( reflectionEffect, false, true, 128, 64 );
			
			var billboard:BillboardNode = new BillboardNode( _camera );
			billboard.addChild( torus );
			scene.addChild( billboard );
		}
		
		override protected function onMouseDown(e:MouseEvent):Boolean 
		{
			return false;
		}
	}
}