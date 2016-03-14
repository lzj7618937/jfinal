/**
 * 存放对 msui 的 config，需在 zepto 之后 msui 之前加载
 *
 * Created by bd on 15/12/21.
 */
//参数配置区域
$.config = {
    pageSize: 10,
    maxItems: 100,
    loadInterval: 1000
};

//公共方法区域
$.mall = {
    //创建单个卡片
    createCard: function(header, imageHtml, footer, url) {
        return '<div class="card">' +
        '<div class="card-header">' + header + '</div>' +
        '<div class="card-content">' +
        '<a href="' + url + '" external>' +
        '<div class="card-content-inner">' + imageHtml + '</div>' +
        '</a>' +
        '</div>' +
        '<div class="card-footer">' + footer + '</div>' +
        '</div>';
    },
    addCart: function(e, id, page) {
        page.find("#nav-page-addCart").on("click", function(e) {
            //从服务端获取列表
            $.getJSON(getCtxPath() + '/weixin/cart/add?packetId=' + $('#packet-id').val() + '&quantity=' + 1, function(data) {
                console.log(data);
                if (data.status === 'error') {
                    $.toast('添加购物车失败:' + data.message, 2000);
                } else {
                    $.toast('添加购物车成功', 2000);
                }
            });
        });
    },
    image:function(url,type) {
    	var qiniuUrl=getImgPath();
		if(url.match(qiniuUrl)){
			return url + '-' + type;
		}
	}
};

//默认执行区域
$(function() {
    'use strict';
    $(document).on("pageInit", function() {
        var currentId = $('.page.page-current')[0].id;
        var navId = '.page.page-current #nav-' + currentId;
        $(navId).addClass('active');
    });
});
