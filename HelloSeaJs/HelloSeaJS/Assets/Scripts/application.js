
define(function (require, exports, module) {

    var $ = require("jquery");
    var util = require("./util");

    alert($("#hello-seajs").text());
    var helloSeaJS = document.getElementById('hello-seajs');
    helloSeaJS.style.color = util.randomColor();
    window.setInterval(function () {
        helloSeaJS.style.color = util.randomColor();
    }, 1500);
})