package com.jfinalshop.model;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Lists;
import com.google.gson.JsonArray;
import com.jfinal.aop.Duang;
import com.jfinal.plugin.activerecord.*;
import com.jfinalshop.util.CommonUtil;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by dextrys on 2016/1/12.
 */
public class Packet extends Model<Packet> {

    public static final Packet dao = Duang.duang(new Packet());

    public void save(Packet packet) {
        packet.set("id", CommonUtil.getUUID());
        packet.set("createDate", new Date());
        packet.save();
    }

    public boolean delete(String id) {
        int count = Db.update("update packet set isDelete = 1  where id = ?", id);
        return count >= 0 ? true : false;
    }

    public List<Packet> getSaleShelves() {
        return dao.find("select * from packet where state = 0 or state is null");
    }

    public List<Packet> geOnSaleShelves() {
        return dao.find("select * from packet where state = 1");
    }

    public boolean updateState(String id, String shelfid) {
        int count = Db.update("update packet set shelf_id =?  where id = ?", shelfid, id);
        return count >= 0 ? true : false;
    }

    public boolean updateState(String shelfid) {
        int count = Db.update("update packet set shelf_id = null  where shelf_id = ?", shelfid);
        return count >= 0 ? true : false;
    }

    public Page<Packet> findProductByShelfId(int pageNumber, int pageSize, String shelfId) {
        Page<Packet> pager = dao.paginate(pageNumber, pageSize, "select * ", "from packet where isDelete = 0 and shelf_id=?", shelfId);
        return pager;
    }

    public List<Product> getPacketMapProduct(String packetid) {
        return Product.dao.find("SELECT pt.* from packetproductmap pa LEFT JOIN product pt on pa.product_id = pt.id where pa.packet_id = ?", packetid);
    }


    public JSONArray getPacketProdParam(String packetId) {
        String sql = "SELECT ppdm.id as `productId`,ppdm.productName as `productName`,prodA.`name` as `param`,prodAMap.element as `value` from product_productattributemapstore prodAMap  INNER JOIN packetproductmap ppdm on \n" +
                "ppdm.product_id = prodAMap.product_id  INNER JOIN productattribute prodA on prodA.id = prodAMap.mapkey_id INNER JOIN packet on packet.id = ppdm.packet_id and packet.id = ?  order by productId";
        List<Record> records = Db.find(sql, packetId);
        JSONArray result = new JSONArray();
        String lastId = "";
        JSONObject item = null;
        JSONArray paramList = null;
        for (Record record : records) {
            String productId = record.getStr("productId");
            String param = record.getStr("param");
            String value = record.getStr("value");
            String productName = record.getStr("productName");
            if (!lastId.equals(productId)) {
                item = new JSONObject();
                result.add(item);
                paramList = new JSONArray();
                item.put("paramList", paramList);
                item.put("productName", productName);
                lastId = productId;
            }
            item.put("productId", productId);
            JSONObject prodParam = new JSONObject();
            prodParam.put(param, value);
            paramList.add(prodParam);
        }
        return result;
    }

}
