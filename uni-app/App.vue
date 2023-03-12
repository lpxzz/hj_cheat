<script>
	export default {
		onLaunch: function() {
			plus.screen.lockOrientation('landscape-primary'); //锁定横屏
			plus.navigator.setFullscreen(true); //隐藏状态栏(应用全屏:只能隐藏状态栏，标题栏和虚拟返回键都还可以显示)	
			console.log('App Launch')
		},
		onShow: function() {
			console.log('App Show')
		},
		onHide: function() {
			console.log('App Hide')
		}
	}
</script>

<style>
	/*每个页面公共css */
</style>
