	
	function logout(){
	    var isLogout = window.confirm("你确定要退出登录吗？");
	    if(isLogout){
		  jQuery.getJSON("http://guangzhou.wap.wxcs.cn/bcp-server/ajax/requestUserLogout.do?jsoncallback=?",{areaCode:'',forwardURL:'http%3A%2F%2Fnnbus.wxgx.cn',areaName:''},function(data){
		  		document.cookie = "nickName=;domain=.wxcs.cn;path=/";
				document.cookie = "mobile=;domain=.wxcs.cn;path=/";
				document.cookie = "email=;domain=.wxcs.cn;path=/";
				document.cookie = "userLogo=;domain=.wxcs.cn;path=/"; 
			if(data.status== '0'){
				jQuery("#hpop2").html(data.detail);
				jQuery(".pop_bg").hide();
				jQuery("#pop_win_tip_1").show();
				
				var url = "http://guangzhou.wap.wxcs.cn/m/index";
				window.location.href = "http://guangzhou.wap.wxcs.cn/bcp-server/ajax/cleanCookieAndJump.do?backurl="+encodeURIComponent(url);
			}
			else{
				jQuery("#hpop2").html(data.detail);
				jQuery(".pop_bg").show();
				jQuery("#pop_win_tip_1").show();
			}
		  });
		}
	}
	
	
	
	jQuery(function(){
		jQuery(".pop_category").hide();
		jQuery(".life_more").click(function(){jQuery(".pop_category").show()});
		jQuery(".pop_close").click(function(){jQuery(".pop_category").hide()});
	});
	
	jQuery(function(){
	    jQuery("#thisPage").attr("value",2);
		jQuery("#closebtn").bind("click",function(){
			jQuery(".pop_bg,#resShare_tip").hide();
		});
		jQuery('.r_comment').hide().eq(0).show();
		jQuery('.r_tabs li').each(function(i){
		jQuery(this).click(function(){
		jQuery('.r_tabs li').removeClass('r_now').eq(i).addClass('r_now');
		jQuery('.r_comment').hide().eq(i).show();
		});
		});
		jQuery('.score a').each(function(i){
		jQuery(this).click(function(){
		jQuery('.score a').removeClass('star_red').eq(i).addClass('star_red');
		});});
	});
	function hideall(){
		jQuery(".pop_bg,#resShare_tip").hide();
	}
	function calc(time){ 
		if(time>0){
			time--; 
			setTimeout('calc('+time+')',1000); 
		}else{
			jQuery(".pop_bg").hide();
			jQuery("#resShare_tip").hide();
		} 
	}
	function upcomment(){
		var comDetail = jQuery("#comDetail").val();
		var resCode = jQuery("#resCode").val();
		var grade = jQuery("#grade").val();
								jQuery.getJSON("http://guangzhou.wap.wxcs.cn/bcp-server/ajax/requestUpComment.do?jsoncallback=?",{comments:comDetail,resCode:resCode,grade:grade,nodeType:"NODE_TYPE_APP",areaCode:440100,areaCode:''},function(data){
			if(data.status == '0'){
				jQuery("#commentResult").html(data.detail);
				jQuery(".pop_bg").show();
				jQuery("#resShare_tip").show();
				calc(2);
							}else{
				if(data.status == '1'){
					var url = document.location.href;
					jQuery("#commentResult").html("<a href='https://ac.wxcs.cn/m/login?backURL="+encodeURIComponent(url)+"&areaName=zhengzhou&jumpType=1'>请先登录！</a>");
				}else{
					jQuery("#commentResult").html(data.detail);
				}
				jQuery(".pop_bg").show();
				jQuery("#resShare_tip").show();
				calc(2);
			}
		});/*end getJson#upcomment*/
	}/*end fn*/
	
	function getGrade(value){
					jQuery("#grade").attr("value",value);
    		switch(value)
    		{
    		case  1:
    			jQuery("#comDetail").attr("value","很差");
    			break;
    		case 2:
    			jQuery("#comDetail").attr("value","不太好");
    			break;
    		case 3:
    			jQuery("#comDetail").attr("value","一般");
    			break;
    		case 4:
    			jQuery("#comDetail").attr("value","非常好");
    			break;
    		case 5:
    			jQuery("#comDetail").attr("value","极力推荐");
    			break;
    		default:
                    　　     	jQuery("#comDetail").attr("value","一般");
    		}
			}
		
	function getMorecomment(){
		var resCode = jQuery("#resCode").val();
		var thisPage = jQuery("#thisPage").val();
		jQuery.getJSON("http://guangzhou.wap.wxcs.cn/bcp-server/ajax/requestMoreInfoComment.do?jsoncallback=?",{resCode:resCode,thisPage:thisPage,type:"1",areaCode:''},function(data){
		    var status = data.status;
		    var detail = data.detail;
		    if(status == "0"){
			   jQuery("#commentList").append(detail);
			   jQuery("#thisPage").attr("value",parseInt(thisPage)+1);
			} else {
			   showTip(detail);
			}
		});
	}
	jQuery(function (){
		 jQuery("#comDetail").focus(function(){      	
      	if(jQuery(this).val()=="请输入你想说的话..."){
         	jQuery(this).val("");
         }
      });/*end focus*/
      jQuery("#comDetail").blur(function(){      	
      	if(isBlank(jQuery(this).val())){
      		jQuery(this).val("请输入你想说的话...");
      	}
      });/*end blur*/
	});
	
	function deleteCommont(id){
		jQuery.getJSON("http://guangzhou.wap.wxcs.cn/bcp-server/ajax/requestDeleteComment.do?jsoncallback=?",{id:id,areaCode:''},function(data){
			if(data.status=="0"){
				jQuery("#comt"+id).remove();			
				jQuery("#fullSize").html(parseInt(jQuery("#fullSize").html()-1));
			}
			showTip(data.detail);
		});/*end getJson*/
	}
	
	function showTip(param){
		jQuery(".pop_bg,#resShare_tip").show();
	    jQuery("#commentResult").html(param);    
	}
	
	function isNotBlank(param){
		 if(param == null || param =="" || param == undefined){
		 	return false;
		 }else{
		 	return true;
		 }
	}
  
  	function isBlank(param){
  		return !isNotBlank(param);
  	}
	String.prototype.trim = function () {
	    return this .replace(/^\s\s*/, '' ).replace(/\s\s*$/, '' );
	};
	function getCode(){
      jQuery(".code").attr("src","http://guangzhou.wap.wxcs.cn/bcp-server/ajax/admin/captcha?value="+new Date().getTime());
   	}
	jQuery(function(){
		jQuery("#closebtn").bind("click",function(){
			jQuery(".pop_bg").hide();
			jQuery("#share_tip").hide();
		});
		jQuery("#close_forward_tip").bind("click",function(){
			jQuery(".pop_bg").hide();
			jQuery("#forward_tip").hide();
			jQuery("#msgshowChange").show();
    		jQuery("#recom_mob").hide();
    		jQuery("#recom_eml").hide();
		});
		jQuery("#closeFenglei").bind("click",function(){
			jQuery("#feilei").hide();
			jQuery(".pop_bg").hide();
		});
		jQuery("#phoneId").focus(function(){      	
	      	if(jQuery(this).val()=="请输入好友手机号"){
	         	jQuery(this).val("");
	         }
	      });/*end focus*/
	      jQuery("#phoneId").blur(function(){      	
	      	if(isBlank(jQuery(this).val())){
	      		jQuery(this).val("请输入好友手机号");
	      	}
	      });/*end blur*/
	      
	      jQuery("#emailId").focus(function(){      	
	      	if(jQuery(this).val()=="请输入好友邮箱地址"){
	         	jQuery(this).val("");
	         }
	      });/*end focus*/
	      jQuery("#emailId").blur(function(){      	
	      	if(isBlank(jQuery(this).val())){
	      		jQuery(this).val("请输入好友邮箱地址");
	      	}
	      });/*end blur*/
	      jQuery("#imageCode2").focus(function(){      	
	      	if(jQuery(this).val()=="验证码"){
	         	jQuery(this).val("");
	         }
	      });/*end focus*/
	      jQuery("#imageCode2").blur(function(){      	
	      	if(isBlank(jQuery(this).val())){
	      		jQuery(this).val("验证码");
	      	}
	      });/*end blur*/
	      jQuery("#imageCode1").focus(function(){      	
	      	if(jQuery(this).val()=="验证码"){
	         	jQuery(this).val("");
	         }
	      });/*end focus*/
	      jQuery("#imageCode1").blur(function(){      	
	      	if(isBlank(jQuery(this).val())){
	      		jQuery(this).val("验证码");
	      	}
	      });/*end blur*/
	});
	function calc(time){ 
		if(time>0){
			time--; 
			setTimeout('calc('+time+')',1000); 
		}else{
			jQuery(".pop_bg").hide();
			jQuery("#share_tip").hide();
			jQuery("#resShare_tip").hide();
		} 
	}
	function share(classification){
		jQuery("#feilei").hide();
		var resCode = jQuery("#resCode").val();
		var areaId = jQuery("#areaId").val();
		jQuery.getJSON("http://guangzhou.wap.wxcs.cn/bcp-server/ajax/requestInfoFav.do?jsoncallback=?",{resCode:'',classification:classification,areaId:areaId,areaCode:''},function(data){
			if(data.status == '0'){
				jQuery("#shareResult").html(data.detail);
				jQuery("#share_title").html('收藏');
				jQuery("#collectionbutton").hide();
				jQuery("#share_tip").show();
				jQuery(".pop_bg").show();
				calc(2);
			}else{
				jQuery("#shareResult").html(data.detail);
				jQuery("#share_title").html('收藏');
				jQuery("#share_tip").show();
				jQuery(".pop_bg").show();
				calc(2);
			}
		});
	}
	/*订阅*/
	function order(){
	jQuery.getJSON("http://guangzhou.wap.wxcs.cn/bcp-server/ajax/requestaddSubscribeMsg.do?jsoncallback=?",{resCode:''},function(data){
		if(data.status == '0'){
			jQuery("#shareResult").html("订阅成功");
			jQuery("#share_title").html('订阅');
			jQuery("#subLink").hide();
			jQuery("#share_tip").show();
			jQuery(".pop_bg").show();
			calc(2);
		}else{
			jQuery("#shareResult").html(data.detail);
			jQuery("#share_title").html('订阅');
			jQuery("#share_tip").show();
			jQuery(".pop_bg").show();
			calc(2);
		}
	});
}
	
	function showadd(){
		var num = document.getElementById("shareNum").getElementsByTagName("li").length;
		num = num + 1;
		jQuery("#shareNum").append("<li id=\"addLi\"><input id=\"newCategory\" type=\"text\" class=\"w_92\" value=\"输入分类\" onfocus=\"catgoryFocus()\" onblur=\"catgoryBlur()\"><a class=\"choice\" href=\"javascript:clickchoicebtn(this);\">取消</a><a class=\"choice\" href=\"javascript:submitC()\">确定</a></li>");
		jQuery("#addBtn").hide();
	}
	function  catgoryFocus(){
         var obj=document.getElementById("newCategory");
      	if(obj.value=="输入分类"){
            obj.value="";
         }
      }
    function  catgoryBlur(){ 
            var obj=document.getElementById("newCategory");
          	if(isBlank(obj.value)){
          		obj.value="输入分类";
          	}
    }
	function clickchoicebtn(obj){
		jQuery("#addLi").remove();
		jQuery("#addBtn").show();
		jQuery("#addResultMsg").html("");
	    jQuery("#addResultMsg").show();
	}
	var categoryCnt = jQuery("#collectionClassSize").val();
	function submitC(){
		var category=jQuery("#newCategory").val();
		var areaId = jQuery("#areaId").val();
		
		if(categoryCnt>9){
				jQuery("#addResultMsg").html("自定义分类不能超过8个");
	          	jQuery("#addResultMsg").show();
		    	return;
			}
		    if(isBlank(category)){
		    	jQuery("#addResultMsg").html("自定义分类不能为空");
	          	jQuery("#addResultMsg").show();
		    	return;
		    }
		    if(category == "默认分类"){
		    	jQuery("#addResultMsg").html("分类名重复");
	          	jQuery("#addResultMsg").show();
		    	return;
		    }
		    if(category == "输入分类"){
		    	jQuery("#addResultMsg").html("分类名不能为空");
	          	jQuery("#addResultMsg").show();
		    	return;
		    }
		    if(/[`~%!@#^=''?~！@#￥……&——‘”“'？*()（），,。.、《》<>]/.test(category)){
		    	jQuery("#addResultMsg").html("分类名称不能包含特殊字符");
	          	jQuery("#addResultMsg").show();
		        return;
		    }
			if(category.length>10){
				jQuery("#addResultMsg").html("自定义分类长度不能超过10");
	          	jQuery("#addResultMsg").show();
		    	return;
		    }
		
	    jQuery.getJSON("http://guangzhou.wap.wxcs.cn/bcp-server/ajax/addCategory.do?jsoncallback=?",{category:category,areaCode:areaId,areaCode:''},function(data){
	       var status = data.status;
	       if(status == "0"){
	       categoryCnt++;
	       	   var u = document.getElementById("shareNum");
			   var num = u.getElementsByTagName("li").length;
			   jQuery("#addLi").remove();
	           jQuery("#shareNum").append("<li>"+num+"、"+category+" <a class=\"choice\" href=\"javascript:share('"+category+"');\">选择</a></li>");
	           jQuery("#addBtn").show();
			   jQuery("#addResultMsg").hide();
	           return;
	       } else {
	          jQuery("#addResultMsg").html(data.detail);
	          jQuery("#addResultMsg").show();
	      }
	   });
	}
	
	function showfeileiDiv(){
		var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
		var iHeihgt = document.documentElement.clientHeight;
		jQuery("#feilei").show();
		jQuery("#share_tip").show();
		var oHeight1 = jQuery("#feilei").height();
		var oHeight2 = jQuery("#share_tip").height();
		jQuery("#feilei").hide();
		jQuery("#share_tip").hide();
		var maxHeight = getScrollHeight();	jQuery.getJSON("http://guangzhou.wap.wxcs.cn/bcp-server/ajax/requestCheckLoginStatus.do?jsoncallback=?",{areaCode:''},function(data){
			var status = data.status;
		   if(status == "0"){
				jQuery("#feilei").show();
				if(oHeight1 > iHeihgt){
					jQuery("#feilei").css("top",0+scrollTop);
				}else{
					jQuery("#feilei").css("top",(iHeihgt - oHeight1)/2 + scrollTop);
				}
				jQuery(".pop_bg").show().css("height",maxHeight);
		   } else {
			  jQuery("#shareResult").html(data.detail);
			  jQuery("#share_title").html('收藏');
			  jQuery("#share_tip").show();
			  jQuery(".pop_bg").show().css("height",maxHeight);;
			  if(oHeight2 > iHeight){
				jQuery("#share_tip").css("top",0+scrollTop);
			  }else{
				jQuery("#share_tip").css("top",(iHeihgt - oHeight2)/2 + scrollTop);
			  }
			  calc(2);
		  }
		});
	}

	function getScrollHeight()
	{
		return Math.max(document.body.scrollHeight,document.documentElement.scrollHeight);
	}
		
	function showShareDiv(){
		/*jQuery.getJSON("http://guangzhou.wap.wxcs.cn/bcp-server/ajax/requestCheckLoginStatus.do?jsoncallback=?",{areaCode:''},function(data){
		var status = data.status;
	       if(status == "0"){*/
	       		jQuery("#recom_mob").hide();
            	jQuery("#recom_eml").hide();
            	jQuery("#msgshowChange").show();
                jQuery("#forward_tip").show();
                jQuery(".pop_bg").show();
            	jQuery("#recom_mob").hide();
            	jQuery("#recom_eml").hide();
	    /*   } else {
	          jQuery("#shareResult").html(data.detail);
	          jQuery("#share_title").html('分享');
	          jQuery("#share_tip").show();
	         calc(2);
	      }
		});*/
	}
	function checkUserLogin(title){
		var a = 0;
		jQuery.getJSON("http://guangzhou.wap.wxcs.cn/bcp-server/ajax/requestCheckLoginStatus.do?jsoncallback=?",{areaCode:''},function(data){
		var status = data.status;
	       if(status == "0"){
	       		a = 0;
	       } else {
			jQuery("#forward_tip").hide();
	          jQuery("#shareResult").html(data.detail);
	          jQuery("#share_title").html(title);
	          jQuery("#share_tip").show();
	          a = 1;
	      }
		});
	      return a;
	}
	function forwordBySMS(){
	var flag = checkUserLogin('短信推荐');
		if(flag == 0){
			var account = jQuery("#phoneId").val();
			var imgCode = jQuery("#imageCode1").val();
			var resName = jQuery("#resName").val();
			var resCode = jQuery("#resCode").val();
			var URL = window.location.href;
			jQuery("#recom_mob").show();
			jQuery("#recom_eml").hide();
			if(account == null || account =="" || account == undefined ||account=="请输入好友手机号"){
				jQuery("#msgshow1").html("请输入手机号");
				jQuery("#msgshow1").show();
				return;
			}
			
			jQuery.ajax({
    			url:"http://guangzhou.wap.wxcs.cn/bcp-server/ajax/checkIsChinaMobile.do?jsoncallback=?",
    			type:"post",
    			data:{mobileNum:account},
    			async: false,/*async:false 同步请求*/
    			dataType:"json",
    			success:function (data){
    				if(data.status == "0"){/*是移动手机号码*/
    					if(imgCode == null || imgCode =="" || imgCode == undefined ||imgCode=="验证码" ){
            				jQuery("#msgshow1").html("请输入验证码");
            				jQuery("#msgshow1").show();
            				return;
            			}
            			jQuery.getJSON("http://guangzhou.wap.wxcs.cn/bcp-server/ajax/requestForwardByPhone.do?jsoncallback=?",{phoneId:account,imageCode:imgCode,resName:resName,URL:URL,resCode:resCode,areaCode:''},function (data){
            				var status = data.status;
            				if(status == '0'){
            					jQuery("#forward_tip").hide();
            					showTipByshare(data.detail,"短信推荐");
            				}else{
            					jQuery("#msgshow1").html(data.detail);
            					jQuery("#msgshow1").show();
            				}
            			});/*end getJson*/
    				} else {
    					jQuery("#msgshow1").html("仅支持移动手机号，换个号码试试");
        				jQuery("#msgshow1").show();
        				return;
    				}
    			}
    		});/*end ajax*/ 
		}
	}/*end fn*/
	
	function cancelForwordByEmail(){
    	jQuery("#msgshowChange").show();
    	jQuery("#recom_mob").hide();
    	jQuery("#recom_eml").hide();
        jQuery(".pop_bg").hide();
    }
	function forwordByEmail(){
	var flag = checkUserLogin('邮箱推荐');
		if(flag == 0){
			jQuery("#recom_mob").hide();
			jQuery("#recom_eml").show();
			var account = jQuery("#emailId").val();
			var imgCode = jQuery("#imageCode2").val();
			var resName = jQuery("#resName").val();
			var resCode = jQuery("#resCode").val();
			var URL = window.location.href;
			if(account == null || account =="" || account == undefined ||account=="请输入好友邮箱地址"){
				jQuery("#msgshow2").html("请输入邮箱地址");
				jQuery("#msgshow2").show();
				return;
			}
			
			jQuery.ajax({
        		url:"http://guangzhou.wap.wxcs.cn/bcp-server/ajax/checkIsRightEmail.do?jsoncallback=?",
        		type:"post",
        		data:{email:account},
        		async: false,/*async:false 同步请求*/
        		dataType:"json",
        		success:function (data){ 
        			if(data.status == "0"){/*正确的邮箱地址*/
        				//emlFlag = false;
						if(imgCode == null || imgCode =="" || imgCode == undefined ||imgCode=="验证码" ){
            				jQuery("#msgshow2").html("请输入验证码");
            				jQuery("#msgshow2").show();
            				return;
            			}
            			jQuery.getJSON("http://guangzhou.wap.wxcs.cn/bcp-server/ajax/requestForwardByEmail.do?jsoncallback=?",{emailId:account,imageCode:imgCode,resName:resName,URL:URL,resCode:resCode,areaCode:''},function(data){
            				var status = data.status;
            				if(status == '0'){
            					jQuery("#forward_tip").hide();
            					showTipByshare(data.detail,"邮箱推荐");
            				}else{
            					jQuery("#msgshow2").html(data.detail);
            					jQuery("#msgshow2").show();
            				}
							getCode();
            			});/*end getJson*/
        			} else {
        				//emlFlag = true;
						jQuery("#msgshow2").html("邮箱格式有误，请重新输入");
        				jQuery("#msgshow2").show();
						getCode();
        				return;
        			}
        		}
        	});
		}/*end if*/
	}
	
	function showMobdiv(){
		jQuery("#phoneId").val("");
		jQuery("#imageCode1").val("");
		jQuery("#msgshow1").hide();
		getCode();
		jQuery.getJSON("http://guangzhou.wap.wxcs.cn/bcp-server/ajax/requestCheckLoginStatus.do?jsoncallback=?",{areaCode:''},function(data){
		var status = data.status;
	       if(status == "0"){
	       		jQuery("#msgshowChange").hide();
        		jQuery("#recom_mob").show();
        		jQuery("#recom_eml").hide();
        		jQuery(".a_forfriend").css("color","#425B9D");
        		jQuery(".a_formail").css("color","#666");
	       } else {
		      jQuery("#forward_tip").hide();
			  jQuery("#msgshowChange").show();
			  jQuery("#recom_eml").hide();
			  jQuery("#recom_mob").hide();
	          jQuery("#shareResult").html(data.detail);
	          jQuery("#share_title").html('分享');
	          jQuery("#share_tip").show();
	         calc(2);
	      }
		});
	}
	function showEmadiv(){
		jQuery("#shareID").hide();
        jQuery("#msgshow2").hide().html("");
        jQuery("#emailId").val("");
    	jQuery("#imageCode2").val("");
		getCode();
		jQuery.getJSON("http://guangzhou.wap.wxcs.cn/bcp-server/ajax/requestCheckLoginStatus.do?jsoncallback=?",{areaCode:''},function(data){
		var status = data.status;
	       if(status == "0"){
		        jQuery("#msgshowChange").hide();
        		jQuery("#recom_mob").hide();
        		jQuery("#recom_eml").show();
        		jQuery(".a_forfriend").css("color","#666");
        		jQuery(".a_formail").css("color","#425B9D");
			} else {
			  jQuery("#forward_tip").hide();
			  jQuery("#msgshowChange").show();
			  jQuery("#recom_eml").hide();
			  jQuery("#recom_mob").hide();
	          jQuery("#shareResult").html(data.detail);
	          jQuery("#share_title").html('分享');
	          jQuery("#share_tip").show();
	         calc(2);
	      }
		});
	}
	function showTipByshare(param,title){
	   		jQuery(".pop_bg,#share_tip").show();
		    jQuery("#shareResult").html(param);
		    jQuery("#share_title").html(title);
	   }
	   
	function isNotBlank(param){
	   	if(param == null || param =="" || param == undefined ){
	   	 	return false;
	   	}else{
	   	 	return true;
	   	}
	   }
	   
	function isBlank(param){
	   return !isNotBlank(param);
	}
	    /*移动手机号段*/
	var mobFlag = true;
	function isNotMobile(param){
		jQuery.ajax({
			url:"http://guangzhou.wap.wxcs.cn/bcp-server/ajax/checkIsChinaMobile.do?jsoncallback=?",
			type:"post",
			data:{mobileNum:param},
			async: false,/*async:false 同步请求*/
			dataType:"json",
			success:function (data){
				if(data.status == "0"){/*是移动手机号码*/
					mobFlag = false;
				} else {
					mobFlag = true;
				}
			}
		});/*end ajax*/ 
		return mobFlag;
	} 
	function isEmail(param){
	   	if(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/.test(param)){
	   		return true;
	   	}else{
	   		return false;
	   	}
	}
	
	var emlFlag = true;
	function isNotEmail(param){
		jQuery.ajax({
			url:"http://guangzhou.wap.wxcs.cn/bcp-server/ajax/checkIsRightEmail.do?jsoncallback=?",
			type:"post",
			data:{email:param},
			async: false,/*async:false 同步请求*/
			dataType:"json",
			success:function (data){ 
				if(data.status == "0"){/*正确的邮箱地址*/
					emlFlag = false;
				} else {
					emlFlag = true;
				}
			}
		});
		return emlFlag;
		
	}
	
	/*登陆*/
       function toLogin()
       {
			var url = document.location.href;
			location.href="https://ac.wxcs.cn/m/login?backURL="+encodeURIComponent(url)+"&areaName=zhengzhou&jumpType=1";
       }
	   /*注册*/
	   function toRegister()
       {
			var url = document.location.href;
			location.href="https://ac.wxcs.cn/m/register?backURL="+encodeURIComponent(url)+"&areaName=zhengzhou&jumpType=1";
       }
