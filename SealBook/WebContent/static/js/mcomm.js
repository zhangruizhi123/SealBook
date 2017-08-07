// JavaScript Document
(function($){
	$.fn.imageShow=function(){
		return this.hover(function(e){
			var $body=$("body");
			//开始
			var src=$(this).attr("src");
			var top=$(this).offset().top;
			var right=$(this).offset().left+$(this).width()+20;
			var $div=$(' <div class="m_img_tool"></div>');
			$div.css({left:right+'px',top:top+'px'});
			var $img=$('<img src="'+src+'" style="width:400px"/>');
			$div.append($img);
			$body.append($div);
			},function(){
				//移除对象
				$(".m_img_tool").remove();
			});
	}
})(jQuery);