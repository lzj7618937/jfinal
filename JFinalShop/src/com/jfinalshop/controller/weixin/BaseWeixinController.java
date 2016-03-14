package com.jfinalshop.controller.weixin;

import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.kit.PropKit;
import com.jfinal.kit.StrKit;
import com.jfinal.log.Log;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.upload.UploadFile;
import com.jfinal.weixin.sdk.api.ApiConfig;
import com.jfinal.weixin.sdk.jfinal.ApiController;
import com.jfinalshop.bean.SystemConfig;
import com.jfinalshop.interceptor.WeixinInterceptor;
import com.jfinalshop.util.SystemConfigUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 后台类 - 管理中心基类
 * 继承此类的子类具备基本的CRUD
 */
@Before(WeixinInterceptor.class)
public class BaseWeixinController<M extends Model<M>> extends ApiController {

    private static final Log log = Log.getLog(BaseWeixinController.class);
    public static final String STATUS = "status";
    public static final String WARN = "warn";
    public static final String SUCCESS = "success";
    public static final String ERROR = "error";
    public static final String MESSAGE = "message";
    public static final String CONTENT = "content";

    @Override
    /**
     * 如果要支持多公众账号，只需要在此返回各个公众号对应的  ApiConfig 对象即可
     * 可以通过在请求 url 中挂参数来动态从数据库中获取 ApiConfig 属性值
     */
    public ApiConfig getApiConfig() {
        ApiConfig ac = new ApiConfig();

        // 配置微信 API 相关常量
        ac.setToken(PropKit.get("token"));
        ac.setAppId(PropKit.get("appId"));
        ac.setAppSecret(PropKit.get("appSecret"));

        /**
         *  是否对消息进行加密，对应于微信平台的消息加解密方式：
         *  1：true进行加密且必须配置 encodingAesKey
         *  2：false采用明文模式，同时也支持混合模式
         */
        ac.setEncryptMessage(PropKit.getBoolean("encryptMessage", false));
        ac.setEncodingAesKey(PropKit.get("encodingAesKey", "setting it in config file"));
        return ac;
    }

    public static enum FileType {
        IMAGE("文件"),
        MEDIA("视频"),
        OTHER("");
        public String name;

        FileType(String name) {
            this.name = name;
        }
    }

    protected String id;
    protected String[] ids;
    protected String redirectionUrl = "redirectionUrl";// 操作提示后的跳转URL,为null则返回前一页
    protected UploadFile uploadFile;

    // 排序方式
    public enum OrderType {
        asc, desc
    }

    private String property;// 查找属性名称
    private String keyword;// 查找关键字
    private String orderBy;// 排序字段
    private String orderType;// 排序方式


    // 获取系统配置信息
    public SystemConfig getSystemConfig() {
        return SystemConfigUtil.getSystemConfig();
    }

    public void renderSuccessMessage(String message, String url) {
        setAttr(MESSAGE, message);
        setAttr(redirectionUrl, getRequest().getContextPath() + url);
        render("/mall/success.html");
    }

    @Clear
    public void renderErrorMessage(String message) {
        setAttr("errorMessages", message);
        setAttr("systemConfig", SystemConfigUtil.getSystemConfig());
        render("/mall/error.html");
    }

    // 输出JSON成功消息，返回null
    public void ajaxJsonSuccessMessage(String message) {
        setAttr(STATUS, SUCCESS);
        setAttr(MESSAGE, message);
        renderJson();
    }

    // 输出JSON错误消息，返回null
    public void ajaxJsonErrorMessage(String message) {
        setAttr(STATUS, ERROR);
        setAttr(MESSAGE, message);
        renderJson();
    }

    // 输出JSON警告消息，返回null
    public void ajaxJsonWarnMessage(String message) {
        Map<String, String> jsonMap = new HashMap<String, String>();
        jsonMap.put(STATUS, WARN);
        jsonMap.put(MESSAGE, message);
        renderJson(jsonMap);
    }

    public void addActionError(String error) {
        setAttr("errorMessages", error);
        render("/mall/error.html");
    }

    /**
     * 根据表名、属性名称、属性值判断在数据库中是否唯一(若新修改的值与原来值相等则直接返回true).
     *
     * @param tableName    表名
     * @param propertyName 属性名称
     * @param value        属性值
     * @return boolean
     */
    public boolean isUnique(String tableName, String propertyName, String value) {
        if (StrKit.notBlank(tableName) && StrKit.notBlank(propertyName) && StrKit.notBlank(value)) {
            String sql = "select * from " + tableName + " where " + propertyName + " = ? ";
            return Db.findFirst(sql, value) == null;
        } else {
            return false;
        }
    }


    public String getProperty() {
        property = getPara("property", "");
        return property;
    }

    public String getKeyword() {
        keyword = getPara("keyword", "");
        return keyword;
    }

    public String getOrderBy() {
        orderBy = getPara("orderBy", "createDate");
        return orderBy;
    }

    public String getOrderType() {
        orderType = getPara("orderType", OrderType.desc.name());
        return orderType;
    }

    public void listAvailable() {
        Integer lastIndex = getParaToInt("lastIndex", 0);
        Integer pageSize = getParaToInt("pageSize", 10);
        Integer pageNumber = 1 + lastIndex / pageSize + (lastIndex % pageSize == 0 ? 0 : 1);
        try {
            Page<?> pager = findAllAvailable(pageNumber, pageSize);
            if (pager == null) {
                ajaxJsonErrorMessage("此方法未实行分页查询:" + this.getClass());
                return;
            } else if (pager.getList().size() > 0) {
                List<?> list = pager.getList();
                List<?> addList = list.subList(lastIndex % pageSize, list.size());
                pager = new Page(addList, pageNumber, pageSize, pager.getTotalPage(), pager.getTotalRow());
            }
            renderJson(pager);
        } catch (Exception e) {
            log.error("分页查询失败", e);
            ajaxJsonErrorMessage("error:" + e.getMessage());
        }
    }

    protected Page<?> findAllAvailable(Integer pageNumber, Integer pageSize) {
        return null;
    }

}
