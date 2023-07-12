<?php

namespace app\admin\model;

use think\Model;


class Product extends Model
{

    

    

    // 表名
    protected $name = 'product';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = false;

    // 定义时间戳字段名
    protected $createTime = false;
    protected $updateTime = false;
    protected $deleteTime = false;

    // 追加属性
    protected $append = [

    ];


    /**
     * 关联产品类型表
     * @return \think\model\relation\BelongsToMany
     */
    public function productcategory()
    {
        return $this->belongsTo('\app\admin\model\Productcategory', 'category_id','id');
    }
    

    







}
