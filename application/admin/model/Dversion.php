<?php

namespace app\admin\model;

use think\Model;
use think\Db;


class Dversion extends Model
{

    

    

    // 表名
    protected $name = 'dversion';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = false;

    // 定义时间戳字段名
    protected $createTime = false;
    protected $updateTime = false;
    protected $deleteTime = false;

    // 追加属性
    protected $append = [

    ];


    public function getVersion($version,$pid){
        return Db::name('dversion')->order('id desc')->where('pid',$pid)->where('version','>',$version)->find();
    }
    

    







}
