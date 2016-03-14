$(function() {
    'use strict';

    //新增热销商品
    var appendHotItem = function(data, targetObj) {
        // 生成新条目的HTML
        var html = '';
        for (var i = 0; i < data.list.length; i++) {
            var header = data.list[i].name;
            var images = eval(data.list[i].productImageListStore);
            var imageHtml = '<img src="' + $.mall.image(getImgPath() + images[0].smallProductImagePath,'s') + '" width="100%">';
            var url = getCtxPath() + "/weixin/product/detail?id=" + data.list[i].id;
            var footer = '价格:' + data.list[i].price;
            html += $.mall.createCard(header, imageHtml, footer, url);
        }
        // 添加新条目
        targetObj.append(html);
    }

    //新增货架
    var appendShelfItem = function(data, targetObj) {
        // 生成新条目的HTML
        var html = '';
        for (var i = 0; i < data.list.length; i++) {
            var header = data.list[i].name;
            var imageHtml = '<img src="' + $.mall.image(getImgPath() +  data.list[i].img,'s') + '" width="100%">';
            var footer = '' + data.list[i].description;
            var url = getCtxPath() + "/weixin/shelf/detail?id=" + data.list[i].id;
            html += $.mall.createCard(header, imageHtml, footer, url);
        }
        // 添加新条目
        targetObj.append(html);
    }

    //新增活动
    var appendActivityItem = function(data, targetObj) {
        // 生成新条目的HTML
        var html = '';
        for (var i = 0; i < data.list.length; i++) {
            var header = data.list[i].name;
            var imageHtml = '<img src="' + $.mall.image(getImgPath() + data.list[i].bannerUrl,'s') + '" width="100%">';
            var url = getCtxPath() + "/weixin/activity/detail?id=" + data.list[i].id;
            var footer = '本账户限购：' + data.list[i].buyLimit;
            html += $.mall.createCard(header, imageHtml, footer, url);
        }
        // 添加新条目
        targetObj.append(html);
    }


    var addHotItems = function(pageSize, lastIndex) {
        //从服务端获取列表
        $.getJSON(getCtxPath() + '/weixin/product/listAvailable?pageSize=' + pageSize + '&lastIndex=' + lastIndex, function(data) {
            //console.log(data);
            if (data.status === 'error') {
                $.toast('获取数据失败:' + data.message, 2000);
            }
            appendHotItem(data, $('#tabHot .list-container'));
        });
    }

    var addShelfItems = function(pageSize, lastIndex) {
        //从服务端获取列表
        $.getJSON(getCtxPath() + '/weixin/shelf/listAvailable?pageSize=' + pageSize + '&lastIndex=' + lastIndex, function(data) {
            console.log(data);
            if (data.status === 'error') {
                $.toast('获取数据失败:' + data.message, 2000);
            }
            appendShelfItem(data, $('#tabShelf .list-container'));
        });
    }

    var addActivityItems = function(pageSize, lastIndex) {
        //从服务端获取列表
        $.getJSON(getCtxPath() + '/weixin/activity/listAvailable?pageSize=' + pageSize + '&lastIndex=' + lastIndex, function(data) {
            //console.log(data);
            if (data.status === 'error') {
                $.toast('获取数据失败:' + data.message, 2000);
            }
            appendActivityItem(data, $('#tabActivity .list-container'));
        });
    }


    //无限滚动,首页
    $(document).on("pageInit", "#page-index", function(e, id, page) {
        //设置buttons为固定高度
        var height = page.find('.bar.bar-nav').height();
        page.find('#fixed-buttons').fixedTab({
            offset: height
        });
        var loading = false;
        // 每次加载添加多少条目
        var pageSize = $.config.pageSize;
        // 最多可加载的条目
        var maxItems = $.config.maxItems;
        var lastIndex = page.find('.tab.active .list-container .card').length;

        addHotItems(pageSize, 0);
        addShelfItems(pageSize, 0);
        addActivityItems(pageSize, 0);
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
                    page.find('.tab.active .infinite-scroll-preloader').remove();
                    return;
                }
                var currentId = page.find('.tab.active')[0].id;
                // 更新最后加载的序号
                lastIndex = page.find('.tab.active .list-container .card').length;
                if (currentId === 'tabHot') {
                    addHotItems(pageSize, lastIndex);
                } else if (currentId === 'tabShelf') {
                    addShelfItems(pageSize, lastIndex);
                } else if (currentId === 'tabActivity') {
                    addActivityItems(pageSize, lastIndex);
                }
                $.refreshScroller();
            }, $.config.loadInterval);
        });
    });

    $.init();

});
