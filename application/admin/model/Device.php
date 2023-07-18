<?php

namespace app\admin\model;

use think\Model;

use think\Db;
use think\Log;


class Device extends Model
{

    public function getStatusList()
    {
        return ['0' => __('离线'), '1' => __('在线')];
    }

    // 表名
    protected $name = 'device';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = false;
    protected $deleteTime = false;

    // 追加属性
    protected $append = [];

    /**
     * 关联产品类型表
     * @return \think\model\relation\BelongsToMany
     */
    public function product()
    {
        return $this->belongsTo('\app\admin\model\Product', 'product_id', 'id');
    }

    public function getDeviceByDid($deviceId)
    {
        return Db::name('device')->where('deviceid', $deviceId)->find();
    }


    //根据设备id获取产品id
    public function getPidByDid($deviceId)
    {
        return Db::name('device')->where('deviceid', $deviceId)->value('product_id');
    }

    //根据设备id获取产品id，根据产品id获得类别为function的物模型
    public function getFunctionModelByDid($deviceId)
    {

        $product_id = Db::name('device')->where('deviceid', $deviceId)->value('product_id');
        return Db::name('productmodel')->where('productid', $product_id)->where('tag', 'functions')->select();
    }

    //根据设备id获取产品id，根据产品id获得类别为property的物模型
    public function getPropertyModelByDid($deviceId)
    {

        $product_id = Db::name('device')->where('deviceid', $deviceId)->value('product_id');
        return Db::name('productmodel')->where('productid', $product_id)->where('tag', 'properties')->select();
    }

    //根据禁用设备按钮修改设备状态
    public function updateStatus($ids)
    {
        $deviceswitch = Db::name('device')->where('id', $ids)->value('deviceswitch');
        Log::write($deviceswitch);
        Db::name('device')->where('id', $ids)->update(['status' => $deviceswitch == 1 ? 2 : 0]);
    }
}
