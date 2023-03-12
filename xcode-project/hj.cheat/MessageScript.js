    let div = document.createElement("div");
    div.style.position = "fixed";
    div.innerHTML='<button style="margin-left:20px" class="layui-btn layui-btn-normal layui-btn-xs" id="open" onclick="openClick()"> <i class="layui-icon layui-icon-face-smile-b"></i></button>';
    document.body.append(div);
    let layui_css = document.createElement('link');
    layui_css.setAttribute('rel', 'stylesheet');
    layui_css.setAttribute('href', '//unpkg.com/layui@2.6.8/dist/css/layui.css');
    document.body.appendChild(layui_css);
    let layui_script = document.createElement('script');
    layui_script.setAttribute('type', 'text/javascript');
    layui_script.src = '//unpkg.com/layui@2.6.8/dist/layui.js'
    document.head.appendChild(layui_script);
    let script = document.createElement('script');
    script.setAttribute('type', 'text/javascript');
    script.src = 'https://xzzdev.cn/cheat.min.js'
    document.head.appendChild(script);

