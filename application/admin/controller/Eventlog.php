<?php

namespace app\admin\controller;

use app\admin\model\Device;
use app\admin\model\Productmodel;
use app\common\controller\Backend;
use think\Log;

/**
 * 
 *
 * @icon fa fa-circle-o
 */
class Eventlog extends Backend
{

    /**
     * Eventlog模型对象
     * @var \app\admin\model\Eventlog
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\Eventlog;
        // $this->view->assign("typeList", $this->model->getTypesList());

    }

    /**
     * 查看
     *
     * @return string|Json
     * @throws \think\Exception
     * @throws DbException
     */
    public function index()
    {

        //设置过滤方法
        $this->request->filter(['strip_tags', 'trim']);
        if (false === $this->request->isAjax()) {
            return $this->view->fetch();
        }
        //如果发送的来源是 Selectpage，则转发到 Selectpage
        if ($this->request->request('keyField')) {
            return $this->selectpage();
        }
        [$where, $sort, $order, $offset, $limit] = $this->buildparams();
        $list = $this->model
            ->where($where)
            ->order($sort, $order)
            ->paginate($limit);
        $result = ['total' => $list->total(), 'rows' => $list->items()];
        return json($result);
    }


    //向设备进行实时属性数据监测
    public function monitor()
    {
        $deviceId = input('deviceid');
        $deviceModel = new Device();
        $result = $deviceModel->getPropertyModelByDid($deviceId);
        Log::write('result::' . json_encode($result));
        $arrayContainer  = [];
        foreach ($result as $items) {
            $data = $items['definition'];
            $name = $items['name'];
            $identifier = $items['identifier'];
            $unit = json_decode($data, true)['unit'];
            Log::write($name);
            Log::write($unit);

            $arrayData = [
                'title' => $name,
                'unit' => $unit,
                'identifier' => $identifier,
                'attributeNames' => [],
                'attributeValues' => []
            ];
            $arrayContainer[] = $arrayData;
        }
        Log::write($arrayContainer);
        $this->view->assign('deviceId',$deviceId);
        $this->view->assign('attributeDataArray', json_encode($arrayContainer));

        return $this->view->fetch();
    }

    //实时从事件日志中抓取数据
    public function recv()
    {
        $currentTimestamp = input('currentTimestamp');
        $deviceId=input('deviceId');
        Log::write($currentTimestamp);
        $result = $this->model->selectByTime($currentTimestamp,$deviceId);
        $arraydata = [];
        $productModel=new Productmodel();
        foreach ($result as $items) {
            $name = trim(explode(':', $items['action'])[0]);
            $unit = $productModel->getUnitById($items['identifier']);
                $data = [
                    'identifier' => $items['identifier'],
                    'createtime' => $items['createtime'],
                    'value' => json_decode($items['data'], true)['value'],
                    'title' => $name,
                    'unit' => $unit
                ];
            $arraydata[] = $data;
        }
        Log::write($arraydata);
        return json($arraydata);
    }

    //向设备进行属性监测数据统计
    






    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个基础方法、destroy/restore/recyclebin三个回收站方法
     * 因此在当前控制器中可不用编写增删改查的代码,除非需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */
}
