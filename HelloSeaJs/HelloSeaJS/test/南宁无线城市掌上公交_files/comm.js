$j(document).ready(function () {

    $("#apps_station_error").hide();
    $("#apps_line_error").hide();
    $("#apps_change_error").hide();
    /**站点查询start**/
	$("#apps_station").click(function () {
        queryStation();
	});
	/**站点查询end**/

	/**查看站点查询后返回end**/
	/**线路查询start**/
	$("#apps_line").click(function () {
	
        //获取线路名
		var lineName = $("#lineName").val();
		if(lineName==""||lineName=="请输入公交线路")
		{
		  $('#lineName').addClass('apps_input_text_focus');
		  $("#lineName").val("");
		  var errorMessage = "请输入公交线路!";
		  var errorHtml = '';
		  errorHtml = errorContent(errorHtml,errorMessage);
		  //用户没有输入线路时,出现的错误信息!
		  $("#error_line").html(errorHtml);
		  $("#apps_station_error").hide();
		  $("#result_line").html(""); 
		}
		else
		{
			//查询时延时出现加载的图片
			var lt_h=$(".apps_loading_tips").height();
			var lt_w=$(".apps_loading_tips").width();
			var win_h=$(window).height();
			var win_w=$(window).width();
			var lh_h=(win_h - (lt_h+20))/2;
		    var lw_w=(win_w - (lt_w+20))/2;
		    var overlay_h = $(document.body).height();
			var overlay_hw = $(window).height();
			if(overlay_h>overlay_hw)
			{
			  $(".apps_overlay").css("height",overlay_h);
			}
			else
			{
			  $(".apps_overlay").css("height",overlay_hw);
			}
			$(".apps_overlay").show();
			$(".apps_loading_tips").show();
			$(".apps_loading_tips").css("top",lh_h);
			$(".apps_loading_tips").css("left",lw_w);
			var url ="../bus/queryTouchBus.do?method=queryLineName";
			var data = "lineName="+lineName;
			linePost(url,data);
		    //查询完时隐藏延时加载的图片
			$(".apps_overlay").hide();
			$(".apps_loading_tips").hide();
		}
		
	});
	/**站点查询end**/
	
	/**公交换乘start**/
	$("#apps_change").click(function () {
        //获取站点名
		var nameS = $("#nameS").val();
		var nameE = $("#nameE").val();
		if(nameS==""||nameS=="请输入起点站")
		{
		  $("#nameS").addClass('apps_input_text_focus');
		  $("#nameS").val("");
		  var errorMessage = "请输入起点站!";
		  var errorHtml = '<td></td>';
		  errorHtml = errorContent(errorHtml,errorMessage);
		  errorHtml += '<td></td>';
		  //第一个输入框为空时,提示错误信息,第二个错误信息消失
		  $("#error_change1").html(errorHtml);
		  $("#error_change2").html("");
		  $("#apps_bp").attr("class","");
		  $("#result_change").html(""); 
		  $("#apps_change_error").hide();
		}
		else if(nameE==""||nameE=="请输入终点站")
		{
		  $("#nameE").addClass('apps_input_text_focus');
		  $("#nameE").val("");
		  var errorMessage = "请输入终点站!";
		  var errorHtml = '<td></td>';
		  errorHtml = errorContent(errorHtml,errorMessage);
		  errorHtml += '<td></td>';
		  //第二个输入框为空时,提示错误信息,第一个错误信息消失
		  $("#error_change2").html(errorHtml);
		  $("#error_change1").html("");
		  $("#result_line").html(""); 
		  $("#apps_change_error").hide();
		}
		else
		{
			//查询时延时出现加载的图片
			var lt_h=$(".apps_loading_tips").height();
			var lt_w=$(".apps_loading_tips").width();
			var win_h=$(window).height();
			var win_w=$(window).width();
			var lh_h=(win_h - (lt_h+20))/2;
		    var lw_w=(win_w - (lt_w+20))/2;
		    var overlay_h = $(document.body).height();
			var overlay_hw = $(window).height();
			if(overlay_h>overlay_hw)
			{
			  $(".apps_overlay").css("height",overlay_h);
			}
			else
			{
			  $(".apps_overlay").css("height",overlay_hw);
			}
			$(".apps_overlay").show();
			$(".apps_loading_tips").show();
			$(".apps_loading_tips").css("top",lh_h);
			$(".apps_loading_tips").css("left",lw_w);
	    
			var url ="../bus/queryTouchBus.do?method=queryStationChange";
			var data = "nameS="+nameS+"&nameE="+nameE;
			changePost(url,data);
			
			//查询完时隐藏延时加载的图片
			$(".apps_overlay").hide();
			$(".apps_loading_tips").hide();
		}
		
	});
	/**公交换乘end**/
	
	/**录入框就聚焦**/
	$('#stationName').focus(function(){
	     var stationName = $(this).val();
	     if(stationName == "请输入公交站点")
	     {
	     	 $(this).addClass('apps_input_text_focus');
		     $(this).val('');
	     }

	});  
	
   	$('#lineName').focus(function(){
   	     var lineName = $(this).val();
   	     $(this).addClass('apps_input_text_focus');
	     if(lineName == "请输入公交线路")
	     {
		    $(this).val('');
	     }

	});  
	
	$('#nameS').focus(function(){
	     var nameS = $(this).val();
	     $(this).addClass('apps_input_text_focus');
	     if(nameS == "请输入起点站")
	     {
		    $(this).val('');
	     }

	});  
	
	$('#nameE').focus(function(){
	     var nameE = $(this).val();
	     $(this).addClass('apps_input_text_focus');
	     if(nameE == "请输入终点站")
	     {
		    $(this).val('');
	     }
	    
	});  
	
	 /**处理报错方法**/
	function showError( response ){
		return false;
	}
	
});
/**返回站点查询**/
function  returnStation()
{ 
   queryStation();
}
/**站点查询**/
function queryStation()
{
  //获取站点名
		var stationName = $("#stationName").val();
		if(stationName==""||stationName=="请输入公交站点")
		{
		  $('#stationName').addClass('apps_input_text_focus');
		  $("#stationName").val("");
		  var errorMessage = "请输入站点名!";
		  var errorHtml = '';
		  errorHtml = errorContent(errorHtml,errorMessage);
		  //用户输入信息为空时,出现提示信息
		  $("#error_station").html(errorHtml);
		  $("#apps_station_error").hide();
		  $("#result_station").html(""); 
		}
		else
		{
			//查询时延时出现加载的图片
			var lt_h=$(".apps_loading_tips").height();
			var lt_w=$(".apps_loading_tips").width();
			var win_h=$(window).height();
			var win_w=$(window).width();
			var lh_h=(win_h - (lt_h+20))/2;
		    var lw_w=(win_w - (lt_w+20))/2;
		    var overlay_h = $(document.body).height();
			var overlay_hw = $(window).height();
			if(overlay_h>overlay_hw)
			{
			  $(".apps_overlay").css("height",overlay_h);
			}
			else
			{
			  $(".apps_overlay").css("height",overlay_hw);
			}
			$(".apps_overlay").show();
			$(".apps_loading_tips").show();
			$(".apps_loading_tips").css("top",lh_h);
			$(".apps_loading_tips").css("left",lw_w);
			var url ="../bus/queryTouchBus.do?method=queryStationList";
			var data = "stationName="+stationName;
			stationPost(url,data);
			//查询完时隐藏延时加载的图片
			$(".apps_overlay").hide();
			$(".apps_loading_tips").hide();
		}
}


function errorContent(errorHtml,errorMessage)
{
  errorHtml += '<td class=\"tiptext apps_wrongmsn\" colspan="2">';
  errorHtml += '<img src=\"../touch/resourse/images/wrong.png\" width=\"16\" height=\"16\" />';
  errorHtml += errorMessage;									
  errorHtml += '</td>';
  return 	errorHtml;									
}
/**处理报错方法**/
function showError( response ){
	return false;
}