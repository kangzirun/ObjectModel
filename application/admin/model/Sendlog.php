<?php

namespace app\admin\model;

use think\Model;


class Sendlog extends Model
{

    

    

    // 表名
    protected $name = 'sendlog';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = false;
    protected $deleteTime = false;

    // 追加属性
    protected $append = [

    ];

    public function getTypeAttr($value)
    {
        $type = ['property'=>'属性获取','function'=>'服务下发','ota'=>'OTA升级'];
        return $type[$value];
    }
    

    







}
