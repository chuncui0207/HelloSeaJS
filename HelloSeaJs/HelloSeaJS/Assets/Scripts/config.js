seajs.config({
    plugins: ["shim"],

    alias: {
        // 配置 jquery 的 shim 配置，这样我们就可以通过 require('jquery') 来获取 jQuery
        'jquery': {
            src: 'lib/jquery-1.9.1.min.js',
            exports: 'jQuery'
        }
    }
});