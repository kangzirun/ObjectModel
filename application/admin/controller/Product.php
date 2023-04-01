<?php

namespace app\admin\controller;

use app\common\controller\Backend;

use think\Log;
use think\Db;
use Exception;
use think\exception\PDOException;
use think\exception\ValidateException;
/**
 * 
 *
 * @icon fa fa-circle-o
 */
class Product extends Backend
{

    /**
     * Product模型对象
     * @var \app\admin\model\Product
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\Product;

    }


        /**
     * 添加
     *
     * @return string
     * @throws \think\Exception
     */
    public function add()
    {
        if (false === $this->request->isPost()) {
            return $this->view->fetch();
        }
        $params = $this->request->post('row/a');
        if (empty($params)) {
            $this->error(__('Parameter %s can not be empty', ''));
        }
        $params = $this->preExcludeFields($params);

        if ($this->dataLimit && $this->dataLimitFieldAutoFill) {
            $params[$this->dataLimitField] = $this->auth->id;
        }
        $result = false;
        
        Db::startTrans();
        try {
            //是否采用模型验证
            if ($this->modelValidate) {
                $name = str_replace("\\model\\", "\\validate\\", get_class($this->model));
                $validate = is_bool($this->modelValidate) ? ($this->modelSceneValidate ? $name . '.add' : $name) : $this->modelValidate;
                $this->model->validateFailException()->validate($validate);
            }
            //生成随机数
            $length = 20;
            $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
            $mqttaccount = '';
            $mqttpwd = '';
            for ($i = 0; $i < $length; $i++) {
                $randomIndex1 = rand(0, strlen($characters) - 1);
                $randomIndex2 = rand(0, strlen($characters) - 1);
                $mqttaccount .= $characters[$randomIndex1];
                $mqttpwd .= $characters[$randomIndex2];
            }
            $params=[
                'name'=>$params['name'],
                'category_id'=>$params['category_id'],
                'devicetype'=>$params['devicetype'],
                'network'=>$params['network'],
                'content'=>$params['content'],
                'image'=>$params['image'],
                'switch'=>$params['switch'],
                'authentication'=>$params['authentication'],
                'mqttaccount'=>$mqttaccount,
                'mqttpwd'=>$mqttpwd,
            ];

            $result = $this->model->allowField(true)->save($params);
            Db::commit();
        } catch (ValidateException|PDOException|Exception $e) {
            Db::rollback();
            $this->error($e->getMessage());
        }
        if ($result === false) {
            $this->error(__('No rows were inserted'));
        }
        $this->success();
    }
    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个基础方法、destroy/restore/recyclebin三个回收站方法
     * 因此在当前控制器中可不用编写增删改查的代码,除非需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */


}
