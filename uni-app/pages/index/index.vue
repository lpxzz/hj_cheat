<template>
	<view>
		<view class="status_bar">
		</view>
	</view>
</template>

<script>
	var wv; //计划创建的webview
	var url = "https://h.api.4399.com/g.php?gameId=100063331";
	export default {
		name: 'haojie',
		components: {

		},
		data() {
			return {
				gameUrl: null,
			}
		},
		created() {},
		methods: {
			// 页面跳转监听器
			embedLoaded(e) {
				alert('Loaded: ' + wv.getURL());
			},
			// 创建新的真实游戏窗口
			create_game_view() {
				// #ifdef APP-PLUS
				plus.webview.close(wv);
				wv = plus.webview.create("", "custom-webview", {

				})
				wv.appendJsFile('_www/static/hook_script.js');
				console.log(plus.io.convertLocalFileSystemURL("_www/static/hook_script.js"));
				wv.loadURL(this.gameUrl)
				var currentWebview = this.$scope
					.$getAppWebview(); //此对象相当于html5plus里的plus.webview.currentWebview()。在uni-app里vue页面直接使用plus.webview.currentWebview()无效
				currentWebview.append(wv); //一定要append到当前的页面里！！！才能跟随当前页面一起做动画，一起关闭
				// 注入脚本
				// wv.evalJS(hookScript);
				// #endif
			},
		},
		onLoad() {
			// #ifdef APP-PLUS
			wv = plus.webview.create("", "custom-webview", {
				// plusrequire: "none", //禁止远程网页使用plus的API，有些使用mui制作的网页可能会监听plus.key，造成关闭页面混乱，可以通过这种方式禁止
				'uni-app': 'none', //不加载uni-app渲染层框架，避免样式冲突
				// top: uni.getSystemInfoSync().statusBarHeight //放置在titleNView下方。如果还想在webview上方加个地址栏的什么的，可以继续降低TOP值
			})
			wv.loadURL(url)
			// 弃用 html5+api几乎都不支持ios
			var phone_os = uni.getSystemInfoSync().platform
			if (phone_os == "ios") {
				console.log("ios处理");
				nw.addEventListener('loaded', function() {
					console.log('New Window loaded!');
					nw.show(); // 显示窗口
					w.close();
					w = null;
				}, false);
			} else {
				wv.listenResourceLoading({
					match: ".*",
				}, (e) => {
					var local_url = "https://huangdi.3304399.net/huangdi_h5/server/ctlcenter/client_king3_h5.php";
					if (e.url.indexOf(local_url) !== -1) {
						// 监听到真实地址 重新加载webview
						console.log("监听资源：" + e.url)
						this.gameUrl = e.url;
						this.create_game_view()
					}
				})
			}


			var currentWebview = this.$scope
				.$getAppWebview(); //此对象相当于html5plus里的plus.webview.currentWebview()。在uni-app里vue页面直接使用plus.webview.currentWebview()无效
			currentWebview.append(wv); //一定要append到当前的页面里！！！才能跟随当前页面一起做动画，一起关闭
			// #endif
		}
	}
</script>
<style>
	.status_bar {
		height: 100%;
		width: 100%;
	}
</style>
<!-- 2074044938 -->
