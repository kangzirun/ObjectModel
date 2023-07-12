<?php

namespace app\admin\controller;

use app\common\controller\Backend;
use think\config\driver\Json;
use think\Db;

/**
 * 
 *
 * @icon fa fa-circle-o
 */
class Ceshi2 extends Backend
{

    /**
     * Ceshi2模型对象
     * @var \app\admin\model\Ceshi2
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\Ceshi2;
        $this->view->assign("statusList", $this->model->getStatusList());
    }



    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个基础方法、destroy/restore/recyclebin三个回收站方法
     * 因此在当前控制器中可不用编写增删改查的代码,除非需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */
    public function search()
    {
        // echo 'eqeq';
        // $name=input('name');
        $a='港';
        $place='%'.$a.'%';
        $results = Db::name('community')->where('name', 'like', $place)->find();
        echo $results['price'];
        // var_dump($results);
        // print($results[1]);

    }
    public function getAll(){
        $results = Db::name('news')->select();

        foreach ($results as &$result) {
            $categroy_id = $result['categroy_id'];
            $categroy_name = Db::name('newscategroy')->where('categroy_id', $categroy_id)->value('name');
            $result['categroy_name'] = $categroy_name;
        }
        $json = json_encode($results);
        var_dump($json);

    }

    public function hello(){
        // $name=input('name');
        $name=1;
        echo $name;
    }
    public function test(){
        $id=input('id');
        echo $id;
        var_dump($id);
    }
}
