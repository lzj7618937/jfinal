package com.jfinalshop.controller.weixin;

import com.jfinal.aop.Before;
import com.jfinal.ext.route.ControllerBind;
import com.jfinalshop.interceptor.WeixinUserInfoInterceptor;

/**
 * Created by jack on 2015/12/26.
 * 首页
 */
@ControllerBind(controllerKey = "/weixin/basket")
public class MallBasketController extends BaseWeixinController {
    @Before(WeixinUserInfoInterceptor.class)
    public void index() {
        render("/mall/page-cart.html");
    }
}
