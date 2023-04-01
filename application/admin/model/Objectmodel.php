<?php

namespace app\admin\model;

use think\Model;


class Objectmodel extends Model
{

    

    

    // 表名
    protected $name = 'objectmodel';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = false;
    protected $deleteTime = false;

    // 追加属性
    protected $append = [

    ];
    

    protected static function init()
    {
        self::afterInsert(function ($row) {
            $pk = $row->getPk();
            $row->getQuery()->where($pk, $row[$pk])->update(['weigh' => $row[$pk]]);
        });
    }

    public function getDatatypeAttr($value)
    {
        $datatype = ['integer'=>'整数','bool'=>'布尔','decimal'=>'小数','string'=>'字符串','array'=>'数组','enum'=>'枚举','object'=>'对象'];
        return $datatype[$value];
    }

    







}
