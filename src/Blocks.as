package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author mhtsu
	 */
	public class Blocks extends Sprite
	{
		[Embed(source="../lib/block/block1.png")] private const img1:Class;
		private var bl:Bitmap = new img1;
		[Embed(source = "../lib/block/block2.png")] private const img2:Class;
		private var bl2:Bitmap = new img2;
		[Embed(source = "../lib/block/block3.png")] private const img3:Class;
		private var bl3:Bitmap = new img3;
		[Embed(source = "../lib/block/block4.png")] private const img4:Class;
		private var bl4:Bitmap = new img4;
		[Embed(source = "../lib/block/item_block.png")] private const imgI:Class;
		private var blI:Bitmap = new imgI;
		
		public var type:int = new int;
		public function Blocks():void
		{
			bl.visible = false;
			this.addChild(bl);
			bl2.visible = false;
			this.addChild(bl2);
			bl3.visible = false;
			this.addChild(bl3);
			bl4.visible = false;
			this.addChild(bl4);
			blI.visible = false;
			this.addChild(blI);
		}
		public function typeSet(t:int):void {
			if (t == 1) {
				bl.visible = true;
				bl2.visible = false;
				bl3.visible = false;
				bl4.visible = false;
				blI.visible = false;
			}else if (t == 2) {
				bl.visible = false;
				bl2.visible = true;
				bl3.visible = false;
				bl4.visible = false;
				blI.visible = false;
			}else if (t == 3) {
				bl.visible = false;
				bl2.visible = false;
				bl3.visible = true;
				bl4.visible = false;
				blI.visible = false;
			}else if (t == 4) {
				bl.visible = false;
				bl2.visible = false;
				bl3.visible = false;
				bl4.visible = true;
				blI.visible = false;
			}else if (t == 9) {
				bl.visible = false;
				bl2.visible = false;
				bl3.visible = false;
				bl4.visible = false;
				blI.visible = true;
			}
		}
	}

}