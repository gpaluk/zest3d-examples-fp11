package plugin.examples.effects 
{
	import io.plugin.core.graphics.Color;
	import io.plugin.utils.Stats;
	import zest3d.applications.Zest3DApplication;
	import zest3d.effects.local.WireframeEffect;
	import zest3d.geometry.SkyboxGeometry;
	import zest3d.resources.enum.AttributeType;
	import zest3d.resources.enum.AttributeUsageType;
	import zest3d.resources.enum.BufferUsageType;
	import zest3d.resources.IndexBuffer;
	import zest3d.resources.TextureCube;
	import zest3d.resources.VertexBuffer;
	import zest3d.resources.VertexBufferAccessor;
	import zest3d.resources.VertexFormat;
	import zest3d.scenegraph.TriMesh;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class WireframeEffectExample extends Zest3DApplication 
	{
		
		[Embed(source = "../../../assets/atfcube/skybox.atf", mimeType = "application/octet-stream")]
		private var SKYBOX_ATF:Class;
		
		override protected function initialize():void 
		{
			addChild( new Stats() );
			clearColor = new Color( 0, 0, 0, 1 );
			var color:Color = new Color( 1, 1, 1, 1 );
			var wireframeEffect:WireframeEffect = new WireframeEffect( color, 0.1 );
			
			var vFormat:VertexFormat = new VertexFormat( 2 );
			vFormat.setAttribute( 0, 0, 0, AttributeUsageType.POSITION, AttributeType.FLOAT3, 0 );
			vFormat.setAttribute( 1, 0, 12, AttributeUsageType.NORMAL, AttributeType.FLOAT3, 0 );
			vFormat.stride = 24;
			
			var vBuffer:VertexBuffer = new VertexBuffer( 3, vFormat.stride, BufferUsageType.STATIC );
			
			var vba:VertexBufferAccessor = new VertexBufferAccessor( vFormat, vBuffer );
			vba.setPositionAt( 0, [ -1, 1, 0 ] );
			vba.setPositionAt( 1, [  1, 1, 0 ] );
			vba.setPositionAt( 2, [  1,  -1, 0 ] );
			vba.setPositionAt( 3, [ -1, -1, -1 ] );
			
			vba.setNormalAt( 0, [ 1, 0, 0, 0 ] );
			vba.setNormalAt( 1, [ 0, 1, 0, 0 ] );
			vba.setNormalAt( 2, [ 0, 0, 1, 0 ] );
			vba.setNormalAt( 3, [ 0, 0, 0, 1 ] );
			
			trace( "Num vertices : " + vba.numVertices );
			
			var iBuffer:IndexBuffer = new IndexBuffer( 3, 2, BufferUsageType.STATIC );
			iBuffer.setIndexAt( 0, 0 );
			iBuffer.setIndexAt( 1, 1 );
			iBuffer.setIndexAt( 2, 2 );
			iBuffer.setIndexAt( 3, 0 );
			iBuffer.setIndexAt( 4, 2 );
			iBuffer.setIndexAt( 5, 3 );
			
			var triMesh:TriMesh = new TriMesh( vFormat, vBuffer, iBuffer );
			triMesh.effect = wireframeEffect;
			
			var skyboxTexture:TextureCube = TextureCube.fromByteArray( new SKYBOX_ATF() );
			skybox = new SkyboxGeometry( skyboxTexture );
			
			scene.addChild( triMesh );
		}	
	}
}