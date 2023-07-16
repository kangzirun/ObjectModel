<?php

namespace app\admin\model;

use think\Model;
use think\Db;

class Productmodel extends Model
{


    // 表名
    protected $name = 'productmodel';
    
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

    public function getTagAttr($value)
    {
        $datatype = ['properties'=>'属性','functions'=>'功能','events'=>'事件'];
        return $datatype[$value];
    }

    public function getModelNameList(){
        return Db::name('objectmodel')->field('id,name')->select();
    }
    public function getArrayType(){
        return ['integer' => '整数', 'decimal' => '小数', 'string' => '字符串','object'=>'对象'];
    }

    //根据设备id找此产品的物模型，并且通过标识符返回物模型名称
    public function getNameByIdentifier($product_id,$identifier){
        $result=Db::name('productmodel')->where('productid',$product_id)->where('identifier',$identifier)->value('name');
        return $result;
    }

    //根据identifier查询单位
    public function getUnitById($identifier){
        $definition = Db::name('productmodel')->where('identifier',$identifier)->where('tag','properties')->value('definition');
        return json_decode($definition, true)['unit'];

    }


    







}
