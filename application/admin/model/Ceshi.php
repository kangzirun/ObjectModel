<?php

namespace app\admin\model;

use think\Model;


class Ceshi extends Model
{

    

    

    // 表名
    protected $name = 'ceshi';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = false;

    // 定义时间戳字段名
    protected $createTime = false;
    protected $updateTime = false;
    protected $deleteTime = false;

    // 追加属性
    protected $append = [
        'testenum_text',
        'testset_text'
    ];
    

    
    public function getTestenumList()
    {
        return ['0' => __('Testenum 0'), '1' => __('Testenum 1'), '2' => __('Testenum 2')];
    }

    public function getTestsetList()
    {
        return ['0' => __('Testset 0'), '1' => __('Testset 1'), '2' => __('Testset 2'), '3' => __('Testset 3')];
    }


    public function getTestenumTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['testenum']) ? $data['testenum'] : '');
        $list = $this->getTestenumList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getTestsetTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['testset']) ? $data['testset'] : '');
        $valueArr = explode(',', $value);
        $list = $this->getTestsetList();
        return implode(',', array_intersect_key($list, array_flip($valueArr)));
    }

    protected function setTestsetAttr($value)
    {
        return is_array($value) ? implode(',', $value) : $value;
    }




}
