package com.jfinalshop.controller.weixin;

import com.alibaba.fastjson.JSONArray;
import com.jfinal.ext.route.ControllerBind;
import com.jfinalshop.model.Packet;


/**
 * Created by dextrys on 2016/1/8.
 */
@ControllerBind(controllerKey = "/weixin/packet")
public class PacketController extends BaseWeixinController<Packet> {

    public void detail() {


        Packet product = Packet.dao.findById(getPara("id"));
        setAttr("packet", product);
        render("/mall/packet/index.html");
    }


    public void getPacketImageText() {
        Packet product = Packet.dao.findById(getPara("id"));
        renderJson(product);
    }

    public void getProductParam() {
        JSONArray packets = Packet.dao.getPacketProdParam(getPara("id"));
        renderJson(packets);
    }

}
