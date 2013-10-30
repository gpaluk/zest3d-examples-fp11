package plugin.examples.particle 
{
	import flash.utils.ByteArray;
	import zest3d.applications.Zest3DApplication;
	import zest3d.effects.Texture2DEffect;
	import zest3d.geometry.ParticleGeometry;
	import zest3d.RandomParticleController;
	import zest3d.resources.Texture2D;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class ParticleExample extends Zest3DApplication 
	{
		
		[Embed(source = "../../../assets/atf/particle.atf", mimeType = "application/octet-stream")]
		private var ParticleATF:Class;
		
		override public function initialize():void 
		{
			var particleTexture:Texture2D = Texture2D.fromByteArray( new ParticleATF() );
			var particleEffect:Texture2DEffect = new Texture2DEffect( particleTexture );
			
			var numParticles:int = 2000;
			var positionSizes:ByteArray = new ByteArray();
			for ( var i:Number = 0; i < numParticles; ++i )
			{
				positionSizes.writeFloat( (Math.random()-0.5) ); //x
				positionSizes.writeFloat( (Math.random()-0.5) ); //y
				positionSizes.writeFloat( (Math.random()-0.5) ); //z
				positionSizes.writeFloat( (Math.random() * 0.5) ); // scaler
			}
			
			var particles:ParticleGeometry = new ParticleGeometry( particleEffect, numParticles, positionSizes );
			particles.scaleUniform = 10;
			particles.addController( new RandomParticleController() );
			
			scene.addChild( particles );
		}
	}
}