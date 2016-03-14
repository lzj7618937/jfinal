package com.jfinalshop.controller.weixin;

import com.jfinal.ext.route.ControllerBind;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.weixin.sdk.api.ApiResult;
import com.jfinalshop.model.CartItem;
import com.jfinalshop.model.Packet;
import com.jfinalshop.model.PacketProductMap;
import com.jfinalshop.util.CommonUtil;

import java.util.Date;
import java.util.List;

/**
 * Created by Jack.Zhou on 2/2/2016.
 */
@ControllerBind(controllerKey = "/weixin/cart")
public class CartController extends BaseWeixinController<CartItem> {

    public void add() {
        ApiResult user = getSessionAttr("userInfo");
        if (user == null) {
            ajaxJsonErrorMessage("用户未登录");
            return;
        }
        String packetId = getPara("packetId");
        int quantity = getParaToInt("quantity", 1);
        try {
            List<PacketProductMap> items = PacketProductMap.dao.getProductsByPacketId(packetId);
            for (PacketProductMap packetProductMap : items) {
                CartItem cartItem = new CartItem();
                cartItem.set("member_id", user.get("openid"));
                cartItem.set("packet_id", packetId);
                cartItem.set("product_id", packetProductMap.get("product_id"));
                cartItem.set("quantity", packetProductMap.getInt("num") * quantity);
                cartItem.set("id", CommonUtil.getUUID());
                cartItem.set("createDate", new Date());
                cartItem.save();
            }
        } catch (Exception e) {
            ajaxJsonErrorMessage("error:" + e.getMessage());
            return;
        }
        ajaxJsonSuccessMessage("商品添加成功");
    }

    public void list() {
        ApiResult user = getSessionAttr("userInfo");
        if (user == null) {
            ajaxJsonErrorMessage("用户未登录");
            return;
        }
        String openid = user.get("openid");
        Page<Packet> cartPackets = null;
        try {
            cartPackets = CartItem.dao.findByMemberId(openid, getParaToInt("pageNumber", 1), getParaToInt("pageSize", 10));
            setAttr("cartPackets", cartPackets);
        } catch (Exception e) {
            ajaxJsonErrorMessage("error:" + e.getMessage());
        }
        renderJson(cartPackets);
    }

    protected Page<Packet> findAllAvailable(Integer pageNumber, Integer pageSize) {
        ApiResult user = getSessionAttr("userInfo");
        if (user == null) {
            throw new RuntimeException("用户未登录");
        }
        String openid = user.get("openid");
        return CartItem.dao.findByMemberId(openid, pageNumber, pageSize);
    }
}
