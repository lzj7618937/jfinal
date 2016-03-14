package com.jfinalshop.interceptor;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.kit.StrKit;
import com.jfinal.weixin.sdk.api.ApiResult;
import com.jfinalshop.model.Footer;
import com.jfinalshop.model.FriendLink;
import com.jfinalshop.model.Member;
import com.jfinalshop.model.Navigation;
import com.jfinalshop.util.SystemConfigUtil;

public class WeixinInterceptor implements Interceptor {

    @Override
    public void intercept(Invocation ai) {
        Controller c = ai.getController();
        c.setAttr("systemConfig", SystemConfigUtil.getSystemConfig());
        c.setAttr("imgPath", PropKit.get("qiniu.url"));
        c.setAttr("userInfo", c.getSession().getAttribute("userInfo"));
        ai.invoke();
    }

}
