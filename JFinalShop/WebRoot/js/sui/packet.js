$(function() {
    'use strict';

    var loadProductDetail = function(packet_id) {
        $.getJSON(getCtxPath() + '/weixin/packet/getPacketImageText?id=' + packet_id, function(data) {
            console.log('loadProductDetail');
            console.log(data);
            if (data.status === 'error') {
                $.toast('获取数据失败:' + data.message, 2000);
            }
            appendProductDetail(data, $('#tabProductDetail .content-block'));
        });
    }

    var appendProductDetail = function(data, targetObj) {
        var html = '';
        html += data['imageText'];
        targetObj.append(html);
    }

    var loadProductParams = function(packet_id) {
        $.getJSON(getCtxPath() + '/weixin/packet/getProductParam?id=' + packet_id, function(data) {
            console.log('loadProductParams');
            console.log(data);
            if (data.status === 'error') {
                $.toast('获取数据失败:' + data.message, 2000);
            }
            appendProductParam(data, $('#tabProductParam .content-block'));
        });
    }

    var appendProductParam = function(data, targetObj) {
        var html = '';
        for (var i = 0; i < data.length; i++) {
            var productName = data[i].prodName;
            html += '<div class="content-block-title">' + productName + '</div>';
            html += '<div class="list-block"><ul>';
            for(var j=0;j<data[i].paramList.length;j++){
                var param = data[i].paramList[j].param;
                var value = data[i].paramList[j].value;
                html += ' <li class="item-content"><div class="item-inner"> <div class="item-title">' + param
                + '</div><div class="item-after">' + value + '</div></div></li>';
            }
            html += '</ul></div>';
        }
        targetObj.append(html);
        $('.tab .infinite-scroll-preloader').remove();
    }

    var loadPacketImage=function(packet_id){
        $.getJSON(getCtxPath() + '/weixin/packet/getPacketImageText?id=' + packet_id, function(data) {


            if (data.status === 'error') {
                $.toast('获取数据失败:' + data.message, 2000);
            }
            appendPacketImage(data, $('#page-packet-main .swiper-wrapper'));
        });
    }

    var appendPacketImage=function(data, targetObj){
        var html = '';
        var imgArray = JSON.parse(data.img);
        for (var i = 0; i < imgArray.length; i++) {
            var imgSrc ='<img src=\"'+ $.mall.image(getImgPath()+ imgArray[i].sourceProductImagePath,'s')+'\" alt=\"\">';
            console.log($.mall.image(getImgPath()+ imgArray[i].sourceProductImagePath,'s'));
            html += ' <div class="swiper-slide photo-browser-slide">';
            html += imgSrc;
            html += '</div>';
        }

        targetObj.append(html);
        $.reinitSwiper('#page-packet-main');
        $('#page-packet-main .infinite-scroll-preloader').remove();
    }


    //无限滚动，切换到详细页面
    $(document).on("pageInit", "#page-packet-main", function(e, id, page) {


        var packet_id = $("#packet-id").val();
        loadPacketImage(packet_id);

        var loading = false;
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
                $.popup("#page-packet-popup");
            }, $.config.loadInterval);
        });
    });

	//加载弹出页面
    $(document).on("open", "#page-packet-popup", function(e) {
    	var target= $(e.target);
    	//设置buttons为固定高度
		var height = target.find('head').height();
		target.find('#fixed-buttons').fixedTab({
			offset: height
		});
        var packet_id = $("#packet-id").val();
        loadProductDetail(packet_id);
        loadProductParams(packet_id);
    });

    $.init();
});
