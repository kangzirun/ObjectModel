<?php

namespace app\admin\model;

use think\Model;
use think\Db;


class Eventlog extends Model
{

    
    // 表名
    protected $name = 'eventlog';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = false;
    protected $deleteTime = false;

    // 追加属性
    protected $append = [

    ];

    public function getTypesList()
    {
        return ['online' => __('设备上线'), 'offline' => __('设备离线'), 
        'property' => __('属性上报'), 'function' => __('功能上报'), 'event' => __('事件上报')];
    }

    public function getTypeAttr($value)
    {
        $type = ['online'=>'设备上线','offline'=>'设备离线','property'=>'属性上报','function'=>'功能上报','event'=>'事件上报'];
        return $type[$value];
    }

    public function insertPayload($data){
        Db::name('eventlog')->insert($data);
    }

    

    







}
