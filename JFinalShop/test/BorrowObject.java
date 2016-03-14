import redis.clients.jedis.ShardedJedis;
import redis.clients.jedis.ShardedJedisPool;

/**
 * Created by tracy on 2016/3/1.
 * Copyright (c) 2016, mr.lizhengjie@gmail.com All Rights Reserved.
 * <p/>
 * *                #                                                   #
 * #                       _oo0oo_                     #
 * #                      o8888888o                    #
 * #                      88" . "88                    #
 * #                      (| -_- |)                    #
 * #                      0\  =  /0                    #
 * #                    ___/`---'\___                  #
 * #                  .' \\|     |# '.                 #
 * #                 / \\|||  :  |||# \                #
 * #                / _||||| -:- |||||- \              #
 * #               |   | \\\  -  #/ |   |              #
 * #               | \_|  ''\---/''  |_/ |             #
 * #               \  .-\__  '-'  ___/-. /             #
 * #             ___'. .'  /--.--\  `. .'___           #
 * #          ."" '<  `.___\_<|>_/___.' >' "".         #
 * #         | | :  `- \`.;`\ _ /`;.`/ - ` : | |       #
 * #         \  \ `_.   \_ __\ /__ _/   .-` /  /       #
 * #     =====`-.____`.___ \_____/___.-`___.-'=====    #
 * #                       `=---='                     #
 * #     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   #
 * #                                                   #
 * #               佛祖保佑         永无BUG            #
 * #                          佛曰:                    #
 * #             写字楼里写字间，写字间里程序员；      #
 * #             程序人员写程序，又拿程序换酒钱。      #
 * #             酒醒只在网上坐，酒醉还来网下眠；      #
 * #             酒醉酒醒日复日，网上网下年复年。      #
 * #             但愿老死电脑间，不愿鞠躬老板前；      #
 * #             奔驰宝马贵者趣，公交自行程序员。      #
 * #             别人笑我忒疯癫，我笑自己命太贱；      #
 * #             不见满街漂亮妹，哪个归得程序员？      #
 */
public class BorrowObject implements Runnable {
    private ShardedJedisPool jedisPool;

    public BorrowObject(ShardedJedisPool jedisPool) {
        this.jedisPool = jedisPool;
    }

    @Override
    public void run() {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = jedisPool.getResource();
            String value = shardedJedis.hget("LONG_KEY_TEST:AA059E03E0AB7D806E6C351F87404B06C1190", "Roc El Pinar Aparthotel");
            System.out.println(value);
        } catch (Exception e) {
            //logger.error(e);
            e.printStackTrace();
        } finally {
            jedisPool.returnResource(shardedJedis);
        }
    }
}
