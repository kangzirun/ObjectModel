<?php

namespace app\admin\controller;

use app\admin\model\Sendlog;
use app\common\controller\Backend;
use think\Log;
use app\api\Clientbuilder;
use \app\common\service\MQTTService;

/**
 * 
 *
 * @icon fa fa-circle-o
 */
class Send extends Backend
{

    /**
     * Productcategory模型对象
     * @var \app\admin\model\Productcategory
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\Productcategory;
    }


    /**
     * property指令下发
     */
    public function property($deviceId, $pid, $propertyData)
    {
        $mqttService = new MQTTService();
        //topic后缀
        $suffix = '/property/get';

        $message = [];
        foreach ($propertyData as $data) {
            $result = [
                'id' => $data,
                'value' => '',
                'remark' => ''
            ];
            $message[] = $result;
        }

        // $mqttService->send($pid, $deviceId, $message, $suffix);

        //先设默认值，后续做逻辑处理
        $detail = '';
        $sendlogModel = new Sendlog();
        foreach($propertyData as $data){
            $remark = '';
            $result = [
                'identifier' => $data,
                'type' => 'property',
                'value' => '',
                'deviceid' => $deviceId,
                'detail' => $detail,
                'remark' => $remark
            ];       
            $sendlogModel->create($result);
        }

    }

    /**
     * monitor指令下发，实时监测
     */
    public function monitor()
    {
        $mqttService = new MQTTService();

        //topic后缀
        $suffix = '/monitor/get';
        //参数
        $count = $this->request->post('count');
        $interval = $this->request->post('interval');
        $deviceId = $this->request->post('deviceId');
        $pid = $this->request->post('pid');

        $message = [
            'count' => $count,
            'interval' => $interval
        ];

        Log::write('count' . $count);
        Log::write('interval' . $interval);

        // $mqttService->send($pid, $deviceId, $message, $suffix);

        //先设默认值，后续做逻辑处理
        $detail = '';

        $remark = '场景联动触发';
        $result = [
            'identifier' => 'monitor',
            'type' => 'function',
            'value' => '监测间隔:' + $interval + ' ' + '监测次数:' + $count,
            'deviceid' => $deviceId,
            'detail' => $detail,
            'remark' => $remark
        ];
        $sendlogModel = new Sendlog();
        $sendlogModel->create($result);

        return $this->success();
    }

    /**
     * function物模型下发
     */
    public function function()
    {
        $mqttService = new MQTTService();

        //topic后缀
        $suffix = '/function/get';

        $deviceId = $this->request->post('deviceId');
        $value = $this->request->post('value');
        $identifier = $this->request->post('identifier');
        $pid = $this->request->post('pid');
        $remark = '场景联动触发';

        $message = [
            'id' => $identifier,
            'value' => $value,
            'remark' => $remark
        ];

        // $mqttService->send($pid, $deviceId, $message, $suffix);

        Log::write('ID：' . $deviceId);
        Log::write('参数：' . $value);
        Log::write('identifier:' . $identifier);
        Log::write('pid:' . $pid);

        //先设默认值，后续做逻辑处理
        $detail = '';

        $result = [
            'identifier' => $identifier,
            'type' => 'function',
            'value' => $value,
            'deviceid' => $deviceId,
            'detail' => $detail,
            'remark' => $remark
        ];
        $sendlogModel = new Sendlog();
        $sendlogModel->create($result);
    }









    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个基础方法、destroy/restore/recyclebin三个回收站方法
     * 因此在当前控制器中可不用编写增删改查的代码,除非需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */
}
