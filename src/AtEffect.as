package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author mhtsu
	 */
	public class AtEffect extends Sprite
	{
		[Embed(source = "../lib/effect/ef1_1.png")]private const img1:Class;
		private var ef1:Bitmap = new img1;
		[Embed(source = "../lib/effect/ef1_2.png")]private const img2:Class;
		private var ef2:Bitmap = new img2;
		[Embed(source = "../lib/effect/ef1_3.png")]private const img3:Class;
		private var ef3:Bitmap = new img3;
		[Embed(source = "../lib/effect/ef1_4.png")]private const img4:Class;
		private var ef4:Bitmap = new img4;
		
		private var ef_n:int = new int(8);//アニメフレーム番号
		
		public function AtEffect() 
		{
			ef1.visible = false;
			this.addChild(ef1);
			ef2.visible = false;
			this.addChild(ef2);
			ef3.visible = false;
			this.addChild(ef3);
			ef4.visible = false;
			this.addChild(ef4);
		}
		
		public function init():void
		{
			ef_n = 0;
		}
		
		public function update():void
		{
			if (ef_n == 0) {
				ef1.visible = true;
				ef2.visible = false;
				ef3.visible = false;
				ef4.visible = false;
			}else if (ef_n == 2) {
				ef1.visible = false;
				ef2.visible = true;
				ef3.visible = false;
				ef4.visible = false;
			}else if (ef_n == 4) {
				ef1.visible = false;
				ef2.visible = false;
				ef3.visible = true;
				ef4.visible = false;
			}else if (ef_n == 6) {
				ef1.visible = false;
				ef2.visible = false;
				ef3.visible = false;
				ef4.visible = true;
			}else if (ef_n == 8) {
				ef1.visible = false;
				ef2.visible = false;
				ef3.visible = false;
				ef4.visible = false;
				ef_n = 8;
			}
			ef_n += 1
		}
		
	}

}