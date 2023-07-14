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

    public function integer()
    {
        $mqttService = new MQTTService();

        //topic后缀
        $suffix = '/function/get';
        //参数
        $deviceId = $this->request->post('deviceId');
        $integerValue = $this->request->post('integerValue');
        $identifier = $this->request->post('identifier');
        $pid = $this->request->post('pid');
        $remark = '场景联动触发';
        $message = [
            'id' => $identifier,
            'value' => $integerValue,
            'remark' => $remark
        ];

        Log::write('ID：' . $deviceId);
        Log::write('参数：' . $integerValue);
        Log::write('identifier:' . $identifier);
        Log::write('pid:' . $pid);

        // $mqttService->send($pid, $deviceId, $message, $suffix);

        //先设默认值，后续做逻辑处理
        $detail = '';

        $result = [
            'identifier' => $identifier,
            'type' => 'function',
            'value' => $integerValue,
            'deviceid' => $deviceId,
            'detail' => $detail,
            'remark' => $remark
        ];
        $sendlogModel = new Sendlog();
        $sendlogModel->create($result);

        return $this->success();
    }

    public function bool()
    {
        $mqttService = new MQTTService();

        //topic后缀
        $suffix = '/function/get';

        $deviceId = $this->request->post('deviceId');
        $boolValue = $this->request->post('boolValue');
        $identifier = $this->request->post('identifier');
        $pid = $this->request->post('pid');
        $remark = '场景联动触发';

        $message = [
            'id' => $identifier,
            'value' => $boolValue,
            'remark' => $remark
        ];

        // $mqttService->send($pid, $deviceId, $message, $suffix);

        Log::write('ID：' . $deviceId);
        Log::write('参数：' . $boolValue);
        Log::write('identifier:' . $identifier);
        Log::write('pid:' . $pid);

        //先设默认值，后续做逻辑处理
        $detail = '';

        $result = [
            'identifier' => $identifier,
            'type' => 'function',
            'value' => $boolValue,
            'deviceid' => $deviceId,
            'detail' => $detail,
            'remark' => $remark
        ];
        $sendlogModel = new Sendlog();
        $sendlogModel->create($result);

        $this->success('请求调度成功');
    }

    public function enum()
    {
        $mqttService = new MQTTService();

        //topic后缀
        $suffix = '/function/get';

        $deviceId = $this->request->post('deviceId');
        $enumValue = $this->request->post('enumValue');
        $identifier = $this->request->post('identifier');
        $pid = $this->request->post('pid');
        $remark = '场景联动触发';

        $message = [
            'id' => $identifier,
            'value' => $enumValue,
            'remark' => $remark
        ];

        // $mqttService->send($pid, $deviceId, $message, $suffix);

        Log::write('ID：' . $deviceId);
        Log::write('参数：' . $enumValue);
        Log::write('identifier:' . $identifier);
        Log::write('pid:' . $pid);

        //先设默认值，后续做逻辑处理
        $detail = '';

        $result = [
            'identifier' => $identifier,
            'type' => 'function',
            'value' => $enumValue,
            'deviceid' => $deviceId,
            'detail' => $detail,
            'remark' => $remark
        ];
        $sendlogModel = new Sendlog();
        $sendlogModel->create($result);
    }

    public function string()
    {
        $mqttService = new MQTTService();

        //topic后缀
        $suffix = '/function/get';

        $deviceId = $this->request->post('deviceId');
        $stringValue = $this->request->post('stringValue');
        $identifier = $this->request->post('identifier');
        $pid = $this->request->post('pid');
        $remark = '场景联动触发';

        $message = [
            'id' => $identifier,
            'value' => $stringValue,
            'remark' => $remark
        ];

        // $mqttService->send($pid, $deviceId, $message, $suffix);

        Log::write('ID：' . $deviceId);
        Log::write('参数：' . $stringValue);
        Log::write('identifier:' . $identifier);
        Log::write('pid:' . $pid);

        //先设默认值，后续做逻辑处理
        $detail = '';

        $result = [
            'identifier' => $identifier,
            'type' => 'function',
            'value' => $stringValue,
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
