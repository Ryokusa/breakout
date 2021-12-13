package 
{
	import adobe.utils.CustomActions;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author mhtsu
	 */
	public class Main extends Sprite 
	{ 
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
						var key:Array = new Array;
			var debugT:TextField = new TextField;
			debugT.width = 100;
			debugT.height = 100;
			debugT.visible = false;
			stage.addChild(debugT);
			var stT:TextField = new TextField
			stT.width = 300;
			stT.height = 20;
			stage.addChild(stT);
			stT.text = "スペースでスタート"
			var mNum:int = new int(1);
			var bMap:Array = new Array;
			bMap = mDataLoad(mNum);
			var mapS:int = new int(4);	//マップ数
			var bS:int = new int;	//ブロック数
			var b:Array = new Array
			for (var i:int = 0; i < 24; i++) {
				b[i] = new Blocks
				b[i].visible = false;
				stage.addChild(b[i]);
			}
			[Embed(source = "../lib/bar.png")]const img:Class;
			var bar:Bitmap = new img;
			bar.x = 160;
			bar.y = 220;
			stage.addChild(bar);
			const barSp:int = new int(4);
			[Embed(source = "../lib/balll.png")]const img2:Class;
			var ball:Bitmap = new img2;
			ball.x = 190;
			ball.y = 199;
			stage.addChild(ball);
			[Embed(source = "../lib/CLEAR.png")]const img3:Class;
			var Clear:Bitmap = new img3;
			Clear.x = 100;
			Clear.y = 100;
			Clear.visible = false;
			stage.addChild(Clear);
			[Embed(source = "../lib/GAMEOVER.png")]const img4:Class;
			var Gameover:Bitmap = new img4;
			Gameover.x = 50;
			Gameover.y = 100;
			Gameover.visible = false;
			stage.addChild(Gameover);
			
			var bSpX:int = new int(2);
			var bSpY:int = new int(-4)
			
			var bF:int = new int(0);
			
			bLoad(bMap);
			
			var at:AtEffect = new AtEffect;
			stage.addChild(at)
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, function keyDown(e:KeyboardEvent):void {
				key[e.keyCode] = true
			})
			
			stage.addEventListener(KeyboardEvent.KEY_UP, function keyUp(e:KeyboardEvent):void {
				key[e.keyCode] = false
			})
			
			stage.addEventListener(Event.ENTER_FRAME, function enterFrame():void {
				debugT.text = "" + key[39] + "\n" + key[37] + "\n" + ball.x + "\n" + ball.y + "\n" + bS
				if (bF >= 0){
					cont();
					bAt();
					if (bF == 1) {
						stT.text = "";
					}else if (bF == -1) {
						Gameover.visible = true;
					}else if (bF == -2) {
						Clear.visible = true;//クリア表示
					}
					if (key[112]) {
						debugT.visible = true;
					}else if (key[113]) {
						debugT.visible = false;
					}else if (key[114]) {
						bF = -2
					}else if (key[115]) {
						bF = 2;	//貫通
					}
				}else if (bF == -2) {
					if (key[78]) {
						if (mNum < mapS) {
							Clear.visible = false;	//クリア表示消去
							bSpX = 2;
							bSpY = -4;
							ball.y = 199;
							ball.x = bar.x + 30
							bF = 0;
							mNum += 1;
							bMap = mDataLoad(mNum);
							bLoad(bMap);
						}else {
							stT.text = "最後まで遊んでくれてありがとう！"
						}
					}
				}else if (bF == -1) {
					if (key[78]) {
						Gameover.visible = false;
						bSpX = 2;
						bSpY = -4;
						ball.y = 199;
						ball.x = bar.x + 30
						bF = 0;
						mNum = 1;
						bMap = mDataLoad(mNum);
						bLoad(bMap);
					}
				}
				at.update()
			})
			function bAt():void {
				var F:Boolean = new Boolean(false);
				if (bF > 0) {
					ball.x += bSpX;
					ball.y += bSpY;
					if (ball.x < 0) {
						ball.x = 0;
						bSpX *= -1;
					}else if (ball.x > 380) {
						ball.x = 380;
						bSpX *= -1;
					}
					if (ball.y < 0) {
						ball.y = 0;
						bSpY *= -1;
					}
					if (ball.y > 300) {
						bSpX = 0;
						bSpY = 0;
						bF = -1;
					}
					if (sqAt(bar.x, bar.y, 80, 10, ball.x, ball.y, 20, 20)) {
						bSpX = ((bar.x + 40) - (ball.x + 10)) / 10 * -1
						bSpY *= -1
						ball.y = bar.y - 21
					}
					for (var i:int = 0; i < 24; i++) {
						if (sqAt(b[i].x, b[i].y, 50, 20, ball.x, ball.y, 20, 20)) {
							if (bMap[uint(i / 6)][i % 6] != 0) {
								if (bF == 1){
									if ((ball.x + 20) - b[i].x <= 8) {
										if (bSpX > 0){
											bSpX *= -1;
											ball.x = b[i].x - 21
										}
									}else if ((b[i].x + 50) - ball.x <= 8) {
										if (bSpX < 0){
											bSpX *= -1
											ball.x = b[i].x + 51
											F = true;
										}
									}
									if ((ball.y + 20) - b[i].y <= 4) { //上
										if (bSpY > 0){
											bSpY *= -1;
											ball.y = b[i].y - 21
										}
									}else if ((b[i].y + 20) - ball.y <= 4) {	//下
										if (bSpY < 0){
											bSpY *= -1;
											ball.y = b[i].y + 21
										}
									}
									bMap[uint(i / 6)][i % 6] -= 1
								}else if (bF == 2) {
									bMap[uint(i / 6)][i % 6] = 0;
								}
								bLoad(bMap);
								if (bS == 0) {
									bF = -2;
								}
								at.init()
								at.x = ball.x - 10
								at.y = ball.y - 10
							}
						}
					}
				}
			}
			function cont():void {
				if (key[32]) {
					bF = 1;
				}
				if (key[39]) {
					bar.x += barSp;
					if (bF == 0) {
						ball.x += barSp;
					}
				}
				if (key[37]) {
					bar.x -= barSp;
					if (bF == 0) {
						ball.x -= barSp;
					}
				}
				if (bar.x < 0) {
					bar.x = 0;
					if (bF == 0) {
						ball.x = 30;
					}
				}else if (bar.x + 80 > 400) {
					bar.x = 320;
					if (bF == 0) {
						ball.x = 350;
					}
				}
			}
			function bLoad(map:Array):void {
				var a:int = new int
				var aa:int = new int
				for (var i:int = 0; i < 4;i++ ) {
					for (var i2:int = 0; i2 < 6;i2++ ) {
						if (map[i][i2] > 0) {
							a = i * 6 + i2
							b[a].typeSet(map[i][i2]);
							b[a].x = i2 * 50 + 50;
							b[a].y = i * 20 + 30;
							b[a].visible = true;
						}else if (map[i][i2] == 0) {
							a = i * 6 + i2
							b[a].visible = false;
						}
						aa += map[i][i2]
						bS = aa;
					}
				}
			}
			function sqAt(x:int, y:int, xS:int, yS:int, x2:int, y2:int, xS2:int, yS2:int):Boolean {
				var b:Boolean = new Boolean(false);
				if (x > x2 + xS2) {
				}else if (x + xS < x2) {
				}else if (y > y2 + yS2) {
				}else if (y + yS < y2) {
				}else {
					b = true;
				}
				return b;
			}
			function mDataLoad(num1:int):Array {
				var re:Array = new Array;
				if (num1 == 1) {
					re = [
					[9, 1, 1, 1, 1, 1],
					[1, 1, 1, 1, 1, 1],
					[1, 1, 1, 1, 1, 1],
					[0, 0, 0, 0, 0, 0]
					]
				}else if (num1 == 2) {
					re = [
					[2, 2, 2, 2, 2, 2],
					[1, 1, 1, 1, 1, 1],
					[1, 1, 1, 1, 1, 1],
					[0, 0, 0, 0, 0, 0]
					]
				}else if (num1 == 3) {
					re = [
					[2, 2, 2, 2, 2, 2],
					[1, 1, 1, 1, 1, 1],
					[1, 1, 2, 2, 1, 1],
					[1, 0, 1, 1, 0, 1]
					]
				}else if (num1 == 4) {
					re = [
					[3, 2, 2, 2, 2, 3],
					[2, 2, 2, 2, 2, 2],
					[1, 1, 1, 1, 1, 1],
					[1, 1, 1, 1, 1, 1]
					]
				}
				return re;
			}
		}
		
	}
	
}