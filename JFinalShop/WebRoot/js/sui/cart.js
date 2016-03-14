$(function() {
    'use strict';

	//新增商品包
    var appendPacketItem = function(data, targetObj) {
        // 生成新条目的HTML
        var html = '';
        for (var i = 0; i < data.list.length; i++) {
            var header = data.list[i].name;
            var imageHtml = '<img src="' + $.mall.image(getImgPath() +  data.list[i].img,'s')  + '" width="100%">';
            var footer = '总价：' + data.list[i].price + '*' + data.list[i].quantity + '=' + data.list[i].price * data.list[i].quantity;
            var url = getCtxPath() + "/weixin/packet/detail?id=" + data.list[i].id;
            html += $.mall.createCard(header, imageHtml, footer, url);
        }
        // 添加新条目
        targetObj.append(html);
    }

    var addPacketItems = function(pageSize, lastIndex) {
        //从服务端获取列表
        $.getJSON(getCtxPath() + '/weixin/cart/listAvailable?pageSize=' + pageSize + '&lastIndex=' + lastIndex, function(data) {
            console.log(data);
            if (data.status === 'error') {
                $.toast('获取数据失败:' + data.message, 2000);
            }
            appendPacketItem(data, $('#page-cart .list-container'));
        });
    }

    //无限滚动，购物车加载
    $(document).on("pageInit", "#page-cart", function(e, id, page) {
        var loading = false;
        // 每次加载添加多少条目
		var pageSize = $.config.pageSize;
		// 最多可加载的条目
		var maxItems = $.config.maxItems;
        var lastIndex = page.find('.list-container .card').length;
        addPacketItems(pageSize, 0);
        page.on('infinite', function() {
            // 如果正在加载，则退出
            if (loading)
                return;
            // 设置flag
            loading = true;
            // 模拟1s的加载过程
            setTimeout(function() {
                // 重置加载flag
                loading = false;
                if (lastIndex >= maxItems) {
                    // 加载完毕，则注销无限加载事件，以防不必要的加载
                    $.detachInfiniteScroll($('.infinite-scroll'));
                    // 删除加载提示符
                    page.find('.infinite-scroll-preloader').remove();
                    return;
                }
                var currentId = $('.tab.active')[0].id;
                // 更新最后加载的序号
                lastIndex = page.find('.list-container .card').length;
                addPacketItems(pageSize, lastIndex);
                $.refreshScroller();
            }, $.config.loadInterval);
        });
    });

    $.init();

});
